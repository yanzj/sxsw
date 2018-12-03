<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String SOCIAL_SECURITY_NO = request.getParameter("SOCIAL_SECURITY_NO");
String REGISTER_NO=request.getSession().getAttribute("REGISTER_NO").toString();
String session_id=request.getSession().getAttribute("SOCIAL_SECURITY_NO").toString();
String time=(new java.text.SimpleDateFormat("yyyy年MM月dd日")).format(new Date());
%>
<!DOCTYPE html>  
<html>  
<head>  
<title>山西省人社税务数据核对系统</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/bootstrap3.3.7/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/iconfont/iconfont.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/taxmess.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/zTreeStyle.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/demo.css"/>
<link rel="stylesheet" href="<%=basePath %>css/zTreeStyle.css" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/print.css" media="print"/>
<link href="<%=basePath%>images/title.png" rel="SHORTCUT ICON">
<script type="text/javascript" src="<%=basePath  %>include/jQuery/jquery-1.9.1.js"></script>
<script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script>
<script type="text/javascript" src="<%=basePath  %>include/iconfont/iconfont.js"></script>
<script type="text/javascript" src="<%=basePath  %>js/jquery.jqprint-0.3.js"></script>
<script type="text/javascript" src="<%=basePath  %>include/bootstrap3.3.7/js/bootstrap.min.js"></script>
<script src="<%=basePath  %>js/json/CityJson.js" type="text/javascript"></script>
<script src="<%=basePath  %>js/json/ProJson.js" type="text/javascript"></script>
<script src="<%=basePath  %>js/json/DistrictJson.js" type="text/javascript"></script>
<script src="<%=basePath  %>js/jquery.ztree.core.min.js" type="text/javascript"></script>

