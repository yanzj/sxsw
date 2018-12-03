<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String bd_rybh = request.getParameter("bd_rybh");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/jquery-validation/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script  type="text/javascript" src="<%=basePath%>include/LigerUI/jquery-validation/messages_cn.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<style type="text/css">
tr {
	line-height: 35px; /*设置行高*/
}

.input_style {
	width: 350px;
	height: 25px;
	background: #F2F2F2;
	margin-left: 10px;
	border: 0px solid #960;
	font-size: 13px;
}

.text_style {
	padding-right: 10px;
	font-size: 13px;
}
</style>
<script>
	//提交数据
	function f_validate(){
		var phone = $("#LXDH").val();	
		var qq = $("#QQ").val();
		var jzdz = $("#JZDZ").val();
		if(phone == "" && qq == "" && jzdz == ""){
			top.my_alert("三项必须填一项!");
			return;
		}
		var rybh = "<%=bd_rybh%>";
		var dataPost = {"model.LXDH":phone,"model.QQ":qq,"model.JZDZ":jzdz,"model.BD_RYBH":rybh};
		return dataPost;
	}
	
    /**判断qq 正则表达式*/
    function qq_validate(){
    	var qq = $("#QQ").val();
    	if(qq != ""){
    		if(!checksqq(qq)){
        		$("#qq_msg").html("格式不正确!");
           		$("#QQ").val("");
        	}else{
        		$("#qq_msg").html("");
        	}
    	}
    }
	/**验证qq 正则表达式*/
	function checksqq(value){
		/**6到12位的qq号码*/	
		var email18 =/^[1-9][0-9]{5,11}$/;
		if(!email18.test(value)){
			return false;
		}
		return true;
	}
	/**验证联系方式*/
	function phone_validate(){
		var phone = $("#LXDH").val();	
		if(phone != ""){
			if(!checkPhoneNum(phone)){
				$("#phone_msg").html("格式不正确!");
           		$("#LXDH").val("");
			}else{
				$("#phone_msg").html("");
			}
		}
	}
	/**手机验证*/
    function checkPhoneNum(value){
		var tel=/^1[3|4|5|8][0-9]\d{4,8}$/;
		if(!tel.test(value)){
			return false;
		}
		return true;
	}
</script>
</head>
<body style="padding-bottom: 20px;">
	<div style="margin-top: 40px;padding-left:45px;">
		<table>
			<tr>
				<td class="text_style">联系电话：</td>
				<td>
					<input type="text" id="LXDH" class="input_style"  onblur="phone_validate();"/>
					<span id="phone_msg" style="mfont-size:15pt;margin-left: 2px;color: red;"></span>
				</td>
			</tr>
			<tr>
				<td class="text_style">QQ号码：</td>
				<td>
					<input type="text" id="QQ" class="input_style" onblur="qq_validate();"/>
					<span id="qq_msg" style="mfont-size:15pt;margin-left: 2px;color: red;"></span>
				</td>
			</tr>
			<tr>
				<td class="text_style">联系地址：</td>
				<td>
					<textarea style="height:70px;margin-top: 5px;" class="input_style" id="JZDZ"></textarea>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
