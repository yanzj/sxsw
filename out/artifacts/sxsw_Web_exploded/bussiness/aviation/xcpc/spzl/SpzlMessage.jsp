<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	String spurl = request.getParameter("spurl").replace("\\", "/").replace("(", "/");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript"src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script type="text/javascript" src="<%=basePath%>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath%>js/btnQuery.js"></script>
<script src="<%=basePath%>js/UploadFailUtil.js"type="text/javascript"></script>
<style>
body,h1,h2,h3,h4,h5,h6,p,ul,li,ol,dl,dd,dt,form,input{
padding:0;margin:0;list-style:none;
}
body{
background:#fff;font-family:"微软雅黑";
}
a{
text-decoration:none;color:#333;
}
img{
border:none;
}
</style>
<script type="text/javascript">
	
</script>
</head>
<!-- 播放器开始 -->
<div id="a1"></div>
<script type="text/javascript" src="<%=basePath %>js/ckplayer/ckplayer.js" charset="utf-8"></script>
<script type="text/javascript">
	var flashvars={	
		f:'<%=spurl%>',
		c:0,
		b:1
	};
	var video=[];
	CKobject.embed('<%=basePath %>js/ckplayer/ckplayer.swf','a1','ckplayer_a1','700','500',false,flashvars,video)	
 </script>
<!-- 播放器结束 -->
<body>
<div id="a1"></div>
</body>
</html>