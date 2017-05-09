package hrms.bss.controller;


import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.model.OrgBaseInfo;
import hrms.model.UserBaseInfo;
import hrms.model.common.Paginator;
import hrms.po.AddOrgMember;
import hrms.po.FindOrgParam;
import hrms.po.SaveOrgParam;
import hrms.po.UpdateOrgParam;
import hrms.util.BssReturnJson;
import hrms.util.Grid;
import hrms.vo.FindOrgVo;
import hrms.vo.OrgInfoVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/filter/org")
public class OrgController extends BaseController{

    private static final int pageSize = 5;

	@RequestMapping(value = "/getAllOrg")
	public ModelAndView getAllOrg(HttpServletRequest request, ModelMap model) {
		searchOrg(null,0, model);

		return new ModelAndView("hrms-org/orgInfo", model);
	}

    @RequestMapping(value = "/searchOrgIndex")
    public ModelAndView searchOrg(FindOrgParam param, ModelMap model){
        searchOrg(param,0,model);
        return new ModelAndView("hrms-org/orgInfo", model);
    }

	@RequestMapping(value = "/searchOrg")
	public ModelAndView searchOrg(FindOrgParam param, @RequestParam("page") int page, ModelMap model){
		String url = "orgInfo/findAllOrg";

		BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
		CommonParams commonParams = new CommonParams();
		commonParams.setPage(page);
		commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

		JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
		String resultStatus = postJson.getString("status");
		if(resultStatus.equals("0000")){
			JSONObject data = postJson.getJSONObject("data");
			System.err.println(data);
			if(data!=null){
                FindOrgVo vo = JSONObject.parseObject(data.get("result").toString(), FindOrgVo.class);
                Integer count = JSONObject.parseObject(data.get("count").toString(), Integer.class);
                Paginator<OrgInfoVo> paginator = new Paginator<OrgInfoVo>(
                        vo.getOrgTables(), count, page + 1,pageSize);
        		model.put("paginator", paginator);

        		model.put("orgInfos",vo.getOrgInfos());
			}

		}

        model.put("searchParam",param);

        return new ModelAndView("hrms-org/orgTable", model);
	}

	@ResponseBody
	@RequestMapping(value="/updateOrg")
    public Grid updateOrg(UpdateOrgParam param, ModelMap modelMap){
        String url = "orgInfo/update";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(1);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("messge"));

        return grid;
    }

    @ResponseBody
    @RequestMapping(value="/createOrg")
    public Grid createOrg(SaveOrgParam param,ModelMap modelMap){
        String url = "orgInfo/save";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(1);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("messge"));

        return grid;
    }

    @ResponseBody
    @RequestMapping(value="/deleteOrg")
    public Grid deleteOrg(OrgBaseInfo param, ModelMap modelMap){
        String url = "orgInfo/deleteOrg";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(1);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("messge"));

        return grid;
    }


    @ResponseBody
    @RequestMapping(value = "/findAllUserName")
    public Grid findAllUserName(FindOrgParam orgParam,@RequestParam("userName")String userName, ModelMap modelMap){
        String url = "userInfo/findAllUserName";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        UserBaseInfo param = new UserBaseInfo();
        param.setUserName(userName);

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();

        String resultStatus = postJson.getString("status");
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            System.err.println(data);
            if(data!=null){
//                ArrayList list = JSONObject.parseObject(data.get("result").toString(), ArrayList.class);
                grid.setData(JSONObject.parseArray(data.get("result").toString()));
            }
        }

        return grid;
    }

    @ResponseBody
    @RequestMapping(value="/addMember")
    public Grid addMember(AddOrgMember param, ModelMap modelMap){
        String url = "orgInfo/addMember";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(1);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return grid;
    }

}
