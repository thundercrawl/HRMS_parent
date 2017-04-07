package hrms.bss.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="")
public class HomeController extends BaseController{
	
	@RequestMapping(value="/filter/home")
	public ModelAndView home(){
		return new ModelAndView("index");
	}
	
	@RequestMapping(value="/login")
	public ModelAndView login(){
		return new ModelAndView("login");
	}

}
