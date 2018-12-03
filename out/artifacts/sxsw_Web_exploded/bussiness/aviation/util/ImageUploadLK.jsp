<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <link  rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link  rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
	<link  rel="stylesheet" type="text/css"  href="<%=basePath  %>css/main.css"/>     
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/ajaxfileupload.js"></script>
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/core/base.js" ></script>  
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/plugins/ligerDialog.js" ></script> 
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/plugins/ligerDrag.js" ></script> 
    <script  type="text/javascript" >
	function ajaxFileUpload(callback){
	        if($("#file").val()==""){
		        $.ligerDialog.warn("请选择文件！");
		        return false;
	          }
            var name = $("#file").val();
			var names = name.split(".");
			var a = names[names.length-1];
			if(a != "gif" && a != "jpg" && a != "jpeg" && a != "png"){
				$.ligerDialog.error("请选择图片！");
 		        return false;
			}
	        $.ajaxSetup({ async : false});
	        $("#loading")
	        .ajaxStart(function(){
	            $(this).show();
	            $("#loads").hide();
	        })//开始上传文件时显示一个图片
	        .ajaxComplete(function(){
	            $(this).hide();
	            $("#loads").show();
	        });//文件上传完成将图片隐藏起来
	        $.ajaxFileUpload({
	                url:'fileuploadLK.action',//用于文件上传的服务器端请求地址
	                secureuri:false,//一般设置为false
	                fileElementId:'file',//文件上传空间的id属性  <input type="file" id="file" name="file" />
	                dataType: 'json',//返回值类型 一般设置为json
	                success: function (data, status){  //服务器成功响应处理函数
	                	if(data.message == "success"){
	                		top.my_alert("上传成功","success");
	                	 }else{
	                		top.my_alert("上传失败","error");
	                	 }
	                	 callback(data);
	                },
	                error: function (data, status, e){ //服务器响应失败处理函数
	                    $.ligerDialog.error(e);
	                }
	            });
	            return false;
	    }
	    
	
    </script>
    <style type="text/css">
   	 	#loading{
   	 		position:absolute; 
   	 		left:0px; 
   	 		top:0px; 
   	 		width:100%; 
   	 		height:100%;
   	 		display:none;
   	 		z-index:99999;
   	 		background:rgba(255,255,255,0.5) url('images/loading/bigloading.gif') no-repeat center; 
   	 		}
    </style>
    </head>
    <body>
        <div align="center"  id="loading" >
        </div>
        <div align="center" id="loads" style="margin-top: 50px">
        	<input type="file" id="file" name="file" class="btn1" accept="image/*"/>
        </div>
    </body>
</html>