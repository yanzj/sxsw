<%@ page language="java" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String rwzt = request.getSession().getAttribute("rwzt").toString();
	String rwtype = request.getSession().getAttribute("rwtype").toString();
	String lb = request.getSession().getAttribute("lb").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>未处理任务列表</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/showdate.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/plugins/ligerDateEditor.js"></script>
<script type="text/javascript" src="<%=basePath%>js/birthdaypicker.js"></script>
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath%>bussiness/aviation/rwcl/wclqq/wclqqlist.js"></script>
<style>


.item_styleone {
	width: 95%;
	border: 0px solid #FF0000;
	margin-bottom: 10px;
	padding: 6px;
}
.item_styletwo{
	width: 95%;
	margin-bottom: 10px;
	padding: 6px;

}
tr{
	    line-height: 35px; /*设置行高*/
        }
        
</style>
</head>
<body class="body_style">
	<div class="item_styleone" >
		<table  border="0" width="100%">
			<tr id="lb">
				<td ><span style="color:#C2C2C2;">类别：</span></td>
				<td ><input type="checkbox" name="checkbox" id="wd" value="0"/>&nbsp;&nbsp;未处理</td>
				<td><input type="checkbox" name="checkbox"  id="jxz" value="1"/>&nbsp;&nbsp;进行中</td>
				<td><input type="checkbox" name="checkbox"  id="ywc" value="2"/>&nbsp;&nbsp;已完成</td>
				<td><input type="hidden"  id="qb" value="3"/>&nbsp;&nbsp;</td>
			</tr>
		    <tr>
		    	<td><span style="color:#C2C2C2;">时间：</span></td>
		    	<td><input name="radio" type="radio"  value="all"/>&nbsp;&nbsp;全部</td>
				<td><input name="radio" type="radio"  value="week"/>&nbsp;&nbsp;一个周内</td>
				<td><input name="radio" type="radio"  value="month"/>&nbsp;&nbsp;一个月内</td>
				<td><input name="radio" type="radio"  value="threeMonth"/>&nbsp;&nbsp;三个月内</td>
				<td><input name="radio" type="radio"  value="time"/>&nbsp;&nbsp;选择时间段&nbsp;&nbsp;
				<input id="begintime" class="Wdate search_input_style"
			onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
		    &nbsp;-&nbsp; <input id="endtime" class="Wdate search_input_style"
			onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" /></td>
				
		    </tr>
		    <tr style="height: 10px"></tr>
			<tr>
				<td><span style="color:#C2C2C2;">名称：</span></td>
				<td colspan="4">
	            	<input id="name" type="text" class="search_input_style"
					style="width: 230px;color: gray;height:25px;padding-right: 4px;"
					value="请输入任务名称关键字" onfocus="onfocuss()"/> &nbsp;&nbsp; <input id="oneSearch_bt"
					type="button" class="search_input_style my_info"
					style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px; margin-right: 10px;"
					value="筛选" onclick="search()" />
				
				</td>
			</tr>
		</table>
	</div>
	 <div class="item_styletwo">
	        <table style="text-align: center; width: 100%;font-size: 14px;">
			<tr style="border-bottom:1px solid #b2b2b2;color: #727272">
				<td width="20%"><span>任务名称</span></td><td width="3%"></td><td width="10%"><span>发布人</span></td><td width="15%"><span>发布时间</span></td><td width="15%"><span>完成时间</span></td><td width="10%"><span>状态</span></td><td width="10%"></td>
			</tr>
			</table>
	 </div>
	  <div class="item_styletwo" id="dadiv">
		  <table style="text-align: center; width: 100%;font-size: 14px;">
			<c:forEach var="item" items="${listmodel}" varStatus="idx">
					<tr id="trid">
						<td width="20%"><span class="my_info dian" onclick="getRwess('${item.RWBH}','${item.RWMC }','${item.RWCJR}')">${item.RWMC}</span></td>
						<c:choose>
							<c:when test="${item.WDSL <= 0}">
									<td width="3%"></td>		
							</c:when>
							
							<c:when test="${item.WDSL > 99}">
									<td width="3%">
									<div id="rwjlround_l" style="background:url(<%=basePath %>images/fk_webunreadbg_l.png) no-repeat;height:16px;width:24px;float:left;margin-top:0px;font-size:12px;text-align:center;line-height:16px;display:block;"><span style="color:#fff">99+</span></div>
									</td>
							</c:when>
							<c:otherwise>
									<td width="3%">
									<div id="rwjlround_s" style="background:url(<%=basePath %>images/fk_webunreadbg_s.png) no-repeat;height:16px;width:16px;float:left;margin-top:0px;font-size:10px;text-align:center;line-height:16px;display:block;"><span style="color:#fff" id="rwjlwdCount">${item.WDSL}</span></div>
									</td>
							</c:otherwise>
						</c:choose>
						<td width="10%"><span>${item.CJRBH}</span></td>
						<td width="15%"><span>${item.CJSJ}</span></td>
						<td width="15%"><span>
						<c:choose>
							<c:when test="${item.RWWCSJ=='1970-01-01'}">无期限</c:when>
							<c:otherwise>${item.RWWCSJ}</c:otherwise> 
						 </c:choose>
						</span></td>
						<td width="10%"><span>
						<c:choose>
    						<c:when test="${item.RWZT==0}">
                                    		<span style="color: red">未处理</span>
    						</c:when>
    						<c:when test="${item.RWZT==1}">
        									进行中
  						    </c:when>
								<c:when test="${item.RWZT==2}">
									<c:choose>
										<c:when test="${item.RWWCSJ=='1970-01-01'}">已完成</c:when>
										<c:when test="${item.RWTJSJ>item.GDWCSJ&&item.RWWCSJ!='1970-01-01'}">超期完成</c:when>
										<c:when test="${item.RWTJSJ<=item.GDWCSJ}">已完成</c:when>
									</c:choose>
								</c:when>
							</c:choose>
						</span></td>
						<td width="10%"><span style="color: #1C86EE;" class="my_info" onclick="getRwess('${item.RWBH}','${item.RWMC }','${item.RWCJR }')">查看任务详情>></span></td>
					</tr>
		    </c:forEach>
		</table>
	</div>
	<c:if test="${fn:length(listmodel)<10}">
		<div id="div_btm" class="div_bottom"  style="display: block;">
			<c:choose>
				<c:when test="${fn:length(listmodel)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="div_bottom" class="div_bottom"></div>
	<!--获取全路径 -->
	<input type="hidden" id="mypath" value="<%=basePath %>" />
	<!--获取任务类型 -->
	<input type="hidden" id="rwtype" value="<%=rwtype %>" />
	<!--获取任务状态  -->
	<input type="hidden" id="rwzt"   value="<%=rwzt %>" />
	<!--  -->
	<input type="hidden" id="type"   value="<%=lb %>" />
</body>
</html>
