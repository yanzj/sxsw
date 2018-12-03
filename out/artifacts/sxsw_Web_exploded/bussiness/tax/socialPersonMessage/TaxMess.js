 var SOCIAL_SECURITY_NO="";
jQuery(function ($){  
	 SOCIAL_SECURITY_NO= $.getUrlParam('SOCIAL_SECURITY_NO');
	 getMess(SOCIAL_SECURITY_NO);  
	 $(".onclick").click( function () { 
			$('.tree').show('fast');
		});
	 $.post("ztree.action",function(data){
  	   var setting = {
  				data: {
  					simpleData: {
  						enable: true
  					}
  				},
  				
  				callback: {
  					beforeClick: beforeClick,
  					onClick: onClick
  				}
  			};
  	var   zNodes=JSON.parse(data).ztree; 
  	$.fn.zTree.init($("#treeDemo"), setting, zNodes);	
	     });
	 
	 $("#btn").click(function(){
	 $("#confirm").modal('show');	
	 $("#submit").click(function(){
		 sub_mit(SOCIAL_SECURITY_NO);
	 }
	
	 );         
	          
                 
        });
 });
 
function beforeClick(treeId, treeNode, clickFlag) {
	$("#SOCIAL_SECURITY_ORGANIZATION_TEXT").val(treeNode.name);
	$('#tree').hide('fast');
	return (treeNode.click != false);
}
function onClick(event, treeId, treeNode, clickFlag) {
	$("#SOCIAL_SECURITY_ORGANIZATION").val(treeNode.name);	
	 $('#tree').hide('fast');
	
}		
 	function toPrint(){
// 	 var 	tax_no= $("#TAX_NO_EDIT").html(); 
// 	 if(tax_no!="--"){
// 		 window.location.href="PrintEmployers.jsp?SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO;  
// 		 
// 	 }else{
// 		 HuiFang.Funtishi("请完善企业信息再添加关联信息");
// 		 return ;
// 	 }
 	
 		 var register_no= $("#REGISTER_NO_EDIT").html(); 
 	 	 if(register_no!="--"){
// 	 		 window.location.href="PrintEmployers.jsp?SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO;  
 	 		 window.location.href="PrintEmployers.jsp?SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO;  
 	 		 
 	 	 }else{
 	 		 HuiFang.Funtishi("请完善企业信息再添加关联信息");
 	 		 return ;
 	 	 }
			   
 
 }
 	 function on_select(obj){
 		$("#REGISTERED_RESIDENCE").val( $(obj).val())
 	 
 	    }
 	 
 $.getUrlParam = function (name) {             
	 var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); // 构造一个含有目标参数的正则表达式对象
																//             
	 var r = window.location.search.substr(1).match(reg);  // 匹配目标参数           
															//  
	 if (r != null) return unescape(r[2]); return null; 

 }
