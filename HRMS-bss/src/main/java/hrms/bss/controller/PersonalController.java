package hrms.bss.controller;

import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.po.FindUserDetailParam;
import hrms.po.UpdateUserPwd;
import hrms.util.BssReturnJson;
import hrms.vo.UserDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/filter/personal")
public class PersonalController extends BaseController{

    private static final int pageSize = 5;

    @ResponseBody
    @RequestMapping(value = "/updatePwd")
    public ModelAndView updatePwd(UpdateUserPwd param, ModelMap modelMap){
        String url = "userInfo/updatePwd";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        modelMap.put("status",postJson.getString("status"));
        modelMap.put("message",postJson.getString("message"));

        return new ModelAndView("login",modelMap);
    }

    @ResponseBody
    @RequestMapping(value = "/personalMessage")
    public ModelAndView personalMessage(Integer userId, ModelMap modelMap){
        String url = "userInfo/findUserDetail";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        FindUserDetailParam param = new FindUserDetailParam();
        if(userId == null){
            param.setUserID(1);
        }else{
            param.setUserID(userId);
        }

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        String resultStatus = postJson.getString("status");
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            System.err.println(data);
            if(data!=null){
                UserDetail userDetail = JSONObject.parseObject(data.get("result").toString(),UserDetail.class);
                modelMap.put("userInfo", userDetail);
            }

        }


        return new ModelAndView("hrms-personal/showPersonalMessage",modelMap);
    }

    @ResponseBody
    @RequestMapping(value = "/showAdminPwd")
    public ModelAndView showAdminPwd(ModelMap modelMap){
        String url = "userInfo/findUserDetail";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        FindUserDetailParam param = new FindUserDetailParam();
        param.setUserID(1);

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        String resultStatus = postJson.getString("status");
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            System.err.println(data);
            if(data!=null){
                UserDetail userDetail = JSONObject.parseObject(data.get("result").toString(),UserDetail.class);
                modelMap.put("userInfo", userDetail);
            }

        }
        return new ModelAndView("hrms-personal/userinfo",modelMap);
    }

}
