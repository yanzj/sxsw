<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id=request.getParameter("id");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>碰撞库信息修改</title>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script type="text/javascript">
	   function modifyPost() {
	   		var formData = liger.get("form2").getData();
		   	var MC = formData.MC;
		   	var FZ = formData.FZ;
		   	var BZXX = formData.BZXX;
		   	var FWID = formData.FWID;
		   	var YJYY = formData.YJYY;
		   	var YJYQ = formData.YJYQ;
		   	var id = $("#rid").val();
		   	var dataPost = {"model.BH":id,"model.MC":MC,"model.FZ":FZ,"model.BZXX":BZXX,"model.FWID":FWID,"model.YJYY":YJYY,"model.YJYQ":YJYQ};
			return dataPost;
		}  


		/**
	   	获取单个的信息
	   */
	  function  getMess(mid){
	     $.ajax({
			url:"databaseinfoQueryById.action", 
			data:"model.BH="+mid, 
			dataType:"json", 
			type:"post",
			success:function (data) {
				var mm = data.dataModel;
				liger.get("form2").setData({
					MC:mm.MC,
					FZ:mm.FZ,
					BZXX:mm.BZXX,
					FWID:mm.FWID,
					YJYY:mm.YJYY,
					YJYQ:mm.YJYQ
				});
			}, 
			error:function (error) {
				alert("获取单个信息失败****" + error.status);
		}});
	  } 
    </script>
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
                    { label: "服务id",name: "FWID", newline: true, type: "text", validate: { required: true,maxlength: 100 } },
                    { label: "分值",name: "FZ", newline: true, type: "text", validate: { required: true,maxlength:100} },
                    { label: "预警原因",name: "YJYY", newline: true, type: "text"},
                    { label: "预警要求",name: "YJYQ", newline: true, type: "text"},
                    { label: "备注信息",name: "BZXX", newline: true, type: "textarea", validate: { required: true} },
                ]
            });
            getMess("<%=id %>");
        });
        
        /**提交验证*/
        function f_validate() { 
            if (form.valid()) {
              return modifyPost();
            }else {
                form.showInvalid();
            }
            return null;
        }

	</script>
    <style type="text/css">
        body{ 
	         margin: 0;
	         padding: 0;
        }
    </style>
</head>
<body style="padding:10px">   
	<form id="form2"></form> 
	<input type="hidden" id="rid" value="<%=id %>"/>
</body>
</html>