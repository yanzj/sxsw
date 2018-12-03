<%@page import="java.io.PrintWriter"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String SOCIAL_SECURITY_NO = request.getParameter("SOCIAL_SECURITY_NO");
String session_id=request.getSession().getAttribute("SOCIAL_SECURITY_NO").toString();
 
%>

<!DOCTYPE HTML >
<html>
<head>
<title>企业基本信息</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/bootstrap3.3.7/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>include/iconfont/iconfont.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/taxmess.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/demo.css"/>
<link rel="stylesheet" type="text/css" href="<%=basePath %>css/zTreeStyle.css"/>
<link href="<%=basePath%>images/title.png" rel="SHORTCUT ICON">
<script type="text/javascript" src="<%=basePath  %>include/jQuery/jquery-1.9.1.js"></script>
<script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script>
<script type="text/javascript" src="<%=basePath  %>include/iconfont/iconfont.js"></script>
<script type="text/javascript" src="<%=basePath  %>include/bootstrap3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath  %>js/dateformat.js"></script>
<script src="<%=basePath  %>js/jquery.ztree.core.min.js" type="text/javascript"></script>
<script type="text/javascript" src="./TaxMess.js"></script>
</head>

<!-- 打印的样式-->
 <style media="print">
  @page {
   size: auto;
   margin: 20mm;
  }
 </style>
<script type="text/javascript">
<%-- if("<%=SOCIAL_SECURITY_NO%>"!="<%=session_id%>"){
window.location.href='<%=basePath%>Index';	
} --%>
 function doPrint() {      
       bdhtml=window.document.body.innerHTML;      
        sprnstr="<!--startprint-->";      
        eprnstr="<!--endprint-->";      
        prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17);      
        prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));   
        window.document.body.innerHTML=prnhtml;   
        window.print();  
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
 

</script>
<body>
<!--startprint-->
	<div class="div_box">
		<h2><span id="company_name">企业基本信息</span></h2>
		<div class="div_m">
			<div>
				<div class="div_l">
					<i></i>				
					<label>人社登记单位名称：</label>
					<span id="COMPANY_NAME_EDIT"></span>
				</div>
				<div class="div_r">
					<i></i>
					<label>税务登记序号：</label>
					<span id="REGISTER_NO_EDIT"></span>
				</div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="div_l">
					<i></i>				
					<input id="COMPANY_TEL" type="hidden" >
					<label>人社登记经办机构：</label>
					<span id="SOCIAL_SECURITY_ORGANIZATION_EDIT"></span>
				</div>
				<div class="div_r">
					<i></i>
					<label>税务纳税人名称：</label>
					<span id="PAY_TAX_PEPOLE_NAME_EDIT"></span>					
				</div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="div_l">
					<i></i>			
					<label>人社登记单位地址：</label>
					<span id="COMPANY_ADDRESS_EDIT"></span>
				</div>
				<div class="div_r">
				    <i></i>
				    <label>税务纳税人识别号：</label>
					<span id="TAX_NO_EDIT"></span>					
				</div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="div_l">
					<i></i>
					<label>人社登记法人姓名：</label>
					<span id="LEGAL_PERSON_NAME_EDIT"></span>
					<input id="LEGAL_PERSON_TEL" type="hidden">
				</div>
				<div class="div_r">
					<i></i>
					<!--<label>人社法人身份证号：</label>-->
					<input id="LEGAL_PERSON_ID" type="hidden">
					<label>税务纳税人状态：</label>
					<span id="PAY_TAX_PEPOLE_STATUS_EDIT"></span>
				</div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="div_l">
					<i></i>
					<input id="SOCIAL_MASTER_TEL" type="hidden">
					<label>人社登记组织机构代码：</label>
					<span id="SOCIAL_ORGRNIZATION_NO_EDIT"></span>
				</div>
				<div class="div_r">
					<i></i>
					<label>主管税务局：</label>
					<span id="TAX_BUREAU_EDIT"></span>
					<!--<label>人社专管员姓名：</label>-->	
					<input id="SOCIAL_MASTER_NAME" type="hidden">				
				</div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="div_l">
					<i></i>
					<label>人社登记单位类型：</label>
					<span id="COMPANY_TYPE_EDIT"></span>
					<!--<label>人社缴费方式：</label>-->
					<input id="SOCIAL_PAY_TYPE" type="hidden">
				</div>
				<div class="div_r">
					<i></i>
					<label>主管税务所科分局：</label>
					<span id="SUB_TAX_BUREAU_EDIT"></span>
				</div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="div_l">
					<i></i>
					<label>人社登记经办人：</label>
					<span id="SOCIAL_AGENT_EDIT"></span>
				</div>
				<div class="div_r">
					<i></i>
					<label>税务行政区划：</label>
					<span id="TAX_AREA_EDIT"></span>
					
				</div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="div_l">
					<i></i>
					<label>人社登记经办人联系电话：</label>
					<span id="SOCIAL_AGENT_TEL_EDIT"></span>
				</div>
				<div class="div_r">
					<i></i>
					<label>税务联系方式：</label>
					<span id="TAX_TEL_EDIT"></span>
				</div>
				<div class="clear"></div>
			</div>
			<!-- <div>
				<div class="div_l">

					<i></i>
					<label>是否为城乡居民虚拟户：</label>
					<span id="REGISTERED_RESIDENCE_EDIT"></span>
				</div>
				<div class="div_r">
					<i></i>
					<label>税务组织机构代码：</label>
					<span id="TAX_ORGANIZATION_EDIT"></span>
				</div>
				<div class="clear"></div>
			</div> -->
				<div>
				<div class="div_l">
					<!-- <i></i>
					<label>人社登记工商营业执照号码：</label>
					<span id="SOCIAL_BUSINESS_NO_EDIT"></span>	 -->	
					<label>是否为城乡居民虚拟户：</label>
					<span id="REGISTERED_RESIDENCE_EDIT"></span>		
				</div>
				<div class="div_r">
					<i></i>
					<label>税务登记类型：</label>
					<span id="TAX_TYPE_EDIT"></span>	
				</div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="div_l">
				</div>
				<div class="div_r">
					<i></i>
					<label>税务街道乡镇：</label>
					<span id="TAX_STREET_EDIT"></span>
				</div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="div_l">					
				</div>
				<div class="div_r">
					<i></i>
					<label>税务法定代表人姓名：</label>
					<span id="TAX_LEGAL_PERSON_NAME_EDIT"></span>
				</div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="div_l">				
				</div>
				<div class="div_r">
					<i></i>
					<label>税务生产经营地址：</label>
					<span id="TAX_PRODUCT_ADDRESS_EDIT"></span>
				</div>
				<div class="clear"></div>
			</div>
			
		</div>
		<!--endprint-->  
		<div class="div_box_bon">
			<button type="button"  onclick="javascript:window.location.href='<%=basePath %>Index'" class="div_box_bon_one">
				<i class="iconfont pad_r6">&#xe614;</i>返回首页
			</button>
			<button class="div_box_bon_one" data-toggle="modal" data-target="#myModal">
				<i class="iconfont pad_r6">&#xe606;</i>&nbsp;&nbsp;&nbsp;修&nbsp;&nbsp;改&nbsp;&nbsp;&nbsp;
			</button>
			<button class="div_box_bon_one" id="Detbtn">
				<i class="iconfont pad_r6"">&#xe606;</i>
				查看明细
			</button>
			<button class="div_box_bon_one"   onclick="toPrint()">
				<i class="iconfont pad_r6"">&#xe605;</i>
				填写各险种关联信息
			</button>
		</div>
		
