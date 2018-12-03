package com.hbsoft.modules.sys.controller;

import com.hbsoft.common.utils.R;
import com.hbsoft.modules.sys.entity.SysUserEntity;
import com.hbsoft.modules.sys.form.SysLoginForm;
import com.hbsoft.modules.sys.service.SysUserService;
import com.hbsoft.modules.sys.service.SysUserTokenService;
import org.apache.commons.io.IOUtils;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;


import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;

import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Map;


/**
 * ClassName:OrderDaoImpe.java
 * Function: TODO ADD FUNCTION
 * Reason:	 TODO ADD REASON
 * 登录相关
 * @author 张亚强
 * @version Ver 1.1
 * @Date 2018/9/7 17:06
 * @see
 * @since
 */
@RestController
public class SysLoginController extends AbstractController{
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private SysUserTokenService sysUserTokenService;

//    /**
//     * 验证码
//     */
//    @GetMapping("captcha.jpg")
//    public void captcha(HttpServletResponse response, String uuid)throws ServletException, IOException {
//        response.setHeader("Cache-Control", "no-store, no-cache");
//        response.setContentType("image/jpeg");
//        //获取图片验证码
//        BufferedImage image = sysCaptchaService.getCaptcha(uuid);
//        ServletOutputStream out = response.getOutputStream();
//        ImageIO.write(image, "jpg", out);
//        IOUtils.closeQuietly(out);
//    }

    /**
     * 登录
     */
    @PostMapping("/sys/login")
    public Map<String, Object> login(SysLoginForm form)throws IOException {
        System.out.println(form);
//        boolean captcha = sysCaptchaService.validate(form.getUuid(), form.getCaptcha());
//        if(!captcha){
//            return R.error("验证码不正确");
//        }

        //用户信息
        SysUserEntity user = sysUserService.queryByUserName(form.getUsername());
        //账号不存在、密码错误
        if(user == null || !user.getPassword().equals(new Sha256Hash(form.getPassword(), user.getSalt()).toHex())) {
            return R.error("账号或密码不正确");
        }

        //账号锁定
        if(user.getStatus() == 0){
            return R.error("账号已被锁定,请联系管理员");
        }

        //生成token，并保存到数据库
        R r = sysUserTokenService.createToken(user.getUserId());
        System.out.println(r);
        return r.put("newname",form.getNewname());
    }


    /**
     * 退出
     */
    @PostMapping("/sys/logout")
    public R logout() {
        sysUserTokenService.logout(getUserId());
        return R.ok();
    }
}
