<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.dhcc.common.util.CommUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String id=request.getParameter("id");
	String FWID = request.getParameter("FWID");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/common.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript"
	src="<%=basePath%>bussiness/aviation/util/UserListMultiSelect.js"></script>
<style type="text/css">
.buttonyj {
	margin-top:20px;
	background-color: #C7D7EE;
	height: 27px;
	width: 120px;
}

.input2 {
    margin-top:10px;
	margin-bottom: 10px;
	min-height: 130px;
	overflow: auto;
	width: 373px;
	border: 0px solid grey;
	background: #F2F2F2;
}

.bg {
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
	position: absolute;
	filter: Alpha(opacity = 50);
	opacity: 0.5;
	background: #D4D4D4;
}
</style>
<script>
   var cacheDept;
   var cacheYJ;
   var cacheRY;
   var cacheDataSet;
   var basePath = "<%=basePath%>";
   $(function (){
  	  var id = "<%=id%>";
      cacheDataSet=$(window.parent.document).find("#cacheDataSet");
      getMess(id);
      $("#subbutton").click(function() {
        	f_validate();
      });
   });
   
   function getMess(mid){
     $.ajax({
       url:"databaseMessQuery.action",
       data:"model.BH="+mid,
       dataType:"json",
       type:"post",
       success:function(data){
      	   var mm = data.model;
      	   //预警部门
           var deptList = mm.yjbmModels;
           var arrDept = [];
           var itemzbzh = "";
           $(deptList).each(function(i,value){
		      arrDept.push({
			        id : value.YHBH,
					name : value.YHXM
		      });
		      var item1 = "<span style='font-size:13px;margin-right:10px' class = 'ry_font' id='"
										+ value.YHBH + "zbzh'>"
										+ value.YHXM+ " <img src='"
										+ basePath + "images/delete.png' onclick=\"removeUser('"
										+ value.YHBH + "','" + value.YHXM
										+ "','yjzbzh')\" style=\"cursor:pointer\" /></span>";
			itemzbzh += item1;
		   });
           cacheDept = arrDept;
           cacheDataSet.children("#cacheDept").text(JSON.stringify(cacheDept));
		   $("#sdescyjzbzh").html(itemzbzh);
		   //预警对象
		   var userList = mm.yjdxModels;
		   var arrYJ = [];
		   var itemuser = "";
		   $(userList).each(function(i,value){
		      arrYJ.push({
			        id : value.YHBH,
					name : value.YHXM
		      });
		      var item2 = "<span style='font-size:13px;margin-right:10px' class = 'ry_font' id='"
										+ value.YHBH + "yj'>"
										+ value.YHXM+ " <img src='"
										+ basePath + "images/delete.png' onclick=\"removeUser('"
										+ value.YHBH + "','" + value.YHXM
										+ "','yjry')\" style=\"cursor:pointer\" /></span>";
			itemuser += item2;
		   });
		   cacheYJ = arrYJ;
		   cacheDataSet.children("#cacheYJ").text(JSON.stringify(cacheYJ));
		   $("#sdescyj").html(itemuser);
       }
     });
   }
   
function f_validate(){
        var id = "<%=FWID%>";
		var zbzhid = "";
		var useridyj = "";
		if (cacheDept) {
			for (i = 0; i < cacheDept.length; i++) {
				zbzhid += cacheDept[i].id + ",";
			}
		}
		if (cacheYJ) {
			for (i = 0; i < cacheYJ.length; i++) {
				useridyj += cacheYJ[i].id + ",";
			}
		}
		//把选中的预警值班账号、预警人、清空
		cacheDataSet.children("#cacheYJ").text("");
		cacheDataSet.children("#cacheDept").text("");
		var dataPost = {"YJDX":useridyj,"YJBM":zbzhid,"SSXMBH":id};
		return dataPost;
}
</script>
</head>

<body style="margin:20px 35px">
  <div id = "bg">
	<table>
		<tr>
			<td><span style="font-size:13px;line-height: 20px;">预警对象：</span></td>
			<td><input id = "selectuseryj" type="button" class="search_input_style buttonyj"
				value="选择预警对象"/></td>
			<td><input id = "clearuseryj" type="button" class="search_input_style buttonyj"
				value="清除预警对象"  onclick="clearuseryj()"/></td>
		</tr>
		<tr>
			<td></td>
			<td colspan="2">
				<div class="input2" style="" id="sdescyj"></div>
			</td>
		</tr>
		<tr>
			<td><span style="font-size:13px;margin-top:20xp;">预警值班账号：</span></td>
			<td><input id = "selectyjzbzh" type="button" class="search_input_style buttonyj"
				value="选择预警值班账号" /></td>
			<td><input  type="button" class="search_input_style buttonyj"
				value="清除预警值班账号" onclick="cleardept()"/></td>
		</tr>
		<tr>
			<td></td>
			<td colspan="2">
				<div class="input2" style="" id="sdescyjzbzh"></div>
			</td>
		</tr>
	</table>
	</div>
	<input type="hidden" id = "mypath" value="<%=basePath%>"/>
</body>
</html>