package hrms.bss.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.model.common.Paginator;
import hrms.po.FindApproveParam;
import hrms.po.FindLeavesParam;
import hrms.po.UpApproveParam;
import hrms.util.BssReturnJson;
import hrms.util.Grid;
import hrms.vo.ApproveDetail;
import hrms.vo.FindAllApproveVo;
import hrms.vo.FindAllLeaveVo;
import hrms.vo.LeaveDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/filter/leave")
public class LeaveController extends BaseController{

    private static final int pageSize = 5;

	/*       business       */
    @RequestMapping(value = "/getAllBusiness")
    public ModelAndView getAllBusiness(HttpServletRequest request,ModelMap model) {
        searchBusiness(null,0, model);

        return new ModelAndView("hrms-leave/businessInfo", model);
    }

    @RequestMapping(value = "/searchBusinessIndex")
    public ModelAndView searchBusinessIndex(FindLeavesParam param, ModelMap model){
        searchBusiness(param,0,model);
        return new ModelAndView("hrms-leave/businessInfo", model);
    }

    @RequestMapping(value = "/searchBusiness")
    public ModelAndView searchBusiness(FindLeavesParam param, @RequestParam("page") int page, ModelMap model){
        String url = "leave/findAllLeaves";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(page);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        if(param == null){
            param = new FindLeavesParam();
        }
        param.setLeaveType(Constant.LEAVE_TYPE_BUSINESS);

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
        String resultStatus = postJson.getString("status");
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            System.err.println(data);
            if(data!=null){
                FindAllLeaveVo vo = JSONObject.parseObject(data.get("result").toString(),FindAllLeaveVo.class);
                Paginator<LeaveDetail> paginator = new Paginator<LeaveDetail>(
                        vo.getLeaveDetails(), vo.getCount(), page + 1,pageSize);
                model.put("paginator", paginator);
            }
        }

        model.put("searchParam",param);

        return new ModelAndView("hrms-leave/businessTable", model);
    }


    @RequestMapping(value = "/upBusinessApprove")
    @ResponseBody
    public String upBusinessApprove(UpApproveParam param, ModelMap model){
        String url = "leave/upApprove";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        if(param != null){
            param.setLeaveType(Constant.LEAVE_TYPE_BUSINESS);
        }

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        if(postJson != null){
            grid.setCode(postJson.getString("status"));
            grid.setMessage(postJson.getString("message"));
        }else{
            grid.setCode("1111");
            grid.setMessage("网络错误");
        }

        return JSON.toJSONString(grid);
    }


    /*   leave    */
    @RequestMapping(value = "/getAllLeaves")
    public ModelAndView getAllLeaves(HttpServletRequest request,ModelMap model) {
        searchLeave(null,0, model);

        return new ModelAndView("hrms-leave/leaveInfo", model);
    }

    @RequestMapping(value = "/searchLeaveIndex")
    public ModelAndView searchLeaveIndex(FindLeavesParam param, ModelMap model){
        searchLeave(param,0,model);
        return new ModelAndView("hrms-leave/leaveInfo", model);
    }

    @RequestMapping(value = "/searchLeave")
    public ModelAndView searchLeave(FindLeavesParam param, @RequestParam("page") int page, ModelMap model){
        String url = "leave/findAllLeaves";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(page);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        if(param == null){
            param = new FindLeavesParam();
        }
        param.setLeaveType(Constant.LEAVE_TYPE_LEAVE);

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
        String resultStatus = postJson.getString("status");
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            System.err.println(data);
            if(data!=null){
                FindAllLeaveVo vo = JSONObject.parseObject(data.get("result").toString(),FindAllLeaveVo.class);

                Paginator<LeaveDetail> paginator = new Paginator<LeaveDetail>(
                        vo.getLeaveDetails(), vo.getCount(), page + 1,pageSize);
                model.put("paginator", paginator);
            }
        }

        model.put("searchParam",param);

        return new ModelAndView("hrms-leave/leaveTable", model);
    }

    @ResponseBody
    @RequestMapping(value = "/upLeaveApprove")
    public String upLeaveApprove(UpApproveParam param, ModelMap model){
        String url = "leave/upApprove";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        if(param != null){
            param.setLeaveType(Constant.LEAVE_TYPE_LEAVE);
        }

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        if(postJson != null){
            grid.setCode(postJson.getString("status"));
            grid.setMessage(postJson.getString("message"));
        }

        return JSON.toJSONString(grid);
    }

    /*   approve    */
    @RequestMapping(value = "/getAllApproves")
    public ModelAndView getAllApproves(HttpServletRequest request,ModelMap model) {
        searchApprove(null,0, model);

        return new ModelAndView("hrms-leave/approveInfo", model);
    }

    @RequestMapping(value = "/searchApproveIndex")
    public ModelAndView searchApproveIndex(FindApproveParam param, ModelMap model){
        searchApprove(param,0,model);
        return new ModelAndView("hrms-leave/approveInfo", model);
    }

    @RequestMapping(value = "/searchApprove")
    public ModelAndView searchApprove(FindApproveParam param, @RequestParam("page") int page, ModelMap model){
        String url = "leave/findAllApproves";

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
            if(data!=null){
                FindAllApproveVo vo = JSONObject.parseObject(data.get("result").toString(),FindAllApproveVo.class);

                Paginator<LeaveDetail> paginator = new Paginator<LeaveDetail>(
                        vo.getApproves(), vo.getCount(), page + 1,pageSize);
                model.put("paginator", paginator);
            }
        }

        model.put("searchParam",param);

        return new ModelAndView("hrms-leave/approveTable", model);
    }

    @ResponseBody
    @RequestMapping(value = "/showApproveDetail")
    public String showApproveDetail(FindApproveParam param, ModelMap model){
        String url = "leave/findApproveDetail";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        Grid grid = new Grid();

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
        String resultStatus = postJson.getString("status");
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            if(data!=null){
                ApproveDetail detail = JSONObject.parseObject(data.get("result").toString(),ApproveDetail.class);

                grid.setData(detail);
            }
        }

        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return JSON.toJSONString(grid);
    }

    @ResponseBody
    @RequestMapping(value = "/passApprove")
    public String passApprove(FindApproveParam param, ModelMap model){
        String url = "leave/passApprove";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        Grid grid = new Grid();

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return JSON.toJSONString(grid);
    }
    @ResponseBody
    @RequestMapping(value = "/rejectApprove")
    public String rejectApprove(FindApproveParam param, ModelMap model){
        String url = "leave/rejectApprove";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        Grid grid = new Grid();

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return JSON.toJSONString(grid);
    }
}