<script type="text/javascript">  
if("<%=SOCIAL_SECURITY_NO%>"!="<%=session_id%>"){
window.location.href='<%=basePath%>Index';	
}   
   function doPrint() {   
   	$("#printEmployers").jqprint(); 	
}
 $(function(){
  	getMess("<%=SOCIAL_SECURITY_NO%>"); 
  	
 });
 
     var   zNodes="a";
     var zNodes1="";
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
    	zNodes=JSON.parse(data).ztree; 
    	zNodes1=JSON.parse(data);
    	$.fn.zTree.init($("#treeDemo"), setting, zNodes);	
	     });
	 $.post("Organization.action",function(data){
	     	data=JSON.parse(data).list; 
	     	$("#SOCIAL_SECURITY_ORGANIZATION").append("<option value=\"\">请选择经办机构</option>");
	     	$.each(data,function(index,item){
	     		$("#SOCIAL_SECURITY_ORGANIZATION").append("<option value=\""+item.ID+"\">"+item.TYPENAME+"</option>");
	     	});
	     	
	     	
	     });
	    $.post("taxPostSelectedQuery.action",function(data){
	    	   data=JSON.parse(data);
	    	   $("#COMPANY_TYPE_ID").append("<option value=\"\">请选择参保险种</option>");
	     	$.each(data,function(index,item){
	     		$("#COMPANY_TYPE_ID").append("<option value=\""+item.id+"\">"+item.text+"</option>");
	     	});
	     	
	     	
	     });
	    
	    function beforeClick(treeId, treeNode, clickFlag) {
	    	$("#SOCIAL_SECURITY_ORGANIZATION_TEXT").val(treeNode.name);
	    	$('#tree').hide('fast');
	    	setvalue(treeNode);
			return (treeNode.click != false);
		}
		function onClick(event, treeId, treeNode, clickFlag) {
			$("#SOCIAL_SECURITY_ORGANIZATION").val(treeNode.id);	
			 $('#tree').hide('fast');
			
		}		
		function setvalue(treeNode){
		
		$.each(zNodes, function (k, p) {
            if (p.id == treeNode.id) {
             var pid=p.pId;
           
             if(pid=="140000"){
	    		var treeNodeid=treeNode.id;
               var id=0;
          $.each(city, function (k, p) { 
            if (p.CityName == treeNode.name) {
             id=p.CityID ;
            }
    	});  
        $("#PurchaseArea option:gt(0)").remove(); 
        $.each(District, function (k, p) {
            if (p.CityID == id) {
                var option = "<option value='" + p.DisName + "'>" + p.DisName + "</option>";
                $("#PurchaseArea").append(option);
            }
        }); 
       $("#PurchaseCity").val(treeNode.name);
        
   }else{
        var PurchaseCity="" ;
       $.each(zNodes, function (k, p){
       if(p.id==pid){
      PurchaseCity= p.name;
       
       }
      })
              var id=0;
         $.each(city, function (k, p) { 
            if (p.CityName == PurchaseCity) {
             id=p.CityID ;
            }
    	});
        $("#PurchaseArea option:gt(0)").remove(); 
        $.each(District, function (k, p) {
            if (p.CityID == id) {
                var option = "<option value='" + p.DisName + "'>" + p.DisName + "</option>";
                $("#PurchaseArea").append(option);
            }
        }); 
    
      $("#PurchaseCity").val(PurchaseCity);
      $("#PurchaseArea").val(treeNode.name);
      
   
   }
  }
 }); 
		
	   
		}
		
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
				$("#REGISTER_NO").val(REGISTER_NO);
				 var IF_MODIFY =json.IF_MODIFY;// 0：未修改 1：已修改
				 var IF_MATCHED =json.IF_MATCHED;// 0：未匹配 1：已匹配
				 var SOCIAL_AGENT =json.SOCIAL_AGENT;//人社经办人
				 var SOCIAL_AGENT_TEL =json.SOCIAL_AGENT_TEL;// 人社经办人联系电话
				// var UNIT_PROPERTIES =json.UNIT_PROPERTIES;// 单位性质
				 var REGISTERED_RESIDENCE =json.REGISTERED_RESIDENCE;// 是否为城乡虚拟户
				 var AREA =json.AREA;// 单位性质
				 var TYPE =json.TYPE;// 是否为城乡虚拟户
				  if(REGISTERED_RESIDENCE==0){
	       			 $("#REGISTERED_RESIDENCE_EDIT").html("否");
	    		 } 
	       		 if(REGISTERED_RESIDENCE==1){
	    			 $("#REGISTERED_RESIDENCE_EDIT").html("是");
	    		 }
	       		 if(REGISTERED_RESIDENCE==""){
	    			 $("#REGISTERED_RESIDENCE_EDIT").html(""); 
	    			 
	    		 }
	       		 $("#ID").val(ID);
	       		 $("#SOCIAL_AGENT_EDIT").html(SOCIAL_AGENT!=""? SOCIAL_AGENT:"");
	       		 $("#SOCIAL_AGENT_TEL_EDIT").html(SOCIAL_AGENT_TEL!=""? SOCIAL_AGENT_TEL:"");
	       		 $("#AREA").val(AREA!=""? AREA:"");
	    		 $("#TYPE").val(TYPE!=""? TYPE:"");
	       		 $("#company_name").html(COMPANY_NAME+"基本信息");
	       		 $("#company_name_sub").html("社保关联信息添加");
	       		 $("#SOCIAL_SECURITY_NO").val(SOCIAL_SECURITY_NO!=""? SOCIAL_SECURITY_NO:"");
	       		 $("#TAX_NO_EDIT").html(TAX_NO!=""? TAX_NO:""); 
	       		 $("#COMPANY_NAME_EDIT").html(COMPANY_NAME!=""? COMPANY_NAME:"");
	       		 $("#PAY_TAX_PEPOLE_NAME_EDIT").html(PAY_TAX_PEPOLE_NAME!=""? PAY_TAX_PEPOLE_NAME:"");
	       		 $("#COMPANY_STATUS_EDIT").html(COMPANY_STATUS!=""? COMPANY_STATUS:"");
	       		 $("#COMPANY_STATUS").html(COMPANY_STATUS!=""? COMPANY_STATUS:"");
	       		 $("#TAX_TYPE_EDIT").html(TAX_TYPE!=""? TAX_TYPE:"");
	       		 $("#PAY_TAX_PEPOLE_STATUS_EDIT").html(PAY_TAX_PEPOLE_STATUS!=""? PAY_TAX_PEPOLE_STATUS:"");
	       		 $("#TAX_BUREAU_EDIT").html(TAX_BUREAU!=""? TAX_BUREAU:"");
	       		 $("#SUB_TAX_BUREAU_EDIT").html(SUB_TAX_BUREAU!=""? SUB_TAX_BUREAU:"");
	       		 $("#SOCIAL_SECURITY_ORGANIZATION_EDIT").html(SOCIAL_SECURITY_ORGANIZATION!=""? SOCIAL_SECURITY_ORGANIZATION:"");
	       		 $("#TAX_AREA_EDIT").html(TAX_AREA!=""? TAX_AREA:"");
	       		 $("#TAX_STREET_EDIT").html(TAX_STREET!=""? TAX_STREET:"");
	       		 $("#COMPANY_TEL_EDIT").html(COMPANY_TEL!=""? COMPANY_TEL:"");
	       		 $("#COMPANY_ADDRESS_EDIT").html(COMPANY_ADDRESS!=""? COMPANY_ADDRESS:"");
	       		 $("#TAX_TEL_EDIT").html(TAX_TEL!=""? TAX_TEL:"");
	       		 $("#TAX_PRODUCT_ADDRESS_EDIT").html(TAX_PRODUCT_ADDRESS!=""? TAX_PRODUCT_ADDRESS:"");
	       		 $("#TAX_ORGANIZATION_EDIT").html(TAX_ORGANIZATION!=""? TAX_ORGANIZATION:"");
	       		 $("#SOCIAL_ORGRNIZATION_NO_EDIT").html(SOCIAL_ORGRNIZATION_NO!=""? SOCIAL_ORGRNIZATION_NO:"");
	       		 $("#SOCIAL_BUSINESS_NO_EDIT").html(SOCIAL_BUSINESS_NO!=""? SOCIAL_BUSINESS_NO:"");
	       		 $("#LEGAL_PERSON_NAME_EDIT").html(LEGAL_PERSON_NAME!=""? LEGAL_PERSON_NAME:"");
	       		 $("#LEGAL_PERSON_ID_EDIT").html(LEGAL_PERSON_ID!=""? LEGAL_PERSON_ID:"");
	       		 $("#LEGAL_PERSON_TEL_EDIT").html(LEGAL_PERSON_TEL!=""? LEGAL_PERSON_TEL:"");
	       		 $("#TAX_LEGAL_PERSON_NAME_EDIT").html(TAX_LEGAL_PERSON_NAME!=""? TAX_LEGAL_PERSON_NAME:"");
	       		 $("#SOCIAL_MASTER_NAME_EDIT").html(SOCIAL_MASTER_NAME!=""? SOCIAL_MASTER_NAME:"");
	       		 $("#SOCIAL_MASTER_TEL_EDIT").html(SOCIAL_MASTER_TEL!=""? SOCIAL_MASTER_TEL:"");
	       		 $("#COMPANY_TYPE_EDIT").html(COMPANY_TYPE!=""? COMPANY_TYPE:"");
	       		 $("#SOCIAL_PAY_TYPE_EDIT").html(SOCIAL_PAY_TYPE!=""? SOCIAL_PAY_TYPE:"");
	       		 $("#TAX_ADMIN_EDIT").html(TAX_ADMIN!=""? TAX_ADMIN:"");
	       		 $("#REGISTER_NO_EDIT").html(REGISTER_NO!=""? REGISTER_NO:"");
	       		 $("#IF_MODIFY").html(IF_MODIFY!=""? IF_MODIFY:"");
	       		 $("#IF_MATCHED").html(IF_MATCHED!=""? IF_MATCHED:"");
	       		 initrelationmess(ID);
	       		 }
				}
			);
  } 
		function initrelationmess(id){ 
		var data={"COMPER_ID":id,"TYPE":""};
			$.post("CompanyTaxRelationQueryList.action",data,function (jsonStr) { 
			var json=JSON.parse(jsonStr); 
			$.each(json,function(index,item){
				var WORKERS_RATE=item.WORKERS_RATE;
				if(WORKERS_RATE!=""){
					WORKERS_RATE=WORKERS_RATE+"%";
				}
			var init_data= "<tr>"+
			"<td>"+item.SOCIAL_SECURITY_ORGANIZATION+"</td>"+
			"<td>"+item.SOCIAL_SECURITY_NO+"</td>"+
			"<td>"+item.COMPANY_TYPE_ID+"</td>"+
			"<td>"+item.RATE+"%</td>"+
			"<td>"+WORKERS_RATE+"</td>"+
			"<td>"+item.TAX_AREA+"</td>"+
			"<td>"+item.REGISTER_NO+"</td>"+
		"</tr>";	  
	   $("#init").append(init_data);
	    	});
	
	
			/*"<tr>"+
			"<td>* 是否税费共管户</td>"+
			"<td></td>"+
			"<td>关联类型</td>"+
			"<td></td>"+
			"<td>特殊单位类别</td>"+
			"<td colspan=\"2\"></td>"+
		"</tr>"+*/
			var foot="<tr>"+
			"<td>关联税务机关</td>"+
			"<td></td>"+
			"<td>关联人</td>"+
			"<td></td>"+
			"<td>关联日期</td>"+
			"<td colspan=\"2\" class=\"print_date\" style=\"text-align: right;\"><%=time %></td>"+
		"</tr>"+
		"<tr>"+	
			"<td style=\"height: 70px;\">经办人签章</td>"+
			"<td colspan=\"2\" class=\"print_date\" style=\"text-align: right;\"><%=time %></td>"+
			"<td>纳税人公章</td>"+		
			"<td colspan=\"4\" class=\"print_date\" style=\"text-align: right;\"><%=time %></td>"+
		"</tr>"+
		"<tr>"+
			"<td>备注</td>"+
			"<td colspan=\"6\"></td>"+
		"</tr>";		
			$("#init").append(foot);
	   });			
				
}
</script>  
</head>  
  
