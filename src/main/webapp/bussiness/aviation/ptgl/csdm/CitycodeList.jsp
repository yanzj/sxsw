<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>城市3字代码页面</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath%>js/btnQuery.js"></script>
<script type="text/javascript" src="./citycode.js"></script>
</head>
<body>
	<div id="toolbar" class="searchDiv">
		<form id="serchform" method="post">
			<table>
				<tr>
					<td align="center" class="ser_cont">城市代码:</td>
					<td class="ser_tit"><input type="text" id="code" value="" />
					</td>
					<td align="center" class="ser_cont">&nbsp;&nbsp;城市名称:</td>
					<td class="ser_tit"><input type="text" id="cityname" value="" />
					</td>
					<td class="ser_cont">&nbsp;&nbsp;<input type="button"
						id="searchBtn" value="查询" class="btn" />
					</td>
					<td class="ser_cont"><input type="button" id="clearBtn"
						value="清空" class="btn" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="maingrid"></div>
	<input type="hidden" id="mypath" value="<%=basePath%>" />
</body>
</html>
