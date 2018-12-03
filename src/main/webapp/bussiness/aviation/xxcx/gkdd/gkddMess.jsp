<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	String basePh = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+"/" + "avi" + "/";
	String BD_RYBH = request.getParameter("BD_RYBH");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>用户详细信息页面</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="./gkddMess.js"></script>
<style>
.topbox {
	width: 100%;
	height: 27px;
	font-size: 12px;
	line-height: 27px;
	border-bottom: 1px solid #BED5F3;
	background: #E3F9FF;
}

.libox {
	background: url(/aviation/images/right.gif) no-repeat 0 5px;
	margin-right: 14px;
	float: left;
	list-style-type: none;
}

.txt_title {
	width: 112px;
	color: #b2b2b2;
	font-size: 14px;
}

.txt_value {
	font-size: 14px;
	color: #44c4c4c;
}

.tr_height {
	height: 28px;
}

/*修改模块按钮，文字样式 */
.but_style {
	width: 80dp;
	height: 80dp;
}

.zj_style {
	color: #cf7844;
	font-size: 14px;
	margin-left: 15px;
}

.but_txt_style {
	margin-top: 30px;
}

.div_over {
	background-color: #e5e5e5;
	width: 20%;
	height:192px;
	float: left;
	text-align: center;
	padding-top:48px;
}

.div_out {
	background-color: #F2F2F2;
	width: 20%;
	height:192px;
	float: left;
	padding-top:48px;
	text-align: center;
}

.but_img_style {
	width: 20%;
	padding-top:48px;
	float: left;
	text-align: center;
}

.list {
	width: 100%;
	height: 80px;
	border-top: 1px solid #ccc;
}

.td1 {
	text-align: center;
	width: 20%;
}

.td2 {
	text-align: center;
	width: 16%;
}

a,a:hover {
	text-decoration: none;
}

.div1 {
	margin-top: 40px;
}

.div2 {
	margin-top: 40px;
}

.r_mtitle-style {
	margin-left: 20px;
	font-weight: bold;
	font-size: 18px;
	color: #F07744;
	float: left;
}

.r_module_more {
	float: right;
	font-size: 15px;
	font-weight: bold;
	margin-right: 20px;
	color: #3E73B5
}

.sf_span_style {
	width: 30px;
	height: 30px;
	margin-left: 5px;
}
.style_font_black{
   font-size:16px;
   font-weight:bold;
}
.style_font_gray{
   color:gray;
   font-size:16px;
   font-weight:bold;
}
.style_count{
   margin-top:6px;
   font-size:16px;
   color:#F07844;
   font-weight:bold;
}
.div_table_over{
	background-color: #f9f9f9;
}
.div_table_out{
	background-color: #ffffff;
}
</style>
</head>

