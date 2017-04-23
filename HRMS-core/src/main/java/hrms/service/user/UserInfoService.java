package hrms.service.user;

import hrms.common.CommonParams;
import hrms.po.FindUserParam;
import hrms.po.LoginParam;
import hrms.po.RegisterUserInfo;
import hrms.po.UpdateUserParam;
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

    /**
     * @describe 条件查找用户
     * @param param
     * @param commonParams
     * @return
     */
    public MsgVo findUsers(FindUserParam param, CommonParams commonParams);

    /**
     * @describe 查看用户详情
     * @param userID
     * @param commonParams
     * @return
     */
    public MsgVo findUserDetail(Integer userID,CommonParams commonParams);

    /**
     * @describe 更新用户资料    姓名、出生年月、性別、手机号码、email
     * @param param
     * @param commonParams
     * @return
     */
    public MsgVo updateUser(UpdateUserParam param, CommonParams commonParams);

    /**
     * @describe 上传用户头像
     * @author xieyw
     * @param picName
     * @param commonParams
     * @return
     */
    public MsgVo uploadUserPhoto(String picName,CommonParams commonParams);

    /**
     * @describe 重置密码
     * @author xieyw
     * @param userID
     * @param commonParams
     * @return
     */
    public MsgVo resetPwd(Integer userID,CommonParams commonParams);
}
