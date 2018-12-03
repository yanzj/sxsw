/*问候语
     */
function remind() {
         var now = new Date(), hour = now.getHours();
         if (hour > 4 && hour < 6) { $("#labelwelcome").html("凌晨好！") }
         else if (hour < 9) { $("#labelwelcome").html("早上好！") }
         else if (hour < 12) { $("#labelwelcome").html("上午好！") }
         else if (hour < 14) { $("#labelwelcome").html("中午好！") }
         else if (hour < 17) { $("#labelwelcome").html("下午好！") }
         else if (hour < 19) { $("#labelwelcome").html("傍晚好！") }
         else if (hour < 22) { $("#labelwelcome").html("晚上好！") }
         else { $("#labelwelcome").html("夜深了，注意休息！") }
         setTimeout("remind()",30000);
     }
//   /*
//    获取顶级菜单信息
//   */
// function getTopMenu(){
// 	 $.ajax({
//    		url:"http://192.168.100.122:8088/sxsw/sys/user/info",
// 	    type:"post",
// 		 data: {"token" : "1f0c348071d36009e8c9a15305a47a41"},
// 	    dataType:'json',
// 	    success:function(data){
// 	    	var $item = [];
// 		    $.each(data,function(index,item){
// 		   		var temp = {"id":item.CDBH,"text":item.CDBT,"img":item.TBLJ,click:myitemclick1};
// 		   		$item.push(temp);
// 		   		if(index===0){
// 		   			myitemclick1(temp);
// 		   		}
// 		    });
// 		     $("#toolbar").ligerToolBar({ items:$item });
// 	     }
// 	  	});
// }
	  
function myitemclick(item){
	$.ajax({
   		url:"menuQueryS.action",
   		data:{"tid":item.id},
	    type:"post",
	    success:function(data){
		      $("#accordion1").html(data);
		      accordion._render();
        	  accordion.setHeight($(".l-layout-center").height() - 25);
	     }
  		});
}

function myitemclick1(item){
    $("#treeMenu").ligerTree({
        idFieldName: 'CDBH',
        textFieldName: 'CDBT',
        iconFieldName: 'TBLJ',
        nodeDraggable: false,
        checkbox: false,
        parentIDFieldName :'SJBH',
        onClick:function(note){
            if(note.data.CDLJ != null && note.data.CDLJ != "" ){
                var tabid = "GDPJ" + "-" + note.data.CDBH;
                window.f_addTab(tabid,note.data.CDBT,note.data.CDLJ);
            }
        }
    });
    $("#pageloading").hide();//隐藏加载框

  // $.ajax({
	// 	url:"treeMenuQuery.action",
	// 	data:{"tid":item.id},
	// 	dataType:"json",
	// 	type:"post",
	// 	success:function (mm) {
	//       	$("#treeMenu").ligerTree({
	//             data:mm,
	//           	idFieldName: 'CDBH',
  //               textFieldName: 'CDBT',
  //               iconFieldName: 'TBLJ',
	//             nodeDraggable: false,
	//             checkbox: false,
	//             parentIDFieldName :'SJBH',
	//             onClick:function(note){
	//             	if(note.data.CDLJ != null && note.data.CDLJ != "" ){
	//             	 var tabid = "GDPJ" + "-" + note.data.CDBH;
	//             	 window.f_addTab(tabid,note.data.CDBT,note.data.CDLJ);
	//             	}
	//             }
  //           });
  //           $("#pageloading").hide();//隐藏加载框
	// 	},
	// 	error:function (error) {
	// 		alert("获取列表错误******" + error.status);
	// 		$("#pageloading").hide();//隐藏加载框
	// }});
}

/*
 获取原来的密码
*/
function modifyPassword(){
	$.ajax({
		 url:"treeuserGetById.action",
		 data:"YHBH="+uid,
		 type:"post",
		 dataType:'json',
		 ansys:false,
		 success:function(mess){
			  $("#oldpass").val(mess.YHMM);
			  openPass();
		 }
	});
	return false;
}
/*
    弹出一个修改密码的窗口
  */   
