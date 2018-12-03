<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.drools.lang.DRLParser.forall_key_return"%>
<%@page import="java.io.Writer"%>
<%@page import="org.drools.lang.DRLParser.forall_key_return"%>
<%@page import="com.dhcc.bussiness.tax.socialPersonMessage.SocialPersonMessageDao"%>
<%@page import="java.util.List"%>
<%@page import="com.dhcc.bussiness.tax.entity.SocialPersonMessage"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String SOCIAL_SECURITY_NO = request.getParameter("SOCIAL_SECURITY_NO");
String TAX_PERSON_ID = request.getParameter("TAX_PERSON_ID");
String TAX_PERSON_NAME = request.getParameter("TAX_PERSON_NAME");
String session_id=request.getSession().getAttribute("SOCIAL_SECURITY_NO").toString();

String time=(new SimpleDateFormat("yyyy年MM月dd日")).format(new Date());

String SOCIAL_TYPE_ID="9933a01499f54ef8a0f9f2dfeb788348";
String url="ListDetail4.jsp";
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
if("<%=SOCIAL_SECURITY_NO%>"!="<%=session_id%>"){
window.location.href='<%=basePath%>Index';	
}
 var Print=0;
function doPrint() { 
  if(Print==0){
		
	HuiFang.Funtishi("先修改再打印！");
			
  return;
 
  }     
    var ID= $("#ID").val();
    var lastName= json.TAX_PERSON_NAME;
    var lastID=json.TAX_PERSON_ID
    window.location.href="PrintPersonal.jsp?ID="+ID+"&lastName="+lastName+"&lastID="+lastID;     
  
     /*   bdhtml=window.document.body.innerHTML;      
        sprnstr="<!--startprint-->";      
        eprnstr="<!--endprint-->";      
        prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17);      
        prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));   
        window.document.body.innerHTML=prnhtml;   
        alert(prnhtml); */
       // window.print();  
}
function pagesetup_null(){                
    var hkey_root,hkey_path,hkey_key;
    hkey_root="HKEY_CURRENT_USER";
    hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
    try{
        var RegWsh = new ActiveXObject("WScript.Shell");
        hkey_key="header";
        RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
        hkey_key="footer";
        RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
    }catch(e){}
}

function getExplorer() {
    var explorer = window.navigator.userAgent ;
    //ie 
    if (explorer.indexOf("MSIE") >= 0) {
        return "IE";
    }
    //firefox 
    else if (explorer.indexOf("Firefox") >= 0) {
        return "Firefox";
    }
    //Chrome
    else if(explorer.indexOf("Chrome") >= 0){
        return "Chrome";
    }
    //Opera
    else if(explorer.indexOf("Opera") >= 0){
        return "Opera";
    }
    //Safari
    else if(explorer.indexOf("Safari") >= 0){
        return "Safari";
    };
} ;
 
    jQuery(function ($){
       var SOCIAL_SECURITY_NO = "<%=SOCIAL_SECURITY_NO%>";
         $("#Forbtn").click(function(){
			 window.location.href = "<%=basePath%>center.jsp";	
			});
  });  
      	  
