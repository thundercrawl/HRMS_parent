package hrms.bss.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.model.common.Paginator;
import hrms.po.FindAllWageParam;
import hrms.po.FindBillParam;
import hrms.po.FindWageDetail;
import hrms.po.SaveWageInfo;
import hrms.po.SaveWageParam;
import hrms.po.SearchBillParam;
import hrms.po.UpdateUserWageParam;
import hrms.util.BssReturnJson;
import hrms.util.Grid;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import hrms.vo.BillDetail;
import hrms.vo.BillDetailVo;
import hrms.vo.FindAllWageVo;
import hrms.vo.WageDetail;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/filter/wage")
public class WageController extends BaseController{

    private static final int pageSize = 5;

	/*       personalBill       */
    @RequestMapping(value = "/getAllBills")
    public ModelAndView getAllBills(HttpServletRequest request,ModelMap model) {
        searchBill(null,0, model);

        return new ModelAndView("hrms-wage/personalBillInfo", model);
    }

    @RequestMapping(value = "/searchBillIndex")
    public ModelAndView searchBillIndex(String date, ModelMap model){
        searchBill(date,0,model);
        return new ModelAndView("hrms-wage/personalBillInfo", model);
    }

    @RequestMapping(value = "/searchBill")
    public ModelAndView searchBill(String date, @RequestParam("page") int page, ModelMap model){
        String url = "bill/searchBill";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(page);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        SearchBillParam param = new SearchBillParam();
        param.setDate(date);
        param.setIsFinance((byte) 0);

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
        String resultStatus = postJson.getString("status");
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            if(data!=null){
                BillDetailVo vo = JSONObject.parseObject(data.get("result").toString(),BillDetailVo.class);
                Paginator<BillDetail> paginator = new Paginator<BillDetail>(
                        vo.getBillDetails(), vo.getCount(), page + 1,pageSize);
                model.put("paginator", paginator);
            }
        }

        model.put("searchParam",param);

