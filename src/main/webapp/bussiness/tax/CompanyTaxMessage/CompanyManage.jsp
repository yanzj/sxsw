<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>保险列表</title>
     <link   rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
    <script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script> 
    <script  type="text/javascript"  src="./CompanyManage.js"></script> 
     <script type="text/javascript">
     
    jQuery(function($){
    
    	   $("#tree").ligerTree({
    			url: "corpSelectedQuery.action",
    			onSelect: onSelect,
    			idFieldName: 'id',
    			parentIDFieldName: 'pid',
    			checkbox: false,
    			itemopen: false
    		});
    		
    	    $("#AREA_ID").click(function(){
    	    	$("#treediv").show();
    	 
    	    })
    
    
	$("#SOCIAL_TYPE_ID").ligerComboBox({
		width : 280,
		url:"taxPostSelectedQuery.action",
		onSelected: function (id){
			$("#SOCIAL_TYPE_ID_VALUE").val(id);		
		}
		});
    
    
    
   $("#serchform").ligerForm();
   $("#searchBtn").click(function(){
     // 点击查询获取到编号值和名称值
    var SOCIAL_SECURITY_NO =$("#SOCIAL_SECURITY_NO").val();
    var COMPANY_NAME  =$("#COMPANY_NAME").val();
    var AREA_ID=$("#AREA_ID_VALUE").val();	
    var SOCIAL_TYPE_ID=$("#SOCIAL_TYPE_ID_VALUE").val();
    g.setOptions({newPage:1});
		g.setOptions({
			parms: [
				{ name: 'SOCIAL_SECURITY_NO', value: SOCIAL_SECURITY_NO },
				{ name: 'COMPANY_NAME', value: COMPANY_NAME },
			    { name: 'SOCIAL_TYPE_ID', value: SOCIAL_TYPE_ID },
				{ name: 'AREA_ID', value: AREA_ID } 
				
			]
		});
		g.loadData();
	});
	
   // 点击清空  
   	$("#clearBtn").click(function(){
		 $("#SOCIAL_SECURITY_NO").val("");
		 $("#COMPANY_NAME").val("");
		 $("#AREA_ID_VALUE").val("");	
		 $("#SOCIAL_TYPE_ID_VALUE").val("");
		 $("#AREA_ID").val("");	
		 $("#SOCIAL_TYPE_ID").val("");
		 
		g.setOptions({newPage:1});
		g.setOptions({
			parms: [
				{ name: 'SOCIAL_SECURITY_NO', value: '' },
				{ name: 'COMPANY_NAME', value: '' },
				
			]
		});
		g.loadData();
	});


});
    function onSelect(note) {
		var cdid = note.data.id;
		var value = note.data.text;
		$("#AREA_ID_VALUE").val(cdid);
		$("#AREA_ID").val(value);
		$("#treediv").hide();
	}
    </script>
</head>
<div id="toolbar" class="searchDiv">
		<form id="serchform" method="post">
			<table>
				<tr>
					<td class="ser_tit">
						<label>社保编号:</label>	
					</td>
					<td class="ser_cont"><input type="text" id="SOCIAL_SECURITY_NO" value=""/></td>
					<td class="ser_tit">
						<label>单位名称:</label>
					</td>
					<td class="ser_cont"><input type="text" id="COMPANY_NAME" value=""/></td>
					<td class="ser_tit">
						<label>登记姓名:</label>
					</td>
					<td class="ser_cont" ><input type="text" id="TAX_PERSON_NAME" value=""/></td>
				</tr>
				<tr>
					<td class="ser_tit">
						<label>行政区域:</label>
					</td>
					<td class="ser_cont"> 
						<input type="text" id="AREA_ID" value="" name=""/><input type="hidden"  id="AREA_ID_VALUE"/>
					</td>
					<td class="ser_tit">
						<label>社保种类:</label>
					</td>
					<td class="ser_cont"> <input ltype="select" id="SOCIAL_TYPE_ID" value="" name=""/><input type="hidden"  id="SOCIAL_TYPE_ID_VALUE"/></td>
					<td class="ser_cont"><input type="button" id="searchBtn" value="查询" class="btn"/></td>
					<td class="ser_cont">
					
					<input type="button" id="clearBtn" value="清空" class="btn"/>
					<input type="button" id="importExcel" value="导入Excel" class="btn"/>
					</td>
				</tr>
			</table>
		</form>
		</div>
    <div id="maingrid"></div>
    <div id="treediv" style="width: 178px; max-height: 260px; border: 1px solid #ccc; overflow: auto;display:none;position:fixed;left:67px;top:60px">
        <ul id="tree" style="width: 178px;"></ul>
    </div>
</body>

</html>
