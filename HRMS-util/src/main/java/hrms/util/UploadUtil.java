package hrms.util;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class UploadUtil {
	/*private String imagePath = "D://imageFile//"
			+ new SimpleDateFormat("yyyyMMddHH").format(new Date()) + "";// 配置图片路径
*/
	//private String imagePath = "D://imageFile//";// 配置图片路径
	public String uploadImage(HttpServletRequest request,HttpServletResponse response,String imagePath,String resolutionRatio)
			throws Exception {
		String filePath = "";
		String resultName = "";
		
		//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		// 设置编码
		multipartResolver.setDefaultEncoding("utf-8");
		MultipartHttpServletRequest multipartRequest = multipartResolver
				.resolveMultipart(request);
		// 获得第1张图片（根据前台的name名称得到上传的文件）
		MultipartFile file = multipartRequest.getFile("imgFile");
		String relId = (String) request.getParameter("relId");
		String relType = (String) request.getParameter("relType");

		String getUploadFileName = file.getOriginalFilename();
	    imagePath+=filePath;
		String getImagePath = imagePath;

		File image = new File(getImagePath);
		if (!image.exists()) {
			image.mkdirs();
		}

		InputStream stream = file.getInputStream();
		BufferedImage srcBufferImage = ImageIO.read(stream);
		System.out.println(" w " + srcBufferImage.getWidth() + " h "
				+ srcBufferImage.getHeight());
		BufferedImage scaledImage;
		ScaleImage scaleImage = ScaleImage.getInstance();
		int yw = srcBufferImage.getWidth();
		int yh = srcBufferImage.getHeight();
		String[] resolutionRatioSplit = resolutionRatio.split(";");
//		String[] resultFileNameArr = new String[resolutionRatioSplit.length];
		for (int i = 0; i < resolutionRatioSplit.length; i++) {
			try {
				String widthAndHeight = resolutionRatioSplit[i];
				String[] widthAndHeightSplit = widthAndHeight.split(",");
				int w = Integer.parseInt(widthAndHeightSplit[0]);
				int h = Integer.parseInt(widthAndHeightSplit[1]);

				Map<String,String> map = generateFileName(relId,relType,getUploadFileName, w, h);
				String fileNewName = map.get("fileName");
				resultName = map.get("resultName");
				//imagePath = imagePath + "/" + fileNewName;
//				resultFileNameArr[i] = fileNewName;
//				response.addCookie(new Cookie("imageName_"+w+"_"+h, fileNewName));
				// 如果上传图片 宽高 比 压缩的要小 则不压缩
				if (w > yw && h > yh) {
					FileOutputStream fos = null;
					FileInputStream fis = null;
					try {
						fos = new FileOutputStream(getImagePath + "/"
								+ fileNewName);
						fis = (FileInputStream) file.getInputStream();
						byte[] buffer = new byte[1024];
						int len = 0;
						while ((len = fis.read(buffer)) > 0) {
							fos.write(buffer, 0, len);
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						if (fis != null) {
							fis.close();
						}
						if (fos != null) {
							fos.close();
						}
					}
				} else {
					scaledImage = scaleImage.imageZoomOut(srcBufferImage, w, h);
					FileOutputStream out = new FileOutputStream(getImagePath
							+ "/" + fileNewName);
					ImageIO.write(scaledImage, "jpeg", out);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (stream != null) {
					stream.close();
				}
			}
		}
		return resultName;
	}

	private Map<String,String> generateFileName( String relId, String relType, String fileName, int w, int h) {
		DateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String formatDate = format.format(new Date());
		int random = new Random().nextInt(10000);
		/*int position = fileName.lastIndexOf(".");
		String extension = fileName.substring(position);*/
		Map<String,String> map = new HashMap<>();
		map.put("fileName",relId+"_"+relType+"_"+formatDate + random + "_" + w + "_" + h );
		map.put("resultName",relId+"_"+relType+"_"+formatDate + random);
		return map;
	}

}