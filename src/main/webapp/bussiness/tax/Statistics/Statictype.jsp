<%@ page language="java" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String SOCIAL_SECURITY_NO= request.getParameter("SOCIAL_SECURITY_NO");		
	String IF_MATCHED=request.getParameter("IF_MATCHED");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<%--      <script src="<%=basePath  %>bussiness/tax/Statistics/Statictype.js" type="text/javascript"></script>
 --%>
<script type="text/javascript">
	
</script>

</head>
<body>
	<div position="center">
		<div id="tab1"
			style="width：100%;height:100%;overflow:hidden; border:1px solid #A3C0E8; "
			class="liger-tab">
			<div title="养老保险" tabid="ylTab" style="width：100%">
				<div id="ylTab"></div>
			</div>
			<div title="工伤保险" tabid="gsTab" style="width：100%">
				<div id="gsTab"></div>
			</div>
			<div title="失业保险" tabid="syTab" style="width：20%">
				<div id="syTab"></div>
			</div>
			<div title="医疗保险" tabid="yTab" style="width：20%">
				<div id="yTab"></div>
			</div>
			<div title="生育保险" tabid="sTab" id="sTab" style="width：20%">
				<div id="sTab"></div>

			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			ylTab();
			//获取养老标签 并给表格赋值 
			function ylTab() {
				$("#ylTab").ligerGrid({
					checkbox : false,
					rowHeight : 23,
					height : '100%',
					heightDiff : -8,
					//获取到社保编号      //设置查询类型
					url : "socialPersonMessageQueryList.action?SOCIAL_TYPE_ID=1&SOCIAL_SECURITY_NO="+<%=SOCIAL_SECURITY_NO%>+"&IF_MATCHED="+<%=IF_MATCHED%>,
					columns : [ {
						display : '人社单位编号',
						name : 'SOCIAL_SECURITY_NO',
						minWidth : 30,
						width : "7%"
					}, {
						display : '税务纳税人识别号',
						name : 'TAX_NO',
						width : "10%",
						minWidth : 30,
						isSort : true
					}, {
						display : '人社单位名称',
						name : 'COMPANY_NAME',
						width : "15%",
						isSort : true
					}, {
						display : '税务纳税人名称',
						name : 'PAY_TAX_PEPOLE_NAME',
						width : "15%",
						isSort : true
					}, {
						display : '人社参保单位状态',
						name : 'COMPANY_STATUS',
						width : "10%",
						isSort : true
					}, {
						display : '税务登记类型',
						name : 'TAX_REGISTER_TYPE',
						width : "10%",
						isSort : true
					}, {
						display : '主管税务局',
						name : 'TAX_BUREAU',
						width : "15%",
						isSort : true
					}, {
						display : '主管税务所科分局',
						name : 'SUB_TAX_BUREAU',
						width : "15%",
						isSort : true
					}, {
						display : '人社经办机构',
						name : 'SOCIAL_SECURITY_ORGANIZATION',
						width : "10%",
						isSort : true
					}, {
						display : '税务街道乡镇',
						name : 'TAX_STREET',
						width : "15%",
						isSort : true
					}, {
						display : '人社单位电话',
						name : 'COMPANY_TEL',
						width : "10%",
						isSort : true
					}

					],
					pageSize : 50,
					pageSizeOptions : [ 50, 100, 150, 200 ],
					root : "listmodal",
					record : "record",
					rownumbers : true,
					usePager : true
				});
			}
			function gsTab() {
				$("#gsTab").ligerGrid({
					checkbox : false,
					rowHeight : 23,
					height : '100%',
					heightDiff : -8,
					//获取到社保编号      //设置查询类型
					url : "socialPersonMessageQueryList.action?SOCIAL_TYPE_ID=2&SOCIAL_SECURITY_NO="+<%=SOCIAL_SECURITY_NO%>+"&IF_MATCHED="+<%=IF_MATCHED%>,
					columns : [ {
						display : '人社单位编号',
						name : 'SOCIAL_SECURITY_NO',
						minWidth : 30,
						width : "5%"
					}, {
						display : '税务纳税人识别号',
						name : 'TAX_NO',
						width : "10%",
						minWidth : 30,
						isSort : true
					}, {
						display : '人社单位名称',
						name : 'COMPANY_NAME',
						width : "16%",
						isSort : true
					}, {
						display : '税务纳税人名称',
						name : 'PAY_TAX_PEPOLE_NAME',
						width : "15%",
						isSort : true
					}, {
						display : '人社参保单位状态',
						name : 'COMPANY_STATUS',
						width : "7%",
						isSort : true
					}, {
						display : '税务登记类型',
						name : 'TAX_REGISTER_TYPE',
						width : "10%",
						isSort : true
					}, {
						display : '主管税务局',
						name : 'TAX_BUREAU',
						width : "15%",
						isSort : true
					}, {
						display : '主管税务所科分局',
						name : 'SUB_TAX_BUREAU',
						width : "15%",
						isSort : true
					}, {
						display : '人社经办机构',
						name : 'SOCIAL_SECURITY_ORGANIZATION',
						width : "10%",
						isSort : true
					}, {
						display : '税务街道乡镇',
						name : 'TAX_STREET',
						width : "15%",
						isSort : true
					}, {
						display : '人社单位电话',
						name : 'COMPANY_TEL',
						width : "10%",
						isSort : true
					}, {
						display : '人社单位地址',
						name : 'COMPANY_ADDRESS',
						width : "15%",
						isSort : true
					}, {
						display : '税务联系方式',
						name : 'TAX_TEL',
						width : "7%",
						isSort : true
					}, {
						display : '税务生产经营地址',
						name : 'TAX_PRODUCT_ADDRESS',
						width : "15%",
						isSort : true
					} ],
					pageSize : 50,
					pageSizeOptions : [ 50, 100, 150, 200 ],
					root : "listmodal",
					record : "record",
					rownumbers : true,
					usePager : true
				});
			}
			function syTab() {
				$("#syTab").ligerGrid({
					checkbox : false,
					rowHeight : 23,
					height : '100%',
					heightDiff : -8,
					//获取到社保编号      //设置查询类型
					url : "socialPersonMessageQueryList.action?SOCIAL_TYPE_ID=3&SOCIAL_SECURITY_NO="+<%=SOCIAL_SECURITY_NO%>+"&IF_MATCHED="+<%=IF_MATCHED%>,
					columns : [ {
						display : '人社单位编号',
						name : 'SOCIAL_SECURITY_NO',
						minWidth : 30,
						width : "5%"
					}, {
						display : '税务纳税人识别号',
						name : 'TAX_NO',
						width : "10%",
						minWidth : 30,
						isSort : true
					}, {
						display : '人社单位名称',
						name : 'COMPANY_NAME',
						width : "15%",
						isSort : true
					}, {
						display : '税务纳税人名称',
						name : 'PAY_TAX_PEPOLE_NAME',
						width : "15%",
						isSort : true
					}, {
						display : '人社参保单位状态',
						name : 'COMPANY_STATUS',
						width : "7%",
						isSort : true
					}, {
						display : '税务登记类型',
						name : 'TAX_REGISTER_TYPE',
						width : "10%",
						isSort : true
					}, {
						display : '主管税务局',
						name : 'TAX_BUREAU',
						width : "15%",
						isSort : true
					}, {
						display : '主管税务所科分局',
						name : 'SUB_TAX_BUREAU',
						width : "15%",
						isSort : true
					}, {
						display : '人社经办机构',
						name : 'SOCIAL_SECURITY_ORGANIZATION',
						width : "10%",
						isSort : true
					}, {
						display : '税务街道乡镇',
						name : 'TAX_STREET',
						width : "15%",
						isSort : true
					}, {
						display : '人社单位电话',
						name : 'COMPANY_TEL',
						width : "10%",
						isSort : true
					}, {
						display : '人社单位地址',
						name : 'COMPANY_ADDRESS',
						width : "15%",
						isSort : true
					}, {
						display : '税务联系方式',
						name : 'TAX_TEL',
						width : "7%",
						isSort : true
					}, {
						display : '税务生产经营地址',
						name : 'TAX_PRODUCT_ADDRESS',
						width : "15%",
						isSort : true
					}, {
						display : '人社法人联系方式',
						name : 'LEGAL_PERSON_TEL',
						width : "7%",
						isSort : true
					}, {
						display : '人社专管员姓名',
						name : 'SOCIAL_MASTER_NAME',
						width : "5%",
						isSort : true
					}, {
						display : '人社专管员联系方式',
						name : 'SOCIAL_MASTER_TEL',
						width : "7%",
						isSort : true
					}, {
						display : '人社单位类型',
						name : 'COMPANY_TYPE',
						width : "10%",
						isSort : true
					}, {
						display : '税收管理员',
						name : 'TAX_ADMIN',
						width : "5%",
						isSort : true
					}, {
						display : '登记序号',
						name : 'REGISTER_NO',
						width : "10%",
						isSort : true
					}, {
						display : '人社社保登记姓名',
						name : 'TAX_PERSON_NAME',
						width : "6%",
						isSort : true
					}, {
						display : '人社医保登记身份证号',
						name : 'TAX_PERSON_ID',
						width : "10%",
						isSort : true
					}, {
						display : '税务登记姓名',
						name : 'TAX_REGISRER_NAME',
						width : "5%",
						isSort : true
					}, {
						display : '税务登记身份证号',
						name : 'TAX_REGISRER_ID',
						width : "10%",
						isSort : true
					}, {
						display : '税务登记来源',
						name : 'TAX_REGISRER_FROM',
						width : "5%",
						isSort : true
					}, {
						display : '险种',
						name : 'SOCIAL_TYPE',
						width : "7%",
						isSort : true
					} ],
					pageSize : 50,
					pageSizeOptions : [ 50, 100, 150, 200 ],
					root : "listmodal",
					record : "record",
					rownumbers : true,
					usePager : true
				});
			}
			function sTab() {
				$("#sTab").ligerGrid({
					checkbox : false,
					rowHeight : 23,
					height : '100%',
					heightDiff : -8,
					//获取到社保编号      //设置查询类型
					url : "socialPersonMessageQueryList.action?SOCIAL_TYPE_ID=4&SOCIAL_SECURITY_NO="+<%=SOCIAL_SECURITY_NO%>+"&IF_MATCHED="+<%=IF_MATCHED%>,
					columns : [ {
						display : '人社单位编号',
						name : 'SOCIAL_SECURITY_NO',
						minWidth : 30,
						width : "5%"
					}, {
						display : '税务纳税人识别号',
						name : 'TAX_NO',
						width : "10%",
						minWidth : 30,
						isSort : true
					}, {
						display : '人社单位名称',
						name : 'COMPANY_NAME',
						width : "15%",
						isSort : true
					}, {
						display : '税务纳税人名称',
						name : 'PAY_TAX_PEPOLE_NAME',
						width : "15%",
						isSort : true
					}, {
						display : '人社参保单位状态',
						name : 'COMPANY_STATUS',
						width : "7%",
						isSort : true
					}, {
						display : '税务登记类型',
						name : 'TAX_REGISTER_TYPE',
						width : "10%",
						isSort : true
					}, {
						display : '主管税务局',
						name : 'TAX_BUREAU',
						width : "15%",
						isSort : true
					}, {
						display : '主管税务所科分局',
						name : 'SUB_TAX_BUREAU',
						width : "15%",
						isSort : true
					}, {
						display : '人社经办机构',
						name : 'SOCIAL_SECURITY_ORGANIZATION',
						width : "10%",
						isSort : true
					}, {
						display : '税务街道乡镇',
						name : 'TAX_STREET',
						width : "15%",
						isSort : true
					}, {
						display : '险种',
						name : 'SOCIAL_TYPE',
						width : "7%",
						isSort : true
					} ],
					pageSize : 50,
					pageSizeOptions : [ 50, 100, 150, 200 ],
					root : "listmodal",
					record : "record",
					rownumbers : true,
					usePager : true
				});
			}
			function yTab() {
				$("#yTab").ligerGrid({
					checkbox : false,
					rowHeight : 23,
					height : '100%',
					heightDiff : -8,
					//获取到社保编号      //设置查询类型
					url : "socialPersonMessageQueryList.action?SOCIAL_TYPE_ID=5&SOCIAL_SECURITY_NO="+<%=SOCIAL_SECURITY_NO%>+"&IF_MATCHED="+<%=IF_MATCHED%>,
					columns : [ {
						display : '人社单位编号',
						name : 'SOCIAL_SECURITY_NO',
						minWidth : 30,
						width : "5%"
					}, {
						display : '税务纳税人识别号',
						name : 'TAX_NO',
						width : "10%",
						minWidth : 30,
						isSort : true
					}, {
						display : '人社单位名称',
						name : 'COMPANY_NAME',
						width : "15%",
						isSort : true
					}, {
						display : '税务纳税人名称',
						name : 'PAY_TAX_PEPOLE_NAME',
						width : "15%",
						isSort : true
					}, {
						display : '人社参保单位状态',
						name : 'COMPANY_STATUS',
						width : "7%",
						isSort : true
					}, {
						display : '税务登记类型',
						name : 'TAX_REGISTER_TYPE',
						width : "10%",
						isSort : true
					} ],
					
					pageSize : 50,
					pageSizeOptions : [ 50, 100, 150, 200 ],
					root : "listmodal",
					record : "record",
					rownumbers : true,
					usePager : true
				});
			}
			$("#tab1").ligerTab( {onAfterSelectTabItem:function(tabid){
			if (tabid == "ylTab") {
				ylTab();
				}
				;
				if (tabid == "gsTab") {
				gsTab();
				}
				if (tabid == "syTab") {
				syTab();
				}
				if (tabid == "yTab") {
				yTab();
				}
				if (tabid == "sTab") {
				sTab();
				}
			
			}} );
		});
	</script>
</body>

</html>
