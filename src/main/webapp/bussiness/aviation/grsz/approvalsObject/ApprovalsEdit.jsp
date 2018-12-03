<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String spdxbh = request.getParameter("spdxbh");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>我的列控对象审批详情页面</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript"
	src="<%=basePath%>bussiness/aviation/grsz/approvalsObject/ApprovalsEdit.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/common.css" />
<style>
.bg {width:100%;height:100%;top:0px;left:0px;position:absolute;filter: Alpha(opacity=50);opacity:0.5; background:#D4D4D4;}
.div1 {
	height: 25px;
	vertical-align: middle;
	clear: both;
	background-color: #C7D9EF;
	font-size: 16px;
	font-weight: bold;
	margin-bottom: 0px;
	padding-left: 20px;
	text-align: center;
	color: #ef7844;
}

.input {
	display: none;
	margin-right: 10px;
}

.txt_title {
	width: 100px;
	color: #b2b2b2;
	font-size: 14px;
}

.tr_height {
	height: 28px;
}

.txt_value {
	font-size: 14px;
	color: #4c4c4c;
}
.bjxxfont{
  color: #b2b2b2;
  font-size: 14px;
}
.bjxxspan{
  margin-left:40px;
  height: 28px;
  line-height:28px;
  font-size: 14px;
  color: #4c4c4c;
}

.button {
	border-radius: 8px;
	width: 130px;
	height: 30px;
	color: white;
}
.lc_zc_font {
	color: #FA4E4F
}
.cl_cjsj {
	color: #FA4E4F;
}

.ry_font {
	color: #346DB2
}
.td_span{
	margin-right:20px;
}
</style>
</head>
<body id = "bg">
	<div
		style="margin-top: 15px;padding-left:20px;margin-bottom: 15px">

		<div style="float: left;width: 16%;padding-right: 40px;">
			<img src="" class="head" id="userimg" style="width:100%; height:200px;" />
		    <div style="border-radius: 8px;height: 30px;width: 140px;background-color: #ef7844;text-align: center;margin: 10px auto;display: none;">
		    	<span id="zt" style="height:100%;line-height:30px;font-size: 18px;color: #ffffff;font-weight: bold;"></span>
		    </div>
		</div>
		<div style="float: left; width: 79%;">
			<div style="height: 56px;">
				<span id="XM" style="height:56px;line-height:56px;font-size: 24px;color: #333333;font-weight: bold; "></span>
				<div style="float: right;border-radius: 8px;margin:13px 400px 13px 0px;height: 30px;width: 120px;background-color: #ef7844;text-align: center;">
					<span id="GKLBMC" style="height:100%;line-height:30px;font-size: 18px;color: #ffffff;font-weight: bold;margin:auto;"></span>
				</div>
			</div>
			<div style="height: 1px;background-color: #b2b2b2;"></div>
			<table style="margin-top: 10px;width: 100%;">
				<tr class="tr_height">
					<td class="txt_title" style="width:11%;">性别</td>
					<td class="txt_value" style="width:35%;"><span id="XB"></span></td>
					<td class="txt_title" style="width:11%;">民族</td>
					<td class="txt_value" style="width:35%;"><span id="MZMC"></span></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">出生日期</td>
					<td class="txt_value" ><span id="CSRQ"></span></td>
					<td class="txt_title">年龄</td>
					<td class="txt_value"><span id="NL"></span></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">住址详情</td>
					<td class="txt_value" colspan="3"><span id="ZZXZ"></span></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">户口地址</td>
					<td class="txt_value" colspan="3"><span id="HKSZD"></span></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">身份证号</td>
					<td class="txt_value"><span id="SFZH"></span></td>
					<td class="txt_title">职业</td>
					<td class="txt_value"><span id="ZY"></span></td>
				</tr>
			</table>
		</div>
		<div style="clear: both; "></div>
	</div>
	<div class="div1" id="lkjl">列控信息</div>
	<div style="margin-top: 5px;padding-left:30px;width: 95%;">
		<table style="width:40%;">
		     <tr class="tr_height">
			    <td class="txt_title">类别：</td>
			    <td class="txt_value"><span class="txt_value"  id="splb"></span></td>
			</tr>
			<tr class="tr_height">
			    <td class="txt_title">状态：</td>
			    <td class="txt_value"><span class="txt_value"  id="spzt"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title">申请时间:</td>
			    <td class="txt_value"><span class="txt_value"  id="CJSJ"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title">申请人:</td>
			    <td class="txt_value"><span class="my_info td_span ry_font" id="CJRXM" onclick="return getCJRXM()"></span><span id="JCMC" class = "td_span"></span><span id="BMMC"></span></td>
			</tr>
		</table>
		<br/>
		<div style="height: 1px;background-color: #b2b2b2;"></div>
		<br />
		<table>
			<tr class="tr_height">
				 <td class="txt_title"><input type="checkbox" name="box"
						value="到期时间" class="input" />到期时间</td>
				 <td class="txt_value"><span id="DQSJ"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title"><input type="checkbox" name="box"
					value="管控类型" class="input" />管控类型：</td>
				<td class="txt_value"><span id="GKLBMC1"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title"><input type="checkbox" name="box"
					value="列控原因" class="input" />列控原因</td>
				<td class="txt_value"><span id="YY"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title"><input type="checkbox" name="box"
					value="预警对象" class="input" />预警对象：</td>
				<td class="txt_value"><span id="YJDXMC"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title"><input type="checkbox" name="box"
					value="预警值班账号" class="input" />预警值班账号：</td>
				<td class="txt_value"><span id="YJBMMC"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title"><input type="checkbox" name="box"
					value="预警要求" class="input" />预警要求：</td>
				<td class="txt_value"><span id="YJYQ"></span></td>
			</tr>
			<tr class="tr_height">
				<td class="txt_title" style="vertical-align:middle;"><input
					type="checkbox" name="box" value="备注说明" class="input" />备注说明：</td>
				<td class="txt_value"><span id="BZ"></span></td>
			</tr>
		</table>
	</div>
	<div id="cxxx" style = "display: none;font-size:13px;"> 
		<div class="div1" style = "margin-top: 30px;" >撤销原因</div>
		<div id ="cxcontent" style="margin-left:30px;">
		</div>
	</div>
	<div id="bjxx" style = "display: none;font-size:13px;"> 
		<div class="div1" style = "margin-top: 30px;" >修改记录</div>
		<div id ="content" style="margin-left:30px;">
		</div>
	</div>
	<div class="div1" style = "margin-top: 30px;" >审批流信息</div>
	<div style="width: 100%;margin-top: 30px; margin-bottom: 30px;">
		<div style="margin-bottom: 10px;">
			<table style="margin: 0px auto;">
				<tr>
					<td><img src="<%=basePath%>images/lkgl/fk_websubmitorg.png"
						id="lc_tj_img" />
					</td>
					<td><img
						src="<%=basePath%>images/lkgl/fk_webdotlineorg_rey.png"
						id="lc_tj_zx" />
					</td>
					<td><img src="<%=basePath%>images/lkgl/fk_webapprovalgrey.png"
						id="lc_sp_img" />
					</td>
					<td><img src="<%=basePath%>images/lkgl/fk_webdotlinegrey.png"
						id="lc_sp_zx" />
					</td>
					<td><img src="<%=basePath%>images/lkgl/fk_webpassgrey.png"
						id="lc_pz_img" />
					</td>
				</tr>
			</table>
		</div>
		<div style=" width: 720px;margin:0px auto;">
			<table style="width:100%">
				<tr>
					<td style="width: 33%;text-align: left;"><img id="lc_tj_jt"
						style="display: none;"
						src="<%=basePath%>images/lkgl/fk_webtriggle.png" />
					</td>
					<td style="width: 33%;text-align: center;"><img id="lc_sp_jt"
						style="display: none;"
						src="<%=basePath%>images/lkgl/fk_webtriggle.png" />
					</td>
					<td style="width: 33%;text-align: right;"><img id="lc_pz_jt"
						style="display: none;"
						src="<%=basePath%>images/lkgl/fk_webtriggle.png" />
					</td>
				</tr>
			</table>
		</div>
		<div
			style="background-color: #F2F3F3; width: 900px;margin:0px auto; border-radius:7px;padding-top: 30px;padding-bottom: 30px;">
			<table id="lc_tab"
				style="width: 720px;margin-left: 80px; line-height: 32px;text-align: left;margin-bottom: 30px;">
			</table>
			<div id="div_spyj" style="display: none;">
				<textarea id="SPYJ"
					style="width:700px;margin-left: 80px;border:0;height:77px;overflow-x:visible;overflow-y:visible;background-color: #ffffff;font-size:14px;padding:10px;color: gray;"
					onfocus="yj_onfocus()" onblur="yj_onblur()">请填写审批意见</textarea>

				<div id="cz_but" align="center"
					style="width:720px;margin-left: 80px;margin-top: 20px">
					<input onclick="over()" type="button"
						style="background-color: #366CB4; border: 1px solid #366CB4"
						class="button" value="不批准" /> &nbsp; &nbsp; <input
						onclick="back()" id="dhxg" type="button"
						style="background-color: #366CB4;border: 1px solid #366CB4"
						class="button" value="打回修改" /> &nbsp;&nbsp; <input
						onclick="pass()" id="ok" type="button"
						style="background-color: #F07844;border: 1px solid #F07844"
						class="button" value="批准" /> 
				</div>
				<div id="dhxg_but" align="center"
					style="width:720px;margin-left: 80px;margin-top: 20px">
			   </div>
			</div>
		</div>
	</div>
	<input type="hidden" value="<%=basePath%>" id="basepath" />
	<input type="hidden" id="BD_RYBH" />
	<input type="hidden" id="SPYJBH" />
	<input type="hidden" id="SPBH" />
	<input type="hidden" id="SFZHM" />
	<input type="hidden" id="CJRBH" />
	<input type="hidden" id="YJDX" />
	<input type="hidden" id="YJBM" />
	<input type="hidden" id="YJYQ" />
	<input type="hidden" id="pass" />
	<input type="hidden" id="lb" />
	<input type="hidden" value="<%=spdxbh%>" id="spdxbh" />
</body>
</html>
