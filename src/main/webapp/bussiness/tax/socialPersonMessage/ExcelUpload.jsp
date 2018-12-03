<%@page import="com.google.inject.servlet.SessionScoped"%>
<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script>
    <script  src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
    <script  src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script  src="<%=basePath  %>include/LigerUI/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script> 
	<link  rel="stylesheet" type="text/css"  href="<%=basePath  %>css/main.css"/>     
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/ajaxfileupload.js"></script>
  
    <script  type="text/javascript" >
    var form;
    jQuery(function ($){
	    	form = $("#form2").ligerForm({
                inputWidth: 200, 
                labelWidth: 60, 
                space: 50,
				validate : true,
                fields: [ 
						{ label: "行政区域", name: "JCBH", newline: true, type: "select", validate: { required: true}, 
							editor: {
								width : 180, 
								selectBoxWidth: 200,
								selectBoxHeight: 200, 
								valueField: 'id',
								treeLeafOnly: false,
								tree: { 
									url:"corpSelectedQuery.action", 
									ajaxType:'post',
									idFieldName: 'id',
									autoCheckboxEven:false,
									parentIDFieldName: 'pid',
									nodeWidth :140,
									checkbox: false
								},
						        onSelected: function(id,value){
									if(''!=id&&''!=value&&"null"!=value){
											$("#area").val(id);
									}
								}
							}
						},
                	{ label: "社保种类", name: "JCBH", newline: true, type: "select", validate: { required: true}, 
						editor: {
							width : 180, 
							selectBoxWidth: 200,
							selectBoxHeight: 200, 
							valueField: 'id',
							treeLeafOnly: false,
							tree: { 
								url:"taxPostSelectedQuery.action", 
								ajaxType:'post',
								idFieldName: 'id',
								autoCheckboxEven:false,
								nodeWidth :140,
								checkbox: false
							},
		                    onSelected: function(id,value){
								if(''!=id&&''!=value&&"null"!=value){
										$("#type").val(id);
								}
							}
						}
					}
                ]
            });
	    });
	    function ajaxFileUpload(callback){
	    	    var  type= $("#type").val();
	    	    var  area= $("#area").val();
	    	    if(area==''){
	    	    	top.$.ligerDialog.warn("请选择行政区域！");
	 		        return false;
	    	    }
	    	    if(type==''){
	    	    	top.$.ligerDialog.warn("请选择社保类型！");
	 		        return false;
	    	    }
	    	   
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
				$("#loads").show();
				
	    	    $.ajaxFileUpload({
	            url:'taxImportExcel.action',
	            data: {
			            "type": type,
			            "area":area
			    },  
	            secureuri:false,
	            fileElementId:'file',
	            dataType: 'json',
	            async:false, 
				success: function (data, status){	
					  $("#type").val("");
			    	  $("#area").val("");
					if(data.message == "success"){
						if("error" == data.result){
							top.$.ligerDialog.error("导入信息失败!","失败");
							 $("#loading").hide();
						}else if("success" == data.result){
							top.$.ligerDialog.success("成功导入"+data.cgcount+"条，失败0条","成功");
						}else{
							var tt = data.result;
							var a = tt.split(",");
							var b = "";
							for(var i=0;i<a.length;i++){
								b+=a[i]+'<br>'
							}
							top.$.ligerDialog.warn("系统存在不匹配字段:"+'<br/>'+b);
						}
						$("#loading").hide();
						callback(null);
					}else{
						top.$.ligerDialog.error("文件上传失败！");
						$("#loading").hide();
					}
				},
				error: function (data, status, e){ 	
					 $("#type").val("");
			    	 $("#area").val("");
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
   	 		} *
    </style>
    </head>
    <body>
    <input type="hidden" id="type">
     <input type="hidden" id="area">
    <form id="form2" style="margin-top: 30px;"></form> 
      	<div align="center"  id="loading" ></div>
        <div align="left" id="loads" style="margin-top: 20px;margin-left: 10px;">
        	<input style="border:0.5px solid #a3c0e8" size="40" type="file" id="file" name="file" class="btn1"/>
        </div>
       <!-- <div align="left" id="loads" style="margin-top: 20px;margin-left: 10px;" id="count" style="display:none">
              <h4> 已 导 入:<span>0</span>条</h4> 
       </div> --> 	
        
    </body>
</html>