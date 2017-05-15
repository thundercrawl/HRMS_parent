package hrms.bss.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.model.common.Paginator;
import hrms.po.ChangeUserStatusParam;
import hrms.po.DeleteFromOrg;
import hrms.po.FindUserParam;
import hrms.po.RegisterUserInfo;
import hrms.po.SaveUserParam;
import hrms.po.UpdateUserParam;
import hrms.util.BssReturnJson;
import hrms.util.DateUtil;
import hrms.util.Grid;
import hrms.util.ParseUtil;
import hrms.util.StringUtil;
import hrms.vo.ShowUserVo;
import hrms.vo.UserDetail;
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
@RequestMapping(value = "/filter/user")
public class UserController extends BaseController{

    private static final int pageSize = 5;

	@RequestMapping(value = "/getAllUser")
	public ModelAndView getAllUser(HttpServletRequest request,ModelMap model) {
		searchUser(null,0, model);

		return new ModelAndView("userManager/user", model);
	}

    @RequestMapping(value = "/getUserFromOrg")
    public ModelAndView getUserFromOrg(FindUserParam param,HttpServletRequest request,ModelMap model) {
        searchUser(param,0, model);

        return new ModelAndView("userManager/user", model);
    }


    @RequestMapping(value = "/searchUserIndex")
    public ModelAndView searchUser(FindUserParam param, ModelMap model){
        searchUser(param,0,model);
        return new ModelAndView("userManager/user", model);
    }