<body>   
<div class="print_box_o" >
	<div class="print_box print_box_print " id="printEmployers">
		<div class="print_title" >
			<h2>社会保险费参保缴费信息关联表（适用用人单位）</h2>
		</div>
		<table border="0" cellspacing="0" cellpadding="0" >
			<thead>
			</thead>
			<tbody id="init">
				<tr>
				<input id="ID" type="hidden">
					<td>统一社会信用代码（纳税人识别号）</td>
					<td><span id="TAX_NO_EDIT"></span></td>
					<td>单位名称</td>
					<td colspan="4"><span id="COMPANY_NAME_EDIT"></span></td>
				</tr>
				<tr>
					<td>组织机构代码</td>
					<td><span id="SOCIAL_ORGRNIZATION_NO_EDIT"></span></td>
					<td>单位地址</td>
					<td colspan="4"><span id="COMPANY_ADDRESS_EDIT"></span></td>
				</tr>
				<tr>
					<td>单位性质</td>
					<td><span id="COMPANY_TYPE_EDIT"></span></td>
					<td>单位参保状态</td>
					<td><span id="COMPANY_STATUS"></td>
					<td>登记注册地所在行政区划</td>
					<td colspan="2"><span id="TAX_AREA_EDIT"></span></td>
				</tr>
				<tr>
					<td>经办人</td>
					<td><span id="SOCIAL_AGENT_EDIT"></span></td>
					<td>经办人手机号码</td>
					<td><span id="SOCIAL_AGENT_TEL_EDIT"></span></td>
					<td>是否为城乡居民虚拟户</td>
					<td colspan="2"> <span id="REGISTERED_RESIDENCE_EDIT"></span></td>
				</tr>
				<tr>
					<!--<td>单位参保状态</td>
					<td><span id="COMPANY_STATUS_EDIT"></span></td>
					<td>单位参保缴费状态</td>
					<td><span id="COMPANY_STATUS_EDIT"></td>-->
					<td>税务登记状态</td>
					<td colspan="6" style="text-align: left;padding-left: 10px;"><span id="PAY_TAX_PEPOLE_STATUS_EDIT"></span></td>
				</tr>
				<tr>
					<td style="width: 18%;">社保经办机构</td>
					<td style="width: 19%;">单位编号</td>
					<td style="width: 13%;">参保费种</td>
					<td style="width: 13%;">单位缴费费率</td>
					<td style="width: 17%;">职工个人缴费费率</td>
					<td style="width: 10%;">统筹区</td>
					<td style="width: 11%;">税务登记序号</td>
				</tr>
				
			</tbody>		
		</table>
		<div class="pring_ins">
			填表说明：	1.对同一单位同一险种因统筹级次等原因费率不同的，需在不同行次分别填写费率及对应数据内容。
						2.由于费率不同等原因，同一单位分别填写多个行次的，需将序号、单位名称、信用代码合并为一项。
						3.单位性质分为：机关事业、企业、社会团体、民办非企业单位、个体工商户、其他等6种类型。
		</div>
	</div>
	<div class="print_button">		
		<button type="button" onclick="javascript:history.back(-1)"  class="div_box_bon_one"><i class="iconfont pad_r6">&#xe669;</i>返回</button>  
		<button type="button"  class="div_box_bon_one" data-toggle="modal" data-target="#AddInformation"><i class="iconfont pad_r6">&#xe626;</i>添加</button>
		<!-- <button type="button" id="check" class="div_box_bon_one"><i class="iconfont pad_r6">&#xe806;</i>提交审核</button>	  -->
		<button type="button" onclick="doPrint()" class="div_box_bon_one"><i class="iconfont pad_r6">&#xe617;</i>打印</button>  
	</div>
	