        return new ModelAndView("hrms-wage/personalBillTable", model);
    }


    @RequestMapping(value = "/showBillDetail")
    public ModelAndView showBillDetail(Integer billId, ModelMap model){
        String url = "bill/findBillDetail";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        FindBillParam param = new FindBillParam();
        param.setBillId(billId);

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
        String resultStatus = postJson.getString("status");
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            if(data!=null){
                BillDetailVo vo = JSONObject.parseObject(data.get("result").toString(),BillDetailVo.class);
                model.put("billDetail",JSONObject.parseObject(data.get("result").toString()));
            }
        }

        return new ModelAndView("hrms-wage/showBillMessage", model);
    }

    @RequestMapping(value = "/showBillMessageFinance")
    public ModelAndView showBillMessageFinance(Integer billId, ModelMap model){
        String url = "bill/findBillDetail";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        FindBillParam param = new FindBillParam();
        param.setBillId(billId);

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
        String resultStatus = postJson.getString("status");
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            if(data!=null){
                BillDetailVo vo = JSONObject.parseObject(data.get("result").toString(),BillDetailVo.class);
                model.put("billDetail",JSONObject.parseObject(data.get("result").toString()));
            }
        }

        return new ModelAndView("hrms-wage/showBillMessageFinance", model);
    }

    /*       wage       */
    @RequestMapping(value = "/getAllWages")
    public ModelAndView getAllWages(HttpServletRequest request,ModelMap model) {
        searchWage(null,0, model);

        return new ModelAndView("hrms-wage/wageInfo", model);
    }

    @RequestMapping(value = "/searchWageIndex")
    public ModelAndView searchWageIndex(FindAllWageParam param, ModelMap model){
        searchWage(param,0,model);
        return new ModelAndView("hrms-wage/wageInfo", model);
    }

    @RequestMapping(value = "/searchWage")
    public ModelAndView searchWage(FindAllWageParam param, @RequestParam("page") int page, ModelMap model){
        String url = "wage/findAllWages";

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
                FindAllWageVo vo = JSONObject.parseObject(data.get("result").toString(),FindAllWageVo.class);
                Paginator<WageDetail> paginator = new Paginator<WageDetail>(
                        vo.getWageDetails(), vo.getCount(), page + 1,pageSize);
                model.put("paginator", paginator);
            }
        }

        model.put("searchParam",param);

        return new ModelAndView("hrms-wage/wageTable", model);
    }


    @ResponseBody
    @RequestMapping(value = "/findWageDetail")
    public String findWageDetail(Integer userId, ModelMap model){
        String url = "wage/findWageDetail";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        FindWageDetail param = new FindWageDetail();
        param.setUserId(userId);
        param.setIsFinance((byte) 1);

        Grid grid = new Grid();

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

        return JSON.toJSONString(grid);
    }

    @ResponseBody
    @RequestMapping(value = "/updateUserWage")
    public String updateUserWage(UpdateUserWageParam param, ModelMap model){
        String url = "wage/updateUserWage";

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


    /*   finance bill*/

    @RequestMapping(value = "/getAllFinanceBills")
    public ModelAndView getAllFinanceBills(HttpServletRequest request,ModelMap model) {
        searchFinanceBill(null,0, model);

        return new ModelAndView("hrms-wage/billInfo", model);
    }

    @RequestMapping(value = "/searchFinanceBillIndex")
    public ModelAndView searchFinanceBillIndex(SearchBillParam param, ModelMap model){
        searchFinanceBill(param,0,model);
        return new ModelAndView("hrms-wage/billInfo", model);
    }

    @RequestMapping(value = "/searchFinanceBill")
    public ModelAndView searchFinanceBill(SearchBillParam param, @RequestParam("page") int page, ModelMap model){
        String url = "bill/searchBill";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(page);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        if(param == null){
            param = new SearchBillParam();
        }
        param.setIsFinance((byte) 1);

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);
        String resultStatus = postJson.getString("status");
        if(resultStatus.equals("0000")){
            JSONObject data = postJson.getJSONObject("data");
            if(data!=null){
                BillDetailVo vo = JSONObject.parseObject(data.get("result").toString(),BillDetailVo.class);
                Paginator<BillDetail> paginator = new Paginator<BillDetail>(
                        vo.getBillDetails(), vo.getCount(), page + 1,pageSize);
                model.put("paginator", paginator);
            }
        }

        model.put("searchParam",param);

        return new ModelAndView("hrms-wage/billTable", model);
    }

    @RequestMapping(value = "/exportInfo")
    @ResponseBody
    public String exportInfo(HttpServletRequest request) throws Exception{
        Grid grid=new Grid();
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());
        multipartResolver.setDefaultEncoding("utf-8");
        MultipartHttpServletRequest multiRequest = multipartResolver
                .resolveMultipart(request);
        MultipartFile file = multiRequest.getFile("file");
        try{
            InputStream input = file.getInputStream();
            //POIFSFileSystem fs = new POIFSFileSystem(input);
            //HSSFWorkbook wb = new HSSFWorkbook(fs);
            Workbook wb = WorkbookFactory.create(input);
            List<SaveWageInfo> list=new ArrayList<SaveWageInfo>();
            SaveWageParam param=new SaveWageParam();
            for (int work=0;work<wb.getNumberOfSheets();work++){
                Sheet sheet = wb.getSheetAt(work);
                System.out.println("lastRowNumer:"+sheet.getLastRowNum());
                for (int rownum = 1; rownum <= sheet.getLastRowNum(); rownum++) {
                    if(sheet.getRow(rownum)!=null&&
                            (sheet.getRow(rownum).getCell(0)!=null&&
                                    sheet.getRow(rownum).getCell(0).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(1)!=null&&
                            sheet.getRow(rownum).getCell(1).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(2)!=null&&
                            sheet.getRow(rownum).getCell(2).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(3)!=null&&
                            sheet.getRow(rownum).getCell(3).toString().trim()!="")){

                        System.out.println(sheet.getRow(rownum));

                        Row row_one = sheet.getRow(rownum);
                        row_one.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_0 = row_one.getCell(0);

                        row_one.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_1 = row_one.getCell(1);

                        row_one.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_2 = row_one.getCell(2);

                        row_one.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_3 = row_one.getCell(3);

                        SaveWageInfo saveWageInfo=new SaveWageInfo();
                        saveWageInfo.setUserPhone(cell_0.getStringCellValue().trim());
                        saveWageInfo.setBaseWage(ParseUtil.parseBigDecimal(cell_1.getStringCellValue().trim()));
                        saveWageInfo.setSubsidyPhone(ParseUtil.parseBigDecimal(cell_2.getStringCellValue().trim()));
                        saveWageInfo.setSubsidyOther(ParseUtil.parseBigDecimal(cell_3.getStringCellValue().trim()));
                        if(row_one.getCell(4) != null){
                            row_one.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                            Cell cell_4 = row_one.getCell(4);
                            if(!StringUtil.isEmpty(cell_4.getStringCellValue())){
                                saveWageInfo.setSubsidyOtherDesc(cell_4.getStringCellValue().trim());
                            }
                        }


                        list.add(saveWageInfo);
                    }
                }
            }
            param.setWageInfos(list);

            CommonParams commonParams = new CommonParams();
            commonParams.setUserId(getCurrentUser().getUserId());
            commonParams.setOrgId(getCurrentUser().getOrgId());
            commonParams.setPage(0);
            commonParams.setPagesize(pageSize);

            JSONObject postJson = new BssReturnJson(appProperties).postJson(
                    "wage/batchSave", param, commonParams,
                    JSONObject.class);
            if (postJson != null) {
                grid.setCode(postJson.getString("status"));
                grid.setMessage(postJson.getString("message"));
            }
        }catch(Exception e){
            System.out.println("报错：文件格式不正确");
            grid.setMessage("fail");
            e.printStackTrace();
        }
        return JSON.toJSONString(grid);
    }

}
