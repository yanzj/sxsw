<%@ page language="java"  pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String itemid=request.getParameter("itemid");//预警编号
String YJDXSFZHM = request.getParameter("YJDXSFZHM");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>预警信息详情页面</title> 
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script> 
    <script  type="text/javascript"  src="<%=basePath  %>js/dateformat.js"></script> 
    <style>
		.libox{width:auto;height:100%;margin-right:14px;background:url(/aviation/images/Icon/27.png) no-repeat 0 5px;padding-left:10px;float: left;list-style-type: none}
		.libox1{background:url(/aviation/images/Icon/28.png) no-repeat 0 5px;}
		.libox a{text-decoration:none;cursor:pointer;color:#2C4D79;padding-left:10px;}
		.libox a:hover{background:none;border:none;}
		.topbox{width:99%;height:26px;font-size:12px;line-height:27px;border-bottom:1px solid #BED5F3;padding-left:10px;position:fixed;background:#E3F9FF;z-index:5;}
		    	.first{position:fixed;width:100%;height:18px;overflow:auto;margin-bottom:50px;background-color: #FFFFFF;}
		.anniu{width:50px;height:18px;float:left;font-size:14px;padding-left:20px;background:url("/infopoolservice/images/smallbt/back.gif") no-repeat 0 2px;border-right:1px solid blue;margin-right:18px;}
 		.conlists{width:1000px;height:auto;margin:0 auto;margin-top:10px;line-height:30px;padding-top:10px;}
 		pre{ white-space: pre-wrap; white-space: -moz-pre-wrap; white-space: -pre-wrap; white-space: -o-pre-wrap;word-wrap: break-word; }
    </style>
    <script type="text/javascript">
    $(function(){
    	var itemid = "<%=itemid%>";
    	getMess(itemid);
    	
    	getTaskInfo();
    	$(".my_info").live("mouseover",function(){
			$(this).addClass("my_info_mess");
		});
		$(".my_info").live("mouseout",function(){
			$(this).removeClass("my_info_mess");
		});
    });
    //取得单个信息的详情
    function getMess(mid){
    	$.ajax({
			url:"earlywarningById.action", 
			data:"id="+mid, 
			dataType:"json", 
			async:false,
			type:"post",
			success:function (mm) {
				$("#YJDXMC").html(mm.YJDXMC);
				$("#YJNR").html(mm.YJNR);
				$("#YJYY").html(mm.YJYY);
				$("#YJYQ").html(mm.YJYQ);
				if("inventorys"==mm.YJLY){
					$("#YJLY").html("现场盘查");
				}
				$("#YJSJ").html(mm.YJSJ);
				//隐藏
				$("#YJBH").val(mm.YJBH);
				$("#YJLY").val(mm.YJLY);
				$("#YJLYBH").val(mm.YJLYBH);
				$("#YJDXSFZHM").val(mm.YJDXSFZHM);
				//隐藏预警对象名
				$("#ryxm").val(mm.YJDXMC);
				
				var newuserimg = mm.YJTX; //文件不存在
				var basepath = $("#basepath").val();
	 			var jqmypath = basepath.substring(0,basepath.length-9);
				var newuserimgt = jqmypath + newuserimg;
				var pic = document.getElementById("userimg");
	 			pic.src = newuserimgt;
	 			my_initGrid();
			}
    	
		});
    }
    var mypath = "<%=basePath%>";
    //预警对象详情
    function getControlps(){
    	var ryxm =  document.getElementById("ryxm").value;
    	var RYBH = $("#RYBH").val();
		var url = "<%=basePath%>bussiness/aviation/xxcx/gkdd/gkddMess.jsp?id="+RYBH+"&casename="+ryxm;
  	    window.parent.f_click(RYBH,ryxm,url);
    }
   
   
    //预警内容
    function getInventory(){
    	var yjly = $("#YJLY").val();
    	var YJDXSFZHM = "<%=YJDXSFZHM%>";
    	if("inventorys"==yjly){
        	var yjlybh = $("#YJLYBH").val();
    		window.parent.f_click(yjlybh,"盘查信息",mypath+"bussiness/aviation/xcpc/pclb/PclbListMess.jsp?pcbh="+yjlybh+"&sfzhm="+YJDXSFZHM);
    	}else{
    		alert("此功能只支持现场盘查！");
    	}
    }
    //分配任务
    function getTaskes(){
    	var itemid = $("#YJBH").val();
    	var content = $("#YJNR").html();
    	var url = "bussiness/aviation/rwcl/fbrw/FbrwAdd.jsp?itemid="+itemid+"&content="+encodeURI(content)+"&itemtype=earlywarning";
    	window.top.my_openwindow("",url,630,600,"发布任务");

    }
    function winOpen(url,title,width,height,button1,button2,callback){
    	window.top.$.ligerDialog.open({
    		width: width, height: height, url: url, title: title, buttons: [{
    			text: button1, onclick: function (item, dialog) {
    				var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
    				var data = fn();
    				if(data){
    					callback(data,dialog);
    					dialog.close();
    				}
    			}
    		},{
    			text: button2, onclick: function (item, dialog) {
    				dialog.close();
    			}
    		}]
         });
    }
    
    
    //获取对应的任务列表  zad  2015-11-17
    function getTaskInfo(){
   		$.ajax({
			url:"TaskGetInfo.action", 
			data:{"yjxxid":"<%=itemid %>"}, 
			dataType:"json", 
			type:"post",
			success:function (data) {
				var GridData = {"Rows":data};
				my_initGrid(GridData);
			}, 
			error:function (error) {
				alert("获取任务列表失败！" + error.status);
			}
		});
   }
    function my_initGrid(data){
    	$("#maingrid").ligerGrid({
    		data:data,
    		checkbox :false,
    		frozenCheckbox:false,
    		columns: [
    		{ display: '任务名称', name: 'RWMC', minWidth: 30 ,width:"25%",isSort:false,
    			 render : function(item) {
	        		  return "<span class=\"my_info\"  onclick=\"javascript:openDialog('"+ item.RWBH+ "','"+item.RWMC+"','"+item.RWZT+"');\">"+ item.RWMC + "</span>";
	        	  }	
    		},
    		{ display: '创建人', name: 'CJRBH', minWidth: 30 ,width:"25%"},
    		{ display: '创建时间', name: 'CJSJ', minWidth: 20 ,width:"25%",
    			render:function(item){
    				var showDate = getdate(item.CJSJ);
    				var temp = "<span title="+showDate+">"+ showDate +"</span>";
    				return  temp;
    			}
    		},
    		{ display: '任务状态', name: 'RWZT', minWidth: 110 ,width:"25%",isSort:false,
    			render: function (item){
    		    	if (item.RWZT == '0'){
    		    		return '未处理';
    		    	}else if(item.RWZT == '1'){
    		    		return '处理中';
    		    	}else if(item.RWZT == '2'){
    		    		return '已完成';
    		    	}
    		    	
            	}	
    		}
    		],
    		pageSize:10,
    		dataAction :'local',
    		width: '50%',
    		alternatingRow:true,
    		allowHideColumn :false,
    		usePager:true,
    		rowHeigth:24,
    		showTableToggleBtn: false
    	});
    }
    //点击任务名称跳转  zad 2015-11-17
    function openDialog(RWBH,RWMC,RWZT) {
    	if(RWZT==0){
    		window.parent.f_click(RWBH,"任务详情","<%=basePath%>bussiness/aviation/rwcl/wclrw/WclrwMess.jsp?id="+RWBH);
    	}else if(RWZT==1){
    		window.parent.f_click(RWBH,"任务进行中","<%=basePath%>bussiness/aviation/rwcl/clzqq/ClzqqMess.jsp?id="+RWBH);
    	}else if(RWZT==2){
    		window.parent.f_click(RWBH,"任务已完成","<%=basePath%>bussiness/aviation/rwcl/clzqq/ClzqqMess.jsp?id="+RWBH);
    	}
    	
}
    </script>
</head>
<body>
	<div style="width:100%;height:50px;">
	  <ul class="topbox">
	  </ul>
	</div>
    <div style="width:100%;height:auto;" align="center" >
    <table class="table_infos"  width="50%" style="font-size: 20px;">
    	<!-- <tr>
    		<th  align="center" colspan="5" style="height:50px;text-align:center;"></th>
    	</tr> -->
    	<tr>
    		<td class="td_tit_Report1" width="30%">预警对象</td>
    		<td align="center"  width="70%"><a class="my_info" style="color: blue" id="YJDXMC"  onclick="getControlps()"></a></td>
    	</tr>
    	<tr>
    		<td class="td_tit_Report1" width="30%">身份证照</td>
    		<td align="center"  width="70%">
    		<img src="" class="head" id="userimg" style="width:100px; height:100px;"/>
    		</td>
    	</tr>
    	<tr>
    		<td class="td_tit_Report1" width="30%">预警内容</td>
    		<td align="center"  width="70%"><a class="my_info" style="color: blue" id="YJNR" onclick="getInventory()"></a></td>
    	</tr>
    	<tr>
    		<td class="td_tit_Report1" width="30%">预警原因</td>
    		<td align="center"  width="70%"><span id="YJYY"></span></td>
    	</tr>
    	<tr>
    		<td class="td_tit_Report1" width="30%" >预警要求</td>
    		<td align="center"  width="70%" ><span id="YJYQ"></span></td>
    	</tr>
    	<tr>
    		<td class="td_tit_Report1" width="30%">预警来源 </td>
    		<td align="center"  width="70%"><span id="YJLY"></span></td>
    	</tr>
    	<tr>
    		<td class="td_tit_Report1" width="30%">预警时间</td>
    		<td align="center"  width="70%"><span id="YJSJ"></span></td>
    	</tr>
    	
    	<tr>
    		<td class="td_tit_Report1" width="30%">备注</td>
    		<td align="left"  width="70%">
    		<pre class="conlist" id="BZXX"></pre>
    		</td>
    	</tr>
    	<tr>
    		<td style="padding:10px;" align="center" width="100%" colspan="2"><input class="btn" type="button" value="任务分配" onclick="getTaskes()"/></td>
    	</tr>
    </table>
    <div id="maingrid" style="margin: auto;"></div>
    <input type="hidden" vlaue="<%=basePath %>" id="basepath"/>
    <input type="hidden" id="YJBH"/>
    <input type="hidden" id="YJLY"/>
    <input type="hidden" id="YJLYBH"/>
    <input type="hidden" id="YJDXSFZHM"/>
    <input type="hidden" id="ryxm" />
    <input type="hidden"   id="RYBH"/>
    </div>
</body>
</html>