<!--修改 弹出框-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false">
	<div class="modal-dialog" style="margin-top:60px;">
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
						<!--<label>人社单位编号：</label>-->
						<input id="SOCIAL_SECURITY_NO" type="hidden" />
						<label>登记单位名称：</label>
						<span><input id="COMPANY_NAME" /></span>
					</div>
					<div class="div_col_r">
						<label>登记序号：</label>
						<span><input id="REGISTER_NO" /></span>
						<i>*</i>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						
						<input id="COMPANY_STATUS"  type="hidden"/>
						<label>登记经办机构：</label>
						<span class="div-add-span">
							<input id="SOCIAL_SECURITY_ORGANIZATION_TEXT" placeholder="请点击选择经办机构" class="onclick"/>
							<input id="SOCIAL_SECURITY_ORGANIZATION"  type="hidden" />
							<div  id="tree"  class="zTreeDemoBackground left tree">
								<ul id="treeDemo" class="ztree"></ul>

							</div>
						</span>
					</div>
					<div class="div_col_r">
						<label>登记类型：</label>
						<span><input id="TAX_TYPE" /></span>						
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>登记单位地址：</label>
						<span><input id="COMPANY_ADDRESS" /></span>
					</div>
					<div class="div_col_r">
						<label>主管税务局：</label>
						<span><input id="TAX_BUREAU" /></span>						
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>登记法人姓名：</label>
						<span><input id="LEGAL_PERSON_NAME" /></span>				
					</div>
					<div class="div_col_r">
						<label>纳税人名称：</label>
						<span><input id="PAY_TAX_PEPOLE_NAME" /></span>
						<i>*</i>
						<!--<label>人社法人身份证号：</label>
						<span><input id="LEGAL_PERSON_ID" /></span>-->
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>登记单位类型：</label>
						<span><input id="COMPANY_TYPE" /></span>
						<!--<label>人社法人联系方式：</label>
						<span><input id="LEGAL_PERSON_TEL" /></span>-->
					</div>
					<div class="div_col_r">
						<label>纳税人状态：</label>
						<span><input id="PAY_TAX_PEPOLE_STATUS" /></span>
						<!--<label>人社专管员姓名：</label>
						<span><input id="SOCIAL_MASTER_NAME" /></span>-->
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>登记组织机构代码：</label>
						<span><input id="SOCIAL_ORGRNIZATION_NO" /></span>
						<!--<label>人社专管员联系方式：</label>
						<span><input id="SOCIAL_MASTER_TEL" /></span>-->
					</div>
					<div class="div_col_r">
						<label>纳税人识别号：</label>
						<span><input id="TAX_NO" /></span>
						<i>*</i>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>登记经办人：</label>
						<span><input id="SOCIAL_AGENT"/></span>
						<i>*</i>
					</div>
					<div class="div_col_r">
						<label>行政区划：</label>
						<span><input id="TAX_AREA" /></span>
						<!--<label>人社缴费方式：</label>
						<span><input id="SOCIAL_PAY_TYPE" /></span>-->
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
						<label>登记经办人联系电话：</label>
						<span><input id="SOCIAL_AGENT_TEL" /></span>
						<i>*</i>
					</div>
					<div class="div_col_r">
						<label>联系方式：</label>
						<span><input id="TAX_TEL" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<!-- <div class="div_update">
				<input type="hidden" id="UNIT_PROPERTIES"> 
					<div class="div_col_l">
						<label>单位性质：</label>
						<span>
							<select class="select-op" id="UNIT_PROPERTIES">
								<option value="">请选择企业性质</option>
								<option value="机关事业">机关事业</option>
								<option value="企业">企业</option>
								<option value="社会团体">社会团体</option>
								<option value="民办非企业单位">民办非企业单位</option>
								<option value="个体工商户">个体工商户</option>
								<option value="其他">个体工商户</option>
							</select>						
						</span>		
					</div>
					<div class="div_col_r">
						<label>组织机构代码：</label>
						<span><input id="TAX_ORGANIZATION" /></span>
					</div>
					<div class="clear"></div>
				</div> -->
				<div class="div_update">
					<div class="div_col_l">
						<label>是否为城乡居民虚拟户：</label>
						<input onclick="on_select(this)" id="yes"  type="radio" value="1" name="select" checked="checked"/>&nbsp;是&nbsp;&nbsp;&nbsp;
						<input onclick="on_select(this)" id="no"  type="radio" value="0" name="select" />&nbsp;否		
					</div>
					<div class="div_col_r">
						<label>街道乡镇：</label>
						<span><input id="TAX_STREET" /></span>
					</div>
					<div class="clear"></div>
				</div>
				
				<div class="div_update">
					<div class="div_col_l">
						<!-- <label>登记工商营业执照号码：</label>
						<span><input id="SOCIAL_BUSINESS_NO" /></span> -->
					</div>
					<div class="div_col_r">
						<label>主管税务所科分局：</label>
						<span><input id="SUB_TAX_BUREAU" /></span>
						<!--<label>人社单位电话：</label>
						<span><input id="COMPANY_TEL" /></span>-->
					</div> 					
					<div class="clear"></div>
				</div>
				<input id="TAX_ADMIN" type="hidden"/>
				<!--<div class="div_update">
					<div class="div_col_l">
						
					</div>
					<div class="div_col_r">
						<label>管理员：</label>
						<span></span>
					</div>
					<div class="clear"></div>
				</div>-->
				<div class="div_update">
					<div class="div_col_l">
										
					</div>
					<div class="div_col_r">
						<label>法定代表人姓名：</label>
						<span><input id="TAX_LEGAL_PERSON_NAME" /></span>
					</div>
					<div class="clear"></div>
				</div>
				<div class="div_update">
					<div class="div_col_l">
										
					</div>
					<div class="div_col_r">
						<label>生产经营地址：</label>
						<span><input id="TAX_PRODUCT_ADDRESS" /></span>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			<div class="modal-footer " style="text-align:center;">
				<!--<button type="button" id="btn_dy" class="div_box_bon_one" onclick="toPrint()">
					<i class="iconfont pad_r6">&#xe617;</i>打印清单
				</button>	-->							
				<button type="button" id="btn" class="div_box_bon_one">
					<i class="iconfont pad_r6">&#xe61b;</i>提交更改
				</button>
				<button type="button" class="div_box_bon_one" data-dismiss="modal"><i class="iconfont pad_r6">&#xe6da;</i>关&nbsp;&nbsp;闭&nbsp;&nbsp;&nbsp;
				</button>
			</div>
		</div>
	</div>
</div>
	</div>
	<input type="hidden" id="ID">
	<input type="hidden" id="IF_MODIFY">
	<input type="hidden" id="IF_MATCHED">
	<input type="hidden" id="status">
	<input type="hidden" id="TYPE">
	<input type="hidden" id="AREA">
	<input type="hidden" id="REGISTERED_RESIDENCE">
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
				<button type="button" class="div_box_bon_one" data-dismiss="modal"><i class="iconfont pad_r6">&#xe6da;</i>取消</button>
				<button type="button" id="submit" class="div_box_bon_one"><i class="iconfont pad_r6">&#xe806;</i>确认</button>
			</div>
		</div>
	</div>
</div>


</body>

</html>
