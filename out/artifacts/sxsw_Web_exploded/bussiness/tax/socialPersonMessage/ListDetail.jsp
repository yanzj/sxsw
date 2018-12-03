<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.drools.lang.DRLParser.forall_key_return"%>
<%@page import="java.io.Writer"%>
<%@page import="org.drools.lang.DRLParser.forall_key_return"%>
<%@page import="com.dhcc.bussiness.tax.socialPersonMessage.SocialPersonMessageDao"%>
<%@page import="com.dhcc.common.system.insurance.InsuranceDao"%>
<%@page import="com.dhcc.avitationmodel.system.Insurance"%>
<%@page import="java.util.List"%>
<%@page import="com.dhcc.bussiness.tax.entity.SocialPersonMessage"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@page import="com.dhcc.bussiness.tax.dao.CompanyTaxMessageDao"%>
<%@page import="com.dhcc.bussiness.tax.entity.*"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String SOCIAL_SECURITY_NO = request.getParameter("SOCIAL_SECURITY_NO");
String TAX_PERSON_ID = request.getParameter("TAX_PERSON_ID");
String TAX_PERSON_NAME = request.getParameter("TAX_PERSON_NAME");
String session_id=request.getSession().getAttribute("SOCIAL_SECURITY_NO").toString();
String SOCIAL_TYPE_ID=request.getSession().getAttribute("TYPE").toString();
String time=(new SimpleDateFormat("yyyy年MM月dd日")).format(new Date());
String url="ListDetail.jsp";
%>

<!DOCTYPE HTML >
<html>
<head>
<title>企业基本信息</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/bootstrap3.3.7/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/iconfont/iconfont.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/taxmess.css" />
<link href="<%=basePath%>images/title.png" rel="SHORTCUT ICON">
<script type="text/javascript" src="<%=basePath  %>include/jQuery/jquery-1.9.1.js"></script>
<script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script>
<script type="text/javascript" src="<%=basePath  %>include/bootstrap3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath  %>js/dateformat.js"></script>
<script type="text/javascript" src="<%=basePath  %>include/iconfont/iconfont.js"></script>
<script type="text/javascript" src="<%=basePath  %>js/Grid.js"></script>

<script type="text/javascript">
		 var SOCIAL_SECURITY_NO ="<%=SOCIAL_SECURITY_NO%>";
		 if(SOCIAL_SECURITY_NO!="<%=session_id%>") {
		  window.location.href='<%=basePath%>Index';	
		}
      jQuery(function ($){
         $("#Forbtn").click(function(){
			 window.location.href = "<%=basePath%>center.jsp";
            });	
	});
