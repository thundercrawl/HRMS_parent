package hrms.bss.controller;

import hrms.entity.UserInfo;
import hrms.model.common.Paginator;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/filter/user")
public class UserController extends BaseController{
	@RequestMapping(value = "/getAllUser")
	public ModelAndView getAllUser(HttpServletRequest request,ModelMap model) {
		searchUser(0, model);
		return new ModelAndView("userManager/user", model);
	}
	
	@RequestMapping(value = "/searchUser")
	public ModelAndView searchUser(@RequestParam("page") int page,ModelMap model){
		
		List<UserInfo> list = new ArrayList<UserInfo>();
		UserInfo userInfo = new UserInfo();
		userInfo.setCreateTime("2016");
		userInfo.setCreateUserId(1);
		userInfo.setSex((byte)1);
		userInfo.setUserName("kelaode");
		userInfo.setUserPhone("123456");
		list.add(userInfo);
		list.add(userInfo);
		list.add(userInfo);
		Paginator<UserInfo> paginator = new Paginator<UserInfo>(
				list, 3, 0 + 1, 5);
		model.put("paginator", paginator);
		return new ModelAndView("userManager/comtable", model);
	}

}
