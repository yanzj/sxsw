<%@ page language="java" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String userid = (String) request.getSession().getAttribute("userid");//用户id
	String BD_RYBH =request.getParameter("BD_RYBH");
	String searchTj = request.getParameter("searchTj");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>盘查信息列表</title>
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
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript" src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="./pclbList.js"></script>
<style>
.top_style {
	width: 90%;
	border: 1px solid #D1D1D1;
	border-radius: 5px;
	margin-bottom: 10px;
	margin-left: 10px;
	padding: 6px;
}

.tab_style {
	width: 150px;
	height: 100%;
	float: left;
	color: white;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	font-size: 15px;
}
.style_font{
   font-size:14px;
   color:#366cb3;
}
</style>
</head>
<body class="body_style" style="font-family:微软雅黑; ">
<input id="source" type="hidden" value="${sessionScope.source}" />
  <div style="height: 22px;line-height: 22px;clear: both;width: 98%;margin-bottom: 20px">
		
		<div style="float: right; width: 53%;text-align: right;">
			<div style="float: right;">
				<input id="searchvalue" type="text" class="search_input_style"
					style="width: 230px;color: gray;height:25px;padding-right: 4px;"
					holder=" 请输入搜索关键词" /> &nbsp;&nbsp; <input id="oneSearch_bt"
					type="button" class="search_input_style"
					style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px; margin-right: 10px;"
					value="搜索"  onclick="shousuo()" /> <span onclick="gjsc_an()"
					style="color: #F07844; width: 90px;height: 20px;margin-left: 10px;margin-right: 5px;font-size: 13px;">
					<span class="float_style">高级搜索&nbsp;</span><img
					src="<%=basePath%>images/common/fkweb_drawbackicon.png"
					style="margin-right: 10px;" /> </span>
			</div>
		</div>
	</div>
	<div id=div_gjss style="width:98%; height:25%; float:left;margin-bottom: 20px;display: none;">
		<div style="float: left; width: 45%;">
			盘查时间:&nbsp;&nbsp;<input id="starttime"  class="Wdate search_input_style"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
				&nbsp;-&nbsp; <input id="endtime" class="Wdate search_input_style"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
		</div>
		<div style="float: left; width: 30%;">
			管控类别&nbsp;&nbsp; <select class="search_input_style" id="lb"
				style="width: 160px;color: gray;height:25px;padding-right: 4px;"></select>
		</div>
		<div style="float: left; width: 25%;text-align: right;">
			民族&nbsp;&nbsp; <select class="search_input_style" id="mz" 
				style="width: 150px;color: gray;height:25px;padding-right: 4px;"></select>
		</div>			
		
	</div>
	<div id="relationpeople">
		<div id="div_sort" style="width: 98%; height:30px;margin-left: 10px;clear: both;">
			<c:if test="${type =='sbr' || type=='jsr'}">
				<div id='order_sbsj' class="sort_style float_style" style="color: #FC9B71;" onclick="order_onclick('order_sbsj','按上报时间排序')">按上报时间排序<span id="jt">↓</span></div>
			</c:if>
			<div id='order_pcsj' class="sort_style float_style" style="color: #FC9B71;" onclick="order_onclick('order_pcsj','按盘查时间排序')">按盘查时间排序 <span id="jt">↓</span></div>
			<div id='order_gklx' class="sort_style float_style" onclick="order_onclick('order_gklx','按管控类型排序')">按管控类型排序</div>
		</div>
	</div>
	<div id="dadiv" style="clear: both;">
		<c:forEach var="item" items="${xcpclist}" varStatus="status" >
			<!-- 基本信息 -->
			
			<div class="item_style">
			   <c:if test="${source=='rwcl'}">
						<div style="width:3%;float:left;text-align: center;">
						  <c:choose>
								<c:when test="${item.ISCHECK}">
										<input  type="checkbox" name="sourcecheck" checked="checked" style="height: 100px;line-height: 100px;"
											value='${item.PCBH},${item.XP},${item.XM},${item.GKLBMC}' />
									</c:when>
									<c:otherwise>
										<input type="checkbox" name="sourcecheck"  style="height: 100px;line-height: 100px;"
											value='${item.PCBH},${item.XP},${item.XM},${item.GKLBMC}' />
									</c:otherwise>
						 </c:choose>
						</div>
				</c:if>
				<div style="width:230px;height:100px;float:left;">
					<table style="width:100%;" >
						<tr>
							<td colspan="2" align="center"  style="padding-top:40px;"><span
								style="font-size: 20px;color: #4d4d4d;">${item.CJSJ}</span></td>
						</tr>
						<tr>
							<td align="center"  style="padding-top:16px;"><span
								style="font-size: 18px; color: #4d4d4d;">${item.JCMC}</span>
							</td>
							<td align="center" style="text-align: left;padding-top:16px;"><span
								style="font-size: 18px; color: #366cb3; ">${item.CJRXM}</span>
							</td>
						</tr>
					</table>
				</div>
				<div style="float:left;height:124px;width:1px;border-right:1px solid #b2b2b2"></div>
				<div style="width:500px;float:left;">
					<table style="width: 100%;">
						<tr>
							<td rowspan="4"  style="margin-right:20px;text-align: center;"><img style="width:124px;height:124px;" src="${item.XP}" id="userimg"/></td>
								
							<td style="width:350px;border-bottom:1px solid #b2b2b2;margin-bottom:6px;  font-size: 19px;color: #EF7844;font-weight: bold;">
								<span class="float_style" style="vertical-align: middle;" onclick="pancharenxq('${item.PCBH}','${item.XM}')">${item.XM}</span>
								<span>
									<c:if test="${item.lsgkcount > 0}">
										<img class="sf_span_style" src="<%=basePath%>images/gkddxq/lsgk.png" />
									</c:if>
									<c:if test="${item.tjlkcount > 0}">
										<img class="sf_span_style" src="<%=basePath%>images/gkddxq/tjlk.png" />
									</c:if>
									<c:if test="${item.ztrycount > 0}">
										<img class="sf_span_style" src="<%=basePath%>images/gkddxq/ztryxx.png" />
									</c:if>
									<c:if test="${item.wffzcount > 0}">
										<img class="sf_span_style" src="<%=basePath%>images/gkddxq/fzxx.png" />
									</c:if>
									<c:if test="${item.zjrycount > 0}">
										<img class="sf_span_style" src="<%=basePath%>images/gkddxq/jzxyr.png" />
									</c:if>
									<c:if test="${item.siscount > 0}">
										<img class="sf_span_style" src="<%=basePath%>images/gkddxq/sisxyr.png" />
									</c:if>
									<c:if test="${item.kssrycount > 0}">
										<img class="sf_span_style" src="<%=basePath%>images/gkddxq/ksszyry.png" />
									</c:if>
									<c:if test="${item.qlzdcount > 0}">
										<img class="sf_span_style" src="<%=basePath%>images/gkddxq/qbqlzd.png" />
									</c:if>
								</span>
								<span class="td_value">
									<c:if test="${item.GKLBBH!=null}">
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
							</td>
						</tr>
						<tr style="margin-top:16px;">
							<td><font style="font-size:14px;color: #b2b2b2;margin-right:20px;">身份证号</font><span style="font-size:14px;color: #4d4d4d;">${item.SFZH}</span></td>
						</tr>
						<tr style="margin-top:14px;">
							<td><font style="font-size:14px;color: #b2b2b2;margin-right:20px;">户口地址</font><span style="font-size:14px;color: #4d4d4d;">${item.HKSZD}</span></td>
						</tr>
						<tr style="margin-top:14px;">
							<td><font style="font-size:14px;color: #b2b2b2;margin-right:20px;">民 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族</font><span style="font-size:14px;color: #4d4d4d;">${item.MZMC}</span></td>
						</tr>
						
					</table>
				</div>
				<div style="float:left;width:1px;height:124px;margin:0 10px;background-color: #b2b2b2;"></div>
				<div>
				   <table>
				       <tr style="border-bottom:1px solid #b2b2b2;">
				           <td style="padding-bottom:12px;padding-top:10px;width:168px;color: #386CB5;"><span class="float_style style_font" onclick="sb('${item.PCBH}')">信息上报</span><span style="margin-left: 20px" class="float_style style_font"  onclick="fprw('${item.XM}','${item.PCBH }','${item.GKLBMC}')">分配任务</span></td>
				       </tr>
				       <tr>
				      	    <c:if test="${type=='sbr'}">
							    <td>
						          <div style="margin: 3px 3px 7px 0px;">
							          <span style="display: block;font-size:14px;color: #b2b2b2;">已上报给：</span>
								      <span class="style_font dian">${item.JSRXM}</span>
							      </div>
						          <span style="display: block;font-size:14px;color: #b2b2b2;">上报时间：</span>
							      <div style="color:#4d4d4d;" class="style_font">${item.SBSJ}</div>
							     </td>
						     </c:if>
						      <c:if test="${type=='jsr'}">
						         <td>
							         <div style="margin: 10px 3px 10px 0px;">
								         <span style="color: #b2b2b2;margin-top:10px;font-size:14px;color: #b2b2b2;">上报人：</span>
								         <span class="style_font">${item.SBRXM}</span>
								     </div>
								     <span style="display: block;font-size:14px;color: #b2b2b2;">上报时间：</span>
							      	 <div style="margin-top:3px;color:#4d4d4d;" class="style_font">${item.SBSJ}</div>
						        </td> 
						     </c:if>
				       </tr>
				   </table>
				</div>
				<div style="clear: both;"></div>
			</div>
		</c:forEach>
	</div>
	<c:if test="${fn:length(xcpclist)<10}">
		<div id="div_btm" class="div_bottom"  style="display: block;">
			<c:choose>
				<c:when test="${fn:length(xcpclist)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="loadover" class="div_bottom"></div>
	<div id="maingrid" style="margin-top: -1px; margin-left: -1px"></div>
	<input type="hidden" id="mypath" value="<%=basePath %>" />
	<input type="hidden" id="type" value="${type}" />
	<input type="hidden" id="BD_RYBH" value="<%=BD_RYBH%>"/>
	<input type="hidden" id="searchTj" value="<%=searchTj%>"/>
</body>
</html>
