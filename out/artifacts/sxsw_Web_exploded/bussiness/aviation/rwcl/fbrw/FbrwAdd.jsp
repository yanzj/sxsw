<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.dhcc.common.util.CommUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id = CommUtil.getID();//获取随机id

String itemid=request.getParameter("itemid");
String itemtype=request.getParameter("itemtype");
String fbrw = request.getParameter("fbrw");

String name= request.getParameter("name");//人员姓名
String gklbmc= request.getParameter("gklbmc");//管控类别名称
String userimg=request.getParameter("userimg"); //人员头像
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>发布任务信息添加</title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath %>css/reportMain.css" />
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
<script src="<%=basePath  %>js/UploadFailUtil.js" type="text/javascript"></script>
<script type="text/javascript"
	src="<%=basePath  %>bussiness/aviation/rwcl/fbrw/schedulingUtil.js"></script>
<script type="text/javascript" src="<%=basePath%>js/birthdaypicker.js"></script>
<script type="text/javascript"
	src="<%=basePath%>My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript"
	src="<%=basePath%>js/jquery.validate.min.js"></script>
<script
	src="<%=basePath%>include/LigerUI/jquery-validation/messages_cn.js"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
<script type="text/javascript">
	var cacheDept;
	var cacheYJ;
	var cacheDataSet;
	var form;
	var basePath = "<%=basePath%>";
	var fbrw = "<%=fbrw%>";
	var itemtype = "<%=itemtype%>";
	var itemid = "<%=itemid%>";
	
	var name="<%=name%>";
	var gklbmc="<%=gklbmc%>";
	var userimg="<%=userimg%>";
    $(function (){
     cacheDataSet=$(window.parent.document).find("#cacheDataSet");
    	//预警信息 
        if(itemtype =="earlywarning"){
    	    var item1="<div id="+itemid+" class=\"ckzl_div\">";
			var item2=" <div class=\"ckzl_divtop\">";
			var item3="   <div>预警信息</div>";
			var item4="   <img class=\"ckzl_divtop_image\"  onclick=\"removesearlywarning('"+itemid+"')\"  src=\"<%=basePath%>images/common/fk_closeicon.png\"/>";
			var item5="  </div>";
			var item6="  <div class=\"ckzl_divbottom\">";
			var item7="     <img src=\""+userimg+"\" class=\"clzl_divbottom_image\"/>";
			var item8="  <div class=\"ckzl_divbottom_text\">"+name+" </div>";
			var item9="     <div class=\"ckzl_divbottom_texts\"> "+gklbmc+"</div>";
			var item10=" </div>";
			var item11="  </div>";
			var content=item1+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11;
            $("#yjxx").append(content);
			$("#zlidsyj").val(itemid);
    	}
    	 //盘查信息
    	else if(itemtype =="inventorys"){
    	    var item1="<div id="+itemid+" class=\"ckzl_div\">";
			var item2=" <div class=\"ckzl_divtop\">";
			var item3="   <div>盘查信息</div>";
			var item4="   <img class=\"ckzl_divtop_image\"  onclick=\"removesearlywarning('"+itemid+"')\"  src=\"<%=basePath%>images/common/fk_closeicon.png\"/>";
			var item5="  </div>";
			var item6="  <div class=\"ckzl_divbottom\">";
			var item7="     <img src=\""+userimg+"\" class=\"clzl_divbottom_image\"/>";
			var item8="  <div class=\"ckzl_divbottom_text\">"+name+" </div>";
			var item9="     <div class=\"ckzl_divbottom_texts\"> "+gklbmc+"</div>";
			var item10=" </div>";
			var item11="  </div>";
			var content=item1+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11;
            $("#pcxx").append(content);
			$("#zlidspc").val(itemid);
    	}
    	
    	else{
    		document.getElementById("pcxx").style.display="block";
    		//document.getElementById("pc").style.display="block";
    		document.getElementById("yjxx").style.display="block";
        	document.getElementById("yj").style.display="block";
        	document.getElementById("gzr").style.display="block";
        	document.getElementById("gz").style.display="block";
    	}
    });
   //选择执行人
   function selectuser(rwcl){
	   f_selectContactyj(rwcl);
   }
   function f_selectContactyj(rwcl){
  	   cacheDataSet.children("#cacheYJ").addClass("selected");
       window.top.$.ligerDialog.open({ title: '选择人员', name:'winselector',width: 900, height: 500, url: '<%=basePath%>bussiness/aviation/util/UserListMultiSelect.jsp?rwcl='+rwcl, buttons: [
           { text: '确定', onclick: f_selectContactOKyj },
           { text: '取消', onclick: function(item,dialog){dialog.close();} }
      ]});
      return false;
   }
   function f_selectContactOKyj(item, dialog){
		var fn = dialog.frame.f_select || dialog.frame.window.f_select; 
         var data = fn(); 
         if (!data)
         {
             alert('请选择人员');
             return;
         }
         cacheYJ=data;
         cacheDataSet.children("#cacheYJ").text("");
         cacheDataSet.children("#cacheYJ").text(JSON.stringify(cacheYJ));
	      var users = "";
   	  for(var i = 0;i<data.length;i++){
       		var s="<span style='font-size:14px;margin-right:10px' id='"+data[i].id+"'>"+data[i].name+"<img src='"+basePath+"images/delete.png' onclick=\"removeUser('"+data[i].id+"','"+data[i].name+"')\" style=\"cursor:pointer\" /></span>";
  	            users += s;
	          }
   	  	  $("#sdescyj").attr("style","width:350px;height:auto;background-color: #F2F2F2;border: 1px solid #F2F2F2;");
          $("#sdescyj").html(users);
         dialog.close();
  	}
    //清除执行人
    function clearuser(){
    	cacheDataSet.children("#cacheYJ").text("");
    	 $("#sdescyj").attr("style","width:350px;height:100px;background-color: #F2F2F2;border: 1px solid #F2F2F2;border:2px dashed red;");
		$("#sdescyj").html("");
    }
    //查找资料点击事件
    function selectzl(){
		var s= $("#s").val();
	   	f_selectTeam(s);
    }
    
    //上传附件
    function uploadfj(){
    	var id=$("#id").val();
    	openFileUploadPages(id,"taskes");
    }
    //非空验证
    function checkData(){
	var RWMC=$("#RWMC").val();
	var RWNR=$("#RWNR").val();
	var RWWCSJ=$("#RWWCSJ").val();
    var len = $("input[name='chk1']:checked").length;
    var RWJSR =$("#sdescyj").html();
    if(RWMC==""){
    	$("#RWMC").attr("style","border:2px dashed red;");
    }
    if(RWNR==""){
    	$("#RWNR").attr("style","border:2px dashed red;");
    }
    if(RWWCSJ==""){
    	if(len==0){
    		$("#RWWCSJ").attr("style","width:200px;height: 19px;background-color: #F2F2F2;border: 1px solid #F2F2F2;border:2px dashed red;");
    	}else{
    		$("#RWWCSJ").attr("style","width:200px;height: 19px;background-color: #F2F2F2;border: 1px solid #F2F2F2;");
    	}
    }else{
    	$("#RWWCSJ").attr("style","width:200px;height: 19px;background-color: #F2F2F2;border: 1px solid #F2F2F2;");
    }
    if(len==0){
    	if(RWWCSJ==""){
    		$("#spanid").attr("style","width:200px;height: 19px;border:2px dashed red;");
    	}else{
    		$("#spanid").attr("style","width:200px;height: 19px;");
    	}
    }else{
    	$("#spanid").attr("style","width:200px;height: 19px;");
    }
    if(RWJSR==""){
    	 $("#sdescyj").attr("style","width:350px;height: 80px;background-color: #F2F2F2;border: 1px solid #F2F2F2;border:2px dashed red;");
    }
   	if(RWMC!=""&&RWNR!=""&&RWJSR!=""&&len==0&&RWWCSJ!=""){
   		return true;
   	}else if(RWMC!=""&&RWNR!=""&&RWJSR!=""&&len==1&&RWWCSJ==""){
   		return true;
   	}
    
}
 		 //组装发送到后台的数据
        function  addPost(){
		   	var RWMC =$("#RWMC").val();	
		   	var RWNR=$("#RWNR").val();
			var RWWCSJ = $("#RWWCSJ").val();
			var RWBH = $("#id").val();
			var RWJSR = "";
			var RWJSRMC = "";
        	for(var i=0;i<cacheYJ.length;i++){
            	RWJSR += cacheYJ[i].id+",";
            	RWJSRMC += cacheYJ[i].name+",";
            }
            
        	//判断无期限单选框是否选中
        	var len = $("input[name='chk1']:checked").length;
        	//预警信息
			var zlidsyj = $("#zlidsyj").val();
			
			//盘查
			var zlidspc = $("#zlidspc").val();
			
			//关注
			var zlidsgz = $("#zlidsgz").val();
			
			//管控人员
			var zlidsgk = $("#zlidsgk").val();
			
			//案事件信息
			var zlidsasj = $("#zlidsasj").val();
			
		   	var dataPost = {"model.RWBH":RWBH,"model.RWMC":RWMC,"model.RWNR":RWNR,"RWJSR":RWJSR,"RWJSRMC":RWJSRMC,"model.RWWCSJ":RWWCSJ,"len":len,"zlidsyj":zlidsyj,"zlidsgz":zlidsgz,"zlidspc":zlidspc,"zlidsgk":zlidsgk,"zlidsasj":zlidsasj};
			return dataPost;
	   };
	      /**提交验证*/
       function f_validate() { 
         if (checkData()) {
          $.ligerDialog.waitting('正在保存中,请稍候...'); 
           return addPost();
         }
         return null;
     }
	      
       	function alertSelect(){
       		var fbrw = "<%=fbrw%>";
       		if(checkData()){
       			var data=addPost();
       			cacheDataSet.children("#cacheYJ").text("");
       	       	$.ajax({
       				url:"fbrwAdd.action", 
       				data:data,
       				dataType:"json", 
       				type:"post",
       				success:function (mm) {
       	       			if("error"==mm.result){
       	       			    top.$.ligerDialog.error("添加发布任务失败!");
       	       			}else{
       	       				if("fbrw"==fbrw){
       	       				 top.$.ligerDialog.success("添加发布任务成功!");
       	       			     window.top.my_closewindow();
       	       				}else{
       	       				var tabid = window.top.getSelectedTabId();
       	       			     top.$.ligerDialog.success("添加发布任务成功!");
       	       			     window.top.f_addTab("222","未处理列表","WclqqAlllist.action?path=<%=basePath%>&apage=15&bpage=1&rwtype=wfc&rwzt=0&lb=lb");
       	       		         window.top.my_removeTab(tabid);
       	       				}
       	       			}
       				}, 
       				error:function (error) {
       					top.$.ligerDialog.error("添加发布任务失败!" + error.status,"error");
       			}});
       		}
       		
       	}
       	
        $(".nav_href").live("mouseover",function(){
    		$(this).addClass("my_info_mess");
    	});
    	$(".nav_href").live("mouseout",function(){
    		$(this).removeClass("my_info_mess");
    	});
    //移除审批人员
	function removeUser(id, name) {
		var data = cacheYJ;
		var idx = -1;
		for (var i = 0; i < data.length; i++) {
			if (id == data[i].id) {
				idx = i;
				break;
			}
		}
		if (idx != -1) {
			try {
				data.splice(idx, 1);
			} catch (e) {
				var temp = [];
				for (i = 0; i < data.length; i++) {
					if (id != data[i].id) {
						temp.push(data[i]);
					}
				}
				cacheYJ = data = temp;
			}
			
			cacheDataSet.children("#cacheYJ").text(JSON.stringify(data));
			//移除标签
			$("#" + id).remove();
			var RWJSR =$("#sdescyj").html();
			if(RWJSR==""){
			 $("#sdescyj").attr("style","width:350px;height:auto;background-color: #F2F2F2;border: 1px solid #F2F2F2;border:2px dashed red;");
			}else{
				 $("#sdescyj").attr("style","width:350px;height:auto;background-color: #F2F2F2;border: 1px solid #F2F2F2;");
			}
		}
	}
    //验证时间单一
    function ISSingle(){
    	var RWWCSJ = $("#RWWCSJ").val();
    	if(RWWCSJ!=""){
    		$.ligerDialog.warn('已选择了完成时间！');
    		$("#chk1").attr("checked",false);
    	}
    	var len = $("input[name='chk1']:checked").length;
    	if(len==1){
    		$("#spanid").attr("style","");
     		$("#RWWCSJ").attr("style","width:200px;height: 19px;background-color: #F2F2F2;border: 1px solid #F2F2F2;");
    	}
    }
    //验证时间单一
    function Single(){
    	var len = $("input[name='chk1']:checked").length;
    	if(len==1){
    		$.ligerDialog.warn('已选择了无期限！');
    		 $("#RWWCSJ").val("");
    	}
    	var RWWCSJ = $("#RWWCSJ").val();
    	if(RWWCSJ!=""){
    		$("#RWWCSJ").attr("style","width:200px;height: 19px;background-color: #F2F2F2;border: 1px solid #F2F2F2;");
    		$("#spanid").attr("style","");
    	}
    }
    //判断任务名称非空
    function ISRWMC(){
    	var RWMC=$("#RWMC").val();
    	if(RWMC==""){
    		$("#RWMC").attr("style","border:2px dashed red;");
    	}else{
    		$("#RWMC").attr("style","");
    	}
    }
    //判断任务内容非空
    function ISRWNR(){
    	var RWNR=$("#RWNR").val();
    	if(RWNR==""){
    		$("#RWNR").attr("style","border:2px dashed red;");
    	}else{
    		$("#RWNR").attr("style","");
    	}
    }
	</script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	font-size: 14px;
}