</script> 
</head>
<body style="height:100%;">
	<div class="List_box">
		<ul class="nav nav-pills l_A">
		  <li class="active">
			<a href="<%=basePath  %>bussiness/tax/socialPersonMessage/ListDetail.jsp?SOCIAL_SECURITY_NO=<%=SOCIAL_SECURITY_NO %>">养老保险</a>
		  </li>
		  <li><a href="<%=basePath  %>bussiness/tax/socialPersonMessage/ListDetail1.jsp?SOCIAL_SECURITY_NO=<%=SOCIAL_SECURITY_NO %>">医疗保险</a></li>
		  <li><a href="<%=basePath  %>bussiness/tax/socialPersonMessage/ListDetail2.jsp?SOCIAL_SECURITY_NO=<%=SOCIAL_SECURITY_NO %>">失业保险</a></li>
		  <li><a href="<%=basePath  %>bussiness/tax/socialPersonMessage/ListDetail3.jsp?SOCIAL_SECURITY_NO=<%=SOCIAL_SECURITY_NO %>">工伤保险</a></li>
		  <li><a href="<%=basePath  %>bussiness/tax/socialPersonMessage/ListDetail4.jsp?SOCIAL_SECURITY_NO=<%=SOCIAL_SECURITY_NO %>">生育保险</a></li>
		</ul>
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
			<table id="demoTable">
				<colgroup><col id="demoTableCol1"></colgroup>
				<thead>
					<tr>
						<th><span id="demoHdr0">人社单位编号</span></th>
						<th class="num"><span id="demoHdr1" >税务纳税人识别号</span></th>
						<th class="num"><span id="demoHdr2">人社单位名称</span></th>
						<th class="num"><span id="demoHdr3" >税务纳税人名称</span></th>
						<th class="num"><span id="demoHdr4">人社参保单位状态</span></th>
						<th class="num"><span id="demoHdr5">税务登记类型</span></th>
						<th class="num"><span id="demoHdr6" >主管税务局</span></th>
						<th class="num"><span id="demoHdr7">主管税务所科分局</span></th>
						<th class="num"><span id="demoHdr8">人社经办机构</span></th>
						<th class="num"><span id="demoHdr9" >税务街道乡镇</span></th>
						<th class="num"><span id="demoHdr10">人社单位电话</span></th>
						<th class="num"><span id="demoHdr11">人社单位地址</span></th>
						<th class="num"><span id="demoHdr12">税务联系方式</span></th>
						<th><span id="demoHdr13">税务登记来源</span></th>
						<th><span id="demoHdr14">税务登记身份证号</span></th>
						<th><span id="demoHdr15">税务登记姓名</span></th>
						<th><span id="demoHdr16">人社社保登记姓名</span></th>
						<th><span id="demoHdr17">人社社保保登记身份证号</span></th>
						<th><span id="demoHdr18">人社法人联系方式</span></th>
						<th><span id="demoHdr19">人社专管员姓名</span></th>
						<th><span id="demoHdr20">人社专管员联系方式</span></th>
						<th><span id="demoHdr21">人社单位类型</span></th>
						<th><span id="demoHdr22">社保类型</span></th>
						<th><span id="demoHdr23">税收管理员</span></th>
						<th><span id="demoHdr24">登记序号</span></th>
						<th><span id="demoHdr25">操作</span></th>
					</tr>
				</thead>
				<tbody id="mybat">
				<%
				SocialPersonMessageDao dao =new SocialPersonMessageDao();
		//SOCIAL_SECURITY_NO  人社单位编号   COMPANY_NAME 人社单位名称  TAX_PERSON_NAME 人社社保登记姓名    SOCIAL_TYPE  社保类型  IF_MODIFY 是否修改  TAX_PERSON_ID 身份证号
				List<SocialPersonMessage> list=dao.socialPersonMessageQueryList(SOCIAL_SECURITY_NO, "",TAX_PERSON_NAME, SOCIAL_TYPE_ID, "",TAX_PERSON_ID);
					if(list.size()>0){
					for (int i = 0; i < list.size(); i++) {
				 %>
						<tr>
				<td class="txt"><%=list.get(i).getSOCIAL_SECURITY_NO() %></td>
						<td><%=list.get(i).getTAX_NO() %></td>
						<td><%=list.get(i).getCOMPANY_NAME() %></td>
						<td><%=list.get(i).getPAY_TAX_PEPOLE_NAME() %></td>
						<td><%=list.get(i).getCOMPANY_STATUS() %></td> 
						<td><%=list.get(i).getTAX_REGISTER_TYPE() %></td>
						<td><%=list.get(i).getTAX_BUREAU() %></td>
						<td><%=list.get(i).getSUB_TAX_BUREAU() %></td>	
						<td><%=list.get(i).getSOCIAL_SECURITY_ORGANIZATION() %></td>
						<td><%=list.get(i).getTAX_STREET() %></td>
						<td><%=list.get(i).getCOMPANY_TEL() %></td>
						<td><%=list.get(i).getCOMPANY_ADDRESS() %></td>
						<td><%=list.get(i).getTAX_TEL() %></td>
						<td><%=list.get(i).getTAX_REGISRER_FROM() %></td>
						<td><%=list.get(i).getTAX_REGISRER_ID() %></td>
						<td><%=list.get(i).getTAX_REGISRER_NAME()%></td>
    					<td><%=list.get(i).getTAX_PERSON_NAME()%></td>
    					<td><%=list.get(i).getTAX_PERSON_ID()%></td>
                       <td><%=list.get(i).getLEGAL_PERSON_TEL()%></td>
                       <td><%=list.get(i).getSOCIAL_MASTER_NAME()%></td>
                      <td><%=list.get(i).getSOCIAL_MASTER_TEL()%></td>
                      <td><%=list.get(i).getCOMPANY_TYPE()%></td>
                      <td><%=list.get(i).getSOCIAL_TYPE()%></td>
                     <td><%=list.get(i).getTAX_ADMIN()%></td>
                     <td><%=list.get(i).getREGISTER_NO()%></td> 
					<td><label data-toggle="modal" class="update_hover"><span onclick="getid('<%=list.get(i).getID() %>')">修改</span></label></td>
					</tr> 
					<% }}%>
				</tbody>
			</table>
		</div>
	</div>
	</div>	
	
	<!--弹出框-->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="margin-top:60px;">
	<!--startprint-->
		<div class="modal-content" style="width:800px;">
			<div class="modal-header modal_header_update">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				
				<h4 class="modal-title modal_title_font" id="myModalLabel">
					<span id="company_name_sub">修改企业基本信息</span>
				</h4>
			</div>
	
			<div class="modal-body">
			<input id="ID" type="hidden" />
			<input id="IF_MATCHED" type="hidden" />
			
				<div class="div_update">
					<div class="div_col_l">
						<label>人社单位编号：</label>
						<span><input id="SOCIAL_SECURITY_NO" readonly="readonly" style="background-color: #cccccc;" /></span>
					</div>
					<div class="div_col_r">
						<label>税务纳税人识别号：</label>
						<span><input id="TAX_NO" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>人社单位名称：</label>
						<span><input id="COMPANY_NAME" /></span>
					</div>
					<div class="div_col_r">
						<label>税务纳税人名称：</label>
						<span><input id="PAY_TAX_PEPOLE_NAME" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>人社参保单位状态：</label>
						<span><input id="COMPANY_STATUS" /></span>
					</div>
					<div class="div_col_r">
						<label>税务登记类型：</label>
						<span><input id="TAX_REGISTER_TYPE" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>主管税务局：</label>
						<span><input id="TAX_BUREAU" /></span>
					</div>
					<div class="div_col_r">
						<label>主管税务所科分局：</label>
						<span><input id="SUB_TAX_BUREAU" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>税务街道乡镇：</label>
						<span><input id="SOCIAL_SECURITY_ORGANIZATION" /></span>
					</div>
					<div class="div_col_r">
						<label>人社单位电话：</label>
						<span><input id="COMPANY_TEL" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>人社单位地址：</label>
						<span><input id="COMPANY_ADDRESS" /></span>
					</div>
					<div class="div_col_r">
						<label>税务联系方式：</label>
						<span><input id="TAX_TEL" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>税务生产经营地址：</label>
						<span><input id="TAX_PRODUCT_ADDRESS" /></span>
					</div>
					<div class="div_col_r">
						<label>税务登记来源：</label>
						<span><input id="TAX_REGISRER_FROM" /></span>
					</div>        
					
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>税务登记身份证号：</label>
						<span><input id="TAX_REGISRER_ID" /></span>
					</div>
					<div class="div_col_r">
						<label>税务登记姓名：</label>
						<span><input id="TAX_REGISRER_NAME" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>人社社保登记姓名：</label>
						<span><input id="TAX_PERSON_NAME" /></span>
					</div>
					<div class="div_col_r">
						<label>人社社保保登记身份证号：</label>
						<span><input id="TAX_PERSON_ID" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>人社法人联系方式：</label>
						<span><input id="LEGAL_PERSON_TEL" /></span>
					</div>
					<div class="div_col_r">
						<label>人社专管员姓名：</label>
						<span><input id="SOCIAL_MASTER_NAME" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>人社专管员联系方式：</label>
						<span><input id="SOCIAL_MASTER_TEL" /></span>
					</div>
					<div class="div_col_r">
						<label>人社单位类型：</label>
						<span><input id="COMPANY_TYPE" /></span>
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
						<label>登记序号：</label>
						<span><input id="REGISTER_NO" /></span>
					</div>
					
					<div class="clear"></div>
				</div>
			</div>
			<!--endprint-->
			<div class="modal-footer " style="text-align:center;">
				<button type="button" id="btn_dy" class="div_box_bon_two" onclick="doPrint()">
					<i class="iconfont pad_r6">&#xe617;</i>打印清单
				</button>								
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
			<div class="modal-footer">
				<button type="button" class="div_box_bon_two" data-dismiss="modal"><i class="iconfont pad_r6">&#xe6da;</i>取消</button>
				<button type="button" class="div_box_bon_two" id="submit"><i class="iconfont pad_r6">&#xe806;</i>确认</button>
			</div>
		</div>
	</div>
