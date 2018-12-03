package com.hbsoft.modules.sys.controller;

import com.hbsoft.modules.sys.entity.SysUserEntity;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * ClassName:OrderDaoImpe.java
 * Function: TODO ADD FUNCTION
 * Reason:	 TODO ADD REASON
 * 公共组件
 * @author 张亚强
 * @version Ver 1.1
 * @Date 2018/9/10 09:59
 * @see
 * @since
 */
public abstract class AbstractController {
    protected Logger logger = LoggerFactory.getLogger(getClass());

    protected SysUserEntity getUser() {
        return (SysUserEntity) SecurityUtils.getSubject().getPrincipal();
    }

    protected Long getUserId() {
        return getUser().getUserId();
    }
}