</script> 
</head>
<body style="height:100%;">
	<div class="List_box">
	 <div id="lilist">
	 </div>
		<div class="List_search">
			<span>
				<label>人社医保登记姓名：</label>
				<input id="name" />
			</span>
			<span class="span_serch">
				<label>人社医保登记身份证号：</label>
				<input id="IDCare"/>
			</span>
			<span class="span_serch">
				<button class="div_box_bon_two" id="selecbtn"><i class="iconfont pad_r6">&#xe6f0;</i>查询</button>
				<button class="div_box_bon_two" id="historybth"><i class="iconfont pad_r6">&#xe669;</i>返回上一页</button>
				<button class="div_box_bon_two" id="Forbtn"><i class="iconfont pad_r6">&#xe614;</i>返回首页</button>
			</span>
		</div>
	<div id="demoDiv">
		<div id="demoGrid">
			
		</div>
	</div>
	</div>	
	<!--弹出框-->
     <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
	<div class="modal-dialog" style="margin-top:60px;">
	<!--startprint-->
		<div class="modal-content" style="width:800px;">
			<div class="modal-header modal_header_update">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				
				<h4 class="modal-title modal_title_font" id="myModalLabel">
					<span id="company_name_sub">修改基本信息</span>
				</h4>
			</div>
			<div class="modal-body">
			<input id="ID" type="hidden" />
			<input id="IF_MATCHED" type="hidden" />
			<input id="SOCIAL_TYPE_ID" type="hidden" />
			<input id="AREA_ID" type="hidden" />
			<input id="TAX_STREET" type="hidden" />
			<div class="div_update">
					<div class="div_col_title-l">
						<i></i>
						人社基本信息
					</div>
					<div class="div_col_title-r">
						<i></i>
						税务基本信息
					</div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>单位编号：</label>
						<span><input id="SOCIAL_SECURITY_NO" readonly="readonly" style="background-color: #cccccc;" /></span>
					</div>
					<div class="div_col_r">
						<label>纳税人识别号：</label>
						<span><input id="TAX_NO" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>单位名称：</label>
						<span><input id="COMPANY_NAME" /></span>
					</div>
					<div class="div_col_r">
						<label>纳税人名称：</label>
						<span><input id="PAY_TAX_PEPOLE_NAME" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>参保单位状态：</label>
						<span><input id="COMPANY_STATUS" /></span>
					</div>
					<div class="div_col_r">
						<label>登记类型：</label>
						<span><input id="TAX_REGISTER_TYPE" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>单位电话：</label>
						<span><input id="COMPANY_TEL" /></span>
					</div>
					<div class="div_col_r">
						<label>主管税务所科分局：</label>
						<span><input id="SUB_TAX_BUREAU" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>社保登记身份证号：</label>
						<span><input id="TAX_PERSON_ID" /></span>
					</div>
					<div class="div_col_r">
						<label>经办机构：</label>
						<span><input id="SOCIAL_SECURITY_ORGANIZATION" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>单位地址：</label>
						<span><input id="COMPANY_ADDRESS" /></span>
					</div>
					<div class="div_col_r">
						<label>联系方式：</label>
						<span><input id="TAX_TEL" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>专管员姓名：</label>
						<span><input id="SOCIAL_MASTER_NAME" /></span>	
					</div>
					<div class="div_col_r">
						<label>登记来源：</label>
						<span><input id="TAX_REGISRER_FROM" /></span>
					</div> 
					
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>单位类型：</label>
						<span><input id="COMPANY_TYPE" /></span>
						
					</div>
					<div class="div_col_r">
						<label>登记姓名：</label>
						<span><input id="TAX_REGISRER_NAME" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>社保登记姓名：</label>
						<span><input id="TAX_PERSON_NAME" /></span>
					</div>
					<div class="div_col_r">
						<label>主管税务局：</label>
						<span><input id="TAX_BUREAU" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>法人联系方式：</label>
						<span><input id="LEGAL_PERSON_TEL" /></span>
					</div>
					<div class="div_col_r">
						<label>生产经营地址：</label>
						<span><input id="TAX_PRODUCT_ADDRESS" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>专管员联系方式：</label>
						<span><input id="SOCIAL_MASTER_TEL" /></span>
					</div>
					<div class="div_col_r">
						<label>登记身份证号：</label>
						<span><input id="TAX_REGISRER_ID" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>社保类型：</label>
						<span><input id="SOCIAL_TYPE" /></span>
					</div>
					<div class="div_col_r">
						<label>税收管理员：</label>
						<span><input id="TAX_ADMIN" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						
					</div>
					<div class="div_col_r">
						<label>登记序号：</label>
						<span><input id="REGISTER_NO" /></span>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			<!--endprint-->
			<div class="modal-footer " style="text-align:center;">
				<!-- <button type="button" id="btn_dy" class="div_box_bon_two" onclick="doPrint()">
					<i class="iconfont pad_r6">&#xe617;</i>打印清单
				</button>	 -->							
				<button type="button" id="btn" class="div_box_bon_two">
					<i class="iconfont pad_r6">&#xe61b;</i>提交更改
				</button>
				<button type="button" class="div_box_bon_two" data-dismiss="modal" id="endbtn"><i class="iconfont pad_r6">&#xe6da;</i>&nbsp;&nbsp;&nbsp;关&nbsp;&nbsp;闭&nbsp;&nbsp;&nbsp;
				</button>
			</div>
		</div>
	</div>
	</div>
	
	<div class="modal fade" id="confirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width:280px;margin-top:200px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" 
						aria-hidden="true">×
				</button>
				<h4 class="modal-title" id="myModalLabel">
					信息提示
				</h4>
			</div>
			<div class="modal-body">
				您确认提交吗？
			</div>
			<div class="modal-footer" >
				<button type="button" class="div_box_bon_two" data-dismiss="modal"><i class="iconfont pad_r6">&#xe6da;</i>取消</button>
				<button type="button" class="div_box_bon_two" id="submit"><i class="iconfont pad_r6">&#xe806;</i>确认</button>
			</div>
		</div>
	</div>
