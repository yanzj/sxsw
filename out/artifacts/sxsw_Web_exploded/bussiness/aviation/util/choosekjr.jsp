<%@ page language="java"  pageEncoding="UTF-8"%>
<%@page import="com.dhcc.common.util.CommUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>合成侦查可见人添加</title>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>css/reportMain.css"/>
    <link    rel="stylesheet" type="text/css" href="<%=basePath %>include/LigerUI/skins/Aqua/css/ligerui-all.css"/>
    <link    rel="stylesheet" type="text/css"  href="<%=basePath %>include/LigerUI/skins/ligerui-icons.css" /> 
    <script  type="text/javascript"  src="<%=basePath  %>include/jQuery/jquery-1.3.2.min.js"></script>    
    <script  type="text/javascript"  src="<%=basePath  %>include/LigerUI/js/ligerui.all.js" ></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
    <script src="<%=basePath  %>include/LigerUI/jquery-validation/messages_cn.js" type="text/javascript"></script>
	<script type="text/javascript">
	var cacheDept;
	var cacheYJ;
	var cacheRY;
	var cacheDataSet;
	var basePath = "<%=basePath%>";
	var form;
    $(function (){
    cacheDataSet=$(window.parent.document).find("#cacheDataSet");
    	form = $("#form2").ligerForm();
    	$("#selectuser").click(function(){
    		f_selectContact();
    	});
    	$("#clearuser").click(function(){
        	    cacheDataSet.children("#cacheRY").text("");
        		$("#sdesc").html("");
        });
    });
    var userid = "";
    var username = "";
    function checkData(){
        for(i=0;i<cacheRY.length;i++){
        	userid+=cacheRY[i].id+",";
        	username+=cacheRY[i].name+",";
        }
   		if(userid == null || userid == ""){
   			$.ligerDialog.warn("请选择人员！");
   			return false;
   		}
   		return true;
   }
        function  addPost(){//组装发送到后台的数据
        	var formData = liger.get("form2").getData();	
		   	var dataPost = {"userids":userid,"usernames":username};
		   	cacheDataSet.children("#cacheRY").text("");
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
	   
       function f_selectContact(){
    	   cacheDataSet.children("#cacheRY").addClass("selected");
           cacheDataSet.children("#cacheYJ").removeClass("selected")
           window.top.$.ligerDialog.open({ title: '选择可见人', name:'winselector',width: 900, height: 500, url: 'bussiness/aviation/util/UserListMultiSelect.jsp', buttons: [
                    { text: '确定', onclick: f_selectContactOK },
                    { text: '取消', onclick: function(item,dialog){dialog.close();} }
                ]
                });
                return false;
            }
          function f_selectContactOK(item, dialog){
        		var fn = dialog.frame.f_select || dialog.frame.window.f_select; 
                 var data = fn(); 
                 if (!data)
                 {
                     alert('请选择人员');
                     return;
                 }
                  cacheRY=data;
                  //把前一次的缓存清空，并重新赋值
                  cacheDataSet.children("#cacheRY").text("");
                  cacheDataSet.children("#cacheRY").text(JSON.stringify(cacheRY));
			     var users = "";
            	 for(i = 0;i<data.length;i++){
	            		var s="<span style='font-size:14px;margin-right:10px' id='"+data[i].id+"ry'>"+data[i].name+" <img src='"+basePath+"images/delete.png' onclick=\"removeUser('"+data[i].id+"','"+data[i].name+"')\" style=\"cursor:pointer\" /></span>";
		   	            users += s;
	   	         }
	   	          $("#sdesc").html(users);
                 dialog.close();
          	}
     //移除审批人员
	function removeUser(id, name) {
		var data = cacheRY;
		var idx = -1;
		for (i = 0; i < data.length; i++) {
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
				cacheRY = data = temp;
			}
			
			cacheDataSet.children("#cacheRY").text(JSON.stringify(data));
			//移除标签
			$("#" + id + "ry").remove();
		}
	}
	</script>
	<style type="text/css">
        html,body{ 
        	margin:0;
        	padding:0;
        	font-size:14px;
        }
    </style>
</head>
<body style="padding:10px">   
	<form action="" id="form2" name="form2">
		<table class="table_info_box" border="0">
	    <tr>
	    <td align="right" class="td_tit">可见人选择&nbsp;&nbsp;</td>
	    <td align="left" colspan="2">
	     	<input type="button" style="width:80px;background-color: #C7D7EE;border: 1px solid #C7D7EE;border-radius:5px;height:27px;width: 120px; margin-right: 5px;" id="selectuser" value="选择可见人"/>
	     	<input type="button" style="width:80px;background-color: #C7D7EE;border: 1px solid #C7D7EE;border-radius:5px;height:27px;width: 120px; margin-right: 5px;" id="clearuser"  value="清除可见人"/>
	     </td>
	   </tr>
	   <tr>
	    <td align="right" class="td_tit">可见人列表&nbsp;&nbsp;</td>
	    <td colspan="2" class="td_cont">
	    	<div style="width:350px;height:100px;margin-top:20px;border: 1px solid grey" id="sdesc"></div>
	    </td>
	   </tr>
	 </table>
	</form>
	<input id="mypath" type="hidden" value="<%=path %>"/>
	<input id="basepath" type="hidden" value="<%=basePath %>"/>
</body>
</html>