	@RequestMapping(value = "/searchUser")
	public ModelAndView searchUser(FindUserParam param,@RequestParam("page") int page, ModelMap model){
		String url = "userInfo/findUsers";

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
				ShowUserVo showUserVo = JSONObject.parseObject(data.get("result").toString(),ShowUserVo.class);
                List<UserDetail> userInfos = showUserVo.getUserInfos();
                Integer count = JSONObject.parseObject(data.get("count").toString(), Integer.class);
                Paginator<UserDetail> paginator = new Paginator<UserDetail>(
                		userInfos, count, page + 1,pageSize);
        		model.put("paginator", paginator);

        		model.put("roleInfos",showUserVo.getRoleInfos());
        		model.put("orgInfos",showUserVo.getOrgInfos());

			}

		}

        model.put("searchParam",param);

        return new ModelAndView("userManager/comtable", model);
	}

    @ResponseBody
    @RequestMapping(value = "/resetPwd")
    public String resetPwd(Integer userID, ModelMap modelMap){

        String url = "userInfo/resetPwd";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        JSONObject postJson = BssReturnJson.postJson(url, userID, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return JSON.toJSONString(grid);
    }

    @ResponseBody
    @RequestMapping(value = "/updateUser")
    public String updateUser(UpdateUserParam param, ModelMap modelMap){

        String url = "userInfo/updateUser";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        try {
            if(! StringUtil.isEmpty(param.getBirthOfDate()))   param.setBirthOfDate(DateUtil.formatDate(DateUtil.SHORT_FORMAT,DateUtil.parse(param.getBirthOfDate(),DateUtil.SHORT_EN_FORMAT)));
        }catch (Exception e){
            Grid grid = new Grid();
            grid.setCode("1111");
            grid.setMessage("时间格式错误：yyyyMMdd");
            return JSON.toJSONString(grid);
        }

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return JSON.toJSONString(grid);
    }


    @ResponseBody
    @RequestMapping(value = "/updateCurrent")
    public String updateCurrent(UpdateUserParam param, ModelMap modelMap){

        String url = "userInfo/updateUser";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        param.setUserID(1);

        try {
            if(! StringUtil.isEmpty(param.getBirthOfDate()))   param.setBirthOfDate(DateUtil.formatDate(DateUtil.SHORT_FORMAT,DateUtil.parse(param.getBirthOfDate(),DateUtil.SHORT_EN_FORMAT)));
        }catch (Exception e){
            Grid grid = new Grid();
            grid.setCode("1111");
            grid.setMessage("时间格式错误：yyyyMMdd");
            return JSON.toJSONString(grid);
        }

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return JSON.toJSONString(grid);
    }

    @ResponseBody
    @RequestMapping(value = "/createUser")
    public String createUser(RegisterUserInfo registerUserInfo,ModelMap modelMap){
        String url = "userInfo/saveUser";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        SaveUserParam param = new SaveUserParam();
        List<RegisterUserInfo> list = new ArrayList<>();
        list.add(registerUserInfo);
        param.setRegisterUserInfos(list);

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return JSON.toJSONString(grid);
    }

    @ResponseBody
    @RequestMapping(value = "/changeUserStatus")
    public String changeUserStatus(ChangeUserStatusParam param,ModelMap modelMap){
        String url = "userInfo/changeStatus";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(3);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return JSON.toJSONString(grid);
    }

    @ResponseBody
    @RequestMapping(value = "/deleteUser")
    public String deleteUser(Integer userID,ModelMap modelMap){
        ChangeUserStatusParam param = new ChangeUserStatusParam();
        param.setUserStatus(Constant.STATUS_DISABLE+"");
        param.setUserID(userID);
        return changeUserStatus(param, modelMap);
    }

    @RequestMapping(value = "/lockUser")
    @ResponseBody
    public String lockUser(Integer userID,ModelMap modelMap){
        ChangeUserStatusParam param = new ChangeUserStatusParam();
        param.setWorkStatus(Constant.STATUS_DISABLE+"");
        param.setUserID(userID);
        return JSON.toJSONString(changeUserStatus(param, modelMap));
//        return ;
    }

    @RequestMapping(value = "/unlockUser")
    @ResponseBody
    public String unlockUser(Integer userID,ModelMap modelMap){
        ChangeUserStatusParam param = new ChangeUserStatusParam();
        param.setWorkStatus(Constant.STATUS_ABLE+"");
        param.setUserID(userID);
        return changeUserStatus(param, modelMap);
    }



    @RequestMapping(value = "/deleteFromOrg")
    @ResponseBody
    public String deleteFromOrg(DeleteFromOrg param, ModelMap modelMap){
        String url = "orgMember/deleteFromOrg";

        BssReturnJson BssReturnJson=new BssReturnJson(appProperties);
        CommonParams commonParams = new CommonParams();
        commonParams.setPage(0);
        commonParams.setPagesize(pageSize);
        commonParams.setUserId(getCurrentUser().getUserId());
        commonParams.setOrgId(getCurrentUser().getOrgId());

        JSONObject postJson = BssReturnJson.postJson(url, param, commonParams, JSONObject.class);

        Grid grid = new Grid();
        grid.setCode(postJson.getString("status"));
        grid.setMessage(postJson.getString("message"));

        return JSON.toJSONString(grid);
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
            List<RegisterUserInfo> userlist=new ArrayList<RegisterUserInfo>();
            SaveUserParam param=new SaveUserParam();
            for (int work=0;work<wb.getNumberOfSheets();work++){
                Sheet sheet = wb.getSheetAt(work);
                System.out.println(sheet.getLastRowNum()+"111111111111111111111");
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
                            sheet.getRow(rownum).getCell(6).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(7)!=null&&
                            sheet.getRow(rownum).getCell(7).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(8)!=null&&
                            sheet.getRow(rownum).getCell(8).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(9)!=null&&
                            sheet.getRow(rownum).getCell(9).toString().trim()!="")
                            &&(sheet.getRow(rownum).getCell(10)!=null&&
                            sheet.getRow(rownum).getCell(10).toString().trim()!="")){
                        System.out.println(rownum);

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

                        row_one.getCell(7).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_7 = row_one.getCell(7);

                        row_one.getCell(8).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_8 = row_one.getCell(8);

                        row_one.getCell(9).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_9 = row_one.getCell(9);

                        row_one.getCell(10).setCellType(Cell.CELL_TYPE_STRING);
                        Cell cell_10 = row_one.getCell(10);

                        RegisterUserInfo registerUserInfo=new RegisterUserInfo();
                        registerUserInfo.setUserName(cell_0.getStringCellValue().trim());
                        registerUserInfo.setUserPhone(cell_1.getStringCellValue().trim());
                        registerUserInfo.setSex(ParseUtil.parseByte(cell_2.getStringCellValue().trim()));
                        registerUserInfo.setUserEmail(cell_3.getStringCellValue().trim());
                        registerUserInfo.setUserCardNumber(cell_4.getStringCellValue().trim());
                        registerUserInfo.setDataOfBirth(cell_5.getStringCellValue().trim());
                        registerUserInfo.setWorkTime(cell_6.getStringCellValue().trim());
                        registerUserInfo.setRoleID(ParseUtil.parseInt(cell_7.getStringCellValue().trim()));
                        registerUserInfo.setIsOrgManager(ParseUtil.parseByte(cell_8.getStringCellValue().trim()));
                        registerUserInfo.setOrgName(cell_9.getStringCellValue().trim());
                        registerUserInfo.setJobName(cell_10.getStringCellValue().trim());

                        userlist.add(registerUserInfo);
                    }
                }
            }
            param.setRegisterUserInfos(userlist);

            CommonParams commonParams = new CommonParams();
            commonParams.setUserId(getCurrentUser().getUserId());
            commonParams.setOrgId(getCurrentUser().getOrgId());
            commonParams.setPage(0);
            commonParams.setPagesize(pageSize);

            JSONObject postJson = new BssReturnJson(appProperties).postJson(
                    "userInfo/saveUser", param, commonParams,
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