<body>
	<div style="margin-top: 25px; padding-left: 20px;">
		<div style="float: left; width: 240px;height: 400px;">
			<img src="" class="head" id="userimg" style="width:240px; height:300px;" />
			<div id="lsgk_div">
				<div style="height: 36px;width:140px;background-color: #ef7844; margin: 10px auto 0px auto;text-align: center;">
					<span id="GKLBMC" style="height:100%;line-height:36px;font-size: 16px;color: #ffffff;font-weight: bold;"></span>
				</div>
				<div style="height: 32px;width:240px;text-align: center;">
					<input type="hidden" id="CJRBH" /> <span style="height:100%;line-height:32px;font-size: 14px;color: #333333">上控人：</span>
					<span id="CJRXM" class="my_info" style="font-size: 14px;color: #366AB3" onclick="getCJRXM('sfcjr','')"></span>
				</div>
				<div style="height: 28px;width:240px;text-align: center;">
					<span
						style="height:100%;line-height:28px;font-size: 12px;color: #333333"
						id="CJSJ"></span>
				</div>
			</div>
		</div>
		<div style="float: left;width: 690px;">
			<div style="height: 56px;margin-left: 40px;">
				<span id="XM"
					style="height:56px;line-height:56px;font-size: 26px;color: #333333;font-weight: bold;"></span>
				<span id="ZT" style="color:#F07844;font-weight: bold;font-size:14px;"></span>
				<span id="guanzhu" onclick="getGz()"
					style="margin-left: 20px;cursor: pointer;"></span>
			</div>
			<div style="width: 33%;height: 72px;float: right;">
				<div style="width: 144px;margin:2px auto; ">
					<span style="margin-right:5px;" class="txt_title">更新时间</span>
					<span id="GXSJ" class="txt_value"></span>
				</div>
				<div style="width:144px;height:28px;margin:10px auto;text-align: center;background-color: #ef7844;border-radius:5px;" onclick="updateInfo()">
					<span id="" style="height:100%;line-height:28px;font-size:14px;color: #ffffff;">点击更新公安信息</span>
				</div>
			</div>
			<div id="sf_div" style="width: 60%;height: 72px;margin-left: 40px;"></div>
			<div style="height: 44px;padding-left: 40px; margin-top: 10px;line-height: 44px;background-color: #ebebeb;">
				<span style="font-size: 18px;color: #333333;font-weight: bold;">个人信息</span>
			</div>
			<div style="margin-left: 40px;">
				<table style="margin-top: 10px;">
					<tr class="tr_height">
						<td class="txt_title">曾用名</td>
						<td class="txt_value" colspan="3"><span id="CYM"></span></td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">性别</td>
						<td class="txt_value" style="width: 256px;"><span id="XB"></span>
						</td>
						<td class="txt_title" style="width: 90px;">民族</td>
						<td class="txt_value"><span id="MZ">维族</span>
						</td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">出生日期</td>
						<td class="mycla"><span id="CSRQ"></span>
						</td>
						<td class="txt_title">年龄</td>
						<td class="txt_value"><span id="NL"></span>
						</td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">身高</td>
						<td class="txt_value"><span id="SG"></span></td>
						<td class="txt_title">婚姻状况</td>
						<td class="txt_value"><span id="HYZK"></span></td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">文化程度</td>
						<td class="txt_value"><span id="WHCD"></span></td>
						<td class="txt_title">兵役状况</td>
						<td class="txt_value"><span id="BYQK"></span></td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">职业</td>
						<td class="txt_value"><span id="ZY"></span></td>
						<td class="txt_title">服务处所</td>
						<td class="txt_value"><span id="FWCS"></span></td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">籍贯国家</td>
						<td class="txt_value"><span id="JGGJ"></span></td>
						<td class="txt_title">籍贯市县</td>
						<td class="txt_value"><span id="JGSSX"></span></td>
					</tr>
					<tr class="tr_height">
						<td class="txt_title">出生地址</td>
						<td class="txt_value" colspan="3"><span id="CSDXZ"></span>
						</td>
					</tr>

					<tr class="tr_height">
						<td class="txt_title">户口地址</td>
						<td class="txt_value" colspan="3"><span id="HKSZD"></span>
						</td>
					</tr>

					<tr class="tr_height">
						<td class="txt_title">现居地址</td>
						<td class="txt_value" colspan="3"><span id="ZZXZ"></span>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="clear: both;"></div>

	</div>
	<div style="height: 72px; line-height: 72px; background-color: #F2F2F2;padding-left: 20px;">
		<div style="width: 34%;float: left;">
			<span class="txt_title">身份证号</span><span class="zj_style"
				id="GMSFZHM"></span>
		</div>
		<div style="width: 33%;float: left;">
			<span class="txt_title">护照号码</span><span class="zj_style"></span>
		</div>
		<div style="width: 33%;float: left;">
			<span class="txt_title">同行证号</span><span class="zj_style"></span>
		</div>
	</div>
	<div style="height: 44px;margin-top: 10px;padding-left:20px;line-height: 44px;background-color: #ebebeb;">
		<div style="width:60%;font-size: 18px;color: #333333;font-weight: bold;float: left;">联系方式</div>
		<div style="float: right;font-size: 16px;margin-right: 40px;">
			<span onclick="conactionAdd()">
				<img src="<%=basePath%>images/xxcx/fk_addmore.png" style="vertical-align: middle;"/>
				<span style="vertical-align: middle;" class="my_info">手动添加</span>
			</span>
			<span class="my_info" style="vertical-align: middle;margin-left: 30px;color:#366AB3;font-size: 13px;" onclick="openConaction()">查看更多>>></span>
		</div>
	</div>
	<div id="lx_div">
	</div>
	<div style="height: 44px;padding-left:20px;line-height: 44px;background-color: #ebebeb;margin-top: 10px;">
		<span style="font-size: 18px;color: #333333;font-weight: bold;">关联信息</span>
	</div>
	<div style="height:240px;background-color: #F2F2F2;">
		<div class="but_img_style my_info" onmouseover="this.className='div_over'"
			onmouseout="this.className='div_out'" onclick="openflight()">
			<div>
				<img id="flight" src="<%=basePath%>images/xxcx/fk_webiconplanegrey.png" class="but_style" />
			</div>
			<div class="but_txt_style">
				<span class="my_info" id="flight_style">航班信息</span>
				<div id="div_flight" class="style_count"></div>
			</div>
		</div>
		<div class="but_img_style  my_info" onmouseover="this.className='div_over'"
			onmouseout="this.className='div_out'"  onclick="openPcxx()">
			<div>
				<img id = "pcxx" src="<%=basePath%>images/xxcx/fk_webiconpollinggrey.png"
					class="but_style"/>
			</div>
			<div class="but_txt_style">
				<span id="pcxx_style" class="my_info">盘查信息</span>
				<div id="div_pc" class="style_count"></div>
			</div>
		</div>
		<div class="but_img_style my_info" onmouseover="this.className='div_over'"
			onmouseout="this.className='div_out'">
			<div>
				<img src="<%=basePath%>images/xxcx/fk_webiconcasegrey.png"
					class="but_style" />
			</div>
			<div class="but_txt_style">
				<span class="style_font_gray my_info">案件信息</span>
			</div>
		</div>
		<div class="but_img_style my_info" onmouseover="this.className='div_over'"
			onmouseout="this.className='div_out'" onclick="openLKDetail()">
			<div>
				<img src="<%=basePath%>images/xxcx/fk_webicon_noticecolor.png"	class="but_style"/>
			</div>
			<div class="but_txt_style">
				<span class="style_font_black my_info">列控信息</span>
			</div>
		</div>
		<div class="but_img_style my_info"
			onmouseover="this.className='div_over'"
			onmouseout="this.className='div_out'" onclick="gzrList()">
			<div>
				<img id="gzr" src="<%=basePath%>images/xxcx/fk_webicon_eyesoncolor.png" class="but_style"/>
			</div>
			<div class="but_txt_style" >
				<span id="gzr_style" class="my_info">关注人  </span>
				<div id="div_gz" class="style_count"></div>
			</div>
		</div>


	</div>
	<div style="height: 2px; background-color: white;"></div>
	<div
		style="height:240px;background-color: #F2F2F2;margin-bottom: 40px;">

		<div class="but_img_style" onmouseover="this.className='div_over'"
			onmouseout="this.className='div_out'" onclick="searchwf()">
			<div>
				<img id="wfxx" src="<%=basePath%>images/xxcx/fk_webicon_crimerecordnocolor.png" class="but_style"/>
			</div>
			<div class="but_txt_style">
				<span id = "wfxx_style" class="my_info">违法信息 </span>
				<div id="div_wffz" class="style_count"></div>
			</div>
		</div>

		<div class="my_info but_img_style" onmouseover="this.className='div_over'"
			onmouseout="this.className='div_out'" onclick="searchzt()">
			<div>
				<img id="ztxx" src="<%=basePath%>images/xxcx/fk_webfleeno.png" class="but_style"/>
			</div>
			<div class="but_txt_style">
				<span id="ztxx_style" class="my_info">在逃信息</span>
				<div id="div_ztry" class="style_count"></div>
			</div>
		</div>


		<div class="my_info but_img_style" onmouseover="this.className='div_over'"
			onmouseout="this.className='div_out'" onclick="searchqlzd()">
			<div>
				<img id="qbql" src="<%=basePath%>images/xxcx/fk_webinteligenceno.png" class="but_style"/>
			</div>
			<div class="but_txt_style">
				<span id="qbql_style" class="my_info">情报七类 </span>
				<div id="div_qbqlzdry" class="style_count"></div>
			</div>
		</div>
		<div class="my_info but_img_style" onmouseover="this.className='div_over'"
			onmouseout="this.className='div_out'" onclick="openJSbs()">
			<div>
				<img id = "jsbs" src="<%=basePath%>images/xxcx/fk_webicon_silkrecordlnocolor.png" class="but_style" />
			</div>
			<div class="but_txt_style">
				<span class="style_font_gray my_info" >精神病史</span>
			</div>
		</div>
		<div class="my_info but_img_style" onmouseover="this.className='div_over'"
			onmouseout="this.className='div_out'" onclick="openQwcx()">
			<div>
				<img src="<%=basePath%>images/xxcx/fk_webiconpollinggrey.png" class="but_style" />
			</div>
			<div class="but_txt_style">
				<span  class="style_font_gray my_info" >全网查询</span>
			</div>
		</div>
	</div>
	<input type="hidden" id="mypath" value="<%=basePath%>"/>
	<input type="hidden" id="myph" value="<%=basePh %>"/>
	<input type="hidden" id="rybh" value="<%=BD_RYBH%>" />
	<input type="hidden" id="RYBH"/>
</body>
</html>