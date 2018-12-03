<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>系统登录界面</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/login.css" />
    <link href="<%=basePath%>images/title.png" rel="SHORTCUT ICON">
    <script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.9.1.js"></script>
    <style type="text/css">
    </style>
    <script language="javascript">
        jQuery(function($) {
            $("#loginBtn").click(function() {
                if (doLogin()) {
                    userlogin();
                }
            });
            $("#password").keyup(function(event) {
                if (event.keyCode == 13) {
                    if (doLogin()) {
                        userlogin();
                    }
                }
            });
            $(window).keyup(function(event) {
                if (event.keyCode == 13) {
                    if (doLogin()) {
                        userlogin();
                    }
                }
            });

        });
        window.onload = function(){
            func1();
        };
        /*用户登录*/
        function userlogin() {
            var username = $("#username").val();//用户名称
            var userpass = $("#password").val();//用户密码
            var newname = $("#newname").val();//用户密码
            var newnamec = document.getElementById("newname");
            var userdata = "";
            if (newnamec.checked == true) {
                userdata = {
                    "userid" : username,
                    "password" : userpass,
                    "newname" : newname,
                };
            } else {
                userdata = {
                    "userid" : username,
                    "password" : userpass,
                    "newname" : "",
                };
            }
            $.ajax({
                url : "ossLogin.action",
                data : userdata,
                async : false,
                dataType : "json",
                type : "post",
                success : function(data) {
                    if (data.msg == "LOGINSUCCESS") {
                        document.location.replace("index.jsp");
                    } else if (data.msg == "LOGINSTOP") {
                        alert("该用户已被禁用！");
                    } else {
                        alert("用户名密码错误！请重新输入。");
                    }
                },
                error : function(error) {
                    alert("网络状况不佳，用户登录失败！" + error.status);
                }
            });
        }
        function doLogin() {
            var username = $("#username").val();//用户名称
            var userpass = $("#password").val();//用户密码
            if (username == null || username == "") {
                alert("请输入用户名!");
                return false;
            } else if (userpass == null || userpass == "") {
                alert("请输入密码!");
                return false;
            }
            return true;
        }
        function func1() {
            var username = $("#username").val();
            if (username != "") {
                $("#newname").attr("checked", true);
                return false;
            }
            return true;
        }
    </script>
</head>

<body>
<div>
    <!--<div style="width:30%;float:left;margin-top:4%;text-align:center;margin-left:5%;"><img src="images/login/logoname1.png" style="width:924px;"/></div>-->
    <div class="div_title"></div>
    <div class="box">
        <div class="blank">用户登录</div>
        <div style="margin-top: 30px;">
            <div  class="div_img"><img src="images/login/user.png" class="user_img"/></div>
            <div style="float:left" >  <input type="text" id="username" name="username"  class="user_input"/></div>
            <div style="clear: both;"></div>
        </div>
        <div style="margin-top: 18px;">
            <div   class="div_img"><img src="images/login/psd.png" class="user_img"/></div>
            <div style="float:left" >  <input type="password"  id="password" name="password" value="" class="user_input"/></div>
            <div style="clear: both;"></div>
        </div>
        <div style="margin-top: 18px;">
            <div style="margin-left: 36px"><input  id="newname" name="newname" type="checkbox" value="encryption" /><span class="savename">保存用户名</span></div>
        </div>
        <div style="margin-top: 20px;">
            <input class="button" id="loginBtn" type="button" value="登录"  />
        </div>
        <div style="margin-top: 18px;font-weight:bold">
            <a class="chrome" title="本系统推荐使用谷歌浏览器，点击下载" href="<%=basePath %>chrome/chrome39.exe" target="_blank">无法正常登录，下载浏览器>></a>
        </div>
    </div>
</div>
</body>
</html>


