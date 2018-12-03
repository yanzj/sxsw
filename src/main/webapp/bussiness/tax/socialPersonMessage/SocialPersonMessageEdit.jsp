<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id = request.getParameter("id");//部门pid
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<base href="<%=basePath %>"/>
    <title>部门信息修改</title>
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
                	{ name: "BMBH", type: "hidden"},
                	{ name: "SXH", type: "hidden"},
                	{ name: "JCBH", type: "hidden"},
                    { label: "部门名称",name: "BMMC", newline: true, type: "text", validate: { required: true,maxlength: 100 } },
                    { label: "所属平台", name: "JCMC", newline: true, type: "text"},                    
					{ label: "上级部门", name: "SJBMBH", newline: true, type: "select", validate: { required: true}, 
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
								parentIDFieldName: 'pid',
								checkbox: false
							}
						}
					},
                    { label: "部门描述",name: "BZXX", newline: true, type: "textarea",width:300 , validate: { maxlength:200} }
                ]
            });
  			getMess("<%=id %>");
			
        });
        
        /**提交验证*/
        function f_validate() { 
            if (form.valid()) {
              return form.getData();
            }else {
                form.showInvalid();
            }
            return null;
        }
 
		 /**
		    获取单个的信息
		 */
		 function  getMess(mid){
		    $.ajax({
			url:"deptgetById.action", 
			data:"BMBH="+mid, 
			async:false,
			dataType:"json", 
			type:"post",
			success:function (mm) {
			   form.setEnabled(["JCMC"], false);
		       liger.get("form2").setData({
		    	    BMBH:mm.BMBH,
		    	    BMMC:mm.BMMC,
		    	    SJBMBH:mm.SJBMBH,
		    	    SXH: mm.SXH,
		    	    JGBM:mm.JGBM,
					BZXX:mm.BZXX,
					JCBH:mm.JCBH,
					JCMC:mm.JCMC
				});
			}, 
			error:function (error) {
				alert("获取单个信息失败****" + error.status);
			}
		});
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
