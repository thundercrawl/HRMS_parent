package hrms.image.controller;

import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.po.UploadUserPhoto;
import hrms.util.BssReturnJson;
import hrms.util.Grid;
import hrms.util.ParseUtil;
import hrms.util.UploadUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;


@Controller
@RequestMapping("/filter/image")
public class ImageController extends BaseController {

	@RequestMapping("/tofindPic")
	public void tofindPic(String imgName,HttpServletResponse response) {
			FileInputStream in = null;
			OutputStream outputStream = null;
			response.setContentType("application/octet-stream;charset=UTF-8");
			try {
				in = new FileInputStream(getImageUploadPath()+"\\"+imgName);
				int i = in.available();
				byte[] data = new byte[i];
				in.read(data);

				outputStream = new BufferedOutputStream(
						response.getOutputStream());
				outputStream.write(data);
				outputStream.flush();

			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				if(in!=null){
					try {
						in.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if(outputStream != null){
					try {
						outputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}


	@ResponseBody
	@RequestMapping(value = "/upload")
	public Grid upload(Model model, HttpServletRequest request,HttpServletResponse response) {
		Grid grid = new Grid();
		try {
			//String resolutionRatio = "120,120;240,240;500,500";
			UploadUtil uploadutil = new UploadUtil();
			String fileName = uploadutil.uploadImage(request, response, getImageUploadPath(), getResolutionRatio());

			String relId = (String) request.getParameter("relId");
			String relType = (String) request.getParameter("relType");

			String url = "userInfo/uploadUserPhoto";
			BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
			CommonParams commonParams = new CommonParams();
			commonParams.setPage(3);
			commonParams.setPagesize(1);
			commonParams.setUserId(1);

			UploadUserPhoto param = new UploadUserPhoto();
			param.setPicName(fileName);
			param.setRelId(ParseUtil.parseInt(relId));
			param.setRelType(ParseUtil.parseInt(relType));

			JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

			grid.setCode(postJson.getString("status"));
			grid.setMessage(postJson.getString("message"));

		} catch (Exception e) {
			e.printStackTrace();
			grid.setCode("1111");
			grid.setMessage("上传图片失败");
		}
		return grid;
	}


	@RequestMapping("/tofindVoice")
	public void tofindVoice(String voiceName,HttpServletResponse response) {
			FileInputStream in = null;
			OutputStream outputStream = null;
			response.setContentType("application/octet-stream;charset=UTF-8");
			try {
				in = new FileInputStream(getImageUploadPath()
						+ voiceName);
				int i = in.available();
				byte[] data = new byte[i];
				in.read(data);

				outputStream = new BufferedOutputStream(
						response.getOutputStream());
				outputStream.write(data);
				outputStream.flush();

			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				if(in!=null){
					try {
						in.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if(outputStream != null){
					try {
						outputStream.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}

}
