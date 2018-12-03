<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id = request.getParameter("id");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>保险信息修改</title>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/messages_cn.js" type="text/javascript"></script>
    <script type="text/javascript">
        var form;
        var dataGrid = [
 	                 { id: 'yyyy', name: '年'}, 
 	                 { id: 'MM', name: '月'}, 
 	                 { id: 'dd', name: '日'}, 
 	                 { id: 'HH', name: '时'}, 
 	                 { id: 'mm', name: '分'}, 
 	                 { id: 'ss', name: '秒'}, 
 	                 { id: 'SSS', name: '毫秒'}
                 ]; 
        
        $(function (){
        	form = $("#form2").ligerForm({
                inputWidth: 170, 
                space: 20,
				validate : true,
                fields: [ 
               	    { label: "保险", name: "TYPENAME", newline: true, width:300,type:"text"},
                    { label: "备注", name: "MEMO", newline: true, width:300,type:"textarea", validate: { maxlength: 200 }}
                ]
            }); 
            getCodeInfo();
        });
		function hideDiv(){
			form.setVisible(["codevalue", "displayvalue", "codeformat", "displayformat", "seqvalue", "seqlength", "displayseq"], false);
		}
        function f_validate(){ 
			if(form.valid()){
				return datePost();
			}else{
			    form.showInvalid();
			}
		}
		function datePost(){
			var formData = form.getData();
			var TYPENAME = formData.TYPENAME;
			var MEMO = formData.MEMO;
			var data = {"insurance.TYPENAME":TYPENAME,"insurance.MEMO":MEMO,"insurance.ID":<%=id %>};
			return data;
		}
		
	function getCodeInfo(){
		  $.ajax({
			url:"InsuranceQueryById.action?id=<%=id %>", 
			async:false,
			dataType:"json", 
			type:"post",
			success:function (mm) {
		        liger.get("form2").setData({
					TYPENAME:mm.TYPENAME,
					MEMO:mm.MEMO
				}); 
				
				/* var dateFormat = codedateformate(mm.TYPENAME);
				if(dateFormat != ""){
				 liger.get("form2").setData({
					TYPENAME: dateFormat
				});
				} */
			}, 
			error:function (error) {
				alert("获取单个信息失败****" + error.status);
			}
			});
		}
		
		
	
    </script>
    <style type="text/css">
        html,body{ 
	        margin:0;
	        padding:0;
        	font-size:14px;
        }
    </style>
</head>
<body style="padding:10px">   
	<form id="form2"></form> 
</body>
</html>
