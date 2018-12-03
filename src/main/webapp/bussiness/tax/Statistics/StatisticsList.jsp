<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 String IF_MATCHED ="1";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>保险列表</title>
     <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
    <script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script> 
    <script  type="text/javascript"  src="./Statistics.js"></script> 
     <script type="text/javascript">
     
    jQuery(function($){
   $("#searchBtn").click(function(){
     // 点击查询获取到编号值和名称值
    var SOCIAL_SECURITY_NO =$("#SOCIAL_SECURITY_NO").val();
    var COMPANY_NAME  =$("#COMPANY_NAME").val();
    var	url="CompanyTaxMessageList.action?type=1&SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO+"&COMPANY_NAME="+COMPANY_NAME;
		 $.ajax({
		url:url, 
		async:false,
		dataType:"json", 
		type:"post",
		success:function (data) {
		// 重新加载表格数据
		 $("#maingrid").ligerGrid('reload',data);
		}
		});
	});
// 点击清空  
});
    </script>
</head>
<body>  
<div>
<div id="toolbar" class="searchDiv">
		<form id="serchform" method="post">
			<table>
				<tr>
				<td class="ser_tit">
					<label>人社编号:</label>
				</td>
				<td class="ser_cont">
					<input id="SOCIAL_SECURITY_NO" type="text" value=""/>
				</td>
				<td class="ser_tit">
					<label>人社单位名称:</label>
				</td>
				<td class="ser_cont">
					<input id="COMPANY_NAME" type="text" value=""/>
				</td>
					<td class="ser_cont"><input type="button" id="searchBtn" value="查询" class="btn"/></td>
				</tr>
			</table>
		</form>
</div>
</div>
<!-- 已匹配数据 -->
    <div id="maingrid"></div>
    <script type="text/javascrip">
 



</script>
</body>

</html>