</div> 
 <!--添加各险种关联信息  弹出框-->

<div class="modal fade" id="AddInformation" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
	<div class="modal-dialog" style="margin-top:60px;">
		<div class="modal-content" style="width:500px;margin-top:150px;">
			<div class="modal-header modal_header_update">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title modal_title_font" id="myModalLabel">
					<span id="company_name_sub">添加各险种关联信息</span>
				</h4>
			</div>
			<div class="modal-body">
				<div class="add-infor-box">
					<div class="div-add">
						<label id="dddd">社保经办机构：</label>
						<span class="div-add-span" >
							<input id="SOCIAL_SECURITY_ORGANIZATION_TEXT" placeholder="请点击选择经办机构" class="onclick"/>
							<input id="SOCIAL_SECURITY_ORGANIZATION"  type="hidden" />
							<!--<select class="select-op" id="SOCIAL_SECURITY_ORGANIZATION" >
								
							</select>-->

								<div  id="tree"  class="zTreeDemoBackground left tree">
									<ul id="treeDemo" class="ztree"></ul>

								</div>


							</span>
					</div>
					<div class="div-add">
						<label>单位编号：</label>
						<span class="div-add-span">
							<input id="SOCIAL_SECURITY_NO" />
						</span>
					</div>
					<div class="div-add">
						<label>参保费种：</label>
						<span class="div-add-span">
							<!--<input id="COMPANY_TYPE_ID" />-->
							<select class="select-op" id="COMPANY_TYPE_ID">
								
							</select>
						</span>
					</div>
					<div class="div-add">
						<label>单位缴费费率(%)：</label>
						<span class="div-add-span"><input id="RATE" /></span>
					</div>
					<div class="div-add">
						<label>职工个人缴费率(%)：</label>
						<span class="div-add-span"><input id="WORKERS_RATE" /></span>
					</div>
					<div class="div-add">
						<label>统筹区：</label>
						<span style="border:none" class="div-add-span">
							<!--<input id="TAX_AREA" />-->
							<div style="margin-top:2px;">
								<i class="select-text">省</i>
								<select class="select-text-center" name="PurchaseProvince" id="PurchaseProvince">
									<option>--请选择--</option>
								</select>
                                <i class="select-text">&nbsp;&nbsp;市</i>
								<select class="select-text-center" name="PurchaseCity" id="PurchaseCity">
									<option>--请选择--</option>
								</select>
								<i class="select-text">&nbsp;&nbsp;县/区</i>
								<select class="select-text-center" name="PurchaseArea" id="PurchaseArea">
									<option>--请选择--</option>
								</select>
							</div>
						</span>
					</div>
					<div class="div-add">
						<label>税务登记序号：</label>
						<span class="div-add-span"><input id="REGISTER_NO" /></span>
					</div>
				</div>
			</div>
			<div class="modal-footer " style="text-align:center;">
				<button type="button" id="submit" class="div_box_bon_one"><i class="iconfont pad_r6">&#xe806;</i>保存</button>											
				<button type="button" class="div_box_bon_one" data-dismiss="modal"><i class="iconfont pad_r6">&#xe6da;</i>取消
				</button>
			</div>
		</div>
	</div>
