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
<title>航班信息列表</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript" src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="./asjList.js"></script>
</head>
<body style="padding-left: 15px; padding-top: 15px;">
	<input id="source" type="hidden" value="${sessionScope.source}" />
	<div style="height: 22px;line-height: 22px;clear: both;width: 98%;">
		<div style="float: left; width: 46%">
			航班日期&nbsp;&nbsp; <input id="starttime" class="Wdate search_input_style"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
			&nbsp;-&nbsp; <input id="endtime" class="Wdate search_input_style"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
		</div>
		<div style="float: right; width: 53%;text-align: right;">
			<div style="float: right;">
				<input type="text" class="search_input_style" id="searchvalue"
					style="width: 230px;color: gray;height:25px;padding-right: 4px;"
					holder=" 请输入搜索关键词" /> &nbsp;&nbsp; <input id="oneSearch_bt"
					type="button" class="search_input_style"
					style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px; margin-right: 10px;"
					value="搜索" onclick="flightserach()" /> <span onclick="gjsc_an()"
					style="color: #F07844; width: 90px;height: 20px;margin-left: 10px;margin-right: 5px;font-size: 13px;">
					<span class="float_style">高级搜索&nbsp;</span><img
					src="<%=basePath%>images/common/fkweb_drawbackicon.png"
					style="margin-right: 10px;" /> </span>
			</div>
		</div>
	</div>
	<div id="div_gjss"
		style="height: 22px;line-height: 22px;margin-top: 15px;display: none;clear: both;width: 98%; ">
		<div>
			<div style="width:55%;float: left;">
				发生案件类型&nbsp;&nbsp;<select id="lx" class="search_input_style"
					style="color: gray;padding-right: 4px;width: 180px;"></select>
				&nbsp;&nbsp; 航班号码&nbsp;&nbsp;<input type="text" id="searchcode"
					class="search_input_style"
					style="color: gray;padding-right: 4px;width: 180px;"
					holder="请输入航班号，例如:MH2310" />
			</div>
			<div style="width:40%;float: right;">
				出发地&nbsp;&nbsp;<input type="text" id="dept" class="search_input_style"
					style="color: gray;padding-right: 4px;" />&nbsp;&nbsp;-&nbsp;&nbsp;
				目的地&nbsp;&nbsp;<input type="text" id="dest" class="search_input_style"
					style="color: gray;padding-right: 4px;" />
			</div>
		</div>
	</div>
	<div id="twoSearch_bt"
		style="width: 98%;height: 22px;line-height: 22px;margin-top: 15px; display: none; text-align: left;clear: both;">
		<input type="button" class="search_input_style"
			style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;"
			value="搜索" onclick="flightserach()"/>
	</div>
	<div id="div_sort"  style="width:98%; height:40px;clear: both;padding-top:15px;">
		<div id='' class="sort_style float_style" style="width: 80px;">
			<input type="checkbox" id="checkBtn" value="全选" onclick="checkall()"/>&nbsp;&nbsp;全选
		</div>
		<div id='order_time' class="sort_style float_style"
			style="color: #FC9B71" onclick="order_onclick('order_time','按航班时间排序')">按航班时间排序
			<span id="jt">↓</span>
		</div>
		<div id='order_code' class="sort_style float_style" class="sort_style float_style" onclick="order_onclick('order_code','按航班编号排序')">按航班编号排序</div>
		<div id='order_case' class="sort_style float_style" class="sort_style float_style" onclick="order_onclick('order_case','按案件类型排序')">按案件类型排序</div>
		<div id='order_adss' class="sort_style float_style" class="sort_style float_style" onclick="order_onclick('order_adss','按目标地点排序')">按目标地点排序</div>
		<!-- <div class="sort_style" style="float: right;">
			<input type="button" class="search_input_style"
				style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;"
				value="筛选重复人员" onclick="screenuser()"/>
		</div> -->
	</div>
	<!-- 案事件列表 -->
	<div id="dadiv">
		<c:forEach var="item" items="${eventslist }">
			<div class="item_style" style="height: 100%;">
				<table style="text-align:center;margin-top: 10px;margin-bottom: 10px;width:98%; line-height: 30px;">
					<tr>
					    <c:if test="${source!='rwcl' }">
							<td width="5%" rowspan="5"> <input type="checkbox" id="evrntscheck" /></td>
						</c:if>
						<!--当来源为添加任务时显示复选框  -->
						<c:if test="${source=='rwcl'}">
							<c:choose> 
								<c:when test="${item.ISCHECK}">
									<td width="5%" rowspan="5"><input type="checkbox" id="evrntscheck" checked="checked"
									value='${item.ASJBH},${item.DEPT},${item.DEST},${item.HBSJ},${item.HBH},${item.AJLBMC},${item.JCMC}' /></td>
							    </c:when>
							    <c:otherwise>
							    	<td width="5%" rowspan="5"><input type="checkbox" id="evrntscheck"
							    	 value='${item.ASJBH},${item.DEPT},${item.DEST},${item.HBSJ},${item.HBH},${item.AJLBMC},${item.JCMC}' /></td>
							    </c:otherwise>
							</c:choose>
						</c:if>
						
						<td style="text-align:left;" colspan="5">
							<span  style="color: #EF7844;font-size: 18px;padding: 0px 10px ;color: white;background-color: #EF7844;border-radius:2px;margin-right: 12px;">${item.AJLBMC }</span>
							<span style="font-size: 18px;">${item.MC }</span>
						</td>
					</tr>
					<tr style="font-size: 17px;border-bottom:1px solid  #b2b2b2;">
						<td colspan="2" style="text-align:left;" >
							<span style="margin-right: 90px;">${item.HBSJ }</span>
							<span style="color: #386CB5;">${item.HBH }</span>
						</td>
						<td  colspan="2" style="text-align:center;"><span style="margin:0px 20px;">${item.DEPT }</span><span class="td_text">---></span><span style="margin:0px 20px;">${item.DEST }</span></td>
					 	<td style="text-align:right;"	><span style="margin-right: 10px;color: #386CB5;" class="float_style" onclick="addAj('${item.HBH}','${item.HBSJ}','${item.DEPT}','${item.DEST}')">添加案事件</span></td>
					</tr>
					<tr style="text-align:left;line-height: 20px;">	
						<td style="width: 30%;">
							<span class="td_text">报&nbsp;&nbsp;案&nbsp;&nbsp;人</span>
							<span class="td_value">${item.BARXM }</span>
						</td>
						<td style="width:2%;" rowspan="3"><div style="width: 1px;float: left; height:50px;background-color: #b2b2b2;"></div></td>
						<td style="width: 30%;"  class="td_text">报案时间<span class="td_value">${item.AFSJ }</span></td>
						<td style="width:2%;" rowspan="3"><div style="width: 1px;float: left; height:50px;background-color: #b2b2b2;"></div></td>
						<td style="width: 30%;" class="td_text">案件详情</td>
					</tr>
					<tr style="text-align:left;line-height: 20px;">
						<td  class="td_text">身份证号<span class="td_value">${item.BARSFZHM }</span></td>
						<td  class="td_text">报案地点<span class="td_value">${item.AFDD}</span></td>
						<td class="td_value" rowspan="2" style="text-align: left;"><span>${item.ZYAQ }</span></td>
					</tr>
					<tr style="text-align:left;line-height: 20px;">	
						<td  class="td_text">联系电话<span class="td_value">${item.BARLXDH}</span></td>
					</tr>
				</table>
			</div>
		</c:forEach>
	</div>
	<c:if test="${fn:length(eventslist)<10}">
		<div id="div_btm" class="div_bottom"  style="display: block;">
			<c:choose>
				<c:when test="${fn:length(eventslist)==0}">无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="loadover" class="div_bottom"></div>
	<input type="hidden" id="mypath" value="<%=basePath %>" />
</body>
</html>
