package hrms.image.controller;

import hrms.model.common.AppProperties;
import hrms.util.UploadImageUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
@RequestMapping("/filter/image")
public class UploadImageController {
	@Resource(name="appProperties")
	protected AppProperties appProperties;
	@RequestMapping(value = "/uploadImg")
	public void upload(Model model, HttpServletRequest request)
			throws Exception {
		String fileServerPath = appProperties.getFileServerPath();
		Map<String, String> map = UploadImageUtil.localUpload(request, "junmo",fileServerPath);
		for (String key : map.keySet()) {
			System.out.println("key= " + key + " and value= " + map.get(key));
		}
	}
}
