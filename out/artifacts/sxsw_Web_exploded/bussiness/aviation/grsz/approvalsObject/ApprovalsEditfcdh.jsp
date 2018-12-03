<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String spdxbh=request.getParameter("spdxbh");
String splb = request.getParameter("splb");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>我的审批详情页面</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="<%=basePath  %>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath  %>bussiness/aviation/grsz/approvalsObject/ApprovalsEditfcdh.js"></script>
<script type="text/javascript" src="<%=basePath  %>bussiness/aviation/util/UserListMultiSelect.js"></script>
<style>
pre {
	white-space: pre-wrap;
	white-space: -moz-pre-wrap;
	white-space: -pre-wrap;
	white-space: -o-pre-wrap;
	word-wrap: break-word;
}

input {
	border: 1px solid #AECAF0;
	height:30px;
}

.input {
	display: none;
	margin-right: 10px;
}

.button {
	border-radius: 8px;
	width: 130px;
	height: 30px;
	color: white;
}

.div1 {
	width: 95%;
	height: 25px;
	vertical-align: middle;
	clear: both;
	background-color: #C7D9EF;
	font-size: 16px;
	font-weight: bold;
	margin-bottom: 20px;
	padding-left: 20px;
	text-align: center;
	color: #ef7844;
}
.input3 {
	min-height: 30px; overflow：auto;
	width: 570px;
	minheight: 30px;
	border: 0px solid #960;
}

.select {
	border-radius: 3px;
	width: 452px;
	height: 30px;
	border: 1px solid #C7D9EF;
}
.td_width{
	width:452px;
	height:30px;
	margin:5px 0px;
}