.input2 {
	width: 350px;
	height: 25px;
	background: #F2F2F2;
	border: 0px solid #960;
}

.input3 {
	width: 350px;
	height: auto;
	background: #F2F2F2;
	border: 0px solid #960;
}

tr {
	line-height: 40px; /*设置行高*/
}
.input4 {
	height:80px;
	width: 350px;
	background: #F2F2F2;
	border: 0px solid grey;
}
/*参考资料 start */
.ckzl_div
{
border-radius: 5px;width: 120px;height: 155px;margin:5px;float: left;
}
/*参考资料 start--案事件  */
.ckzl_div_asj
{
border-radius: 5px;width: 180px;height: 240px;margin:5px;float: left;
}
.ckzl_divtop
{
 height:25px; border-top-left-radius: 5px;border-top-right-radius: 5px;background-color: #A6A6A6;position:relative;line-height: 25px;text-align: center;color: white;font-size: 13px;
}
.ckzl_divtop_asj
{
 height:36px; border-top-left-radius: 5px;border-top-right-radius: 5px;background-color: #A6A6A6;position:relative;line-height: 36px;text-align: center;color: white;font-size: 13px;
}
.ckzl_divtop_image
{
 
position:absolute;top:0;right:0;margin-top: 5px;margin-right:5px;width: 10px;height: 10px;
}

