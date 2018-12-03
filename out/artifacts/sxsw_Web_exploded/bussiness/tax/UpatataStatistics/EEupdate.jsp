<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>保险列表</title>
     <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
    <script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script> 
    <script type="text/javascript">
     jQuery(function($){
     GridExe();
   	$("#searchBtn").click(function(){
     // 点击查询获取到编号值和名称值
    var SOCIAL_SECURITY_NO =$("#SOCIAL_SECURITY_NO").val();
    var COMPANY_NAME  =$("#COMPANY_NAME").val();
    var	url="CompanyTaxMessageList.action?type=1&SOCIAL_SECURITY_NO="+SOCIAL_SECURITY_NO+"&COMPANY_NAME="+COMPANY_NAME;
		 $.ajax({
		url:url, 
		async:false,
		dataType:"json", 
		type:"post",
		success:function (data) {
		// 重新加载表格数据
		 $("#maingrid").ligerGrid('reload',data);
		}
		});
	});
 });
 
 	// 设置表格
   function GridExe(){
   // 获取到表格的位置   liger 
      $("#maingrid").ligerGrid({
        checkbox: false,   
        rowHeight:22,
        url:"CompanyTaxMessageList.action?IF_MODIFY=1", //查询企业已修改的数据
      	pageSize:50,
		pageSizeOptions:[50,100,150,200],
		root:"listmodal",
		record:"record",
		rownumbers :true,
		enabledSort :false,
		height:"100%",
		heightDiff:-8,
		title:"社保信息列表",
        columns: [
			{ display: '人社单位编号', name: 'SOCIAL_SECURITY_NO',width:180},
			{ display: '税务纳税人识别号', name: 'TAX_NO',width:180},
			{ display: '人社单位名称', name: 'COMPANY_NAME' ,width:180},
			{ display: '税务纳税人名称', name: 'PAY_TAX_PEPOLE_NAME' ,width:180},
			{ display: '人社参保单位状态', name: 'COMPANY_STATUS',width:180 },
			{ display: '税务登记类型', name: 'TAX_TYPE' ,width:180},
			{ display: '税务纳税人状态', name: 'PAY_TAX_PEPOLE_STATUS' ,width:180},
			{ display: '主管税务局', name: 'TAX_BUREAU' ,width:180},
			{ display: '主管税务所科分局', name: 'SUB_TAX_BUREAU',width:180 },			
			{ display: '人社经办机构', name: 'SOCIAL_SECURITY_ORGANIZATION',width:180 },		
			{ display: '税务行政区划', name: 'TAX_AREA' ,width:180},
			{ display: '税务街道乡镇', name: 'TAX_STREET',width:180 },
			{ display: '人社单位电话', name: 'COMPANY_TEL' ,width:180},
			{ display: '人社单位地址', name: 'COMPANY_ADDRESS' ,width:180},
			{ display: '税务联系方式', name: 'TAX_TEL' ,width:180},
			{ display: '税务生产经营地址', name: 'TAX_PRODUCT_ADDRESS',width:180 },
			{ display: '人社工商营业执照号码', name: 'SOCIAL_BUSINESS_NO',width:180 },
			{ display: '人社组织机构代码', name: 'SOCIAL_ORGRNIZATION_NO',width:180 },
			{ display: '税务组织机构', name: 'TAX_ORGANIZATION' ,width:180},
			{ display: '人社法人姓名', name: 'LEGAL_PERSON_NAME' ,width:180},
			{ display: '人社法人身份证号', name: 'LEGAL_PERSON_ID' ,width:180},
			{ display: '人社法人联系方式', name: 'LEGAL_PERSON_TEL' ,width:180},
			{ display: '税务法定代表人姓名', name: 'TAX_LEGAL_PERSON_NAME',width:180 },
			{ display: '人社专管员姓名', name: 'SOCIAL_MASTER_NAME',width:180 },
			{ display: '人社专管员联系方式', name: 'SOCIAL_MASTER_TEL' ,width:180},
			{ display: '人社单位类型', name: 'COMPANY_TYPE' ,width:180},
			{ display: '人社缴费方式', name: 'SOCIAL_PAY_TYPE' ,width:180},
			{ display: '税收管理员', name: 'TAX_ADMIN',width:180 },
			{ display: '登记序号', name: 'REGISTER_NO' ,width:180},
		],
      }); 
   }
    </script>
</head>
<body>  
<div>
<div id="toolbar" class="searchDiv">
		<form id="serchform" method="post">
			<table>
				<tr>
				<td class="ser_tit">
					<label>人社编号:</label>
				</td>
				<td class="ser_cont">
					<input id="SOCIAL_SECURITY_NO" type="text" value=""/>
				</td>
				<td class="ser_tit">
					<label>人社单位名称:</label>
				</td>
				<td class="ser_cont">
					<input id="COMPANY_NAME" type="text" value=""/>
				</td>
					<td class="ser_cont"><input type="button" id="searchBtn" value="查询" class="btn"/></td>
				</tr>
			</table>
		</form>
</div>
</div>
<!-- 已匹配数据 -->
 <div id="maingrid"></div>

</body>

</html>