</div>
	</div>
	<input type="hidden" id="TYPE">
	<input type="hidden" id="AREA">
	<input type="hidden" id="SOCIAL_SECURITY_NO_EDIT">
</body>  
<script type="text/javascript">
 $("#submit").click(function(){
 	 var start_json="{";
     var end_json="}";
     var json="";
     var data="";
     var COMPER_ID= $("#ID").val();
     var TAX_NO= $("#TAX_NO_EDIT").html();
     var SOCIAL_SECURITY_NO_EDIT= $("#SOCIAL_SECURITY_NO_EDIT").val();
     data = data + "\"COMPER_ID\":\""+COMPER_ID+"\",";
     data = data + "\"TAX_NO\":\""+TAX_NO+"\",";
     data = data + "\"SOCIAL_SECURITY_NO_EDIT\":\""+SOCIAL_SECURITY_NO_EDIT+"\",";
    //社保经办机构
	var SOCIAL_SECURITY_ORGANIZATION= $("#SOCIAL_SECURITY_ORGANIZATION").val(); 
	if(SOCIAL_SECURITY_ORGANIZATION.length<1){
	HuiFang.Funtishi("社保经办机构不能为空");
	 return;
	}
	
	 data = data + "\"SOCIAL_SECURITY_ORGANIZATION\":\""+SOCIAL_SECURITY_ORGANIZATION+"\",";
	//单位编号
	var SOCIAL_SECURITY_NO=$("#SOCIAL_SECURITY_NO").val();
	if(SOCIAL_SECURITY_NO.length<1){
	HuiFang.Funtishi("单位编号不能为空");
	return;
	}
	 data = data + "\"SOCIAL_SECURITY_NO\":\""+SOCIAL_SECURITY_NO+"\",";
	
	 //保险类型
	var COMPANY_TYPE_ID=$("#COMPANY_TYPE_ID").val();//保险类型
	if(COMPANY_TYPE_ID.length<1){
	HuiFang.Funtishi("保险类型不能为空");
	return;
	}
	
	
	
	
   data = data + "\"COMPANY_TYPE_ID\":\""+COMPANY_TYPE_ID+"\",";
	var RATE=$("#RATE").val(); //单位缴费费率
	if(RATE.length<1){
	HuiFang.Funtishi("单位缴费费不能为空");
	return;
	}
	 data = data + "\"RATE\":\""+RATE+"\",";
	
	if(RATE>=100){	
	HuiFang.Funtishi("单位缴费费不能大于100%");
	return;
	  }
	var WORKERS_RATE=$("#WORKERS_RATE").val(); //职工缴费费率
	if(WORKERS_RATE!=''&&WORKERS_RATE>=100){	
	HuiFang.Funtishi("职工缴费费率不能大于100%");
	return;
	  }
	 data = data + "\"WORKERS_RATE\":\""+WORKERS_RATE+"\",";
	  
	var PurchaseProvince=$("#PurchaseProvince").find("option:selected").text();//行政区
	var PurchaseCity=$("#PurchaseCity").find("option:selected").text();//行政区
	var PurchaseArea=$("#PurchaseArea").find("option:selected").text();//行政区
    var	TAX_AREA=PurchaseProvince+PurchaseCity+PurchaseArea;
   
	if( TAX_AREA.indexOf("--请选择--") >= 0){
	  HuiFang.Funtishi("统筹区不能为空");
	  return;
	}
		 data = data + "\"TAX_AREA\":\""+TAX_AREA+"\",";
	 
	 
	var REGISTER_NO=$("#REGISTER_NO").val();//税务登记号
	if(REGISTER_NO.length<1){
	HuiFang.Funtishi("税务登记号不能为空");
	return;
	}
	 data = data + "\"REGISTER_NO\":\""+REGISTER_NO+"\",";
	 data = data + "\"TYPE\":\"\""; //审核状态
	 
	
 //获取到添加的信息
        json=start_json+data+end_json;
        var model=  JSON.parse(json);  
        $.ajax({
			url:"CompanyTaxRelationAdd.action", 
			data:model, 
			dataType:"json", 
			type:"post",
			success:function (jsonStr) {        			
	       	    var status=jsonStr.status;
	       		if(status=="000000"){
	       		 window.location.reload();
	       		 $("#AddInformation").modal('hide');
	       		 HuiFang.Funtishi("已保存！");
	     	       	}else{
	       	 	  HuiFang.Funtishi("保存失败！");
	       	 		
	       		}
			}, 
			error:function (error) {
				
			}
		});

 });

