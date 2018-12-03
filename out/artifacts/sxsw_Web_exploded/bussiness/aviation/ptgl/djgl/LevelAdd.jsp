<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String pid = request.getParameter("pid");//部门id
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath %>"/>
    <title>等级管理添加</title>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/messages_cn.js" type="text/javascript"></script>
	<script type="text/javascript">
		var form;
        $(function (){
        	form = $("#form2").ligerForm({
                inputWidth: 170, 
                labelWidth: 90, 
                space: 40,
				validate : true,
                fields: [ 
                    { label: "等级名称",name: "DJMC", newline: true, type: "text", validate: { required: true,maxlength: 100 } },
                    { label: "等级简称",name: "DJJC", newline: true, type: "text", validate: { required: true,maxlength: 100 } },
                    { label: "最小分值", name: "ZXFZ", newline: true, type: "text", validate: { required: true}},
					{ label: "最大分值", name: "ZDFZ", newline: true, type: "text", validate: { required: true } },
                    { label: "备注信息",name: "BZXX", newline: true, type: "textarea",width:300 , validate: { maxlength:200} }
                ]
            });
        });
        
        /**提交验证*/
        function f_validate() { 
            if (form.valid()) {
               return addPost();
            }else {
                form.showInvalid();
            }
            return null;
        }
        function  addPost(){
		   	var formData = liger.get("form2").getData();
		   	var DJMC = formData.DJMC;
		   	var DJJC = formData.DJJC;
		   	var ZXFZ = formData.ZXFZ;
		   	var ZDFZ = formData.ZDFZ;
		   	var BZXX = formData.BZXX;
		   	var dataPost = {"model.DJMC":DJMC,"model.DJJC":DJJC,"model.ZXFZ":ZXFZ,"model.ZDFZ":ZDFZ,"model.BZXX":BZXX};
			return dataPost;
	   }
	</script>
    <style type="text/css">
        body{ 
	         margin: 0;
	         padding: 0;
        }
        .liger-button {
        	float:left;
        	margin-left:20px;
       	}
    </style>
</head>
<body style="padding:10px">   
	<form id="form2"></form> 
</body>
