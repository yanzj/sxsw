<%@ page language="java"  pageEncoding="UTF-8"%>
<%@page import="com.dhcc.common.util.CommUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String id=request.getParameter("id");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>添加执行人</title>
     <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/messages_cn.js" type="text/javascript"></script>
	 <script src="<%=basePath  %>js/UploadFailUtil.js" type="text/javascript"></script>
	 <script type="text/javascript" src="<%=basePath  %>bussiness/aviation/rwcl/fbrw/schedulingUtil.js"></script>
	 <link rel="stylesheet" type="text/css" href="<%=basePath%>css/common.css" />
	<script type="text/javascript">
	var form;
	var cacheYJ;
	var cacheDataSet;
	var basePath = "<%=basePath%>";
    $(function (){
    	var id = "<%=id%>";
    	getMess(id);
    	cacheDataSet=$(window.parent.document).find("#cacheDataSet");
    	/* form = $("#form2").ligerForm(); */
       
    });
    //获取执行人集合
    function getMess(id){
    	$.ajax({
    		url : "taskesQueryById.action",
    		data:"id="+id,
    		dataType : "json",
    		type : "post",
    		success : function(data) {
    			var value = data.msg;
    			var objArray = JSON.parse(value);
    			$(objArray).each(function (i, value) { 
    				var listmodelinfo = value.listmodel;
    				var arrYJ = [];
    				var itemuser = "";
    				$(listmodelinfo).each(function(k,atk){
    					 arrYJ.push({
    					        id : atk.YHBH,
    							name : atk.YHXM
    				      });
    					 var item1 = "<span style='font-size:13px;margin-right:8px' class = 'ry_font' id='"
								+ atk.YHBH + "'>"
								+ atk.YHXM+ " <img src='"
								+ basePath + "images/delete.png' onclick=\"removeUser('"
								+ atk.YHBH + "','" + atk.YHXM
								+ "')\" style=\"cursor:pointer\" /></span>";
                      	itemuser += item1;
    					
    				});
    				   cacheYJ = arrYJ;
    				   cacheDataSet.children("#cacheYJ").text(JSON.stringify(cacheYJ));
    				   $("#sdescyj").html(itemuser);

    			});
    		},
    		error : function(error) {
    			alert("获取执行人信息失败****" + error.status);
    		}
    	});
    	
    }
    //选择执行人
    function selectusers(rwcl){
 	   f_selectContactyjs(rwcl);
    }
    function f_selectContactyjs(rwcl){
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
    		    var s="<span style='font-size:14px;margin-right:10px' id='"+data[i].id+"'>"+data[i].name+"<img src='"+basePath+"images/delete.png' onclick=\"removeUser('"+data[i].id+"','"+data[i].name+"')\" style=\"cursor:hand\" /></span>";
   	            users += s;
 	          }
           $("#sdescyj").html(users);
          dialog.close();
   	}
     //清除执行人
     function clearuser(){
     	cacheDataSet.children("#cacheYJ").text("");
 		$("#sdescyj").html("");
 		cacheYJ="";
     }
    function checkData(){
    	var RWJSR = "";
    	for(var i=0;i<cacheYJ.length;i++){
        	RWJSR+=cacheYJ[i].id+",";
        }
    	var RWJSR =$("#sdescyj").html();
   		if(RWJSR == null || RWJSR == ""){
   			$.ligerDialog.warn("执行人不能为空！");
   			return false;
   		}
   		return true;
    }
 		 //组装发送到后台的数据
        function  addPost(){
            var rwid = $("#id").val();
            var RWJSR = "";
        	for(var i=0;i<cacheYJ.length;i++){
            	RWJSR += cacheYJ[i].id+",";
            }
		   	var dataPost = {"JSR":RWJSR,"rwid":rwid};
			return dataPost;
	   }
	      /**提交验证*/
       function f_validate() { 
         if (checkData()) {
          $.ligerDialog.waitting('正在保存中,请稍候...'); 
           return addPost();
         }
         return null;
     }
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
   		}
   	}
	</script>
	<style type="text/css">
        html,body{ 
        	margin:0;
        	padding:0;
        	font-size:14px;
        }
	    .input2 {
		width: 350px;
		height: 25px;
		background: #F2F2F2;
		border: 0px solid #960;
	}
    </style>
</head>
<body>  
		<div
		style="width:100%;height: 40px;line-height:40px;background-color: #C7D7EE;margin-top: 20px;">
		<div style="width: 98%;font-size: 16px;font-weight: bold;color: #F07844;border:0px solid #F00;text-align:center;">
				增派人员
		</div>
	    </div>
		 
	<form action="" id="form2" name="form2">
		 <table  border="0" style="padding:30px; margin-left:60px" >
	     <tr>
	    <td align="right" class="td_tit">执行人 </td>
	    <td align="left" class="td_cont" colspan="2">
	    <input type="button" class="search_input_style"
				style="background-color: #C7D7EE;border: 1px solid #C7D7EE;height:27px;width: 120px; margin-right: 5px;"
				value="添加执行人" onclick="selectusers('rwcl')" />
	     </td>
	   </tr>
	   <tr>
	    <td align="right" class="td_tit"></td>
	    <td colspan="2" class="input2" style="height: 90PX;">
	    	<div style="width:300px;border: 0px solid grey" id="sdescyj"></div>
	    </td>
	    </tr>
	 </table>
	</form>
	<input id="mypath" type="hidden" value="<%=path %>"/>
	<input id="basePath" type="hidden" value="<%=basePath %>"/>
	<input id="id" type="hidden" value="<%=id %>"/>
</body>
</html>
