package hrms.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class XmlUtil {

	public static String format(Map<String, String> params) {
		Document doc = DocumentHelper.createDocument();
		Element element = DocumentHelper.createElement("xml");
		for(String key : params.keySet()) {
			Element innerElement = DocumentHelper.createElement(key);
			innerElement.add(DocumentHelper.createText(params.get(key)));
			element.add(innerElement);
		}
		doc.add(element);
		return doc.asXML();
	}

	public static Map<String, String> parse(String responseData) {
		Map<String, String> ret = new HashMap<String, String>();
		Document document;
		try {
			document = DocumentHelper.parseText(responseData);
			Element root = document.getRootElement();
			ret.putAll(parseInnerElement(root.elements()));
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return ret;
	}

	private static Map<String, String> parseInnerElement(List<?> elements) {
		Map<String, String> ret = new HashMap<String, String>();
		for(Object obj : elements) {
			if(obj instanceof Element) {
				Element e = (Element) obj;
				if(e.isTextOnly()) {
					ret.put(e.getName(), noCdata(e.getText()));
				} else {
					ret.putAll(parseInnerElement(e.elements()));
				}
			}
		}
		return ret;
	}

	private static String noCdata(String text) {
		text = text.replace("<![CDATA[", "")
				.replace("]]>", "");
		return text;
	}
	
	private static String cdata(String text) {
		return new StringBuffer()
					.append("<![CDATA[")
					.append(text).append("]]>").toString();
	}
	
	public static String formatWxXml(Map<String, String> params) {
		Document doc = DocumentHelper.createDocument();
		Element element = DocumentHelper.createElement("xml");
		for(String key : params.keySet()) {
			Element innerElement = DocumentHelper.createElement(key);
			innerElement.add(DocumentHelper.createText(cdata(params.get(key))));
			element.add(innerElement);
		}
		doc.add(element);
		String xml = doc.asXML();
		xml = xml.replaceAll("&lt;", "<");
		xml = xml.replaceAll("&gt;", ">");
		return xml;
	}
	
	public static String formatWxXml2(Map<String, Object> params) {
		Document doc = DocumentHelper.createDocument();
		Element element = DocumentHelper.createElement("xml");
		for(String key : params.keySet()) {
			Element innerElement = DocumentHelper.createElement(key);
			Object obj =params.get(key);
			if (obj instanceof String) {
				innerElement.add(DocumentHelper.createText(cdata((String)obj)));
			} else {
				innerElement.add(DocumentHelper.createText(obj.toString()));
			}
			element.add(innerElement);
		}
		doc.add(element);
		String xml = doc.asXML();
		xml = xml.replaceAll("&lt;", "<");
		xml = xml.replaceAll("&gt;", ">");
		return xml;
	}
	
}
