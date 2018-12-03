<%@ page language="java" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id=request.getParameter("id");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>碰撞库信息修改</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/common.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript"
	src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath  %>include/LigerUI/js/ligerui.all.js"></script>
<script
	src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
<script
	src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.metadata.js"
	type="text/javascript"></script>
<script
	src="<%=basePath  %>include/LigerUI/jquery-validation/messages_cn.js"
	type="text/javascript"></script>
<script type="text/javascript">
    $(function(){
    	$(".my_info").live("mouseover",function(){
			$(this).addClass("my_info_mess");
		});
		$(".my_info").live("mouseout",function(){
			$(this).removeClass("my_info_mess");
		});
       	getMess("<%=id%>");
    });
	   /**
	   	获取单个的信息
	   */
	  function  getMess(mid){
	  	 var mypath = "<%=basePath%>";
	     $.ajax({
			url:"databaseMessQuery.action", 
			data:"model.BH="+mid, 
			dataType:"json", 
			type:"post",
			async : false,
			success:function (data) {
				var mm = data.model;
				$("#MC").html(mm.MC);
				$("#FWID").html(mm.FWID);
				$("#FZ").html(mm.FZ);
				$("#BZXX").html(mm.BZXX);
				$("#YJYY").html(mm.YJYY);
				$("#YJYQ").html(mm.YJYQ);
				if(mm.yjdxModels.length>0){
					var itemyjdx = "";
				    $("#yjdxdiv").show();
					$(mm.yjdxModels).each(function(i,value){
					   itemyjdx += "<div style=\"float:left\"><div><img  style=\"width:130px;height:130px;\" src=\""+mypath+""+value.YHTX+"\" /></div><div style=\"font-size:13px;text-align:center;\" class=\"my_info\"  onclick=\"getCJRXM('"+value.YHBH+"')\">"+value.YHXM+"</div><div style=\"font-size:13px;text-align:center;\">"+value.BMMC+"</div></div>";
					});
					$("#yjdx").html(itemyjdx);
				}else{
				    $("#yjdxdiv").hide();
				    $("#yjdx").html("");
				}
				if(mm.yjbmModels.length>0){
					var itemyjbm = "";
					$("#yjbmdiv").show();
					$(mm.yjbmModels).each(function(i,value){
						itemyjbm+="<div style=\"font-size:13px;margin-left:30px;margin-top:10px;\" class=\"my_info\"  onclick=\"getCJRXM('"+value.YHBH+"')\">"+value.YHXM+"("+value.BMMC+")</div>";
					});
					$("#yjbm").html(itemyjbm);
				}else{
					$("#yjbmdiv").hide();
					$("#yjbm").html("");
				}
			}, 
			error:function (error) {
				alert("获取单个信息失败****" + error.status);
		}});
	   }
	   //预警对象信息
	   function getCJRXM(cjrbh){
			var mypath = "<%=basePath%>";
			var url = mypath+"system/user/UserMess.jsp?id="+cjrbh;
			window.top.my_openwindow("",url,700,450,"上控人详情信息");
		} 
		
		//添加预警对象/预警部门
		function itemclick() {
			var mypath = "<%=basePath%>";
			var id = "<%=id%>";
			var FWID = $("#FWID").html();
		    var url = mypath + "bussiness/aviation/ptgl/pzkgl/DatabaseAddYJXX.jsp?id="+id+"&FWID="+FWID;
		    winOpen(url, "添加信息", 600, 620, '添加', '取消', function(data, dialog) {
							top.$.ligerDialog.waitting('正在提交中,请稍候...');
							$.ajax({
								url : "databaseYjAdd.action",
								data : data,
								dataType : "json",
								type : "post",
								success : function(data) {
		        					getMess(id);
									top.$.ligerDialog.closeWaitting();
									if ("success" == data.result) {
										top.$.ligerDialog.success("添加成功！");
										window.top.my_closewindow();
									} else {
										top.$.ligerDialog.error("添加失败！");
										$("#bg").removeClass("bg");
									}
								},
								error : function(error) {
									dialog.close();
									top.$.ligerDialog.error("网络状况不佳，添加失败！" + error.status,
											"错误");
									$("#bg").removeClass("bg");
								}
							});
		  }); 
		}
		function winOpen(url,title,width,height,button1,button2,callback) {
		window.top.$.ligerDialog.open({width:width,height:height,url:url,title:title,
			buttons:[{text:button1,onclick:function(item, dialog) {
							var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
							var data = fn();
							if (data) {
								callback(data);
								dialog.close();
							}
						}
					},{
						text:button2,onclick:function(item, dialog) {
							dialog.close();
						}
					}]
			});
	}
		
    </script>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
}

.div1 {
	height: 30px;
	line-height: 30px;
	clear: both;
	background-color: #C7D9EF;
	font-size: 16px;
	font-weight: 600;
	margin-top: 20px;
	margin-bottom: 10px;
	padding-left: 30px;
	color: #353336;
}
</style>
</head>
<body>
	<div class="div1">碰撞库基本信息</div>
	<div style="margin-left:30px;">
		<table>
			<tr>
				<td width="300px;">库名称：&nbsp;&nbsp;&nbsp;<span id="MC"></span></td>
				<td width="300px;">服务ID：&nbsp;&nbsp;&nbsp;<span id="FWID"></span></td>
			</tr>
			<tr>
				<td>预警原因：&nbsp;&nbsp;&nbsp;<span id="YJYY"></span></td>
				<td>预警要求：&nbsp;&nbsp;&nbsp;<span id="YJYQ"></span></td>
			</tr>
			<tr>
				<td>分值：&nbsp;&nbsp;&nbsp;<span id="FZ"></span></td>
				<td>备注信息：&nbsp;&nbsp;&nbsp;<span id="BZXX"></span></td>
			</tr>
		</table>
		<div style="margin-top:10px;">
			<span> <input id="oneSearch_bt" type="button"
				class="search_input_style"
				style="background-color: #F07844;border: 1px solid #F07844;height:30px;color: white;width: 120px;"
				value="添加" onclick="itemclick()" />
			</span>
		</div>
	</div>
	<div class="div1" id="yjdxdiv" style="display: none;">预警对象信息</div>
	<div id="yjdx"></div>
	<div class="div1" id="yjbmdiv" style="display: none;">预警值班账号</div>
	<div id="yjbm" style="margin-bottom:50px;"></div>
</body>
</html>