package hrms.bss.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.model.common.Paginator;
import hrms.po.FindSignParam;
import hrms.po.SaveSignInfo;
import hrms.po.SaveSignParam;
import hrms.util.BssReturnJson;
import hrms.util.Grid;
import hrms.util.ParseUtil;
import hrms.vo.FindSignsVo;
import hrms.vo.SignInfoDetail;
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
@RequestMapping(value = "/filter/sign")
public class SignController extends BaseController{

    private static final int pageSize = 5;

	@RequestMapping(value = "/getAllSign")
	public ModelAndView getAllSign(HttpServletRequest request,ModelMap model) {
		searchSign(null,0, model);

		return new ModelAndView("hrms-sign/signInfo", model);
	}

    @RequestMapping(value = "/searchSignIndex")
    public ModelAndView searchSign(FindSignParam param, ModelMap model){
        searchSign(param,0,model);
        return new ModelAndView("hrms-sign/signInfo", model);
    }

	@RequestMapping(value = "/searchSign")
	public ModelAndView searchSign(FindSignParam param, @RequestParam("page") int page, ModelMap model){
		String url = "sign/findSigns";

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
                FindSignsVo vo = JSONObject.parseObject(data.get("result").toString(),FindSignsVo.class);
                Integer count = JSONObject.parseObject(data.get("count").toString(), Integer.class);
                Paginator<SignInfoDetail> paginator = new Paginator<SignInfoDetail>(
                        vo.getSignInfoDetails(), count, page + 1,pageSize);
        		model.put("paginator", paginator);
			}
		}

        model.put("searchParam",param);

        return new ModelAndView("hrms-sign/signTable", model);
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
            List<SaveSignInfo> signList=new ArrayList<SaveSignInfo>();
            SaveSignParam param=new SaveSignParam();
            for (int work=0;work<wb.getNumberOfSheets();work++){
                Sheet sheet = wb.getSheetAt(work);
                for (int rownum = 1; rownum <= sheet.getLastRowNum(); rownum++) {
                    if(sheet.getRow(rownum)!=null&&
                            (sheet.getRow(rownum).getCell(0)!=null&&
                                    sheet.getRow(rownum).getCell(0).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(1)!=null&&
                            sheet.getRow(rownum).getCell(1).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(2)!=null&&
                            sheet.getRow(rownum).getCell(2).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(3)!=null&&
                            sheet.getRow(rownum).getCell(3).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(4)!=null&&
                            sheet.getRow(rownum).getCell(4).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(5)!=null&&
                            sheet.getRow(rownum).getCell(5).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(6)!=null&&
                            sheet.getRow(rownum).getCell(6).toString().trim()!="")){
                        Row row_one = sheet.getRow(rownum);
                        row_one.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_0 = row_one.getCell(0);

                        row_one.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_1 = row_one.getCell(1);

                        row_one.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_2 = row_one.getCell(2);

                        row_one.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_3 = row_one.getCell(3);

                        row_one.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_4 = row_one.getCell(4);

                        row_one.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_5 = row_one.getCell(5);

                        row_one.getCell(6).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_6 = row_one.getCell(6);

                        SaveSignInfo signInfo=new SaveSignInfo();
                        String signDate = cell_2.getStringCellValue().trim();
                        signInfo.setUserPhone(cell_1.getStringCellValue().trim());
                        signInfo.setSignInStatus(ParseUtil.parseByte(cell_3.getStringCellValue().trim()));
                        signInfo.setSignInTime(signDate+" "+cell_4.getStringCellValue().trim()+":00");
                        signInfo.setSignOutStatus(ParseUtil.parseByte(cell_5.getStringCellValue().trim()));
                        signInfo.setSignOutTime(signDate+" "+cell_6.getStringCellValue().trim()+":00");

                        signList.add(signInfo);
                    }
                }
            }
            param.setSignInfos(signList);

            CommonParams commonParams = new CommonParams();
            commonParams.setUserId(getCurrentUser().getUserId());
            commonParams.setOrgId(getCurrentUser().getOrgId());
            commonParams.setPage(0);
            commonParams.setPagesize(pageSize);

            JSONObject postJson = new BssReturnJson(appProperties).postJson(
                    "sign/batchSave", param, commonParams,
                    JSONObject.class);
            if (postJson != null) {
                grid.setCode(postJson.getString("status"));
                grid.setMessage(postJson.getString("message"));
            }
        }catch(Exception e){
            grid.setCode("0000");
            grid.setMessage("报错：文件格式不正确");
            e.printStackTrace();
        }
        return JSON.toJSONString(grid);
    }

}
