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
    <title>碰撞库信息添加</title>
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
                    { label: "库名称",name: "MC", newline: true, type: "text", validate: { required: true,maxlength: 100 } },
                    { label: "服务id", name: "FWID", newline: true, type: "text", validate: { required: true,maxlength: 100 }},
                    { label: "分值",name: "FZ", newline: true, type: "text", validate: { required: true,maxlength: 100 } },
                    { label: "预警原因",name: "YJYY", newline: true, type: "text"},
                    { label: "预警要求",name: "YJYQ", newline: true, type: "text"},
                    { label: "备注信息", name: "BZXX", newline: true, type: "textarea", validate: { required: true}},
                    
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
		   	var MC = formData.MC;
		   	var FZ = formData.FZ;
		   	var BZXX = formData.BZXX;
		   	var FWID = formData.FWID;
		   	var YJYY = formData.YJYY;
		   	var YJYQ = formData.YJYQ;
		   	var dataPost = {"model.MC":MC,"model.FZ":FZ,"model.BZXX":BZXX,"model.FWID":FWID,"model.YJYY":YJYY,"model.YJYQ":YJYQ};
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
