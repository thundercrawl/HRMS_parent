package hrms.bss.controller;

import com.alibaba.fastjson.JSONObject;
import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import hrms.common.CommonParams;
import hrms.po.LoginParam;
import hrms.util.BssReturnJson;
import hrms.vo.LoginInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping(value = "/login")
public class LoginController extends BaseController{
	@Autowired
	private Producer captchaProducer = null;
	@ResponseBody
	@RequestMapping(value = "/ajaxValidateVerifyCode")
	public String ajaxValidateVerifyCode(String verifyCode,HttpServletRequest request) {
		HttpSession session = request.getSession();
		String code = (String) session
				.getAttribute(Constants.KAPTCHA_SESSION_KEY);
		if (code != null && code.equals(verifyCode)) {
			return "true";
		}
		return "false";
	}

	@RequestMapping(value = "/getKaptchaImage")
	public ModelAndView getKaptchaImage(HttpServletResponse response,HttpServletRequest request)
			throws Exception {
		
		HttpSession session = request.getSession();
		String code = (String) session
				.getAttribute(Constants.KAPTCHA_SESSION_KEY);
		System.out.println("验证码: " + code);

		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control",
				"no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		response.setContentType("image/jpeg");

		String capText = captchaProducer.createText();
		session.setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);

		BufferedImage bi = captchaProducer.createImage(capText);
		ServletOutputStream out = response.getOutputStream();
		ImageIO.write(bi, "jpg", out);
		try {
			out.flush();
		} finally {
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value = "/login", method={RequestMethod.POST})
	public void login(LoginParam loginParam, ModelMap modelMap, HttpServletResponse response) {

        String url = "userInfo/login";
		String msg = 2+"";

		BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
		CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(3);

		JSONObject postJson = BssReturnJson.postJson(url, loginParam, commonParams, JSONObject.class);
		String resultStatus = postJson.getString("status");
		if(resultStatus.equals("0000")){
			JSONObject data = postJson.getJSONObject("data");
			if(data!=null){
                LoginInfo loginInfo = JSONObject.parseObject(data.get("result").toString(),LoginInfo.class);
				getHttpSession().setAttribute(appProperties.getSessionKey(), loginInfo);
				msg = 1+"";
			}

		}
		if(resultStatus.equals("5024")){
			msg = "5024";
		}
		PrintWriter pw = null;
		response.setCharacterEncoding("utf-8");
		try {
			pw = response.getWriter();
			pw.write(msg);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (pw != null) {
				pw.flush();
				pw.close();
			}
		}
	}
	/**
	 * 
	 *注销
	 */
	@RequestMapping("/logout")
	public ModelAndView logout(ModelMap model,HttpServletRequest request){
		request.getSession().removeAttribute(appProperties.getSessionKey());
		return new ModelAndView("login",model);
	}
}