.ckzl_divbottom
{
height: 130px;background-color: #C7D7EE;text-align: center;
}
.ckzl_divbottom_asj
{
height: 210px;background-color: #C7D7EE;text-align: center;
}

.clzl_divbottom_image
{
 width: 80px;height: 80px;padding-top: 7px;padding-bottom:5px
}
.ckzl_divbottom_text
{
  font-size: 12px;height:18px;line-height: 18px;
}
.ckzl_divbottom_text_asj
{
  font-size: 18px;height:70px;line-height: 90px;
  font-family:"Microsoft YaHei",微软雅黑";
  color:#333333;
}
.ckzl_divbottom_text_asj_time
{
  font-size: 14px;height:8px;line-height: 6px;
  font-family:"Microsoft YaHei",微软雅黑";
  color:#333333;
}
.ckzl_divbottom_text_asj_number
{
  font-size: 18px;height:50px;line-height:70px;
  font-family:"Microsoft YaHei",微软雅黑";
  color:#333333;
}
.ckzl_divbottom_text_asj_type
{
  font-size: 18px;height:30px;line-height:20px;
  font-family:"Microsoft YaHei",微软雅黑";
  color:#ef7844;
  font-weight:bold;
}
.ckzl_divbottom_text_asj_airport
{
  font-size: 14px;height:30px;line-height:30px;
  font-family:"Microsoft YaHei",微软雅黑";
  color:#333333;
}
.ckzl_divbottom_t
{
 font-size: 14px;
 font-family:"Microsoft YaHei",微软雅黑";
 color:#b2b2b2;
}
.ckzl_divbottom_texts
{
 font-size: 11px;height: 15px;line-height: 15px;color: #F07844
}
.height
{
	height:100px;width:350px;background-color: #F2F2F2;border: 0px solid #960;
}
.time{
	width:200px;height: 22px;background-color: #F2F2F2;border: 1px solid #F2F2F2;
}
/*参考资料 end  */
</style>
</head>
<body style="padding:30px">
	<table>
		<tr>
			<td><span style="color:#C2C2C2;">任务名称<span
					style="color:#FF0000;">*</span>&nbsp;&nbsp;</span>
			</td>
			<td><input style="width:350px;" id="RWMC" type="text"
				class="input2" onchange="ISRWMC()"></input>
			</td>
			<td></td>
		</tr>
		<tr>
			<td style="vertical-align:top"; ><span style="color:#C2C2C2;">任务内容<span
					style="color:#FF0000;">*</span>&nbsp;&nbsp;</span>
			</td>
			<td><textarea  class="height" id="RWNR" 
					class="input2" onchange="ISRWNR()"></textarea>
			</td>
			<td></td>
		</tr>
		<tr>
			<td><span style="color:#C2C2C2;">完成时间<span
					style="color:#FF0000;">*</span>&nbsp;&nbsp;</span>
			</td>
			<td colspan="2"><input style="width:200px;height: 19px;background-color: #F2F2F2;border: 1px solid #F2F2F2;"
				id="RWWCSJ" class="Wdate"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" onchange="Single()"></input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="spanid" style="width:200px;height: 19px;"><input
				type="checkbox" name="chk1" id="chk1" onchange="ISSingle()" />&nbsp;无期限</span></td>
		</tr>
		<tr>
			<td><span style="color:#C2C2C2;">执行人<span
					style="color:#FF0000;">*</span>&nbsp;&nbsp;</span>
			</td>
			<td colspan="2"><input type="button" class="search_input_style"
				style="background-color: #C7D7EE;border: 1px solid #C7D7EE;height:27px;width: 120px; margin-right: 5px;"
				value="选择执行人" onclick="selectuser('rwcl')" /> <input type="button"
				class="search_input_style"
				style="background-color:#ffffff;border: 1px solid #ffffff;color:#366CB2;height:27px;width: 100px; "
				value="清除执行人" onclick="clearuser()" /></td>
		</tr>
		<tr>
			<td><span>&nbsp;</span></td>
				<td colspan="2" class="input2">
				<div class="input4" id="sdescyj"></div> 
			</td>
		</tr>
		<tr>
			<td><span style="color:#C2C2C2;">选择资料</span>
			</td>
			<td colspan="2"><select id="s" name="s"
				style="width:160px; border: 1px solid #C7D7EE">
					<option style="selected" value="">-请选择-</option>
					<option value="earlywarning">预警信息</option>
					<option value="payattention">关注人</option>
					<option value="inventoryinfo">盘查信息</option>
					<option value="controlledpeople">管控人员</option>
					<option value="events">案事件</option>
			</select>&nbsp; <input type="button" class="search_input_style"
				style="background-color: #C7D7EE;border: 1px solid #C7D7EE;height:27px;width: 80px; margin-right: 5px;"
				value="查找" onclick="selectzl()" /></td>
		</tr>
		<tr>
			<td></td>
			<td colspan="2" class="input3">
				<div id="zl" style="width:350px;border:0px solid #7FFF00;">
					<div id="zldiv"></div>
				</div> 
				<!-- 预警 -->
				<input id="zlidsyj" type="hidden" />
				<!-- 关注 -->
				<input id="zlidsgz" type="hidden" /> 
				<!-- 盘查 --> 
				<input id="zlidspc" type="hidden" />
				<!-- 管控人员 --> 
				<input id="zlidsgk" type="hidden" />
				<!-- 案事件 -->
				<input id="zlidsasj" type="hidden" />
		</td>
		</tr>
		<tr>
			<td><span>&nbsp;</span>
			</td>
			<td colspan="2"><input id="upload" type="button"
				class="search_input_style"
				style="background-color: #C7D7EE;border: 1px solid #C7D7EE;height:27px;width: 120px; margin-right: 5px;"
				value="上传图片" onclick="uploadfj()" /></td>
		</tr>



		<tr>
			<td><span>&nbsp;</span>
			</td>
			<td colspan="2" class="input2" style="height: 80PX;">
			     <div style="width:350px;border: 0px solid grey" id="yjxx"></div>
			     <div style="width:350px;border: 0px solid grey" id="gzxx"></div>
			     <div style="width:350px;border: 0px solid grey" id="pcxx"></div>
			     <div style="width:350px;border: 0px solid grey" id="gkxx"></div>
			     <div style="width:350px;border: 0px solid grey" id="asjxx"></div>
				<div style="width:350px;border: 0px solid grey" id="voice"></div>
				<div style="width:350px;border: 0px solid grey" id="image"></div>
			</td>
		</tr>
		<tr>
			<td><span>&nbsp;</span>
			</td>
			<td colspan="2"><input id="upload" type="button"
				class="search_input_style"
				style="background-color: #F07844;color:white;border: 1px solid #F07844;height:27px;width: 120px; margin-right: 5px;"
				value="发布任务" onclick="alertSelect()" /></td>
		</tr>
	</table>
	<input id="basePath" type="hidden" value="<%=basePath %>" />
	<input id="mypath" type="hidden" value="<%=basePath %>"/>
	<input id="id" type="hidden" value="<%=id %>"/>
</body>
</html>
