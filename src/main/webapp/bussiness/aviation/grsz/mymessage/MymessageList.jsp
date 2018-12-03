<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String userid = (String)request.getSession().getAttribute("userid");
String welcomeJsp = request.getParameter("welcomeJsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>我的消息页面</title>
    <link    rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script> 
    <script  type="text/javascript"  src="<%=basePath  %>bussiness/aviation/grsz/mymessage/mymessage.js"></script>   
    <script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script> 
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
    
<style>
td {
	font-size: 13px;
}
.holder{
  color:gray;
}
.input {
	border: 1px solid #D1D1D1;
	border-radius: 7px;
	width: 200px;
	height: 28px;
	color: gray;
}
</style>
</head>
<body class="body_style">  
    <div style="width:95%;">
       <table width="70%" style="line-height: 30px;">
         <tr>
           <td width="8%">类别</td>
           <td width="15%"><input id="inventorys" type="checkbox" name="box" value="inventorys"/>盘查</td>
           <td width="15%"><input id="sp" type="checkbox" name="box" value="sp"/>审批</td>
           <td width="15%"><input id="taskes" type="checkbox" name="box" value="taskes"/>任务</td>
         </tr>
         <tr>
           <td>状态</td>
           <td><input id = "wd" type="checkbox" name="checkbox" value="0"/>未读</td>
           <td><input id = "yd" type="checkbox" name="checkbox" value="1"/>已读</td>
         </tr>
       </table>
       <div style = "margin:10px 0px 20px 0px;">
         <input class = "holder input"  id = "XXNR"  holder="请输入消息内容搜索关键字" value=""></input>
         <input type="button" onclick="search()" value="搜索"
				class="search_input_style"
				style="background-color: #F07844;margin-left:20px;border: 1px solid #F07844;height:30px;color: white;width: 120px;" />
       </div>
       <table style="width:100%" >
          <tr style="text-align: center;">
             <td width="35%">消息内容</td>
             <td width="19%">消息类别</td>
             <td width="10%" >状态</td>
             <td width="20%">时间</td>
             <td width="15%">操作</td>
          </tr>
          <tr></tr>
       </table>
       <div style="height:1px;background-color:#b2b2b2;margin:10px 0px;"></div>
       <table  id="dadiv" style="width:100%;line-height: 30px;">
          <c:forEach items="${model}" var="item" >
             <tr>
               <td width="35%"><span style="color:#007EE2;" class = "my_info" onclick="openDialog('${item.XXBH}','${item.SSXMBH}','${item.SSXMLX}','${item.SFCK}','${item.SSZXMLX}')">${item.YHXM}${item.XXNR}</span></td>
               <td width="19%" style="text-align: center;">
	               <c:choose>
	                  <c:when test="${item.SSXMLX=='taskes'}"><span>任务</span></c:when>
	                  <c:when test="${item.SSXMLX=='inventorys'}"><span>盘查</span></c:when>
	                  <c:otherwise><span>审批</span></c:otherwise>
	               </c:choose>
               </td>
               <td width="10%" style="text-align: center;">
	               <c:choose>
					  <c:when test="${item.SFCK == 1}">
						  <span id="${item.XXBH}">已读</span>
					  </c:when>
					  <c:otherwise>
						  <span id="${item.XXBH}" style="color: red;">未读</span>
					  </c:otherwise>
				   </c:choose>
               </td>
               <td width="20%" style="text-align: center;">${item.CJSJ}</td>
               <td width="15%" style="text-align: center;">
                 <span style="color:#007EE2" class = "my_info" onclick="openDialog('${item.XXBH}','${item.SSXMBH}','${item.SSXMLX}','${item.SFCK}')">查看</span>
               </td>
             </tr>
          </c:forEach>
       </table>
    </div>
    <c:if test="${fn:length(model)<10}">
		<div id="div_btm" class="div_bottom" style="display: block;">
			<c:choose>
				<c:when test="${fn:length(model)==0}">暂无数据</c:when>
				<c:otherwise>数据加载完成</c:otherwise>
			</c:choose>
		</div>
	</c:if>
	<div id="div_bottom" class="div_bottom"></div>
	<input type="hidden" id="mypath" value="<%=basePath%>"/>
    <input type="hidden" id="userid" value="<%=userid%>"/>
    <input type="hidden" id="welcomeJsp" value="<%=welcomeJsp%>"/>	
</body>
</html>