function openPass(){
 $.ligerDialog.open({ target: $("#XGMM"),width:400,height:200,title:"密码修改",allowClose:true,isHidden:true,
		buttons: [ 
			    { text: '确定', onclick: function (item, dialog) { 
				   	var np1 = $("#newpass").val();
					var np2 = $("#newpass1").val();
					if(checkXT()){
					 	$.ajax({
					      url:"userModifyPass.action",
					      data:{"YHMM":np1},
					      type:"post",
					      success:function(mess){
					      	if(mess == "success"){
						        $.ligerDialog.success('修改成功！');
						        dialog.hide();
						        $("#newpass").val("");
						        $("#newpass1").val("");
						        $("#oldpass").val("");
					        }else{
					         	$.ligerDialog.success('修改失败！');
					        }
					      }
				     	});
					  }
				    } 
				  },
	    		{ text: '取消', onclick: function (item, dialog) { 
					dialog.hide();
			    } 
			    }
	   		] 
	   });
	  return false;
}
	/**
	 密码修改时校验数据
	 */
	function checkXT(){
		var np1 = $("#newpass").val();
		var np2 = $("#newpass1").val();
		var passReg = /[A-Za-z].*[0-9]|[0-9].*[A-Za-z]/;
		if(np1 == null || np1 == ""){
		 	$.ligerDialog.alert("密码不能为空！","提示","warn");
		     return false;
		}
		if(!passReg.test(np1)){
			$.ligerDialog.alert("密码必须为数字字母混合！","提示","warn");
		     return false;
		}
		if(np1.length < 8){
		 	$.ligerDialog.alert("密码长度不能小于8！","提示","warn");
		     return false;
		}
	   if(np1 != np2){
		  	$.ligerDialog.alert("两次密码不同！","提示","warn");
		   	return false;
	   }
	 return true;
	}
	    
/*
打开用户的详细信息弹窗
*/
function openUserMess(){
	var url = "system/user/UserMess.jsp?id="+uid;
	$.ligerDialog.open({
			title:"用户详细信息",allowClose:true,
		    url: url, width:700, height:450, 
		    modal: true, isResize: false ,
		    isHidden:false
		    });
	return false;
}
	    
/**
用户退出系统
*/
function userSignOut(){
  var userOutFlag = false;
  $.ligerDialog.confirm("确定退出系统？", "提示", function (ok) {
		if (ok) {
			document.location.replace("login.jsp");
		}
	});
	return false;
}




function checkin(){//签到函数
	 $.ligerDialog.confirm("您是否要签到？", "提示", function (ok) {
	 	if (ok) {
		$.ajax({
			url:"queryIfCheckin.action", 
			dataType:"json", 
			type:"post",
			success:function (data) {
	       		if("YESCHECKIN" == data.result){
					$.ligerDialog.success("你已签到，当天不能重复签到！");
	   			}else{
	   				var dataA = {"model.checktype":"01","model.checkway":"01"};
				    $.ajax({
						url:"checkinInfoQD.action", 
						data:dataA, 
						dataType:"json", 
						type:"post",
						success:function (data) {
							var mm = data.checkinModel;
				       		if("success" == data.result){
								$.ligerDialog.success("签到成功！");
				   			}else{
				   				$.ligerDialog.error("签到失败！请重新签到~");
				   			}
						}, 
						error:function (error) {
								$.ligerDialog.error("签到失败！" + error.status,"错误");
						}
					});
	   			}
			}
		});
		}
		});
		return false;
	}
function checkback(){//签退函数
	$.ligerDialog.confirm("您是否要签退？", "提示", function (ok) {
	 	if (ok) {
		var dataA = {"model.checktype":"02","model.checkway":"01"};
	    $.ajax({
			url:"checkinInfoQD.action", 
			data:dataA, 
			dataType:"json", 
			type:"post",
			success:function (data) {
				var mm = data.checkinModel;
	       		if("success" == data.result){
					$.ligerDialog.success("签退成功！");
	   			}else{
	   				$.ligerDialog.error("签退失败！请重新签退~");
	   			}
			}, 
			error:function (error) {
					$.ligerDialog.error("签退失败！" + error.status,"错误");
			}
		});
		}
		});
		return false;
	}
	
	/*
	修改个人信息
	*/
	function modifyUserInfo(){
		var url = "system/user/UserEditSelf.jsp?id="+uid;
		$.ligerDialog.open({
				width: 700, height: 450, url: url, title: "修改个人信息", buttons: [{
					text: "修改", onclick: function (item, dialog) {
						var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
						var data = fn();
						if(data){
							$.ajax({
								url:"treeUpdateuser.action", 
								data:data,
								dataType:"json",
								type:"post",
								success:function (mm) {
									if("error" == mm.result){
										$.ligerDialog.error("修改用户信息失败!");
									}else{
										$.ligerDialog.success("修改用户信息成功！");
										dialog.close();
									}
								}, 
								error:function (error) {
									$.ligerDialog.error("修改用户信息失败！" + error.status);
								}
								});
						}
					}
				},{
					text: "取消", onclick: function (item, dialog) {
						dialog.close();
					}
				}]
		     });
		 return false;
	}