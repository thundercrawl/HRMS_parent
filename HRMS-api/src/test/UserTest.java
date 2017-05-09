import com.alibaba.fastjson.JSONObject;
import hrms.common.CommonParams;
import hrms.common.Constant;
import hrms.po.RegisterUserInfo;
import hrms.po.SaveUserParam;
import hrms.util.DateUtil;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 谢益文 on 2017/4/21.
 */
public class UserTest {
    private static String url = "http://localhost:8888/HRMS-api";
    public static void main(String[] args) {
        try {
//            user117(url+ "/secSearchBil/billInfoOut", paramStr());//出账
//            user117(url+ "/userInfo/findUsers", paramStr());//查询用户
//            user117(url+ "/userInfo/findUserDetail", paramStr());//查询用户详情
//            user117(url+ "/userInfo/updateUser", paramStr());//更新用户资料
//            user117(url+ "/userInfo/uploadUserPhoto", paramStr());//上传头像
//            user117(url+ "/userInfo/login", paramStr());//登录
            user117(url+ "/userInfo/saveUser", paramStr());//批量注册

        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    public static Object paramsObject(){//入参分装contractId
//		private String tableName;
        String columnName = "";
//        String param = "{\"userPhone\":\"0194\",\"endTime\":\"ASSET_TYPE\"}";
        String param = "{\"userPhone\":\"0194\"}";
        param = "{\"userID\":1}";
        param = "{\"userID\":\"1\",\"userSex\":\"2\",\"birthOfDate\":\"2000-01-10\",\"userEmail\":\"4312@qq.com\",\"userPhone\":\"18201947095\"}";
        param = "{\"picName\":\"default_user_photo_1.jpg\"}";
        param = "{\"userPhone\":\"18201947095\",\"userPasswd\":\"xieyiwen\"}";

        SaveUserParam saveUserParam = new SaveUserParam();
        List<RegisterUserInfo> registerUserInfos = new ArrayList<>();
        RegisterUserInfo registerUserInfo = new RegisterUserInfo();
        registerUserInfo.setOrgName("IT Org");
        registerUserInfo.setUserName("wu li tou 1");
        registerUserInfo.setDataOfBirth("1996-01-02");
        registerUserInfo.setIsOrgManager((byte) 1);
        registerUserInfo.setJobName("org manager");
        registerUserInfo.setRoleID(Constant.ROLE_WORKER_VALUE);
        registerUserInfo.setSex((byte) 1);
        registerUserInfo.setUserCardNumber("432503199601022222");
        registerUserInfo.setUserEmail("341234@qq.com");
        registerUserInfo.setUserPhone("18201947196");
        registerUserInfo.setWorkTime("2017-02-02");
        registerUserInfos.add(registerUserInfo);

        registerUserInfo = new RegisterUserInfo();
        registerUserInfo.setOrgName("IT Org");
        registerUserInfo.setUserName("wu li tou 2");
        registerUserInfo.setDataOfBirth("1996-01-02");
        registerUserInfo.setIsOrgManager((byte) 0);
        registerUserInfo.setJobName("IT programmer");
        registerUserInfo.setRoleID(Constant.ROLE_WORKER_VALUE);
        registerUserInfo.setSex((byte) 1);
        registerUserInfo.setUserCardNumber("432503199601033333");
        registerUserInfo.setUserEmail("341234@qq.com");
        registerUserInfo.setUserPhone("18201947197");
        registerUserInfo.setWorkTime("2017-02-02");
        registerUserInfos.add(registerUserInfo);
        registerUserInfo = new RegisterUserInfo();
        registerUserInfo.setOrgName("IT Org");
        registerUserInfo.setUserName("wu li tou 2");
        registerUserInfo.setDataOfBirth("1996-01-02");
        registerUserInfo.setIsOrgManager((byte) 0);
        registerUserInfo.setJobName("IT programmer");
        registerUserInfo.setRoleID(Constant.ROLE_WORKER_VALUE);
        registerUserInfo.setSex((byte) 1);
        registerUserInfo.setUserCardNumber("432503199601033333");
        registerUserInfo.setUserEmail("341234@qq.com");
        registerUserInfo.setUserPhone("18201947198");
        registerUserInfo.setWorkTime("2017-02-02");
        registerUserInfos.add(registerUserInfo);
        registerUserInfo = new RegisterUserInfo();
        registerUserInfo.setOrgName("IT Org");
        registerUserInfo.setUserName("wu li tou 2");
        registerUserInfo.setDataOfBirth("1996-01-02");
        registerUserInfo.setIsOrgManager((byte) 0);
        registerUserInfo.setJobName("IT programmer");
        registerUserInfo.setRoleID(Constant.ROLE_WORKER_VALUE);
        registerUserInfo.setSex((byte) 1);
        registerUserInfo.setUserCardNumber("432503199601033333");
        registerUserInfo.setUserEmail("341234@qq.com");
        registerUserInfo.setUserPhone("18201947199");
        registerUserInfo.setWorkTime("2017-02-02");
        registerUserInfos.add(registerUserInfo);
        registerUserInfo = new RegisterUserInfo();
        registerUserInfo.setOrgName("IT Org");
        registerUserInfo.setUserName("wu li tou 2");
        registerUserInfo.setDataOfBirth("1996-01-02");
        registerUserInfo.setIsOrgManager((byte) 0);
        registerUserInfo.setJobName("IT programmer");
        registerUserInfo.setRoleID(Constant.ROLE_WORKER_VALUE);
        registerUserInfo.setSex((byte) 1);
        registerUserInfo.setUserCardNumber("432503199601033333");
        registerUserInfo.setUserEmail("341234@qq.com");
        registerUserInfo.setUserPhone("18201947110");
        registerUserInfo.setWorkTime("2017-02-02");
        registerUserInfos.add(registerUserInfo);
        registerUserInfo = new RegisterUserInfo();
        registerUserInfo.setOrgName("IT Org");
        registerUserInfo.setUserName("wu li tou 2");
        registerUserInfo.setDataOfBirth("1996-01-02");
        registerUserInfo.setIsOrgManager((byte) 0);
        registerUserInfo.setJobName("IT programmer");
        registerUserInfo.setRoleID(Constant.ROLE_WORKER_VALUE);
        registerUserInfo.setSex((byte) 1);
        registerUserInfo.setUserCardNumber("432503199601033333");
        registerUserInfo.setUserEmail("341234@qq.com");
        registerUserInfo.setUserPhone("18201947111");
        registerUserInfo.setWorkTime("2017-02-02");
        registerUserInfos.add(registerUserInfo);
        registerUserInfo = new RegisterUserInfo();
        registerUserInfo.setOrgName("IT Org");
        registerUserInfo.setUserName("wu li tou 2");
        registerUserInfo.setDataOfBirth("1996-01-02");
        registerUserInfo.setIsOrgManager((byte) 0);
        registerUserInfo.setJobName("IT programmer");
        registerUserInfo.setRoleID(Constant.ROLE_WORKER_VALUE);
        registerUserInfo.setSex((byte) 1);
        registerUserInfo.setUserCardNumber("432503199601033333");
        registerUserInfo.setUserEmail("341234@qq.com");
        registerUserInfo.setUserPhone("18201947112");
        registerUserInfo.setWorkTime("2017-02-02");
        registerUserInfos.add(registerUserInfo);
        registerUserInfo = new RegisterUserInfo();
        registerUserInfo.setOrgName("IT Org");
        registerUserInfo.setUserName("wu li tou 2");
        registerUserInfo.setDataOfBirth("1996-01-02");
        registerUserInfo.setIsOrgManager((byte) 0);
        registerUserInfo.setJobName("IT programmer");
        registerUserInfo.setRoleID(Constant.ROLE_WORKER_VALUE);
        registerUserInfo.setSex((byte) 1);
        registerUserInfo.setUserCardNumber("432503199601033333");
        registerUserInfo.setUserEmail("341234@qq.com");
        registerUserInfo.setUserPhone("18201947113");
        registerUserInfo.setWorkTime("2017-02-02");
        registerUserInfos.add(registerUserInfo);
        registerUserInfo = new RegisterUserInfo();
        registerUserInfo.setOrgName("IT Org");
        registerUserInfo.setUserName("wu li tou 2");
        registerUserInfo.setDataOfBirth("1996-01-02");
        registerUserInfo.setIsOrgManager((byte) 0);
        registerUserInfo.setJobName("IT programmer");
        registerUserInfo.setRoleID(Constant.ROLE_WORKER_VALUE);
        registerUserInfo.setSex((byte) 1);
        registerUserInfo.setUserCardNumber("432503199601033333");
        registerUserInfo.setUserEmail("341234@qq.com");
        registerUserInfo.setUserPhone("18201947114");
        registerUserInfo.setWorkTime("2017-02-02");
        registerUserInfos.add(registerUserInfo);
        registerUserInfo = new RegisterUserInfo();
        registerUserInfo.setOrgName("IT Org");
        registerUserInfo.setUserName("wu li tou 2");
        registerUserInfo.setDataOfBirth("1996-01-02");
        registerUserInfo.setIsOrgManager((byte) 0);
        registerUserInfo.setJobName("IT programmer");
        registerUserInfo.setRoleID(Constant.ROLE_WORKER_VALUE);
        registerUserInfo.setSex((byte) 1);
        registerUserInfo.setUserCardNumber("432503199601033333");
        registerUserInfo.setUserEmail("341234@qq.com");
        registerUserInfo.setUserPhone("18201947115");
        registerUserInfo.setWorkTime("2017-02-02");
        registerUserInfos.add(registerUserInfo);
        saveUserParam.setRegisterUserInfos(registerUserInfos);

        param = JSONObject.toJSONString(saveUserParam);
        return JSONObject.parseObject(param);
//		return "101483";

    }
    public static String paramStr(){//公共参数
        Map<String, Object> j=new HashMap<String, Object>();
        CommonParams s=new CommonParams();
        s.setUserId(1);//管理员
        s.setOrgId(1);//组织
        s.setPage(0);
        s.setPagesize(3);

        j.put("commonParam", s);
        j.put("object", paramsObject());
        return JSONObject.toJSONString(j);
    }
    public static void user117(String Url,String str) throws UnsupportedEncodingException{
        @SuppressWarnings({ "resource" })
        HttpClient httpclient = new DefaultHttpClient();
        HttpPost httpPost = new HttpPost(Url);
        StringEntity strEntity = new StringEntity(str);
        strEntity.setContentEncoding("UTF-8");
        strEntity.setContentType("application/json; charset=UTF-8");
        httpPost.setEntity(strEntity);
        try {

            @SuppressWarnings("resource")
            HttpResponse httpResponse = new DefaultHttpClient().execute(httpPost);
            HttpEntity entity = httpResponse.getEntity();
            if (entity != null) {
                File file =new File("javaio-appendfile.txt");
                System.err.println(file.getAbsolutePath());
                if(!file.exists()){
                    file.createNewFile();
                }
                FileWriter fileWritter = new FileWriter(file.getName(),true);
                BufferedWriter bf1 = new BufferedWriter(fileWritter);
                // 打印响应内容长度
//				File file=new File("D:/a/file.txt");
//				BufferedWriter bf=new BufferedWriter(new PrintWriter(file));
                String bf ="";
                bf+= DateUtil.formatDate()+"\r\n";
                bf+=Url+"\r\n";
                bf+="入参:"+"\r\n";
                bf+=str+"\r\n";
                String st111r = EntityUtils.toString(entity, "UTF-8");
//				Paginator<RecOut> A= (Paginator)JSONObject.parseObject(st111r);
                    // 打印响应内容
                bf+="出参:"+"\r\n";
                bf+= st111r+"\r\n";
                System.err.println(bf);
                bf1.write(bf);
                bf1.close();
            }
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClientProtocolException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

}
