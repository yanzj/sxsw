<%@ page language="java" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>安检信息列表</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="./flightInfoList.js"></script>
<style>
.controlps_img {
	width: 100px;
	height: 100px;
	background-color: white;
	margin-left: 17px;
	margin-top: 5px;
	margin-bottom: 5px;
}

</style>
</head>
<body style="padding-left: 15px; padding-top: 15px;">
	<div 
		style="height: 22px;line-height: 22px;width: 98%;clear: both;">
			<div style="float: left; width: 46%">
				航班日期&nbsp;&nbsp; <input id="starttime"  class="Wdate search_input_style"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
				&nbsp;-&nbsp; <input id="endtime" class="Wdate search_input_style"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
			</div>
			<div style="float: right; width: 53%;text-align: right;">
				<div style="float: right;">
					<input type="text" class="search_input_style" id="searchvalue" 
						style="width: 230px;color: gray;height:25px;padding-right: 4px;"
						holder=" 请输入搜索关键词"/> &nbsp;&nbsp; <input id="oneSearch_bt" type="button"
						class="search_input_style"
						style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px; margin-right: 10px;"
						value="搜索" onclick="flightserach()" /><span onclick="gjsc_an()" 
						style="color: #F07844; width: 90px;height: 20px;margin-left: 10px;margin-right: 5px;font-size: 13px;">
						<span class="float_style">高级搜索&nbsp;</span><img
						src="<%=basePath%>images/common/fkweb_drawbackicon.png"
						style="margin-right: 10px;" /> </span>
				</div>
			</div>
	</div>
	<div id="div_gjss"
		style="height: 22px;line-height: 22px;margin-top: 15px; display: none;clear: both;width: 98%;">
				<div style="width:35%;float: left;">
					航班号码&nbsp;&nbsp;<input type="text" id="searchcode" class="search_input_style"
						style="color: gray;padding-right: 4px;width: 180px;"
						holder="请输入航班号，例如:MH2310"/>
				</div>
				<div style="width:45%;float: left;">
					出发地&nbsp;&nbsp;<input type="text" id="dept" class="search_input_style"
						style="color: gray;padding-right: 4px;" />&nbsp;&nbsp;-&nbsp;&nbsp;
					目的地&nbsp;&nbsp;<input type="text" id="dest" class="search_input_style"
						style="color: gray;padding-right: 4px;" />
				</div>
				<div style=" width:20%;float: left;">
				<span style="float: right;"><input type="button"
					class="search_input_style"
					style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px; margin-right: 10px;"
					value="搜索" onclick="flightserach()" /> </span>
				</div>
		</div>
	<div id="relationpeople"
		style="width: 98%;clear: both;">
		<div style="width: 100%; height:30px;display: none;">
			<div id='order_sfz' class="sort_style float_style"
				style="color: #FC9B71"
				onclick="order_onclick('order_sfz','按身份证号排序')">按身份证号排序 ↓</div>
			<div class="sort_style float_style">按管控对象排序</div>
			<div class="sort_style float_style">按人员类型排序</div>
			<div id='order_djsj' class="sort_style float_style"
				onclick="order_onclick('order_djsj','按登机时间排序')">按登机时间排序</div>
	     
		</div>

		<div id="bigdiv" style="clear: both; margin-top: 20px;">
			<c:forEach var="item" items="${flightQueryAllList}">
				<!-- 基本信息 -->
				<div class="item_style">
					<div style="width: 99%;">
						<!-- 航班信息 -->
						<div style="width: 14%; float: left; line-height: 30px">
							<div>
								<span class="td_value">${item.FLIGHTDATE}</span>
							</div>
							<div>
								<span class="td_value float_style" onclick="openDialog('${item.FLIGHTCODE}','${item.FLIGHTDATE}','${item.DPSRDEPARTURECHN}','${item.DPSRDESTINATIONCHN}')">${item.FLIGHTCODE}</span>
							</div>
							<div>
								<span class="td_value">${item.DPSRDEPARTURECHN}-${item.DPSRDESTINATIONCHN}</span>
							</div>
						</div>
						<!-- 图片 -->
						<div
							style="width: 1px;float: left; height:100px;background-color: #b2b2b2;">
						</div>
						<div style="width: 10%; float: left;">
							<img src="${item.XP }" class="controlps_img" />
						</div>
						<!--基本信息and安检信息-->
						<div style="width: 73%;float:right;">
							<div>
								<span style="font-size: 19px;color: #EF7844;font-weight: bold;vertical-align: middle;" class="float_style" onclick="openDetail('${item.CTYPE}','${item.CERT}','${item.CHNNAME}')">${item.CHNNAME}</span>
								<span class="td_value">
									<c:if test="${item.GKLBMC!=null}">
										<input id="oneSearch_bt" type="button" class="search_input_style" style="vertical-align: middle;
											background-color: #F07844;border: 1px solid #F07844;width:100px;color: white; margin-right: 10px;"
											value=" ${item.GKLBMC}" />
										<c:choose>
											<c:when test="${item.GZBH!=null}">
												<img src="<%=basePath%>images/common/fkweb_focusonforaimat.png" style="vertical-align: middle;" />
											</c:when>
											<c:otherwise>
												<img src="<%=basePath%>images/common/fkweb_eyesongrey.png" style="vertical-align: middle;"/>
											</c:otherwise>
										</c:choose>
									</c:if>	
								</span>
							</div>
							<div style="width: 98%;line-height: 30px">
								<div style="width: 33%;float: left;">
									<span class="td_text">身份证号:</span><span class="td_value">${item.CERT}</span>
								</div>
								<div style="width: 33%;float: left;">
									<span class="td_text">护照号:</span><span class="td_value">${item.CERT}</span>
								</div>
								<div style="width: 33%;float: left;">
									<span class="td_text">通行证号:</span><span class="td_value">${item.CERT}</span>
								</div>
							</div>
							<div
								style="height: 1px;background-color: #b2b2b2; clear: both; margin-top: 5px;margin-bottom: 5px;"></div>

							<!-- 登机信息 -->
							<c:if test="${item.GATETM != null}">
								<div class="anInfo_div_style">
									<div>
										<span class="title_value">登机&nbsp;</span> <span
											class="title_value">${item.FLIGHTDATE} ${fn:substring(item.GATETM,0,2)}:${fn:substring(item.GATETM,2,4)}</span>
									</div>
									<div>
										<div style="width: 24%;float: left;">
											<span class="td_text">登机口</span>&nbsp;&nbsp;<span
												class="info_value">${item.SGATES}</span>
										</div>
										<div style="width: 24%;float: left;">
											<span class="td_text">序号</span>&nbsp;&nbsp;<span
												class="info_value">${item.BRDNO}</span>
										</div>
										<div style="clear: both;"></div>
									</div>
								</div>
							</c:if>
							<!-- 安检信息 -->
							<c:if test="${item.CHECKTIME != null}">
								<div class="anInfo_div_style">
									<div>
										<span class="title_value">安检&nbsp;</span> <span
											class="title_value">${item.FLIGHTDATE} ${fn:substring(item.CHECKTIME,0,2)}:${fn:substring(item.CHECKTIME,2,4)}</span>
									</div>
									<div style="width: 98%;">
										<div style="width: 48%;float: left;">
											<span class="td_text">安检通道</span> <span class="info_value">${item.CHECKCHANNEL}</span>
										</div>
										<div style="width: 48%;float: left;">
											<span class="td_text">安检人员</span> <span class="info_value">${item.CHECKER}</span>
										</div>
									</div>
									<div style="width: 98%;clear: both;">
										<div style="width: 48%;float: left;">
											<span class="td_text">安检证件</span> <span class="info_value">身份证</span>
										</div>
										<div style="width: 48%;float: left;">
											<span class="td_text">证件号码</span> <span class="info_value">${item.CNUMBER}</span>
										</div>
									</div>
									<div style="width: 98%;clear: both;">
										<div style="width: 48%;float: left;">
											<span class="td_text">有效期限</span> <span class="info_value">${item.CVALIDATE}</span>
										</div>
										<div style="width: 48%;float: left;">
											<span class="td_text">发放单位</span> <span class="info_value">${item.CDEP}</span>
										</div>
									</div>
									<div style="width: 98%;clear: both;">
										<div style="width: 48%;float: left; ">
											<div class="td_text" style="float: left;">证件照片</div>
											<div>
												<img src="${item.PHOTO }"
													class="controlps_img" />
											</div>
										</div>
										<div style="width: 48%;float: left;">
											<div class="td_text" style="float: left;">过检照片</div>
											<div>
												<img src="${item.PICPATH }"
													class="controlps_img " />
											</div>
										</div>
									</div>
									<div style="width: 98%;clear: both;"></div>
								</div>
							</c:if>
							<!-- 值机信息 -->
							<div class="anInfo_div_style" style="clear: both;">
								<div>
									<span class="title_value">值机&nbsp;</span> <span
										class="title_value">${item.FLIGHTDATE} ${fn:substring(item.CKITM,0,2)}:${fn:substring(item.CKITM,2,4)}</span>
								</div>
								<div>
									<div style="width: 24%;float: left;">
										<span class="td_text">座位</span><span class="info_value">${item.SEAT}</span>
									</div>
									<div style="width: 24%;float: left;">
										<span class="td_text">仓位</span><span class="info_value">无法提供</span>
									</div>
									<div style="width: 24%;float: left;">
										<span class="td_text">登机口</span><span class="info_value">${item.GATES}</span>
									</div>
									<div style="width: 24%;float: left;">
										<span class="td_text">序号</span><span class="info_value">${item.BRDNO}</span>
									</div>
									<div style="clear: both;"></div>
								</div>
							</div>
						</div>
						<div style="width: 1%;clear: both;"></div>
					</div>
				</div>
			</c:forEach>
		</div>
		<c:if test="${fn:length(flightQueryAllList)<10}">
			<div id="div_btm" class="div_bottom"  style="display: block;">
				<c:choose>
					<c:when test="${fn:length(flightQueryAllList)==0}">暂无数据</c:when>
					<c:otherwise>数据加载完成</c:otherwise>
				</c:choose>
			</div>
		</c:if>
		<div id="loadover" class="div_bottom"></div>
	</div>
	<input type="hidden" id="mypath" value="<%=basePath %>" />
	<input type="hidden" id="rybh" value="${rybh}" />
	<input type="hidden" id="lkid" value="${lkid}" />
</body>
</html>
