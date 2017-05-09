package hrms.bss.filter;

import hrms.vo.LoginInfo;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * 用于检查用户是否登录了系统的过滤器
 */
public class SessionFilter implements Filter {
	
	private static final Log log = LogFactory.getLog(SessionFilter.class);

	
	/** 要检查的 session 的名称 */
    private String sessionKey;
 
    /** 检查不通过时，转发的URL */
    private String forwardUrl;
 
    
    @Override
    public void init(FilterConfig cfg) throws ServletException {
    	sessionKey = cfg.getInitParameter("sessionKey");
        forwardUrl = cfg.getInitParameter("redirectUrl");
    }
 
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {

    	 // 如果 sessionKey 为空，则直接放行
        if (StringUtils.isBlank(sessionKey)) {
            chain.doFilter(req, res);
            return;
        }
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String servletPath = request.getServletPath();
        String contextPath = request.getContextPath();
        String redirect = servletPath + "?" + StringUtils.defaultString(request.getQueryString());
 
        System.out.println("bss-url :servletPath :"+servletPath);
        System.err.println("请求链接："+redirect);
        
        // 如果请求的路径与forwardUrl相同
        if (servletPath.equals(forwardUrl)) {
            chain.doFilter(req, res);
            return;
        }
        
        Object sessionObj = request.getSession().getAttribute(sessionKey);
        // 如果Session为空，则跳转到指定页面
        if (sessionObj == null
                || !(sessionObj instanceof LoginInfo)
                || ((LoginInfo)sessionObj).getUserId() == null) {
            response.sendRedirect(contextPath + StringUtils.defaultIfEmpty(forwardUrl, "/") + "?redirect=" + URLEncoder.encode(redirect, "UTF-8"));
        } else {
            chain.doFilter(req, res);
        }
        chain.doFilter(request, response);
    }
 
    @Override
    public void destroy() {
    }
}