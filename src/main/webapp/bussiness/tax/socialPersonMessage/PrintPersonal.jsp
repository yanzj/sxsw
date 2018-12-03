<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String ID = request.getParameter("ID");
String lastName = request.getParameter("lastName");
String lastID = request.getParameter("lastID"); 
String preName = request.getParameter("preName");
String preTAX_PERSON_ID = request.getParameter("preTAX_PERSON_ID");
String time=(new SimpleDateFormat("yyyy年MM月dd日")).format(new Date());
%>
<!DOCTYPE html>  
<html>  
<head>  
<title>打印用人单位信息</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/bootstrap3.3.7/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/iconfont/iconfont.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/taxmess.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/print.css" media="print"/>
<link href="<%=basePath%>images/title.png" rel="SHORTCUT ICON">
<script type="text/javascript" src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath  %>include/iconfont/iconfont.js"></script>
<script type="text/javascript" src="<%=basePath  %>js/jquery.jqprint-0.3.js"></script>
 

</head>  
  
<body>  
<div class="print_box_o">
	<div id="printPersonal" class="print_box  print_box_print1">
		<div class="print_title" >
			<h2>社会保险费参保缴费信息关联表（适用职工个人）</h2>
		</div>
		<table border="0" cellspacing="0" cellpadding="0" >
			<thead>
			</thead>
			<tbody id="init">
				<tr>
					<td>用人单位统一社会信用代码（纳税人识别号）</td>
					<td colspan="2"><span id="TAX_NO"></td>
					<td>税务登记序号</td>
					<td colspan="2"><span id="REGISTER_NO"></td>
				</tr>
				<tr>
					<td>用人单位名称</td>
					<td colspan="2"><span id="COMPANY_NAME"></span></td>
					<td>用人单位编号</td>
					<td colspan="2"><span id="SOCIAL_SECURITY_NO"></td>
				</tr>
				<tr>
					<td>险种</td>
					<td colspan="2"><span id="SOCIAL_TYPE"></td>
					<td>社保经办机构</td>
					<td colspan="2"><span id="SOCIAL_SECURITY_ORGANIZATION"></td>
				</tr>
				<tr>
					<td style="width: 20%;">更改前姓名</td>
					<td style="width: 15%;">更改后姓名</td>
					<td style="width: 15%;">更改前身份证号</td>
					<td style="width: 15%;">更改后身份证号</td>
					<td style="width: 20%;">社会保险经办机构</td>
					<td style="width: 15%;">人员编号</td>
				</tr>
				
			</tbody>		
		</table>
	</div>
	
	<div class="print_button">
		<button type="button" onclick="javascript:history.back(-1)" class="div_box_bon_one"><i class="iconfont pad_r6">&#xe669;</i>返回</button> 
		<button type="button" onclick="doPrint()" class="div_box_bon_one"><i class="iconfont pad_r6">&#xe617;</i>打印</button>  
	</div>
</div> 
</body>  
<script type="text/javascript">  
			var lastName="<%=lastName%>";
	       	$("#Name").html(lastName);
	       	var lastID=<%=lastID%>;
	       	$("#ID").html(lastID);   
			function doPrint(){
			$("#printPersonal").jqprint();
            }
			$.ajax({
			url:"GroupSocialPersonMessage.action?ID=<%=ID%>", 
			dataType:"json", 
			type:"post",
			success:function (jsonStr){       
				var json =jsonStr;					
	       	  	//绑定数据到表单
			    var  ID =json.ID;//ID 
			    var  SOCIAL_SECURITY_NO=json.SOCIAL_SECURITY_NO;//人社单位编号
			    var  TAX_NO =json.TAX_NO;//税务纳税人识别号
			    var  COMPANY_NAME =json.COMPANY_NAME;//人社单位名称
			    var  SOCIAL_TYPE_ID=json.SOCIAL_TYPE_ID;//社保类型
			    var  REGISTER_NO=json.REGISTER_NO;//登记序号
			    var  SOCIAL_SECURITY_ORGANIZATION =json.SOCIAL_SECURITY_ORGANIZATION;//人社经办机构
			    var  SOCIAL_TYPE=json.SOCIAL_TYPE;//社保类型
	       		 $("#ID").val(ID);
	       		 $("#company_name").html(+"基本信息");
	       		 $("#company_name_sub").html("修改"+SOCIAL_TYPE+"信息修改");
	       		 $("#SOCIAL_SECURITY_NO").html(SOCIAL_SECURITY_NO!=""? SOCIAL_SECURITY_NO:"");
	       		 $("#TAX_NO").html(TAX_NO!=""? TAX_NO:""); 
	       		 $("#COMPANY_NAME").html(COMPANY_NAME!=""? COMPANY_NAME:"");
	       		 $("#SOCIAL_SECURITY_ORGANIZATION").html(SOCIAL_SECURITY_ORGANIZATION!=""? SOCIAL_SECURITY_ORGANIZATION:"");
	       		 $("#SOCIAL_TYPE").html(SOCIAL_TYPE_ID!=""? SOCIAL_TYPE_ID:"");
	       		 $("#REGISTER_NO").html(REGISTER_NO!=""? REGISTER_NO:"");
	       	    
	          var  allSocialPersonMessage= jsonStr.allSocialPersonMessage;
			  $.each(allSocialPersonMessage,function(index,item){
				var init_data= "<tr>"+
				"<td>"+item.TAX_PERSON_NAME+"</td>"+
				"<td>"+item.NEW_TAX_PERSON_NAME+"</td>"+
				"<td>"+item.TAX_PERSON_ID+"</td>"+
				"<td>"+item.NEW_TAX_PERSON_ID+"</td>"+
				"<td>"+SOCIAL_SECURITY_ORGANIZATION+"</td>"+
				"<td>"+item.REGISTER_NO+"</td>"+
			  "</tr>";	  
		     $("#init").append(init_data);
		    	});
	
			var foot=<%-- "<tr>"+
			"<td>关联税务机关</td>"+
			"<td></td>"+
			"<td>关联人</td>"+
			"<td></td>"+
			"<td>关联日期</td>"+
			"<td colspan=\"2\" class=\"print_date\" style=\"text-align: right;\"><%=time %></td>"+ 
		"</tr>"+--%>
		"<tr>"+
			"<td style=\"height: 70px;\">经办人签章</td>"+
			"<td colspan=\"2\" class=\"print_date\" style=\"text-align: right;\"><%=time %></td>"+
			"<td>纳税人公章</td>"+
			"<td><%=time%></td>"+
			"<td colspan=\"3\" class=\"print_date\" style=\"text-align: right;\"><%=time %></td>"+
		"</tr>"+
		"<tr>"+
			"<td>备注</td>"+
			"<td colspan=\"6\"></td>"+
		"</tr>";		
			$("#init").append(foot); 

			}, 
			
			
			
			
			error:function (error) {
				
			}
		}); 
		
</script>  
</html> 