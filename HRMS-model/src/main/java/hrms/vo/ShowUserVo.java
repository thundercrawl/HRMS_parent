package hrms.vo;

import java.util.List;

/**
 * Created by 谢益文 on 2017/4/2.
 */
public class ShowUserVo {
    private List<UserDetail> userInfos;

    public List<UserDetail> getUserInfos() {
        return userInfos;
    }

    public void setUserInfos(List<UserDetail> userInfos) {
        this.userInfos = userInfos;
    }
}
