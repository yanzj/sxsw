<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
<link rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
<script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
<script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script>  
<script  type="text/javascript"  src="<%=basePath  %>js/btnQuery.js" ></script> 
<link href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css"></link>
<script src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js" type="text/javascript"></script> 
<script src="<%=basePath%>include/LigerUI/js/core/base.js" type="text/javascript"></script>
<script src="<%=basePath%>include/LigerUI/js/plugins/ligerTab.js" type="text/javascript"></script>
<script src="<%=basePath%>include/LigerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
<script src="<%=basePath%>include/LigerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
<script src="<%=basePath%>include/LigerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
    <script  type="text/javascript">
	/**每次点击获取按钮跳转到一个Tab显示*/
	var navtab = null;
    $(function ()
    {
    	var height = $(document).height();
        $("#tab1").ligerTab();
        navtab = $("#tab1").ligerGetTabManager();
        navtab.setHeight(height);
        $("#iframe").attr("src","<%=basePath%>bussiness/aviation/xxcx/service/CzryList.jsp");
    });
    var alert = function (t)
    {
        $.ligerDialog.warn(t.toLocaleString());
    };
    function f_click(tabid,text,value)
    {
    	var height = $(document).height();
  	    navtab.addTabItem({tabid:tabid,text:text,url:value});
        navtab.setHeight(height);  
    }
    /**删除指定的Tab*/
    function f_remove_click(tabid){
    	navtab.removeTabItem(tabid);
    }
    </script>
</head>
<body style="padding:0px;">
       	<div id="tab1" style="border:0px solid #A3C0E8;overflow:hidden;">
       	<div  id="untitle" title="全国住人员信息查询">
       	 	<iframe frameborder="0" id="iframe" src=""></iframe>
        </div>
        </div>
        <div style="display:none"></div>
</body>
</html>