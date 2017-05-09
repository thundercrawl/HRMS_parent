package hrms.po;

import java.io.Serializable;

/**
 * Created by 谢益文 on 2017/4/25.
 */
public class UpdateUserPwd implements Serializable{

    private String oldPwd;
    private String newPwd;

    public String getOldPwd() {
        return oldPwd;
    }

    public void setOldPwd(String oldPwd) {
        this.oldPwd = oldPwd;
    }

    public String getNewPwd() {
        return newPwd;
    }

    public void setNewPwd(String newPwd) {
        this.newPwd = newPwd;
    }
}