function sub_mit(SOCIAL_SECURITY_NO){
	 $("#confirm").modal('hide');
	 var start_json="{";
     var end_json="}";
     var json="";
     var data="";
     var SOCIAL_AGENT= $("#SOCIAL_AGENT").val();
     var SOCIAL_AGENT_TEL= $("#SOCIAL_AGENT_TEL").val();
     var REGISTER_NO= $("#REGISTER_NO").val();
     var PAY_TAX_PEPOLE_NAME= $("#PAY_TAX_PEPOLE_NAME").val();
     var TAX_NO= $("#TAX_NO").val();
     if(SOCIAL_AGENT==''){
    	 HuiFang.Funtishi("人社登记登记经办人不能为空");
    	 
    	 return;
    	 
     }
     if(SOCIAL_AGENT_TEL==''){
    	 HuiFang.Funtishi("人社登记经办人联系电话不能为空");
    	 
    	 return;
    	 
     }
     if(REGISTER_NO==''){
    	 HuiFang.Funtishi("税务登记序号不能为空");
    	 
    	 return;
    	 
     }
     if(PAY_TAX_PEPOLE_NAME==''){
    	 HuiFang.Funtishi("税务人名称不能为空");
    	 
    	 return;
    	 
     }
     if(TAX_NO==''){
    	 HuiFang.Funtishi("税务纳税人识别号不能为空");
    	 return;
     }
     
		 $("input").each(function(){
       	  var id =$(this).attr("id");
       	  var value = $(this).val();
       	  data +="\""+id+"\""+":\"" +value+"\","
        });
		 var SOCIAL_SECURITY_ORGANIZATION= $("#SOCIAL_SECURITY_ORGANIZATION").val(); 		
		 data = data + "\"SOCIAL_SECURITY_ORGANIZATION\":\""+SOCIAL_SECURITY_ORGANIZATION+"\",";
		//var  UNIT_PROPERTIES=$("#UNIT_PROPERTIES").find("option:selected").text();
		var  UNIT_PROPERTIES=$("#COMPANY_TYPE").val();
		data = data + "\"UNIT_PROPERTIES\":\""+UNIT_PROPERTIES+"\",";
        data = data + "\"IF_MODIFY\":\"1\"";
        json=start_json+data+end_json;
        var model=  JSON.parse(json);  
        var form_data={"json":json}
        $.ajax({
			url:"modifyCompanyMess.action", 
			data:model, 
			dataType:"json", 
			type:"post",
			success:function (jsonStr) {        			
	       	    var status=jsonStr.status;
	       		if(status=="000000"){
	       		 $("#status").val(1);
	       		 HuiFang.Funtishi("修改成功！");
	       		 getMess(SOCIAL_SECURITY_NO);     
	       		 window.location.href="PrintEmployers.jsp?SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO;  
	       		 $("#myModal").modal('hide');
	       		}else{
	       		 $("#confirm").modal('hide');	
	       			
	       		}
			}, 
			error:function (error) {
				
			}
		});
		
		
		
		
	}
 $("#updateC").click(function(){
		$("#confirm").modal('show');
	});
 var type="";
 var IF_MATCHED="0";//设置企业匹配状态
  function  getMess(SOCIAL_SECURITY_NO){
		var data={"COMPANY_NAME":"","SOCIAL_SECURITY_NO":SOCIAL_SECURITY_NO};
		$.post("findSocialMess.action",data,function (jsonStr) {
	       		var json =$.parseJSON( jsonStr );
	       		var status=json.status;
	       		if(status=="000001"){
	       			HuiFang.Funtishi("哎呀!系统错误！");
	       		 }else if(status=="000000"){       	    	  
				 var  ID = json.ID;// ID
				 var SOCIAL_SECURITY_NO = json.SOCIAL_SECURITY_NO;// 人社单位编号
				 var TAX_NO =json.TAX_NO;// 税务纳税人识别号				
				 var COMPANY_NAME = json.COMPANY_NAME;// 人社单位名称
				 var PAY_TAX_PEPOLE_NAME =json.PAY_TAX_PEPOLE_NAME;// 税务纳税人名称
			     var COMPANY_STATUS =json.COMPANY_STATUS;// 人社参保单位状态
		         var TAX_TYPE =json.TAX_TYPE;// 税务登记类型
				 var PAY_TAX_PEPOLE_STATUS =json.PAY_TAX_PEPOLE_STATUS;// 税务纳税人状态
				 var TAX_BUREAU =json.TAX_BUREAU;// 主管税务局
				 var SUB_TAX_BUREAU =json.SUB_TAX_BUREAU;// 主管税务所科分局
				 var SOCIAL_SECURITY_ORGANIZATION =json.SOCIAL_SECURITY_ORGANIZATION;// 人社经办机构
				 var TAX_AREA =json.TAX_AREA;// 税务行政区划
				 var TAX_STREET =json.TAX_STREET;// 税务街道乡镇
				 var COMPANY_TEL =json.COMPANY_TEL;// 人社单位电话
				 var COMPANY_ADDRESS =json.COMPANY_ADDRESS;// 人社单位地址
				 var TAX_TEL =json.TAX_TEL;// 税务联系方式
				 var TAX_PRODUCT_ADDRESS =json.TAX_PRODUCT_ADDRESS;// 税务生产经营地址
				 var SOCIAL_BUSINESS_NO =json.SOCIAL_BUSINESS_NO;// 人社工商营业执照号码
				 var SOCIAL_ORGRNIZATION_NO =json.SOCIAL_ORGRNIZATION_NO;// 人社组织机构代码
				 var TAX_ORGANIZATION =json.TAX_ORGANIZATION;// 税务组织机构
				 var LEGAL_PERSON_NAME =json.LEGAL_PERSON_NAME;// 人社法人姓名
				 var LEGAL_PERSON_ID =json.LEGAL_PERSON_ID;// 人社法人身份证号
				 var LEGAL_PERSON_TEL =json.LEGAL_PERSON_TEL;// 人社法人联系方式
				 var TAX_LEGAL_PERSON_NAME =json.TAX_LEGAL_PERSON_NAME;// 税务法定代表人姓名
				 var SOCIAL_MASTER_NAME =json.SOCIAL_MASTER_NAME;// 人社专管员姓名
				 var SOCIAL_MASTER_TEL =json.SOCIAL_MASTER_TEL;// 人社专管员联系方式
				 var COMPANY_TYPE =json.COMPANY_TYPE;// 人社单位类型
				 var SOCIAL_PAY_TYPE =json.SOCIAL_PAY_TYPE;// 人社缴费方式
				 var TAX_ADMIN =json.TAX_ADMIN;// 税收管理员
				 var REGISTER_NO =json.REGISTER_NO;// 登记序号
				 var IF_MODIFY =json.IF_MODIFY;// 0：未修改 1：已修改
				 var IF_MATCHED =json.IF_MATCHED;// 0：未匹配 1：已匹配
				 type==json.TYPE;//获取到社保类型
				 var SOCIAL_AGENT =json.SOCIAL_AGENT;//人社经办人
				 var SOCIAL_AGENT_TEL =json.SOCIAL_AGENT_TEL;// 人社经办人联系电话
				 var UNIT_PROPERTIES =json.UNIT_PROPERTIES;// 单位性质
				 var REGISTERED_RESIDENCE =json.REGISTERED_RESIDENCE;// 是否为城乡虚拟户
				 var AREA =json.AREA;// 单位性质
				 var TYPE =json.TYPE;// 是否为城乡虚拟户
	       		 $("#ID").val(ID);
	       		 $("#AREA").val(AREA);
	       		 $("#TYPE").val(TYPE);
	       		 $("#company_name").html(COMPANY_NAME+"基本信息");
	       		 $("#company_name_sub").html("修改"+COMPANY_NAME+"基本信息");
	       		 $("#SOCIAL_SECURITY_NO_EDIT").html(SOCIAL_SECURITY_NO!=""? SOCIAL_SECURITY_NO:"--");
	       		 $("#TAX_NO_EDIT").html(TAX_NO!=""? TAX_NO:"--"); 
	       		 $("#COMPANY_NAME_EDIT").html(COMPANY_NAME!=""? COMPANY_NAME:"--");
	       		 $("#PAY_TAX_PEPOLE_NAME_EDIT").html(PAY_TAX_PEPOLE_NAME!=""? PAY_TAX_PEPOLE_NAME:"--");
	       		 $("#COMPANY_STATUS_EDIT").html(COMPANY_STATUS!=""? COMPANY_STATUS:"--");
	       		 $("#TAX_TYPE_EDIT").html(TAX_TYPE!=""? TAX_TYPE:"--");
	       		 $("#PAY_TAX_PEPOLE_STATUS_EDIT").html(PAY_TAX_PEPOLE_STATUS!=""? PAY_TAX_PEPOLE_STATUS:"--");
	       		 $("#TAX_BUREAU_EDIT").html(TAX_BUREAU!=""? TAX_BUREAU:"--");
	       		 $("#SUB_TAX_BUREAU_EDIT").html(SUB_TAX_BUREAU!=""? SUB_TAX_BUREAU:"--");
	       		 $("#SOCIAL_SECURITY_ORGANIZATION_EDIT").html(SOCIAL_SECURITY_ORGANIZATION!=""? SOCIAL_SECURITY_ORGANIZATION:"--");
	       		 $("#TAX_AREA_EDIT").html(TAX_AREA!=""? TAX_AREA:"--");
	       		 $("#TAX_STREET_EDIT").html(TAX_STREET!=""? TAX_STREET:"--");
	       		 $("#COMPANY_TEL_EDIT").html(COMPANY_TEL!=""? COMPANY_TEL:"--");
	       		 $("#COMPANY_ADDRESS_EDIT").html(COMPANY_ADDRESS!=""? COMPANY_ADDRESS:"--");
	       		 $("#TAX_TEL_EDIT").html(TAX_TEL!=""? TAX_TEL:"--");
	       		 $("#TAX_PRODUCT_ADDRESS_EDIT").html(TAX_PRODUCT_ADDRESS!=""? TAX_PRODUCT_ADDRESS:"--");
	       		 $("#TAX_ORGANIZATION_EDIT").html(TAX_ORGANIZATION!=""? TAX_ORGANIZATION:"--");
	       		 $("#SOCIAL_ORGRNIZATION_NO_EDIT").html(SOCIAL_ORGRNIZATION_NO!=""? SOCIAL_ORGRNIZATION_NO:"--");
	       		 $("#SOCIAL_BUSINESS_NO_EDIT").html(SOCIAL_BUSINESS_NO!=""? SOCIAL_BUSINESS_NO:"--");
	       		 $("#LEGAL_PERSON_NAME_EDIT").html(LEGAL_PERSON_NAME!=""? LEGAL_PERSON_NAME:"--");
	       		 $("#LEGAL_PERSON_ID_EDIT").html(LEGAL_PERSON_ID!=""? LEGAL_PERSON_ID:"--");
	       		 $("#LEGAL_PERSON_TEL_EDIT").html(LEGAL_PERSON_TEL!=""? LEGAL_PERSON_TEL:"--");
	       		 $("#TAX_LEGAL_PERSON_NAME_EDIT").html(TAX_LEGAL_PERSON_NAME!=""? TAX_LEGAL_PERSON_NAME:"--");
	       		 $("#SOCIAL_MASTER_NAME_EDIT").html(SOCIAL_MASTER_NAME!=""? SOCIAL_MASTER_NAME:"--");
	       		 $("#SOCIAL_MASTER_TEL_EDIT").html(SOCIAL_MASTER_TEL!=""? SOCIAL_MASTER_TEL:"--");
	       		 $("#COMPANY_TYPE_EDIT").html(COMPANY_TYPE!=""? COMPANY_TYPE:"--");
	       		 $("#SOCIAL_PAY_TYPE_EDIT").html(SOCIAL_PAY_TYPE!=""? SOCIAL_PAY_TYPE:"--");
	       		 $("#TAX_ADMIN_EDIT").html(TAX_ADMIN!=""? TAX_ADMIN:"--");
	       		 $("#REGISTER_NO_EDIT").html(REGISTER_NO!=""? REGISTER_NO:"--");
	       		 $("#IF_MODIFY").html(IF_MODIFY!=""? IF_MODIFY:"--");
	       		 $("#IF_MATCHED").html(IF_MATCHED!=""? IF_MATCHED:"--");
	       		 
	       		 $("#SOCIAL_AGENT_EDIT").html(SOCIAL_AGENT!=""? SOCIAL_AGENT:"--");
	       		 $("#SOCIAL_AGENT_TEL_EDIT").html(SOCIAL_AGENT_TEL!=""? SOCIAL_AGENT_TEL:"--");
	       		 $("#UNIT_PROPERTIES_EDIT").html(UNIT_PROPERTIES!=""? UNIT_PROPERTIES:"--");
	         	
	       		 if(REGISTERED_RESIDENCE==0){
	       			 $("#REGISTERED_RESIDENCE_EDIT").html("否");
	    		 } 
	       		 if(REGISTERED_RESIDENCE==1){
	    			 $("#REGISTERED_RESIDENCE_EDIT").html("是");
	    		 }
	       		 
	       		 if(REGISTERED_RESIDENCE==""){
	    			 $("#REGISTERED_RESIDENCE_EDIT").html("--"); 
	    			 
	    		 }
	       		
	       		
	       		 
	       		 
	       		 
	       		 
	             /*--------------------------------- 修改------------------------------------------------------------------------------- */  		 
	       		 $("#SOCIAL_SECURITY_NO").val(SOCIAL_SECURITY_NO!=""? SOCIAL_SECURITY_NO:"");
	    		 $("#TAX_NO").val(TAX_NO!=""? TAX_NO:""); 
	    		 $("#COMPANY_NAME").val(COMPANY_NAME!=""? COMPANY_NAME:"");
	    		 $("#PAY_TAX_PEPOLE_NAME").val(PAY_TAX_PEPOLE_NAME!=""? PAY_TAX_PEPOLE_NAME:"");
	    		 $("#COMPANY_STATUS").val(COMPANY_STATUS!=""? COMPANY_STATUS:"");
	    		 $("#TAX_TYPE").val(TAX_TYPE!=""? TAX_TYPE:"");
	    		 $("#PAY_TAX_PEPOLE_STATUS").val(PAY_TAX_PEPOLE_STATUS!=""? PAY_TAX_PEPOLE_STATUS:"");
	    		 $("#TAX_BUREAU").val(TAX_BUREAU!=""? TAX_BUREAU:"");
	    		 $("#SUB_TAX_BUREAU").val(SUB_TAX_BUREAU!=""? SUB_TAX_BUREAU:"");
	    		 $("#SOCIAL_SECURITY_ORGANIZATION").val(SOCIAL_SECURITY_ORGANIZATION!=""? SOCIAL_SECURITY_ORGANIZATION:"");
	    		 $("#TAX_AREA").val(TAX_AREA!=""? TAX_AREA:"");
	    		 $("#TAX_STREET").val(TAX_STREET!=""? TAX_STREET:"");
	    		 $("#COMPANY_TEL").val(COMPANY_TEL!=""? COMPANY_TEL:"");
	    		 $("#COMPANY_ADDRESS").val(COMPANY_ADDRESS!=""? COMPANY_ADDRESS:"");
	    		 $("#TAX_TEL").val(TAX_TEL!=""? TAX_TEL:"");
	    		 $("#TAX_PRODUCT_ADDRESS").val(TAX_PRODUCT_ADDRESS!=""? TAX_PRODUCT_ADDRESS:"");
	    		 $("#TAX_ORGANIZATION").val(TAX_ORGANIZATION!=""? TAX_ORGANIZATION:"");
	    		 $("#SOCIAL_ORGRNIZATION_NO").val(SOCIAL_ORGRNIZATION_NO!=""? SOCIAL_ORGRNIZATION_NO:"");
	    		 $("#SOCIAL_BUSINESS_NO").val(SOCIAL_BUSINESS_NO!=""? SOCIAL_BUSINESS_NO:"");
	    		 $("#LEGAL_PERSON_NAME").val(LEGAL_PERSON_NAME!=""? LEGAL_PERSON_NAME:"");
	    		 $("#LEGAL_PERSON_ID").val(LEGAL_PERSON_ID!=""? LEGAL_PERSON_ID:"");
	    		 $("#LEGAL_PERSON_TEL").val(LEGAL_PERSON_TEL!=""? LEGAL_PERSON_TEL:"");
	    		 $("#TAX_LEGAL_PERSON_NAME").val(TAX_LEGAL_PERSON_NAME!=""? TAX_LEGAL_PERSON_NAME:"");
	    		 $("#SOCIAL_MASTER_NAME").val(SOCIAL_MASTER_NAME!=""? SOCIAL_MASTER_NAME:"");
	    		 $("#SOCIAL_MASTER_TEL").val(SOCIAL_MASTER_TEL!=""? SOCIAL_MASTER_TEL:"");
	    		 $("#COMPANY_TYPE").val(COMPANY_TYPE!=""? COMPANY_TYPE:"");
	    		 $("#SOCIAL_PAY_TYPE").val(SOCIAL_PAY_TYPE!=""? SOCIAL_PAY_TYPE:"");
	    		 $("#TAX_ADMIN").val(TAX_ADMIN!=""? TAX_ADMIN:"");
	    		 $("#REGISTER_NO").val(REGISTER_NO!=""? REGISTER_NO:"");
	    		 $("#IF_MODIFY").val(IF_MODIFY!=""? IF_MODIFY:"");
	    		 $("#IF_MATCHED").val(IF_MATCHED!=""? IF_MATCHED:"");
	    		 
	    		 $("#SOCIAL_AGENT").val(SOCIAL_AGENT!=""? SOCIAL_AGENT:"");
	       		 $("#SOCIAL_AGENT_TEL").val(SOCIAL_AGENT_TEL!=""? SOCIAL_AGENT_TEL:"");
	       		 $("#UNIT_PROPERTIES").val(UNIT_PROPERTIES!=""? UNIT_PROPERTIES:"");
	       		
	       		 $("#AREA").val(AREA!=""? AREA:"");
	    		 $("#TYPE").val(TYPE!=""? TYPE:"")
	    		 if(REGISTERED_RESIDENCE==0){	    	
	    			  $("#yes").removeAttr("checked");
	    			  $("#no").attr("checked","checked");
	    			 
	    		 }
	    		 if(REGISTERED_RESIDENCE==1){
	    			  $("#no").removeAttr("checked");
	    			  $("#yes").attr("checked","checked");
	    		 }
	    		 if(REGISTERED_RESIDENCE==''){
	    			  $("#no").removeAttr("checked");
	    			  $("#yes").removeAttr("checked");
	    		 }
	    		 $("#REGISTERED_RESIDENCE").val( REGISTERED_RESIDENCE);
	       		 }
				}
			);
		 // 跳转到明细 页面
		 $("#Detbtn").click(function(){
				 window.location.href = "ListDetail.jsp?SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO; 		
			
			 return;
			 
     });
		
  } 
  var HuiFang={
		    m_tishi :null,//全局变量 判断是否存在div,

		     //提示div 等待2秒自动关闭
		      Funtishi: function (content, url) {
		          if (HuiFang.m_tishi == null) {
		              HuiFang.m_tishi = '<div class="xiaoxikuang none" id="app_tishi" style="z-index:9999;left: 50%;width:25%;position: fixed;background:none;bottom:60%;opacity:0.7;"> <p class="app_tishi" style="background: none repeat scroll 0 0 #000; border-radius: 30px;color: #fff; margin: 0 auto;padding: 1.5em;text-align: center;width: 70%;opacity: 0.8; font-family:Microsoft YaHei;letter-spacing: 1px;font-size: 1.1em;"></p></div>';
		              $(document.body).append(HuiFang.m_tishi);
		          }
		          $("#app_tishi").show();
		          $(".app_tishi").html(content);
		          if (url) {
		              window.setTimeout("location.href='" + url + "'", 1500);
		          } else {
		              setTimeout('$("#app_tishi").fadeOut()', 1500);
		          }
		      },
		  }

  
  