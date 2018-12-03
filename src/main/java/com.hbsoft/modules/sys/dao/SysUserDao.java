package com.hbsoft.modules.sys.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.hbsoft.modules.sys.entity.SysUserEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * ClassName:OrderDaoImpe.java
 * Function: TODO ADD FUNCTION
 * Reason:	 TODO ADD REASON
 *
 * @author 张亚强
 * @version Ver 1.1
 * @Date 2018/9/7 16:33
 * @see
 * @since
 */
@Mapper
public interface SysUserDao extends BaseMapper<SysUserEntity>{
    /**
     * 查询用户的所有权限
     * @param userId  用户ID
     */
    List<String> queryAllPerms(Long userId);

    /**
     * 查询用户的所有菜单ID
     */
    List<Long> queryAllMenuId(Long userId);

    /**
     * 根据用户名，查询系统用户
     */
    SysUserEntity queryByUserName(String username);

}
