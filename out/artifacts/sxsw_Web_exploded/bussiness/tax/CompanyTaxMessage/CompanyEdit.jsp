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
    <title>企业信息修改</title>
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
                labelWidth: 80, 
                space: 20,
				validate : true,
                fields: [ 
                	{ name: "ID", type: "hidden"},
                	{ name: "TAX_NO", type: "hidden"},
                	{ name: "PAY_TAX_PEPOLE_NAME", type: "hidden"},
                	{ name: "COMPANY_NAME", type: "hidden"},
                	{ label: "原密码",name: "PASSWORD", newline:false, type: "text", width:150},
                	{ label: "新密码",name: "NEWPWD", newline:false, type: "password", width:150},
                	{ label: "确认密码",name: "REPWD", newline:false, type: "password", width:150 }
                	/* 
                	,validate:"{required:true,maxlength:6,digits:true}",id:newpassword,
                	,validate:"{required:true,maxlength:6,digits:true,equalTo:'#newpassword'}"
                	{ name: "SOCIAL_SECURITY_NO", type: "hidden"},
                	{ name: "TAX_NO", type: "hidden"},
                    { label: "人社单位名称",name: "COMPANY_NAME", newline:false, type: "text", width:280},
                    { label: "密码",name: "PASSWORD", newline: false, type: "text", validate: { required: true,maxlength: 100 } },
                    { label: "税务纳税人名称",name: "PAY_TAX_PEPOLE_NAME", newline: true, type: "text", width:280},
                    { label: "人社参保单位状态",name: "COMPANY_STATUS", newline: false, type: "text", width:280 },
                    { label: "税务登记类型",name: "TAX_TYPE", newline: false, type: "text" , width:280},
                    { label: "税务纳税人状态",name: "PAY_TAX_PEPOLE_STATUS", newline: false, type: "text" , width:280},
                    { label: "主管税务局",name: "TAX_BUREAU", newline: false, type: "text", width:280},
                    { label: "主管税务所科分局",name: "SUB_TAX_BUREAU", newline: false, type: "text", width:280},
                    { label: "人社经办机构",name: "SOCIAL_SECURITY_ORGANIZATION", newline: false, type: "text", width:280},
                    { label: "税务行政区划",name: "TAX_AREA", newline: false, type: "text", width:280},
                    { label: "税务街道乡镇",name: "TAX_STREET", newline: false, type: "text", width:280},
                    { label: "人社单位电话",name: "COMPANY_TEL", newline: false, type: "text", width:280},
                    { label: "人社单位地址",name: "COMPANY_ADDRESS", newline: false, type: "text", width:280 },
                    { label: "税务联系方式",name: "TAX_TEL", newline: false, type: "text", width:280 },
                    { label: "税务生产经营地址",name: "TAX_PRODUCT_ADDRESS", newline: false, type: "text", width:280},
                    { label: "人社工商营业执照号码",name: "SOCIAL_BUSINESS_NO", newline: false, type: "text", width:280},
                    { label: "人社组织机构代码",name: "SOCIAL_ORGRNIZATION_NO", newline: false, type: "text", width:280},
                    { label: "税务组织机构",name: "TAX_ORGANIZATION", newline: false, type: "text" , width:280},
                    { label: "人社法人姓名",name: "LEGAL_PERSON_NAME", newline: false, type: "text", width:280},
                    { label: "人社法人身份证号",name: "LEGAL_PERSON_ID", newline: false, type: "text", width:280},
                    { label: "人社法人联系方式",name: "LEGAL_PERSON_TEL", newline: false, type: "text", width:280},
                    { label: "税务法定代表人姓名",name: "TAX_LEGAL_PERSON_NAME", newline: false, type: "text", width:280 },
                    { label: "人社专管员姓名",name: "SOCIAL_MASTER_NAME", newline: false, type: "text", width:280 },
                    { label: "人社专管员联系方式",name: "SOCIAL_MASTER_TEL", newline: false, type: "text", width:280},
                    { label: "人社单位类型",name: "COMPANY_TYPE", newline: false, type: "text", width:280 },
                    { label: "人社缴费方式",name: "SOCIAL_PAY_TYPE", newline: false, type: "text", width:280 },
                    { label: "税收管理员",name: "TAX_ADMIN", newline: false, type: "text", width:280},
                    { label: "登记序号",name: "REGISTER_NO", newline: false, type: "text", width:280 },
                    { label: "修改", name: "IF_MODIFY", newline: false, type: "text", width:280},                    
                    { label: "匹配", name: "IF_MATCHED", newline: false, type: "text", width:280},                    
                    { label: "人社经办人", name: "SOCIAL_AGENT", newline: false, type: "text", width:280},                    
                    { label: "人社经办人联系电话", name: "SOCIAL_AGENT_TEL", newline: false, type: "text", width:280},                    
                    { label: "单位性质", name: "UNIT_PROPERTIES", newline: false, type: "text", width:280},                    
                    { label: "是否为城乡虚拟户", name: "REGISTERED_RESIDENCE", newline: false, type: "text", width:280} */                 
                    /* { label: "社保类型", name: "TYPE", newline: false, type: "text", width:280},                    
                    { label: "社保区域", name: "AREA", newline: false, type: "text", width:280}   */               
                    
                ]
            });
  			getMess("<%=id %>");
			
        });
        
        /**提交验证*/
        function f_validate() { 
         var  ID = liger.get("form2").getData().ID;
         var  pwd = liger.get("form2").getData().NEWPWD;
         var  repwd = liger.get("form2").getData().REPWD;
         var  TAX_NO = liger.get("form2").getData().TAX_NO;
         var  PAY_TAX_PEPOLE_NAME = liger.get("form2").getData().PAY_TAX_PEPOLE_NAME;
         var  COMPANY_NAME = liger.get("form2").getData().COMPANY_NAME;
         
        
         var reg=new RegExp("^[0-9]{6}$");
         
            if (form.valid()) {
            if(pwd.match(reg)&&repwd.match(reg)&&pwd==repwd){
            	var data={"PASSWORD":pwd,"ID":ID,"TAX_NO":TAX_NO,"PAY_TAX_PEPOLE_NAME":PAY_TAX_PEPOLE_NAME,"COMPANY_NAME":COMPANY_NAME};
             //alert(ID);
             //alert(COMPANY_NAME); 
             	return data;
            }
             
            }else {
                form.showInvalid();
            }
            
            return top.$.ligerDialog.error("请重新输入六位整数密码");
            
           
        }
 
		 /**
		    获取单个的信息
		 */
		 function  getMess(mid){
		    $.ajax({
			url:"companyById.action", 
			data:"ID="+mid, 
			async:false,
			dataType:"json", 
			type:"post",
			success:function (mm) {
			   form.setEnabled(["PASSWORD"], false); 
			   
			   /* form.setEnabled(["COMPANY_NAME"], false); 
			   form.setEnabled(["PAY_TAX_PEPOLE_NAME"], false); 
			   form.setEnabled(["COMPANY_STATUS"], false); 
			   form.setEnabled(["TAX_TYPE"], false); 
			   form.setEnabled(["PAY_TAX_PEPOLE_STATUS"], false); 
			   form.setEnabled(["TAX_BUREAU"], false); 
			   form.setEnabled(["SUB_TAX_BUREAU"], false); 
			   form.setEnabled(["SOCIAL_SECURITY_ORGANIZATION"], false); 
			   form.setEnabled(["TAX_AREA"], false); 
			   form.setEnabled(["TAX_STREET"], false); 
			   form.setEnabled(["COMPANY_TEL"], false); 
			   form.setEnabled(["COMPANY_ADDRESS"], false); 
			   form.setEnabled(["TAX_TEL"], false); 
			   form.setEnabled(["TAX_PRODUCT_ADDRESS"], false); 
			   form.setEnabled(["SOCIAL_BUSINESS_NO"], false); 
			   form.setEnabled(["SOCIAL_ORGRNIZATION_NO"], false); 
			   form.setEnabled(["TAX_ORGANIZATION"], false); 
			   form.setEnabled(["LEGAL_PERSON_NAME"], false); 
			   form.setEnabled(["LEGAL_PERSON_ID"], false); 
			   form.setEnabled(["LEGAL_PERSON_TEL"], false); 
			   form.setEnabled(["TAX_LEGAL_PERSON_NAME"], false); 
			   form.setEnabled(["SOCIAL_MASTER_NAME"], false); 
			   form.setEnabled(["SOCIAL_MASTER_TEL"], false); 
			   form.setEnabled(["COMPANY_TYPE"], false); 
			   form.setEnabled(["SOCIAL_PAY_TYPE"], false); 
			   form.setEnabled(["TAX_ADMIN"], false); 
			   form.setEnabled(["REGISTER_NO"], false); 
			   form.setEnabled(["IF_MODIFY"], false); 
			   form.setEnabled(["IF_MATCHED"], false); 
			   form.setEnabled(["SOCIAL_AGENT"], false); 
			   form.setEnabled(["SOCIAL_AGENT_TEL"], false); 
			   form.setEnabled(["UNIT_PROPERTIES"], false); 
			   form.setEnabled(["REGISTERED_RESIDENCE"], false);  */
			   /* form.setEnabled(["TYPE"], false); 
			   form.setEnabled(["AREA"], false);  */
			  /*  var a;
			    if(0==mm.IF_MODIFY){
			        a='未修改';
			        }else{
			        a='已修改';
			        }
			   var b;
			     if(0==mm.IF_MATCHED){
			     	b='未匹配';
			     }else{
			     	b='已匹配';
			     }
			    var c;
			    if(0==mm.REGISTERED_RESIDENCE){
			    	c='否';
			    }else{
			    	c='是';
			    } */
		       liger.get("form2").setData({
		       		ID:mm.ID,
		       		PASSWORD:mm.PASSWORD,
		       		TAX_NO:mm.TAX_NO,
		       		COMPANY_NAME:mm.COMPANY_NAME,
		       		PAY_TAX_PEPOLE_NAME: mm.PAY_TAX_PEPOLE_NAME
		    	    /* SOCIAL_SECURITY_NO:mm.SOCIAL_SECURITY_NO,
		    	    TAX_NO:mm.TAX_NO,
		    	    COMPANY_NAME:mm.COMPANY_NAME,
		    	    PAY_TAX_PEPOLE_NAME: mm.PAY_TAX_PEPOLE_NAME,
		    	    COMPANY_STATUS:mm.COMPANY_STATUS,
					TAX_TYPE:mm.TAX_TYPE,
					PAY_TAX_PEPOLE_STATUS:mm.PAY_TAX_PEPOLE_STATUS,
					TAX_BUREAU:mm.TAX_BUREAU,
					SUB_TAX_BUREAU:mm.SUB_TAX_BUREAU,
					SOCIAL_SECURITY_ORGANIZATION:mm.SOCIAL_SECURITY_ORGANIZATION,
					TAX_AREA:mm.TAX_AREA,
					TAX_STREET:mm.TAX_STREET,
					COMPANY_TEL:mm.COMPANY_TEL,
					COMPANY_ADDRESS:mm.COMPANY_ADDRESS,
					TAX_TEL:mm.TAX_TEL,
					TAX_PRODUCT_ADDRESS:mm.TAX_PRODUCT_ADDRESS,
					SOCIAL_BUSINESS_NO:mm.SOCIAL_BUSINESS_NO,
					SOCIAL_ORGRNIZATION_NO:mm.SOCIAL_ORGRNIZATION_NO,
					TAX_ORGANIZATION:mm.TAX_ORGANIZATION,
					LEGAL_PERSON_NAME:mm.LEGAL_PERSON_NAME,
					LEGAL_PERSON_ID:mm.LEGAL_PERSON_ID,
					LEGAL_PERSON_TEL:mm.LEGAL_PERSON_TEL,
					TAX_LEGAL_PERSON_NAME:mm.TAX_LEGAL_PERSON_NAME,
					SOCIAL_MASTER_NAME:mm.SOCIAL_MASTER_NAME,
					SOCIAL_MASTER_TEL:mm.SOCIAL_MASTER_TEL,
					COMPANY_TYPE:mm.COMPANY_TYPE,
					SOCIAL_PAY_TYPE:mm.SOCIAL_PAY_TYPE,
					TAX_ADMIN:mm.TAX_ADMIN,
					REGISTER_NO:mm.REGISTER_NO,
					IF_MODIFY:a,
					IF_MATCHED:b,
					SOCIAL_AGENT:mm.SOCIAL_AGENT,
					SOCIAL_AGENT_TEL:mm.SOCIAL_AGENT_TEL,
					UNIT_PROPERTIES:mm.UNIT_PROPERTIES,
					REGISTERED_RESIDENCE:c, */
				/* 	TYPE:mm.TYPE,
					AREA:mm.AREA, */
					
					
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
