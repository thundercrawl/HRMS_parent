package hrms.bss.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.po.DataCountParam;
import hrms.util.BssReturnJson;
import hrms.util.Grid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/filter/data")
public class DataCountController extends BaseController{

    private static final int pageSize = 5;

	/*       signCount       */

    @RequestMapping(value = "/getSign")
    public ModelAndView gethSign(String year, ModelMap model){
        return new ModelAndView("hrms-data/signInfo", model);
    }

    @RequestMapping(value = "/searchSign")
    @ResponseBody
    public String searchSign(String year, ModelMap model){

        String url = "data/signCount";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        DataCountParam param = new DataCountParam();
        param.setYear(year);

        Grid  grid = new Grid();

        try {
            JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
            String resultStatus = postJson.getString("status");
            if(resultStatus.equals("0000")){
                JSONObject data = postJson.getJSONObject("data");
                if(data!=null){
                    grid.setData(JSONObject.parseObject(data.get("result").toString()));
                }
            }
            grid.setCode(postJson.getString("status"));
            grid.setMessage(postJson.getString("message"));
        }catch (Exception e){
            e.printStackTrace();
        }

        return JSON.toJSONString(grid);
    }


    /*   billCount*/

    @RequestMapping(value = "/getBill")
    public ModelAndView getBill(String year, ModelMap model){
        return new ModelAndView("hrms-data/billInfo", model);
    }
    @RequestMapping(value = "/searchBill")
    @ResponseBody
    public String searchBill(String year, ModelMap model){
        String url = "data/billCount";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        DataCountParam param = new DataCountParam();
        param.setYear(year);

        Grid grid =  new Grid();

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
        String resultStatus = postJson.getString("status");
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            if(data!=null){
                grid.setData(data.get("result").toString());
            }
        }

        return JSON.toJSONString(grid);

//        return grid;
    }


}
