package hrms.repository.impl.sys;

import hrms.entity.SysParamConfig;
import hrms.repository.RepositorySupport;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

/**
 * Created by 谢益文 on 2017/3/20.
 */
@Repository("sysParamConfigRepository")
public class SysParamConfigRepository extends RepositorySupport<SysParamConfig> {

    /**
     * @describe 通过paramID查找对应的系统配置
     * @param paramID
     * @return
     */
    public SysParamConfig findByID(String paramID){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(SysParamConfig.class);
        detachedCriteria.add(Restrictions.eq("paramId",paramID));
        return this.findOne(detachedCriteria);
    }
}