</div>
		<script type="text/javascript">
		var typeID=null;
		var myGrid =null;
		var preID=null;
		var preTAX_PERSON_NAME=null;
		var preTAX_PERSON_ID=null;
		var l=0;
		var n=0;
		var lilist=$("#lilist");
		 $.ajax({
			url:"Instructslist.action", 
			dataType:"json", 
			type:"post",
			success:function (jsonStr) {  
			 jsonlis=jsonStr;
			 ini(jsonStr[0].ID);
			 typeID=jsonStr[0].ID;
			 var  str="<ul class='nav nav-pills l_A'>";
			 for(var i=0; i<jsonStr.length;i++){
			 n++;
			 var TYPENAME= jsonStr[i].TYPENAME;
			  str+= "<li ><a id="+i+" onclick=\"Instructslist(\'"+jsonStr[i].ID+"',this,'"+i+"')\">"+TYPENAME+"</a></li>";  
			 }
			  lilist.append(str+"</ul>");
	         $("#0").css("background","#033BB6").css("border","1px solid #033BB6");
			}, 
			error:function (error) {
			}
		});	
		
	    
		// 表格设置  查询明细数据 公司人社编号        参保类别ID  参保姓名 参保身份证号          
		 function Instructslist(typeId,obj,i){ 
		 l=i;
		 typeID=typeId;
		 $("#demoGrid").empty();
		 $(obj).css("background","#033BB6").css("border","1px solid #033BB6");
		 for(var m=0;m<n;m++){
		 if(i!=m){
		  $("#"+""+m+"").css("background","#3EC4F7").css("border","1px solid #3EC4F7");
		 }
			 
		 }
		
		 var table="<table id=\"demoTable\">"+
				"<colgroup><col id=\"demoTableCol1\"></colgroup>"+
				"<thead>"+
					"<tr>"+
						"<th><span id=\"demoHdr13\">税务登记来源</span></th>"+
						"<th><span id=\"demoHdr14\">税务登记身份证号</span></th>"+
						"<th><span id=\"demoHdr15\">税务登记姓名</span></th>"+
						"<th><span id=\"demoHdr16\">人社社保登记姓名</span></th>"+
						"<th><span id=\"demoHdr17\">人社社保保登记身份证号</span></th>"+
						"<th><span id=\"demoHdr18\">人社法人联系方式</span></th>"+
						"<th><span id=\"demoHdr19\">人社专管员姓名</span></th>"+
						"<th><span id=\"demoHdr20\">人社专管员联系方式</span></th>"+
						"<th><span id=\"demoHdr21\">人社单位类型</span></th>"+
						"<th><span id=\"demoHdr22\">社保类型</span></th>"+
						"<th><span id=\"demoHdr23\">税收管理员</span></th>"+
						"<th><span id=\"demoHdr24\">登记序号</span></th>"+
						"<th><span id=\"demoHdr25\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;操&nbsp;作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></th>"+
					"</tr>"+
				"</thead>"+
				"<tbody id=\"mybat\"></tbody>"+
			"</table>";
		 $("#demoGrid").append(table);
		 var TAX_PERSON_NAME= $("#name").val();
		 var TAX_PERSON_ID= $("#IDCare").val();
		 var  data={"TYPE":typeId,"TAX_PERSON_NAME":TAX_PERSON_NAME,"TAX_PERSON_ID":TAX_PERSON_ID};
		 //获取到表格的位置 
		   var tbl=$("#mybat");
		   tbl.empty();
		   $.ajax({
			url:"SocialPersonMessagelist.action", 
			dataType:"json", 
			type:"post",
			data:data,
			success:function (json){  
			if(json.length>0){
			 for(var i=0; i<json.length;i++){
			   var LEGAL_PERSON_TEL =json[i].LEGAL_PERSON_TEL;
			   if(LEGAL_PERSON_TEL==null||LEGAL_PERSON_TEL==""){
			   LEGAL_PERSON_TEL="--";
			   }
			   var SOCIAL_MASTER_NAME=json[i].SOCIAL_MASTER_NAME;
			   if(SOCIAL_MASTER_NAME==null||SOCIAL_MASTER_NAME==""){
			   SOCIAL_MASTER_NAME="--";
			   }
			   var SOCIAL_MASTER_TEL=json[i].SOCIAL_MASTER_TEL;
			   if(SOCIAL_MASTER_TEL==null||SOCIAL_MASTER_TEL==""){
			   SOCIAL_MASTER_TEL="--";
			   }
			   var COMPANY_TYPE=json[i].COMPANY_TYPE;
			   if(COMPANY_TYPE==null||COMPANY_TYPE==""){
			   COMPANY_TYPE="--";
			   }
			   var TAX_ADMIN=json[i].TAX_ADMIN;
			   if(TAX_ADMIN==null||TAX_ADMIN==""){
			   TAX_ADMIN="--";
			   }
			   
			    /*  ID=json[i].ID;  */
			    
			        var str="<tr>";		
			    	 str+="<td>"+(json[i].TAX_REGISRER_FROM)+"</td>";
					 str+="<td>"+json[i].TAX_REGISRER_ID+"</td>";
					 str+="<td>"+json[i].TAX_REGISRER_NAME+"</td>";
    				 str+="<td>"+json[i].TAX_PERSON_NAME+"</td>";
    				 str+="<td>"+json[i].TAX_PERSON_ID+"</td>";
                     str+="<td>"+LEGAL_PERSON_TEL+"</td>";
                     str+="<td>"+SOCIAL_MASTER_NAME+"</td>";
                     str+="<td>"+SOCIAL_MASTER_TEL+"</td>";
                     str+="<td>"+COMPANY_TYPE+"</td>";
                     str+="<td>"+ json[i].SOCIAL_TYPE+"</td>";
                     str+="<td>"+TAX_ADMIN+"</td>";
                     str+="<td>"+ json[i].REGISTER_NO+"</td>";
					 str+="<td><label data-toggle='modal' class='update_hover'><span onclick=\"update(\'"+json[i].ID+"',\'"+json[i].TAX_REGISRER_NAME+"')\">修 改</span></label></td>";
					 tbl.append(str+="</tr>");
 			 }
 			 initdata();
 			 }
			}, 
			error:function (error) {
			  HuiFang.Funtishi("暂无关联信息");
				}
		
		});
		 
		 }	
		 
		 
		 function ini(typeId){
		 $("#demoGrid").empty();
		 var table="<table id=\"demoTable\">"+
				"<colgroup><col id=\"demoTableCol1\"></colgroup>"+
				"<thead>"+
					"<tr>"+
						"<th><span id=\"demoHdr13\">税务登记来源</span></th>"+
						"<th><span id=\"demoHdr14\">税务登记身份证号</span></th>"+
						"<th><span id=\"demoHdr15\">税务登记姓名</span></th>"+
						"<th><span id=\"demoHdr16\">人社社保登记姓名</span></th>"+
						"<th><span id=\"demoHdr17\">人社社保保登记身份证号</span></th>"+
						"<th><span id=\"demoHdr18\">人社法人联系方式</span></th>"+
						"<th><span id=\"demoHdr19\">人社专管员姓名</span></th>"+
						"<th><span id=\"demoHdr20\">人社专管员联系方式</span></th>"+
						"<th><span id=\"demoHdr21\">人社单位类型</span></th>"+
						"<th><span id=\"demoHdr22\">社保类型</span></th>"+
						"<th><span id=\"demoHdr23\">税收管理员</span></th>"+
						"<th><span id=\"demoHdr24\">登记序号</span></th>"+
						"<th><span id=\"demoHdr25\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;操&nbsp;作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></th>"+
					"</tr>"+
				"</thead>"+
				"<tbody id=\"mybat\"></tbody>"+
			"</table>";
		 $("#demoGrid").append(table);
		 var TAX_PERSON_NAME= $("#name").val();
		 var TAX_PERSON_ID= $("#IDCare").val();
		 var  data={"TYPE":typeId,"TAX_PERSON_NAME":TAX_PERSON_NAME,"TAX_PERSON_ID":TAX_PERSON_ID};
		 //获取到表格的位置 
		   var tbl=$("#mybat");
		   tbl.empty();
		   $.ajax({
			url:"SocialPersonMessagelist.action", 
			dataType:"json", 
			type:"post",
			data:data,
			success:function (json){  
			if(json.length>0){
			 for(var i=0; i<json.length;i++){
			   var LEGAL_PERSON_TEL =json[i].LEGAL_PERSON_TEL;
			   if(LEGAL_PERSON_TEL==null){
			   LEGAL_PERSON_TEL="--";
			   }
			   var SOCIAL_MASTER_NAME=json[i].SOCIAL_MASTER_NAME;
			   if(SOCIAL_MASTER_NAME==null){
			   SOCIAL_MASTER_NAME="--";
			   }
			   var SOCIAL_MASTER_TEL=json[i].SOCIAL_MASTER_TEL;
			   if(SOCIAL_MASTER_TEL==null){
			   SOCIAL_MASTER_TEL="--";
			   }
			   var COMPANY_TYPE=json[i].COMPANY_TYPE;
			   if(COMPANY_TYPE==null){
			   COMPANY_TYPE="--";
			   }
			   var TAX_ADMIN=json[i].TAX_ADMIN;
			   if(TAX_ADMIN==null){
			   TAX_ADMIN="--";
			   }
			        var str="<tr>";		
			    	 str+="<td>"+(json[i].TAX_REGISRER_FROM)+"</td>";
					 str+="<td>"+json[i].TAX_REGISRER_ID+"</td>";
					 str+="<td>"+json[i].TAX_REGISRER_NAME+"</td>";
    				 str+="<td>"+json[i].TAX_PERSON_NAME+"</td>";
    				 str+="<td>"+json[i].TAX_PERSON_ID+"</td>";
                     str+="<td>"+LEGAL_PERSON_TEL+"</td>";
                     str+="<td>"+SOCIAL_MASTER_NAME+"</td>";
                     str+="<td>"+SOCIAL_MASTER_TEL+"</td>";
                     str+="<td>"+COMPANY_TYPE+"</td>";
                     str+="<td>"+ json[i].SOCIAL_TYPE+"</td>";
                     str+="<td>"+TAX_ADMIN+"</td>";
                     str+="<td>"+ json[i].REGISTER_NO+"</td>";
					 str+="<td><label data-toggle='modal' class='update_hover'><span onclick=\"update(\'"+json[i].ID+"',\'"+json[i].TAX_REGISRER_NAME+"')\">修 改</span></label></td>";
					 tbl.append(str+="</tr>");
 			 }
 			 initdata();
 			 }
			}
		
		});
		 }
		 
		 
 		//返回上一页
        $("#historybth").click(function(){
      	var SOCIAL_SECURITY_NO = "<%=SOCIAL_SECURITY_NO%>";
     	var url = "<%=basePath%>bussiness/tax/socialPersonMessage/TaxMess.jsp?SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO;
		window.location.href =	url;
			}); 
			
		//设置关闭按键
		$("#endbtn").click(function(){
      	//获取到查询的条件
      	var TAX_PERSON_NAME=$("#name").val();
      	var TAX_PERSON_ID=$("#IDCare").val();
        var SOCIAL_SECURITY_NO = "<%=SOCIAL_SECURITY_NO%>";
		//刷新当前页
      	var url="<%=url%>?TAX_PERSON_NAME="+TAX_PERSON_NAME+"&TAX_PERSON_ID="+TAX_PERSON_ID+"&SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO;
       	window.location.href=url;      	
       });
       
		//设置修改按键
		  $("#selecbtn").click(function(){
      	  Instructslist(typeID,this,l);
      	   	
       }); 
		  //设置修改 
		  function getid(id) {
			$.ajax({
			url:"backSocialPersonMessage.action?ID="+id, 
			dataType:"json", 
			type:"post",
			success:function (jsonStr) 
			{       
				var json =jsonStr;	
				preID=json.ID;
				preTAX_PERSON_ID=json.TAX_PERSON_ID;
				preTAX_PERSON_NAME=json.TAX_PERSON_NAME;		
				var ID =json.ID;
			    var SOCIAL_SECURITY_NO=json.SOCIAL_SECURITY_NO;//人社单位编号
			    var  TAX_NO =json.TAX_NO;//税务纳税人识别号
			    var   COMPANY_NAME =json.COMPANY_NAME;//人社单位名称
			    var  PAY_TAX_PEPOLE_NAME=json.PAY_TAX_PEPOLE_NAME;//税务纳税人名称
			    var  COMPANY_STATUS=json.COMPANY_STATUS;//人社参保单位状态
			    var  TAX_REGISTER_TYPE =json.TAX_REGISTER_TYPE;//税务登记类型
			    var  TAX_BUREAU=json.TAX_BUREAU;//主管税务局
			    var  SUB_TAX_BUREAU =json.SUB_TAX_BUREAU;//主管税务所科分局
			    var  SOCIAL_SECURITY_ORGANIZATION =json.SOCIAL_SECURITY_ORGANIZATION;//人社经办机构
			    var  TAX_STREET=json.TAX_STREET;//税务街道乡镇
			    var  COMPANY_TEL =json.COMPANY_TEL;//人社单位电话
			    var  COMPANY_ADDRESS=json.COMPANY_ADDRESS;//人社单位地址
			    var  TAX_TEL=json.TAX_TEL;//税务联系方式
			    var  TAX_PRODUCT_ADDRESS=json.TAX_PRODUCT_ADDRESS;//税务生产经营地址
			    var  TAX_REGISRER_FROM=json.TAX_REGISRER_FROM;//税务登记来源
			    var  TAX_REGISRER_ID=json.TAX_REGISRER_ID;//税务登记身份证号
			    var  TAX_REGISRER_NAME=json.TAX_REGISRER_NAME;//税务登记姓名
			    var  TAX_PERSON_NAME=json.TAX_PERSON_NAME;//人社社保登记姓名
			    var  TAX_PERSON_ID=json.TAX_PERSON_ID;//人社社保保登记身份证号
			    var  LEGAL_PERSON_TEL=json.LEGAL_PERSON_TEL;//人社法人联系方式
			    var  SOCIAL_MASTER_NAME=json.SOCIAL_MASTER_NAME;//人社专管员姓名
			    var  SOCIAL_MASTER_TEL=json.SOCIAL_MASTER_TEL;//人社专管员联系方式
			    var  COMPANY_TYPE=json.COMPANY_TYPE;//人社单位类型
			    var  SOCIAL_TYPE_ID=json.SOCIAL_TYPE_ID;//社保类型
			    var  SOCIAL_TYPE=json.SOCIAL_TYPE;//社保类型
			    var  TAX_ADMIN=json.TAX_ADMIN;//税收管理员
			    var  REGISTER_NO=json.REGISTER_NO;//登记序号
			    var  IF_MODIFY=json.IF_MODIFY;//0：未修改 1：已修改
			    var  IF_MATCHED=json.IF_MATCHED;//0：未匹配 1：已匹配
			    var  AREA_ID=json.AREA_ID; //区域id
	       		 $("#ID").val(ID);
	       		 $("#company_name").html(+"基本信息");
	       		 $("#company_name_sub").html(TAX_REGISRER_NAME+SOCIAL_TYPE+"信息修改");
	       		 $("#SOCIAL_SECURITY_NO").html(SOCIAL_SECURITY_NO!=""? SOCIAL_SECURITY_NO:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_NO").html(TAX_NO!=""? TAX_NO:"<font color=\"red\">数据缺失</font>"); 
	       		 $("#COMPANY_NAME").html(COMPANY_NAME!=""? COMPANY_NAME:"<font color=\"red\">数据缺失</font>");
	       		 $("#PAY_TAX_PEPOLE_NAME").html(PAY_TAX_PEPOLE_NAME!=""? PAY_TAX_PEPOLE_NAME:"<font color=\"red\">数据缺失</font>");
	       		 $("#COMPANY_STATUS").html(COMPANY_STATUS!=""? COMPANY_STATUS:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_REGISTER_TYPE").html(TAX_REGISTER_TYPE!=""? TAX_REGISTER_TYPE:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_BUREAU").html(TAX_BUREAU!=""? TAX_BUREAU:"<font color=\"red\">数据缺失</font>");
	       		 $("#SUB_TAX_BUREAU").html(SUB_TAX_BUREAU!=""? SUB_TAX_BUREAU:"<font color=\"red\">数据缺失</font>");
	       		 $("#SOCIAL_SECURITY_ORGANIZATION").html(SOCIAL_SECURITY_ORGANIZATION!=""? SOCIAL_SECURITY_ORGANIZATION:"<font color=\"red\">数据缺失</font>");
	       		 $("#COMPANY_TEL").html(COMPANY_TEL!=""? COMPANY_TEL:"<font color=\"red\">数据缺失</font>");
	       		 $("#COMPANY_ADDRESS").html(COMPANY_ADDRESS!=""? COMPANY_ADDRESS:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_TEL").html(TAX_TEL!=""? TAX_TEL:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_PRODUCT_ADDRESS").html(TAX_PRODUCT_ADDRESS!=""? TAX_PRODUCT_ADDRESS:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_REGISRER_FROM").html(TAX_REGISRER_FROM!=""? TAX_REGISRER_FROM:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_REGISRER_ID").html(TAX_REGISRER_ID!=""? TAX_REGISRER_ID:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_PERSON_NAME").html(TAX_PERSON_NAME!=""? TAX_PERSON_NAME:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_REGISRER_NAME").html(TAX_REGISRER_NAME!=""? TAX_REGISRER_NAME:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_PERSON_ID").html(TAX_PERSON_ID!=""? TAX_PERSON_ID:"<font color=\"red\">数据缺失</font>");
	       		 $("#SOCIAL_MASTER_NAME").html(SOCIAL_MASTER_NAME!=""? SOCIAL_MASTER_NAME:"<font color=\"red\">数据缺失</font>");
	       		 $("#SOCIAL_MASTER_TEL").html(SOCIAL_MASTER_TEL!=""? SOCIAL_MASTER_TEL:"<font color=\"red\">数据缺失</font>");
	       		 $("#COMPANY_TYPE").html(COMPANY_TYPE!=""? COMPANY_TYPE:"<font color=\"red\">数据缺失</font>");
	       		 $("#SOCIAL_TYPE_ID").html(SOCIAL_TYPE_ID!=""? SOCIAL_TYPE_ID:"<font color=\"red\">数据缺失</font>");
	       		 $("#SOCIAL_TYPE").html(SOCIAL_TYPE!=""? SOCIAL_TYPE:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_ADMIN").html(TAX_ADMIN!=""? TAX_ADMIN:"<font color=\"red\">数据缺失</font>");
	       		 $("#REGISTER_NO").html(REGISTER_NO!=""? REGISTER_NO:"<font color=\"red\">数据缺失</font>");
	       		 $("#IF_MODIFY").html(IF_MODIFY!=""? IF_MODIFY:"<font color=\"red\">数据缺失</font>");
	       		 $("#IF_MATCHED").html(IF_MATCHED!=""? IF_MATCHED:"<font color=\"red\">数据缺失</font>");
	       		 $("#LEGAL_PERSON_TEL").html(LEGAL_PERSON_TEL!=""? LEGAL_PERSON_TEL:"<font color=\"red\">数据缺失</font>");
	       		 $("#TAX_STREET").html(TAX_STREET!=""? TAX_STREET:"<font color=\"red\">数据缺失</font>");
	       		 $("#AREA_ID").html(AREA_ID!=""? AREA_ID:"<font color=\"red\">数据缺失</font>");
	             /*--------------------------------- 修改------------------------------------------------------------------------------- */  		 
	       		 $("#SOCIAL_SECURITY_NO").val(SOCIAL_SECURITY_NO!=""? SOCIAL_SECURITY_NO:"");
	       		 $("#TAX_NO").val(TAX_NO!=""? TAX_NO:""); 
	       		 $("#COMPANY_NAME").val(COMPANY_NAME!=""? COMPANY_NAME:"");
	       		 $("#PAY_TAX_PEPOLE_NAME").val(PAY_TAX_PEPOLE_NAME!=""? PAY_TAX_PEPOLE_NAME:"");
	       		 $("#COMPANY_STATUS").val(COMPANY_STATUS!=""? COMPANY_STATUS:"");
	       		 $("#TAX_REGISTER_TYPE").val(TAX_REGISTER_TYPE!=""? TAX_REGISTER_TYPE:"");
	       		 $("#TAX_BUREAU").val(TAX_BUREAU!=""? TAX_BUREAU:"");
	       		 $("#SUB_TAX_BUREAU").val(SUB_TAX_BUREAU!=""? SUB_TAX_BUREAU:"");
	       		 $("#SOCIAL_SECURITY_ORGANIZATION").val(SOCIAL_SECURITY_ORGANIZATION!=""? SOCIAL_SECURITY_ORGANIZATION:"");
	       		 $("#COMPANY_TEL").val(COMPANY_TEL!=""? COMPANY_TEL:"");
	       		 $("#COMPANY_ADDRESS").val(COMPANY_ADDRESS!=""? COMPANY_ADDRESS:"");
	       		 $("#TAX_TEL").val(TAX_TEL!=""? TAX_TEL:"");
	       		 $("#TAX_PRODUCT_ADDRESS").val(TAX_PRODUCT_ADDRESS!=""? TAX_PRODUCT_ADDRESS:"");
	       		 $("#TAX_REGISRER_FROM").val(TAX_REGISRER_FROM!=""? TAX_REGISRER_FROM:"");
	       		 $("#TAX_REGISRER_ID").val(TAX_REGISRER_ID!=""? TAX_REGISRER_ID:"");
	       		 $("#TAX_PERSON_NAME").val(TAX_PERSON_NAME!=""? TAX_PERSON_NAME:"");
	       		 $("#TAX_REGISRER_NAME").val(TAX_REGISRER_NAME!=""? TAX_REGISRER_NAME:"");
	       		 $("#TAX_PERSON_ID").val(TAX_PERSON_ID!=""? TAX_PERSON_ID:"");
	       		 $("#SOCIAL_MASTER_NAME").val(SOCIAL_MASTER_NAME!=""? SOCIAL_MASTER_NAME:"");
	       		 $("#SOCIAL_MASTER_TEL").val(SOCIAL_MASTER_TEL!=""? SOCIAL_MASTER_TEL:"");
	       		 $("#COMPANY_TYPE").val(COMPANY_TYPE!=""? COMPANY_TYPE:"");
	       		 $("#SOCIAL_TYPE_ID").val(SOCIAL_TYPE_ID!=""? SOCIAL_TYPE_ID:"");
	       		 $("#SOCIAL_TYPE").val(SOCIAL_TYPE!=""? SOCIAL_TYPE:"");
	       		 $("#TAX_ADMIN").val(TAX_ADMIN!=""? TAX_ADMIN:"");
	       		 $("#REGISTER_NO").val(REGISTER_NO!=""? REGISTER_NO:"");
	       		 $("#IF_MODIFY").val(IF_MODIFY!=""? IF_MODIFY:"");
	       		 $("#IF_MATCHED").val(IF_MATCHED!=""? IF_MATCHED:"");
	       		 $("#LEGAL_PERSON_TEL").val(LEGAL_PERSON_TEL!=""? LEGAL_PERSON_TEL:"");
	       		 $("#TAX_STREET").val(TAX_STREET!=""? TAX_STREET:"");
	       		 $("#AREA_ID").val(AREA_ID!=""? AREA_ID:"");
			}, 
			error:function (error) {	
			}
		}); 
	}
		$("#btn").click(function(){
			 $("#confirm").modal('show');	
			 $("#submit").click(function(){
			var start_json="{";
     		var end_json="}";
     		var json="";
    		var data="";
		 $("#myModal input").each(function(){
       	  var id =$(this).attr("id");
       	  var value = $(this).val();
       	  data +="\""+id+"\""+":\"" +value+"\","
        });
        data = data + "\"IF_MODIFY\":\"1\"";
        
        json=start_json+data+end_json;
        var model=  JSON.parse(json);  
        $.ajax({
			url:"SetSocialPersonMessage.action", 
			data:model, 
			dataType:"json", 
			type:"post",
			success:function (jsonStr) {  
				Print=1;      			
	       	    var status=jsonStr.status;
	       		if(status=="000000"){
	       		  $("#confirm").modal('hide');
	       		  $("#myModal").modal('hide');
	       		 $("#status").val(1);
	       		 HuiFang.Funtishi("修改成功！");
	       		  
	       		 $("#demoGrid").empty();
      			  Instructslist(typeID);
      			  
      			window.location.href="PrintPersonal.jsp?ID="+preID;
      			  
	       		}else{
	       		 $("#confirm").modal('hide');	
	       			
	       		}
			}, 
			error:function (error) {
				
			}
		});
		
		 		
	 });
	 });	
		function  update(id,name){
	    $("#myModal").modal('show');
		 getid(id);
		 }
			function initdata() {
				var gridColSortTypes = [ "string", "number", "number",
						"number", "number", "number", "number", "number",
						"number", "number", "number", "number", "number" ], gridColAlign = [];
				var onColumnSort = function(newIndexOrder, columnIndex,
						lastColumnIndex) {
					var offset = (this.options.allowSelections && this.options.showSelectionColumn) ? 1
							: 0, doc = document;
					if (columnIndex !== lastColumnIndex) {
						if (lastColumnIndex > -1) {
							doc.getElementById("demoHdr"
									+ (lastColumnIndex - offset)).parentNode.style.backgroundColor = "";
						}
						doc.getElementById("demoHdr" + (columnIndex - offset)).parentNode.style.backgroundColor = "#f7f7f7";
					}
				};
				var onResizeGrid = function(newWidth, newHeight) {
					var demoDivStyle = document.getElementById("demoDiv").style;
					demoDivStyle.width = newWidth + "px";
					demoDivStyle.height = newHeight + "px";
				};
				for (var i = 0, col; col = gridColSortTypes[i]; i++) {
					gridColAlign[i] = (col === "number") ? "right" : "left";
				}
				    myGrid = new Grid("demoGrid", {
					srcType : "dom",
					srcData : "demoTable",
					allowGridResize : true,
					allowColumnResize : true,
					allowClientSideSorting : true,
					allowSelections : true,
					allowMultipleSelections : true,
					showSelectionColumn : false,
					onColumnSort : onColumnSort,
					onResizeGrid : onResizeGrid,
					colAlign : gridColAlign,
					colBGColors : [ "#fafafa" ],
					colSortTypes : gridColSortTypes,
					fixedCols : 1
				});
				}
			var HuiFang = {
				m_tishi : null,
				Funtishi : function(content, url) {
					if (HuiFang.m_tishi == null) {
						HuiFang.m_tishi = '<div class="xiaoxikuang none" id="app_tishi" style="z-index:9999;left: 50%;width:15%;position: fixed;background:none;bottom:60%;opacity:0.7;"> <p class="app_tishi" style="background: none repeat scroll 0 0 #000; border-radius: 30px;color: #fff; margin: 0 auto;padding: 1.5em;text-align: center;width: 70%;opacity: 0.8; font-family:Microsoft YaHei;letter-spacing: 1px;font-size: 1.1em;"></p></div>';
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
			
			
			
		</script>
		
	</body>
</html>
