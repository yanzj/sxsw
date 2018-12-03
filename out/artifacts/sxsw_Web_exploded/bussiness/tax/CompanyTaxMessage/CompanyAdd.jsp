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
    <title>企业信息添加</title>
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
                inputWidth: 160, 
                labelWidth: 140, 
                space: 20,
				validate : true,
                fields: [ 
                	{ label: "行政区", name: "AREA_NAME", newline: true, width:180, type: "select", validate: { required: true}, 
						editor: {
							width : 1800, 
							selectBoxWidth: 200,
							selectBoxHeight: 200, 
							valueField: 'id',
							treeLeafOnly: false,
							tree: { 
								url:"taxDeptSelectedQuery.action", 
								ajaxType:'post',
								idFieldName: 'id',					
								checkbox: false
							},
							onSelected: function(id,value){
								if(''!=id&&''!=value&&"null"!=value){
									$("[name=AREA]").val(id);
								}
							}
						}
					},
					{ label: "人社单位编号", name: "SOCIAL_SECURITY_NO",width:280},
					{ label: "税务纳税人识别号", name: "TAX_NO",width:280},
					{ label: "人社单位名称", name: "COMPANY_NAME" ,width:280},
					{ label: "税务纳税人名称", name: "PAY_TAX_PEPOLE_NAME" ,width:280},
					{ label: "社保类型名称", name: "TYPENAME" ,width:280},
					{ label: "密码", name: "PASSWORD" ,width:280},
					{ label: "人社参保单位状态", name: "COMPANY_STATUS",width:280 },
					{ label: "税务登记类型", name: "TAX_TYPE" ,width:280},
					{ label: "税务纳税人状态", name: "PAY_TAX_PEPOLE_STATUS",width:280},
					{ label: "主管税务局", name: "TAX_BUREAU" ,width:280},
					{ label: "主管税务所科分局", name: "SUB_TAX_BUREAU",width:280 },			
					{ label: "人社经办机构", name: "SOCIAL_SECURITY_ORGANIZATION",width:280 },		
					{ label: "税务行政区划", name: "TAX_AREA",width:280},
					{ label: "税务街道乡镇", name: "TAX_STREET",width:280 },
					{ label: "人社单位电话", name: "COMPANY_TEL" ,width:280},
					{ label: "人社单位地址", name: "COMPANY_ADDRESS",width:280},
					{ label: "税务联系方式", name: "TAX_TEL",width:280},
					{ label: "税务生产经营地址", name: "TAX_PRODUCT_ADDRESS",width:280 },
					{ label: "人社工商营业执照号码", name: "SOCIAL_BUSINESS_NO",width:280 },
					{ label: "人社组织机构代码", name: "SOCIAL_ORGRNIZATION_NO",width:280 },
					{ label: "税务组织机构", name: "TAX_ORGANIZATION" ,width:280},
					{ label: "人社法人姓名", name: "LEGAL_PERSON_NAME" ,width:280},
					{ label: "人社法人身份证号", name: "LEGAL_PERSON_ID" ,width:280},
					{ label: "人社法人联系方式", name: "LEGAL_PERSON_TEL" ,width:280},
					{ label: "税务法定代表人姓名", name: "TAX_LEGAL_PERSON_NAME",width:280 },
					{ label: "人社专管员姓名", name: "SOCIAL_MASTER_NAME",width:280 },
					{ label: "人社专管员联系方式", name: "SOCIAL_MASTER_TEL" ,width:280},
					/* { label: "人社单位类型", name: "COMPANY_TYPE",width:280}, */
					{ label: "人社缴费方式", name: "SOCIAL_PAY_TYPE",width:280},
					{ label: "税收管理员", name: "TAX_ADMIN",width:280 },
					{ label: "登记序号", name: "REGISTER_NO" ,width:280},
					{ label: "所属平台", name: "JCBH", newline: true, type: "select", validate: { required: true}, 
						editor: {
							width : 1800, 
							selectBoxWidth: 200,
							selectBoxHeight: 200, 
							valueField: 'id',
							treeLeafOnly: false,
							tree: { 
								url:"airPostSelectedQuery.action", 
								ajaxType:'post',
								idFieldName: 'id',
								autoCheckboxEven:false,
								nodeWidth :140,
								checkbox: false
							},
		                    onSelected: function(id,value){
								if(''!=id&&''!=value&&"null"!=value){
										liger.get("dept").treeManager.set("url","cropDeptTreeQuery.action?id="+id);
								}
							}
						}
					},
                    { label: "所属部门", name: "dept", newline: false, type: "select", validate: { required: true},
	                    editor: {
	                        width : 1800, 
				            selectBoxWidth: 200,
				            selectBoxHeight: 200, 
				            valueField: 'id',
				            treeLeafOnly: false,//只能选中子节点的属性
	                        tree: { 
								ajaxType:'post',
								idFieldName: 'id',
                				parentIDFieldName: 'pid',
                				autoCheckboxEven:false,
                				nodeWidth :140,
                				checkbox: false
							},
							onSelected: function(id,value){
								if(''!=id&&''!=value&&"null"!=value){
										$("[name=SSBMBH]").val(id);
								}
							}
	                    }
                    },
					
				
                ]
            });
  			
        });
        
        /**提交验证*/
        function f_validate() { 
          if(form.valid()){
				return form.getData();
			}else{
			    form.showInvalid();
			}
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
