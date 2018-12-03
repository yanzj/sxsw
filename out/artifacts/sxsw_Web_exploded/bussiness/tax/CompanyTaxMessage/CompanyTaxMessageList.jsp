<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>部门列表页面</title>
     <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
    <script  type="text/javascript"  src="CompanyTaxMessageList.js"></script> 
    
  	
</head>
<body>  
<div id="toolbar" class="searchDiv">
		<form id="serchform" method="post">
			<table>
				<tr>
					<td class="ser_tit">
						<label>社保编号:</label>	
					</td>
					<td class="ser_cont"><input type="text" id="SOCIAL_SECURITY_NO" value=""/></td>
					<td class="ser_tit">
						<label>单位名称:</label>
					</td>
					<td class="ser_cont"><input type="text" id="COMPANY_NAME" value=""/></td>
					<td class="ser_tit">
						<label>登记姓名:</label>
					</td>
					<td class="ser_cont" ><input type="text" id="TAX_PERSON_NAME" value=""/></td>
				</tr>
				<tr>
					<td class="ser_tit">
						<label>行政区域:</label>
					</td>
					<td class="ser_cont"> 
						<input type="text" id="AREA_ID" value="" name=""/><input type="hidden"  id="AREA_ID_VALUE"/>
					</td>
					<td class="ser_tit">
						<label>社保种类:</label>
					</td>
					<td class="ser_cont"> <input ltype="select" id="SOCIAL_TYPE_ID" value="" name=""/><input type="hidden"  id="SOCIAL_TYPE_ID_VALUE"/></td>
					<td class="ser_cont"><input type="button" id="searchBtn" value="查询" class="btn"/></td>
					<td class="ser_cont">
					
					<input type="button" id="clearBtn" value="清空" class="btn"/>
					<input type="button" id="importExcel" value="导入Excel" class="btn"/>
					</td>
				</tr>
			</table>
		</form>
		</div>
    <div id="maingrid"></div>
    <div id="treediv" style="width: 178px; max-height: 260px; border: 1px solid #ccc; overflow: auto;display:none;position:fixed;left:67px;top:60px">
        <ul id="tree" style="width: 178px;"></ul>
    </div>
</body>
</html>
