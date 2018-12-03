<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String itemid = request.getParameter("itemid");
String itemtype = request.getParameter("itemtype");
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
	<link  rel="stylesheet" type="text/css"  href="<%=basePath  %>css/main.css"/>     
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/ajaxfileupload.js"></script>
    <script  type="text/javascript" >
	function ajaxFileUpload(callback){
	        if($("#file").val()==""){
		        top.$.ligerDilaog.warn("请选择文件！");
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
	        var dataM;
	        $.ajaxFileUpload({
	                url:'fileupload.action',//用于文件上传的服务器端请求地址
	                secureuri:false,//一般设置为false
	                fileElementId:'file',//文件上传空间的id属性  <input type="file" id="file" name="file" />
	                dataType: 'json',//返回值类型 一般设置为json
                  	data: {//加入的文本参数  
			            "itemid": "<%=itemid %>",  
			            "itemtype": "<%=itemtype %>"  
			        },  
	                success: function (data, status){  //服务器成功响应处理函数
	                	if(data.message === "success"){
	                		top.$.ligerDialog.success("上传成功！");
	                	 }else{
	                	 	top.$.ligerDialog.error("文件上传失败！");
	                	 }
	                	 callback(data);
	                },
	                error: function (data, status, e){ //服务器响应失败处理函数
	                    alert(e);
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
        	<input type="file" id="file" name="file" class="btn1"/>
        </div>
    </body>
</html>