</div>
		<script type="text/javascript">
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
      	//获取到查询的条件
      	var TAX_PERSON_NAME=$("#name").val();
      	var TAX_PERSON_ID=$("#IDCare").val();
        var SOCIAL_SECURITY_NO = "<%=SOCIAL_SECURITY_NO%>";
		//刷新当前页
      	var url="<%=url%>?TAX_PERSON_NAME="+TAX_PERSON_NAME+"&TAX_PERSON_ID="+TAX_PERSON_ID+"&SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO;
       	window.location.href=url;      	
       });
		  //设置修改 
		  function getid(id) {
			//获取到ID 访问后台获取到数据
			$.ajax({
			url:"SocialPersonMessage.action?ID="+id, 
			dataType:"json", 
			type:"post",
			success:function (jsonStr) 
			{       
			json =jsonStr;	
	       	  //绑定数据到表单
				var ID =json.ID;//ID
			    var SOCIAL_SECURITY_NO=json.SOCIAL_SECURITY_NO;//人社单位编号
			    var TAX_NO =json.TAX_NO;//税务纳税人识别号
			    var COMPANY_NAME =json.COMPANY_NAME;//人社单位名称
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
	       		 $("#ID").val(ID);
	       		 $("#company_name").html(+"基本信息");
	       		 $("#company_name_sub").html("修改"+SOCIAL_TYPE+"信息修改");
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
	       	   
			}, 
			error:function (error) {
				
			}
		}); 
		 $("#myModal").modal('show');
			// 获取到数据
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
	       		// $("#myModal").modal('hide');
	       		
	       		 $("#status").val(1);
	       		 HuiFang.Funtishi("修改成功！"); 
	       		
	       		}else{
	       		 $("#confirm").modal('hide');	
	       			
	       		}
			}, 
			error:function (error) {
				
			}
		});
		
		 		
	 });
	 });	
	 var HuiFang={
		  m_tishi :null,

		  
		      Funtishi: function (content, url) {
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
	/* 	(function(window, document, undefined) {
				"use strict";
				var gridColSortTypes = ["string", "number", "number", "number", "number", "number", "number", "number", "number", "number", "number", "number", "number", "string", "string", "string","string", "number", "number", "number", "number", "number", "number", "number", "number", "string"], 
				    gridColAlign = [];
				
				var onColumnSort = function(newIndexOrder, columnIndex, lastColumnIndex) {
					var offset = (this.options.allowSelections && this.options.showSelectionColumn) ? 1 : 0, 
					    doc = document;
					
					if (columnIndex !== lastColumnIndex) {
						if (lastColumnIndex > -1) {
							doc.getElementById("demoHdr" + (lastColumnIndex - offset)).parentNode.style.backgroundColor = "";
						}
						doc.getElementById("demoHdr" + (columnIndex - offset)).parentNode.style.backgroundColor = "#f7f7f7";
					}
				};
				
				var onResizeGrid = function(newWidth, newHeight) {
					var demoDivStyle = document.getElementById("demoDiv").style;
					demoDivStyle.width = newWidth + "px";
					demoDivStyle.height = newHeight + "px";
				};
				
				for (var i=0, col; col=gridColSortTypes[i]; i++) {
					gridColAlign[i] = (col === "number") ? "right" : "left";
				}
				
				var myGrid = new Grid("demoGrid", {
				    	srcType : "dom", 
				    	srcData : "demoTable", 
				    	allowGridResize : true, 
				    	allowColumnResize : true, 
				    	allowClientSideSorting : true, 
				    	allowSelections : true, 
				    	allowMultipleSelections : true, 
				    	showSelectionColumn :false, 
				    	onColumnSort : onColumnSort, 
				    	onResizeGrid : onResizeGrid, 
				    	colAlign : gridColAlign, 
				    	colBGColors : ["#fafafa"], 
				    	colSortTypes : gridColSortTypes, 
				    	fixedCols : 1
				    });
				     
})(this, this.document);   */ 


		</script>
	</body>
</html>
