<%@page import="com.google.inject.servlet.SessionScoped"%>
<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String servicetype = request.getParameter("servicetype");
%>
<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
	<link  rel="stylesheet" type="text/css"  href="<%=basePath  %>css/main.css"/>     
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/ajaxfileupload.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath %>/css/reportMain.css"/>
    <script  type="text/javascript" >
	    jQuery(function ($){
	    	var type="<%=servicetype %>";
	    	if(type=="01"){
	    		$("#controlpstemplate").hide();
	    		$("#citycodetemplate").hide();
	    		$("#dictiontemplate").hide();
	    	}else if(type=="02"){
	    		$("#usertemplate").hide();
	    		$("#citycodetemplate").hide();
	    		$("#dictiontemplate").hide();
	    	}else if(type=="03"){
	    		$("#controlpstemplate").hide();
	    		$("#usertemplate").hide();
	    		$("#dictiontemplate").hide();
	    	}else if(type=="04"){
	    		$("#controlpstemplate").hide();
	    		$("#usertemplate").hide();
	    		$("#citycodetemplate").hide();
	    	}
	    });
	    function ajaxFileUpload(callback){
	    		if($("#file").val()==""){
					top.$.ligerDialog.warn("请选择文件！");
	 		        return false;
				}
				var name = $("#file").val();
				var names = name.split(".");
				var a = names[names.length-1];
				if(a!="xlsx"&&a!="xls"){
					top.$.ligerDialog.warn("请选择Excel文件！");
	 		        return false;
				}
				$("#loading").show();
	    	$.ajaxFileUpload({
	            url:'serviceExcelImport.action',//用于文件上传的服务器端请求地址
	            data: {//加入的文本参数  
			            "servicetype": "<%=servicetype %>"
			    },  
	            secureuri:false,//一般设置为false
	            fileElementId:'file',//文件上传空间的id属性  <input type="file" id="file" name="file" />
	            dataType: 'json',//返回值类型 一般设置为json
	            async:false, 
				success: function (data, status){  //服务器成功响应处理函数
					if(data.message == "success"){
						if("error" == data.result){
							top.$.ligerDialog.error("导入信息失败!","error");
							$("#loading").hide();
						}else if("success" == data.result){
							top.$.ligerDialog.success("成功导入"+data.cgcount+"条，失败0条","success");
						}else{
							var tt = data.result;
							var a = tt.split(",");
							var b = "";
							for(var i=0;i<a.length;i++){
								b+=a[i]+'<br>'
							}
							top.$.ligerDialog.warn("系统中含有如下未添加信息，请先添加这些信息！"+'<br/>'+b);
						}
						$("#loading").hide();
						callback(null);
					}else{
						top.$.ligerDialog.error("文件上传失败！");
						$("#loading").hide();
					}
				},
				error: function (data, status, e){ //服务器响应失败处理函数
					top.$.ligerDialog.error("文件上传失败:"+e);
					$("#loading").hide();
				}
			});
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
        	<input type="file" id="file" name="file" class="btn1"/>
        </div>
        <table style="width: 100%;margin: 20px auto;text-align: center;color: red;font-size: 14px;">
			<tr>
				<td align="right" width="22%">注：</td>
				<td align="left">1、只能上传特定模板的Excel文件！</td>
			</tr>
			<tr>
				<td align="right" width="22%"></td>
				<td align="left">2、Excel模板
					<a id="usertemplate" target="_blank" href="system/templatefile/usertemplate.zip">下载</a>
					<a id="controlpstemplate" target="_blank" href="system/templatefile/controlpstemplate.zip">下载</a>
					<a id="citycodetemplate" target="_blank" href="system/templatefile/citycodetemplate.zip">下载</a>
					<a id="dictiontemplate" target="_blank" href="system/templatefile/dictiontemplate.zip">下载</a>！
				</td>
			</tr>
		</table>
    </body>
</html>