.table_dhxg{  
	border: 0px solid #B1CDE3;  
	background: #fff;  
	font-size:14px;  
	padding: 3px 3px 3px 8px;  
	color: #4f6b72;  
	height: 24px;
	margin:15px 0px 0px 20px;
}
.input4 {
	border-radius: 3px;
	min-height: 20px;
	overflow: auto;
	border: 1px solid #E0EDFF;
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
font{
  font-size:14px;
}
.bg {width:100%;height:100%;top:0px;left:0px;position:absolute;filter: Alpha(opacity=50);opacity:0.5; background:#D4D4D4;}
</style>
</head>
<body id = "bg">
	<form id="form2">
		<div class="div1">被列控人信息</div>
		<div style="margin-top: 20px;padding-left:20px;height: 280px;width: 95%;">

			<div style="float: left;width: 19%">
				<div>
					<img src="" class="head" id="userimg"
						style="width:160px; height:200px;margin-top: 10px;" />
				</div>
				<div
					style="border-radius: 8px;margin-top:20px;height: 30px;width: 160px;background-color: #ef7844;text-align: center;">
					<span id="GKLBMC"
						style="height:100%;line-height:30px;font-size: 18px;color: #ffffff;font-weight: bold;"></span>
				</div>
			</div>
			<div style="float: left; width: 81%">
				<table style="margin-top: 10px;width: 100%;" class="table_infos">
					<tr class="tr_height">
						<td class="txt_title" style=" width:20%;">姓名</td>
						<td class="txt_value"><div id="XM"></div></td>
						<td class="txt_title">身份证号</td>
						<td class="txt_value"><div id="SFZH"></div></td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title" style=" width:20%;">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别</td>
						<td class="txt_value"><div id="XB"></div></td>
						<td class="txt_title" style=" width:20%;">民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族</td>
						<td class="txt_value"><div id="MZMC"></div></td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">出生日期</td>
						<td class="txt_value"><div id="CSRQ"></div></td>
						<td class="txt_title" style="width: 90px;">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄</td>
						<td class="txt_value"><div id="NL"></div></td>
					</tr>
					<tr style="height: 49px;margin-bottom: 0px">
						<td class="txt_title">籍贯</td>
						<td class="txt_value" colspan="3"><div id="HKSZD"></div></td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">住地详址</td>
						<td class="txt_value" colspan="3"><div id="ZZXZ"></div></td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">&nbsp;职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业</td>
						<td class="txt_value"><div id="ZY"></div></td>
						<td class="txt_title" style="width: 90px;"><font id="DQSJBZ"
							color="red"></font>&nbsp;到期时间</td>
						<td class="txt_value"><input id="DQSJ"
							class="Wdate search_input_style1"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" /></td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">审批人：&nbsp;&nbsp;&nbsp;</td>
						<td colspan="2"><div id="sdesc" class="input3"></div></td>
						<td style="width:10%;" id="selectuser">&nbsp;&nbsp;<img
							style="width:20px;height:20px"
							src="<%=basePath%>images/common/fkweb_personicon.png" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="div1">列控申请</div>
		<div style="margin-top: 5px;padding-left:30px;width: 95%;">

			<table style="width:40%;" class="table_dhxg">
				<tr class="tr_height">
					<td class="txt_title">申请时间：</td>
					<td class="txt_value"><span id="CJSJ"></span></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">申请人：</td>
					<td class="txt_value"><span class="my_info" id="CJRXM"
						onclick="return getCJRXM()"></span>&nbsp;&nbsp;&nbsp;<span id="JCMC"></span>&nbsp;&nbsp;&nbsp;<span id="BMMC"></span></td>
			    </tr>
			</table>
			<br />
			<div style="height: 1px;background-color: #b2b2b2;"></div>
			<br />
			<table  class="table_dhxg">
				<tr class="tr_height">
					<td class="txt_title">管控类型：</td>
					<td class="txt_value"><select id = "GKLB" class="select " ></select>&nbsp;&nbsp;&nbsp;<font
						id="GKLBMCBZ" color="red"></font></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">列控原因：</td>
					<td class="txt_value"><input class="td_width" id="YY" />&nbsp;&nbsp;&nbsp;<font
						id="YYBZ" color="red"></font></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">预警对象：</td>
					<td class="txt_value"><div class="input4 td_width" id="sdescyj"></div></td>
					<td id="selectuseryj"><img class="my_info" style="margin-left:-41px;height:20px"
						src="<%=basePath%>images/common/fkweb_personicon.png" />&nbsp;&nbsp;&nbsp;<font
						id="YJDXMCBZ" color="red" ></font></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">预警值班账号：</td>
					<td class="txt_value"><div class="input4 td_width" id="sdescyjzbzh"></div></td>
					<td id="selectyjzbzh"><img class="my_info"
						style="margin-left:-41px;height:20px"
						src="<%=basePath%>images/common/fkweb_personicon.png" />&nbsp;&nbsp;&nbsp;<font
						id="YJBMMCBZ" color="red" ></font></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title">预警要求：</td>
					<td class="txt_value"><input id="YJYQ" class="td_width"  />&nbsp;&nbsp;&nbsp;<font
						id="YJYQBZ" color="red"></font></td>
				</tr>
				<tr class="tr_height">
					<td class="txt_title" style="vertical-align:middle;">备注说明：</td>
					<td class="txt_value"><input id="BZXX" class="td_width" />&nbsp;&nbsp;&nbsp;<font
						id="BZXXBZ" color="red"></font></td>
				</tr>
			</table>
		</div>
		<div class="div1">审批流信息</div>
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

		<div align="center" style="margin-bottom:20px;">
			<input  id = "tj" onclick="passUP()" type="button"
				style="background-color: #366CB4;" class="button" value="提交" />

		</div>
		<input type="hidden" value="<%=basePath%>" id="mypath" />
		<input type="hidden" id="BD_RYBH" />
		<input type="hidden" id="GKLBMC1" /> <input 
			type="hidden" id="CJRBH" /> <input
			type="hidden" id="YJDX" /> <input type="hidden" id="YJBM" /> <input
			type="hidden" id="YJYQ" /> <input type="hidden" id="pass" /> <input
			type="hidden" id="ZZLJ" /> <input type="hidden" id="SPZT" /> <input type="hidden" id="LB" /> <input
			type="hidden" id="MZ" /> <input type="hidden" id="MZMC1" /> <input
			type="hidden" id="RYXB1" /> <input type="hidden" id="itemid"
			value="<%=spdxbh%>" />
			<input type="hidden" id="SPYJBH"/>
	</form>
</body>
</html>
