package hrms.bss.controller;

import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.model.common.Paginator;
import hrms.po.FindUserDetailParam;
import hrms.po.FindUserParam;
import hrms.po.UpdateUserParam;
import hrms.util.BssReturnJson;
import hrms.util.DateUtil;
import hrms.util.Grid;
import hrms.util.StringUtil;
import hrms.vo.ShowUserVo;
import hrms.vo.UserDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = "/filter/user")
public class UserController extends BaseController{
	@RequestMapping(value = "/getAllUser")
	public ModelAndView getAllUser(HttpServletRequest request,ModelMap model) {
		searchUser(null,0, model);
		return new ModelAndView("userManager/user", model);
	}
	
	@RequestMapping(value = "/searchUser")
	public ModelAndView searchUser(FindUserParam param,@RequestParam("page") int page, ModelMap model){

	    final int pageSize = 10;

		String url = "userInfo/findUsers";
		String msg = 2+"";

		BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
		CommonParams commonParams = new CommonParams();
		commonParams.setPage(page);
		commonParams.setPagesize(pageSize);
		commonParams.setUserId(1);
		commonParams.setOrgId(1);

		JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
		String resultStatus = postJson.getString("status");
		if(resultStatus.equals("0000")){
			JSONObject data = postJson.getJSONObject("data");
			if(data!=null){
				ShowUserVo showUserVo = JSONObject.parseObject(data.get("result").toString(),ShowUserVo.class);
                List<UserDetail> userInfos = showUserVo.getUserInfos();
                Paginator<UserDetail> paginator = new Paginator<UserDetail>(
                        userInfos, 3, 0 + 1, pageSize);
                model.put("paginator", paginator);
				msg = 1+"";
			}

		}

        return new ModelAndView("userManager/comtable", model);
	}

    @ResponseBody
    @RequestMapping(value = "/showPersonMessage")
    public Grid showPersonMessage(Integer userID, ModelMap modelMap){
        final int pageSize = 10;

        String url = "userInfo/findUserDetail";
        String msg = 2+"";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUserOrgId());
        FindUserDetailParam param = new FindUserDetailParam();
        param.setUserID(userID);

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        String resultStatus = postJson.getString("status");
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            if(data!=null){
                UserDetail userDetail = JSONObject.parseObject(data.get("result").toString(),UserDetail.class);
                grid.setData(userDetail);
            }
        }

        return grid;
    }
    @ResponseBody
    @RequestMapping(value = "/resetPwd")
    public Grid resetPwd(Integer userID, ModelMap modelMap){
        final int pageSize = 10;

        String url = "userInfo/resetPwd";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUserOrgId());

        JSONObject postJson = BssReturnJson.postJson(url, userID, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return grid;
    }

    @ResponseBody
    @RequestMapping(value = "/updateUser")
    public Grid updateUser(UpdateUserParam param, ModelMap modelMap){
        final int pageSize = 10;

        String url = "userInfo/updateUser";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(1);
        commonParams.setOrgId(1);
/*
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUserOrgId());
*/

        try {
            if(! StringUtil.isEmpty(param.getBirthOfDate()))   param.setBirthOfDate(DateUtil.formatDate(DateUtil.SHORT_FORMAT,DateUtil.parse(param.getBirthOfDate(),DateUtil.SHORT_EN_FORMAT)));
        }catch (Exception e){
            Grid grid = new Grid();
            grid.setCode("1111");
            grid.setMessage("时间格式错误：yyyyMMdd");
            return grid;
        }

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return grid;
    }
}
