package hrms.service.impl.user;

import hrms.common.CommonParams;
import hrms.po.FindUserParam;
import hrms.po.LoginParam;
import hrms.po.RegisterUserInfo;
import hrms.vo.MsgVo;

import java.util.List;

/**
 * Created by 谢益文 on 2017/3/20.
 */
public interface UserInfoService {

    /**
     * @describe 批量注册用户
     * @param registerUserInfos
     */
    public MsgVo save(List<RegisterUserInfo> registerUserInfos, CommonParams commonParams);

    /**
     * @describe 用户登录
     * @return
     */
    public MsgVo login(LoginParam param);

    public MsgVo findUsers(FindUserParam param,Integer userID, CommonParams commonParams);

    public MsgVo findUserDetail(Integer userID,CommonParams commonParams);
}
