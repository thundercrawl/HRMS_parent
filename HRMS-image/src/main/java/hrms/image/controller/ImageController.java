package hrms.image.controller;

import hrms.util.UploadUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;


@Controller
@RequestMapping("/filter/image")
public class ImageController extends BaseController {


	@RequestMapping(value = "/upload")
	public void upload(Model model, HttpServletRequest request,HttpServletResponse response) {
		try {
			//String resolutionRatio = "120,120;240,240;500,500";
			UploadUtil uploadutil = new UploadUtil();
			System.out.println(getImageUploadPath());
			System.out.println(getResolutionRatio());
			uploadutil.uploadImage(request,response,getImageUploadPath(),getResolutionRatio());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/tofindPic")
	public void tofindPic(String imgName,HttpServletResponse response) {
			FileInputStream in = null;
			OutputStream outputStream = null;
			response.setContentType("application/octet-stream;charset=UTF-8");
			try {
				in = new FileInputStream(getImageUploadPath()
						+ imgName);
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
