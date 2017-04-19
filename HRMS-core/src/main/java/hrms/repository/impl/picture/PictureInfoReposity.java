package hrms.repository.impl.picture;

import hrms.common.Constant;
import hrms.entity.PictureInfo;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 * Created by 谢益文 on 2017/4/2.
 */
@Repository("pictureInfoReposity")
public class PictureInfoReposity extends RepositorySupport<PictureInfo> {


    /**
     * @describe 查询用户头像
     * @author xieyw
     * @param userID
     * @return
     */
    public PictureInfo findUserPhoto(Integer userID){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(PictureInfo.class);
        detachedCriteria.add(Restrictions.eq("picStatus", Constant.STATUS_ABLE))
                .add(Restrictions.eq("relId",userID))
                .add(Restrictions.eq("relType",Constant.REL_TYPE_USER_PHOTO));

        return this.findOne(detachedCriteria);
    }
}
