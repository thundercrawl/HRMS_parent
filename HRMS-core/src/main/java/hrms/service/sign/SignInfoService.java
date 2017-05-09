package hrms.service.sign;

import hrms.common.CommonParams;
import hrms.po.FindSignParam;
import hrms.po.SaveSignParam;
import hrms.vo.MsgVo;

/**
 * Created by 谢益文 on 2017/5/2.
 */
public interface SignInfoService {
    public MsgVo batchSave(SaveSignParam param, CommonParams commonParams);

    public MsgVo findSigns(FindSignParam param, CommonParams commonParams);
}
