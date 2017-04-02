package hrms.po;

import java.util.List;

/**
 * Created by 谢益文 on 2017/3/22.
 */
public class SaveUserParam {
    private List<RegisterUserInfo> registerUserInfos;

    public List<RegisterUserInfo> getRegisterUserInfos() {
        return registerUserInfos;
    }

    public void setRegisterUserInfos(List<RegisterUserInfo> registerUserInfos) {
        this.registerUserInfos = registerUserInfos;
    }
}
