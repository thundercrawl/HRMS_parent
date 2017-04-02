package hrms.api.restful.interceptor;


import com.alibaba.fastjson.JSONObject;
import hrms.annotation.HRMSParam;
import hrms.common.ErrorCode;
import hrms.vo.MsgVo;
import org.apache.commons.lang3.StringUtils;
import org.apache.cxf.common.i18n.BundleUtils;
import org.apache.cxf.common.logging.LogUtils;
import org.apache.cxf.jaxrs.JAXRSServiceImpl;
import org.apache.cxf.jaxrs.ext.RequestHandler;
import org.apache.cxf.jaxrs.impl.MetadataMap;
import org.apache.cxf.jaxrs.impl.RequestPreprocessor;
import org.apache.cxf.jaxrs.impl.UriInfoImpl;
import org.apache.cxf.jaxrs.interceptor.JAXRSInInterceptor;
import org.apache.cxf.jaxrs.lifecycle.ResourceProvider;
import org.apache.cxf.jaxrs.model.ClassResourceInfo;
import org.apache.cxf.jaxrs.model.OperationResourceInfo;
import org.apache.cxf.jaxrs.model.ProviderInfo;
import org.apache.cxf.jaxrs.model.URITemplate;
import org.apache.cxf.jaxrs.provider.ProviderFactory;
import org.apache.cxf.jaxrs.utils.HttpUtils;
import org.apache.cxf.jaxrs.utils.InjectionUtils;
import org.apache.cxf.jaxrs.utils.JAXRSUtils;
import org.apache.cxf.message.Exchange;
import org.apache.cxf.message.Message;
import org.apache.cxf.message.MessageUtils;
import org.apache.cxf.phase.AbstractPhaseInterceptor;
import org.apache.cxf.phase.Phase;
import org.apache.cxf.service.Service;
import org.apache.cxf.transport.http.AbstractHTTPDestination;
import org.springframework.core.MethodParameter;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ParameterCheckInterceptor extends AbstractPhaseInterceptor<Message> {

    private static final Logger LOG = LogUtils.getL7dLogger(ParameterCheckInterceptor.class);
    private static final ResourceBundle BUNDLE = BundleUtils.getBundle(JAXRSInInterceptor.class);
    
    public ParameterCheckInterceptor() {
        super(Phase.UNMARSHAL);
    }

    @Override
    public void handleFault(Message message) {
        super.handleFault(message);
        
        LOG.fine("Cleanup thread local variables");
        
        Object rootInstance = message.getExchange().remove(JAXRSUtils.ROOT_INSTANCE);
        Object rootProvider = message.getExchange().remove(JAXRSUtils.ROOT_PROVIDER);
        if (rootInstance != null && rootProvider != null) {
            try {
                ((ResourceProvider)rootProvider).releaseInstance(message, rootInstance);
            } catch (Throwable tex) {
                LOG.warning("Exception occurred during releasing the service instance, " + tex.getMessage());
            }
        }
        ProviderFactory.getInstance(message).clearThreadLocalProxies();
        ClassResourceInfo cri = (ClassResourceInfo)message.getExchange().get(JAXRSUtils.ROOT_RESOURCE_CLASS);
        if (cri != null) {
            cri.clearThreadLocalProxies();
        }
    }
    
    public void handleMessage(Message message) {
        
        if (message.getExchange().get(OperationResourceInfo.class) != null) {
            // it's a suspended invocation;
            return;
        }
        
        try {
            processRequest(message);
        } catch (RuntimeException ex) {
            Response excResponse = JAXRSUtils.convertFaultToResponse(ex, message);
            if (excResponse == null) {
                ProviderFactory.getInstance(message).clearThreadLocalProxies();
                message.getExchange().put(Message.PROPOGATE_EXCEPTION, 
                                          JAXRSUtils.propogateException(message));
                throw ex;
            }
            message.getExchange().put(Response.class, excResponse);
        }
        
        
    }
    
    private void processRequest(Message message) {
        
        ProviderFactory providerFactory = ProviderFactory.getInstance(message);
        
        RequestPreprocessor rp = providerFactory.getRequestPreprocessor();
        if (rp != null) {
            rp.preprocess(message, new UriInfoImpl(message, null));
            if (message.getExchange().get(Response.class) != null) {
                return;
            }
        }
        
        // Global pre-match request filters
        if (JAXRSUtils.runContainerRequestFilters(providerFactory, message, true, null)) {
            return;
        }
        
        String requestContentType = (String)message.get(Message.CONTENT_TYPE);
        if (requestContentType == null) {
            requestContentType = "*/*";
        }
        
        String rawPath = HttpUtils.getPathToMatch(message, true);
        
        //1. Matching target resource class
        Service service = message.getExchange().get(Service.class);
        List<ClassResourceInfo> resources = ((JAXRSServiceImpl)service).getClassResourceInfos();

        String acceptTypes = HttpUtils.getProtocolHeader(message, Message.ACCEPT_CONTENT_TYPE, null);
        if (acceptTypes == null) {
            acceptTypes = "*/*";
            message.put(Message.ACCEPT_CONTENT_TYPE, acceptTypes);
        }
        List<MediaType> acceptContentTypes = null;
        try {
            acceptContentTypes = JAXRSUtils.sortMediaTypes(acceptTypes);
        } catch (IllegalArgumentException ex) {
            throw new WebApplicationException(406);
        }
        message.getExchange().put(Message.ACCEPT_CONTENT_TYPE, acceptContentTypes);

        MultivaluedMap<String, String> values = new MetadataMap<String, String>();
        ClassResourceInfo resource = JAXRSUtils.selectResourceClass(resources, 
                                          rawPath, 
                                          values,
                                          message);
        if (resource == null) {
            org.apache.cxf.common.i18n.Message errorMsg = 
                new org.apache.cxf.common.i18n.Message("NO_ROOT_EXC", 
                                                   BUNDLE,
                                                   message.get(Message.REQUEST_URI),
                                                   rawPath);
            LOG.warning(errorMsg.toString());
            Response resp = JAXRSUtils.createResponse(resource, message, errorMsg.toString(), 
                    Response.Status.NOT_FOUND.getStatusCode(), false);
            throw new WebApplicationException(resp);
        }

        message.getExchange().put(JAXRSUtils.ROOT_RESOURCE_CLASS, resource);

        String httpMethod = HttpUtils.getProtocolHeader(message, Message.HTTP_REQUEST_METHOD, "POST");
        OperationResourceInfo ori = null;     
        
        boolean operChecked = false;
        List<ProviderInfo<RequestHandler>> shs = providerFactory.getRequestHandlers();
        for (ProviderInfo<RequestHandler> sh : shs) {
            if (ori == null && !operChecked) {
                try {                
                    ori = JAXRSUtils.findTargetMethod(resource, 
                        message, httpMethod, values, 
                        requestContentType, acceptContentTypes, false);
                    setExchangeProperties(message, ori, values, resources.size());
                } catch (WebApplicationException ex) {
                    operChecked = true;
                }
                
            }
            InjectionUtils.injectContexts(sh.getProvider(), sh, message);
            Response response = sh.getProvider().handleRequest(message, resource);
            if (response != null) {
                message.getExchange().put(Response.class, response);
                return;
            }
            
        }
        
        if (ori == null) {
            try {                
                ori = JAXRSUtils.findTargetMethod(resource, message, 
                                            httpMethod, values, requestContentType, acceptContentTypes, true);
                setExchangeProperties(message, ori, values, resources.size());
            } catch (WebApplicationException ex) {
                if (JAXRSUtils.noResourceMethodForOptions(ex.getResponse(), httpMethod)) {
                    Response response = JAXRSUtils.createResponse(resource, null, null, 200, true);
                    message.getExchange().put(Response.class, response);
                    return;
                } else {
                    throw ex;
                }
            }
        }

        if (LOG.isLoggable(Level.FINE)) {
            LOG.fine("Request path is: " + rawPath);
            LOG.fine("Request HTTP method is: " + httpMethod);
            LOG.fine("Request contentType is: " + requestContentType);
            LOG.fine("Accept contentType is: " + acceptTypes);

            LOG.fine("Found operation: " + ori.getMethodToInvoke().getName());
        }
        
        setExchangeProperties(message, ori, values, resources.size());
        
        //Process parameters
        try {
            processParameters(ori, values, message);
        } catch (Exception ex) {
            Response excResponse = JAXRSUtils.convertFaultToResponse(ex, message);
            if (excResponse == null) {
                throw new WebApplicationException(ex);
            } else {
                message.getExchange().put(Response.class, excResponse);
            }
        }
        
    }
    
    private void processParameters(OperationResourceInfo ori, MultivaluedMap<String, String> values,
			Message message) {
    	HttpServletRequest request = (HttpServletRequest) message.get(AbstractHTTPDestination.HTTP_REQUEST);//这句可以获取到request
		String requestURI = request.getRequestURI();
		LOG.info("请求接口："+requestURI);
		System.out.println("请求接口："+requestURI+":"+System.currentTimeMillis());
		
    	InputStream is = message.getContent(InputStream.class);
		BufferedReader br = new BufferedReader(new InputStreamReader(is, Charset.forName("utf8")));
		StringBuffer stringBuffer = new StringBuffer();
		String str = "";
		try {
			while((str = br.readLine()) != null) {
				stringBuffer.append(URLDecoder.decode(str, "utf8"));
				System.out.println(URLDecoder.decode(str, "utf8"));
				LOG.info(URLDecoder.decode(str, "utf8"));
			}
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		try {
			JSONObject jsonObject = JSONObject.parseObject(stringBuffer.toString());
			Exchange exchange = message.getExchange();  
			OperationResourceInfo resourceInfo = exchange.get(OperationResourceInfo.class);
			Method method = resourceInfo.getAnnotatedMethod();
			Class<?>[] paramTypes = (Class[]) method.getGenericParameterTypes();
			Annotation[][] parameterAnnotations = method.getParameterAnnotations();
			
			List<Object> newParams = new ArrayList<Object>();
			Annotation[] rules = parameterAnnotations[0];
			String parameterName = getParameterName(rules,new MethodParameter(method,0));
			System.out.println(parameterName);
			if(!StringUtils.isEmpty(parameterName) && paramTypes.length == 2) {
				String commonParamName = getParameterName(parameterAnnotations[1],new MethodParameter(method,1));
				commonParamName = commonParamName == null ? "commonParam" : commonParamName;
				if(jsonObject.get(commonParamName) == null) {
					ResponseBuilder rb = Response.status(Response.Status.BAD_REQUEST);
					rb.language(Locale.SIMPLIFIED_CHINESE);
					LOG.warning("参数校验不通过------>无commonParam参数");
					Response response = rb.entity(MsgVo.failJson(ErrorCode.PARAMERROR)).build();
					message.getExchange().put(Response.class, response);
					return;
				}
				Object obj = jsonObject.get(parameterName);
				newParams.add(parameterName);
				newParams.add(paramTypes[0]);
				newParams.add(obj);
				newParams.add(commonParamName);
				newParams.add(paramTypes[1]);
				newParams.add(jsonObject.get(commonParamName));
				message.setContent(List.class, newParams);
			}
		} catch(Exception e) {
			
		}
	}
    
    private String getParameterName(Annotation[] rules,MethodParameter mp) {
		for (Annotation a : rules) {
			if(a instanceof QueryParam) {
				return ((QueryParam)a).value();
			} 
			if(a instanceof FormParam) {
				return ((FormParam)a).value();
			}
			if(a instanceof HeaderParam) {
				return ((HeaderParam)a).value();
			}
			if(a instanceof PathParam) {
				return ((PathParam)a).value();
			}
			if(a instanceof CookieParam) {
				return ((CookieParam)a).value();
			}
			if(a instanceof MatrixParam) {
				return ((MatrixParam)a).value();
			}
			if(a instanceof HRMSParam) {
				return ((HRMSParam)a).value();
			}
		}
		return mp.getParameterName();
	}

	private void setExchangeProperties(Message message, OperationResourceInfo ori, 
                                      MultivaluedMap<String, String> values,
                                      int numberOfResources) {
        message.getExchange().put(OperationResourceInfo.class, ori);
        message.put("org.apache.cxf.resource.method", ori.getMethodToInvoke());
        message.put(URITemplate.TEMPLATE_PARAMETERS, values);
        
        String plainOperationName = ori.getMethodToInvoke().getName();
        if (numberOfResources > 1) {
            plainOperationName = ori.getClassResourceInfo().getServiceClass().getSimpleName()
                + "#" + plainOperationName;
        }
        message.getExchange().put("org.apache.cxf.resource.operation.name", plainOperationName);
        
        boolean oneway = ori.isOneway() 
            || MessageUtils.isTrue(HttpUtils.getProtocolHeader(message, Message.ONE_WAY_REQUEST, null));
        message.getExchange().setOneWay(oneway);
    }
}
