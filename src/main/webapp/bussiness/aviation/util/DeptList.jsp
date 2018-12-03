<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String ids = request.getParameter("ids");
String names = request.getParameter("names");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath %>"/>
    <title>选择用户列表页面(可用多选)</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" />
    <script type="text/javascript" src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script type="text/javascript" src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
  	<script type="text/javascript">
		var treemanager;
		var manager = "";
		var ids = "<%=ids%>";
		var names = "<%=names%>";
		$(function () {
			    $("#tree").ligerTree({
                url: "corpSelectedQuery.action",
                idFieldName: 'id',
                parentIDFieldName: 'pid',
                checkbox: true,
                autoCheckboxEven:false,
                onSuccess:onSuccess
            });
			treemanager = $("#tree").ligerGetTreeManager();
		});
			
		 function onSuccess(){
		 		var json=$(window.parent.document).find("#cacheDataSet").children("#cacheDept").text();
		 		if(json!=""){
		 		var data=JSON.parse(json);
			    for(i=0;i<data.length;i++){
			       this.selectNode(data[i].data.id);
			    }
		 		}
		 		
		  }
	     
 	/**
    选择函数
    */
    function f_select(){
    	  var result=[];
          var data = $("#tree").ligerTree("getChecked");
          for(var i=0;i<data.length;i++){
          	result.push({"data":{"id":data[i].data.id,"text":data[i].data.text}});
          }
		  return result;
   }  
  	</script>
</head>
<body style="padding: 0px;">
       <div>
           <ul id="tree"></ul>
       </div>
 </body>
</html>