var HuiFang={
		  m_tishi :null,
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
 };
 
$(function () {
$("#COMPANY_TYPE_ID").change(function(){
 
 
var COMPANY_TYPE_ID= $("#COMPANY_TYPE_ID").val();

var param={"COMPANY_TYPE_ID":COMPANY_TYPE_ID};
	 $.ajax({
			url:"getCompanyId.action", 
			data:param, 
			dataType:"json", 
			type:"post",
			success:function (jsonStr) {        			
	       var SOCIAL_SECURITY_NO=jsonStr.SOCIAL_SECURITY_NO;
	       		
	       	$("#SOCIAL_SECURITY_NO").val(SOCIAL_SECURITY_NO);
	       	
	       		/* if(status=="000000"){
	       		 window.location.reload();
	       		 $("#AddInformation").modal('hide');
	       		 HuiFang.Funtishi("已查询！");
	     	       	}else{
	       	 	  HuiFang.Funtishi("失败！");
	       	 		
	       		} */
			}, 
			error:function (error) {
				
			}
		});


})
    /* $.each(province, function (k, p) { 
    	 if(p.ProID==4){
    		 var option = "<option value='" + p.ProID + "'>" + p.ProName + "</option>";
    	        $("#PurchaseProvince").append(option);
    	} 
       var option = "<option value='" + 4+ "'>山西省</option>";
    	        $("#PurchaseProvince").append(option);
    }); */
           var option = "<option value='" + 4+ "'>山西省</option>";
    	        $("#PurchaseProvince").append(option);
     $("#PurchaseProvince").val(4);
        var selValue = 4;
        $("#PurchaseCity option:gt(0)").remove();
        $.each(city, function (k, p) { 
            if (p.ProID == selValue) {
                var option = "<option value='" + p.CityName + "'>" + p.CityName + "</option>";
                $("#PurchaseCity").append(option);
            }
        });
     
     
    $("#PurchaseCity").change(function () {
        var selValue = $("#PurchaseCity").val();
              var id=0;
         $.each(city, function (k, p) { 
            if (p.CityName == selValue) {
             id=p.CityID ;
            }
    	});
        $("#PurchaseArea option:gt(0)").remove(); 
        $.each(District, function (k, p) {
            if (p.CityID == id) {
                var option = "<option value='" + p.Id + "'>" + p.DisName + "</option>";
                $("#PurchaseArea").append(option);
            }
        }); 
    }); 
});
 
$(".onclick").click( function () { 
	$('.tree').show('fast');
});

 $("#check").click(function(){
	var id= $("#ID").val();
	$.post("CompanyTaxRelationCheck.action",{"ID":id},function(data){
	 	data=JSON.parse(data); 
	 	if(data.status=="000000"){
	 		 HuiFang.Funtishi("提交成功！");
	 		
	 	}else{
	 		 HuiFang.Funtishi("请勿重复提交！");
	 		
	 	}
	 	
	 	
	 	});
	 	
	 
 });
</script>
</html> 