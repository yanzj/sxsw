/*--------
	 打开附件添加页面
-----------------*/
function  openFileUploadPage(id,tablename){
   	var rmd = new Date().getTime();
    window.top.$.ligerDialog.open(
	{ title: '附件上传', name:'winselector'+rmd,width: 400, height: 200, url: 'bussiness/callcenter/util/FileUpload.jsp?itemid='+id+'&itemtype='+tablename+'&rmd='+rmd, 
		buttons: 
			[{ text: '上传', onclick: 
				function(item,dialog){
					var fn = dialog.frame.ajaxFileUpload || dialog.frame.window.ajaxFileUpload;
					var data = fn(function(data){
						dialog.close();
						loadDatas(id,tablename);
					});
				} 
			},
			{ text: '取消', onclick: 
				function(item,dialog){
					dialog.close();
				}  
			}]
	});
}

//上传图片，成功后显示姓名
function  openFileUploadImage(id,tablename){
   	var rmd = new Date().getTime();
    window.top.$.ligerDialog.open(
	{ title: '附件上传', name:'winselector'+rmd,width: 400, height: 200, url: 'bussiness/callcenter/util/ImageUpload.jsp?itemid='+id+'&itemtype='+tablename+'&rmd='+rmd, 
		buttons: 
			[{ text: '上传', onclick: 
				function(item,dialog){
					var fn = dialog.frame.ajaxFileUpload || dialog.frame.window.ajaxFileUpload;
					var data = fn(function(data){
						dialog.close();
						loadDatas(id,tablename);
					});
				} 
			},
			{ text: '取消', onclick: 
				function(item,dialog){
					dialog.close();
				}  
			}]
	});
}

/**
附件上传成功后回调函数
itemid id
itemtype 表名
*/
function loadDatas(itemid,itemtype){
	$.ajax({
		url:'attQueryByItemId.action',
		data:"model.SSXMBH="+itemid+"&model.SSXMLX="+itemtype,
		type:"post",
		dataType:'json',
		success:function(msg){
			$("#filename").empty();
			var mypath = $("#mypath").val();
			$.each(msg,function(index,item){
				//var url = "filedownload.action?filename="+item.filename+"&truefilename="+item.originalfilename;;
				$('input[name="YHTX"]').val(item.FWQLJ); 
				var oclick="attDelete('"+item.FJBH+"','"+itemid+"','"+itemtype+"');";
				var bder="0";
				var hurl="javascript:void(0)";
				var fwqlj = item.FWQLJ;
				var filenameArrimg = fwqlj.substring(fwqlj.lastIndexOf("\\")+1, fwqlj.length);
				fwqlj = fwqlj.substring(34);
				var fwq =fwqlj.split("\\\\");
				var fwqname = fwq[fwq.length-1];
				var url = mypath + item.FWQLJ.split("aviation")[1].replace(/\\/g, "/");
				var filenameArr = fwqname.split(".");
				var str = "";
				if(filenameArr[1].toUpperCase() == "AMR"){
					url = url.replace(".amr",".mp3");
					str="<a href="+url+" target=\"_blank\" onclick=\"editor('"+filenameArrimg+"')\">"+item.SCSDWJM+"</a>  <a href="+hurl+" onclick="+oclick+"  border="+bder+" >reco<img   border="+bder+" title=\"删除\" src=\""+mypath+"/images/delete.png\"/></a>;&nbsp;";
				}else{
					str="<a href="+url+" target=\"_blank\">"+item.SCSDWJM+"</a>  <a href="+hurl+" onclick="+oclick+"  border="+bder+" >image<img   border="+bder+" title=\"删除\" src=\""+mypath+"/images/delete.png\"/></a>;&nbsp;";
				}
				$("#filename").append(str);
			});
		},
		error:function(error){
			alert(error.status);
		}
	});
}
/*
 * 新添加功能 start
 */
/*--------
打开附件添加页面
-----------------*/
function  openFileUploadPages(id,tablename){
	var rmd = new Date().getTime();
window.top.$.ligerDialog.open(
{ title: '附件上传', name:'winselector'+rmd,width: 400, height: 200, url: 'bussiness/callcenter/util/FileUpload.jsp?itemid='+id+'&itemtype='+tablename+'&rmd='+rmd, 
	buttons: 
		[{ text: '上传', onclick: 
			function(item,dialog){
				var fn = dialog.frame.ajaxFileUpload || dialog.frame.window.ajaxFileUpload;
				var data = fn(function(data){
					dialog.close();
					loadDatass(id,tablename);
				});
			} 
		},
		{ text: '取消', onclick: 
			function(item,dialog){
				dialog.close();
			}  
		}]
});
}


/**
附件上传成功后回调函数
itemid id
itemtype 表名
*/
function loadDatass(itemid,itemtype){
	$.ajax({
		url:'attQueryByItemId.action',
		data:"model.SSXMBH="+itemid+"&model.SSXMLX="+itemtype,
		type:"post",
		dataType:'json',
		success:function(msg){
			$("#image").empty();  //附件
			$("#voice").empty();  //语音
			$("#mvoice").empty();  //视频
			var mypath = $("#mypath").val();
			$.each(msg,function(index,item){
				//var url = "filedownload.action?filename="+item.filename+"&truefilename="+item.originalfilename;;
				$('input[name="YHTX"]').val(item.FWQLJ); 
				var oclick="attDelete('"+item.FJBH+"','"+itemid+"','"+itemtype+"');";
				var bder="0";
				var hurl="javascript:void(0)";
				var fwqlj = item.FWQLJ;
				var filenameArrimg = fwqlj.substring(fwqlj.lastIndexOf("\\")+1, fwqlj.length);
				fwqlj = fwqlj.substring(34);
				var fwq =fwqlj.split("\\\\");
				var fwqname = fwq[fwq.length-1];
				var url = mypath + item.FWQLJ.split("aviation")[1].replace(/\\/g, "/");
				var filenameArr = fwqname.split(".");
				var str = "";
				if(filenameArr[1].toUpperCase() == "AMR"){
					url = url.replace(".amr",".mp3");
					str="<a href="+url+" target=\"_blank\" onclick=\"editor('"+filenameArrimg+"')\">"+item.SCSDWJM+"</a>  <a href="+hurl+" onclick="+oclick+"  border="+bder+" >reco<img   border="+bder+" title=\"删除\" src=\""+mypath+"/images/delete.png\"/></a>;&nbsp;";
					$("#voice").append(str);
				}else if(filenameArr[1].toUpperCase() == "MP4"){
					str="<div style=\"float:left;margin-right:8px;width:100px;height:100px;margin:5px;position:relative;\"><img src=\""+mypath+"/images/splogo.png\" style=\"width: 100px;height: 100px\" /><img src=\""+mypath+"/images/common/fkweb_closeicon.png\" onclick="+oclick+" style=\"position:absolute;top:0;right:0; margin-top: 5px;margin-right:5px;width: 15px;height: 15px;\"/></div>";
					$("#mvoice").append(str);
				}else{
					str="<a href="+url+" target=\"_blank\">"+item.SCSDWJM+"</a>  ";
					str="<div style=\"float:left;margin-right:8px;width:100px;height:100px;margin:5px;position:relative;\"><img src=\""+url+"\" style=\"width: 100px;height: 100px\" /><img src=\""+mypath+"/images/common/fkweb_closeicon.png\" onclick="+oclick+" style=\"position:absolute;top:0;right:0; margin-top: 5px;margin-right:5px;width: 15px;height: 15px;\"/></div>";
					//str="<div style=\"width:100px;height:100px;position:relative;\"><img src=\"<%=basePath %>images/common/b4b281ad806d470283c7c14f6cee5e15.jpg\" style=\"width: 100px;height: 100px\" /><img src=\"<%=basePath %>images/common/fkweb_closeicon.png\" style=\"position:absolute;top:0;right:0; margin-top: 5px;margin-right: 5px;width: 15px;height: 15px;\"/></div>";
					//str="<img   style=\"width: 100px;height: 100px\"/> <a href="+hurl+" onclick="+oclick+"  border="+bder+" ><img   border="+bder+" title=\"删除\" src=\""+mypath+"/images/delete.png\"/></a>&nbsp;";
					$("#image").append(str);
				}
				//$("#filename").append(str);
			});
		},
		error:function(error){
			alert(error.status);
		}
	});
}
//打开附件添加页面,上传图片成功后显示图片
function  openFileUploadImages(id,tablename){
   	var rmd = new Date().getTime();
    window.top.$.ligerDialog.open(
	{ title: '附件上传', name:'winselector'+rmd,width: 400, height: 200, url: 'bussiness/callcenter/util/ImageUpload.jsp?itemid='+id+'&itemtype='+tablename+'&rmd='+rmd, 
		buttons: 
			[{ text: '上传', onclick: 
				function(item,dialog){
					var fn = dialog.frame.ajaxFileUpload || dialog.frame.window.ajaxFileUpload;
					var data = fn(function(data){
						dialog.close();
						loadDatass(id,tablename);
					});
				} 
			},
			{ text: '取消', onclick: 
				function(item,dialog){
					dialog.close();
				}  
			}]
	});
}
/*
 * 新添加功能 end
 */




function editor(filename){
	$.ajax({
		url:"amrtompthree2.action?filename="+filename,
		type:"post",
		dataType:'json',
		success:function(msg){
			alert(success.status);
		},
		error:function(error){
			alert(error.status);
		}
		});
}
/**
附件删除函数
*/
function attDelete(id,itemid,itemtype){
	top.$.ligerDialog.confirm("确定删除该附件?删除数据后不可恢复！", "提示", function (ok) {
		if (ok) {
			$.ajax({
				url:'attDelete.action',
				data:'ids='+id,
				dataType:'json',
				success:function(){
					loadDatass(itemid,itemtype);
				},
				error:function(error){
					window.top.$.ligerDialog.error(error.status);
				}
			});
		}
	});
}
/**
 * 下载附件
 * @param itemid 需要查找附件的id
 * @param itemtype 表名称
 * @param spanid 表格id
 * @return
 */
function loadFileList(itemid,itemtype,spanid){
	$.ajax({
		url:'attQueryByItemId.action',
		data:"model.SSXMBH="+itemid+"&model.SSXMLX="+itemtype,
		type:"post",
		dataType:'json',
		success:function(msg){
			$("#"+spanid).empty();
			var mypath = $("#mypath").val();
			$.each(msg,function(index,item){
				var fwqlj = item.FWQLJ;
				fwqlj = fwqlj.substring(34);
				var fwq =fwqlj.split("\\\\");
				var fwqname = fwq[fwq.length-1];
				var url = mypath + item.FWQLJ.split("aviation")[1].replace(/\\/g, "/");
				var filenameArr = fwqname.split(".");
				var str = "";
				var studyid = item.FJBH;
				if(filenameArr[1].toUpperCase() == "PNG" || filenameArr[1].toUpperCase() == "GIF" || filenameArr[1].toUpperCase() == "JPEG" || filenameArr[1].toUpperCase() == "JPG"){
					str = "<a href="+url+" target=\"_blank\" style='display:block;float:left;margin-right:2px;' onclick=\"dd('"+studyid+"')\"><img style='width:100px;height:60px;' src='"+url+"'/></a>&nbsp;";
				}else if(filenameArr[1].toUpperCase() == "AMR"){
					var url = mypath + item.FWQLJ.split("aviation")[1].replace(/\\/g, "/");
					var url = url.replace(".amr",".mp3");
					str = "<a href="+url+" target=\"_blank\" onclick=\"editor('"+fwqname+"')\">"+item.YYWJ+"秒</a>;&nbsp;";
				}
				$("#"+spanid).append(str);
			});
		},
		error:function(error){
			alert(error.status);
		}
	});
}


function loadImageShow(itemid,itemtype,spanid){
	$.ajax({
		url:'attQueryByItemId.action',
		data:"model.itemid="+itemid+"&model.itemtype="+itemtype,
		type:"post",
		dataType:'json',
		success:function(msg){
			$("#"+spanid).empty();
			var mypath = $("#mypath").val();
			$.each(msg,function(index,item){
				var url = mypath + "/fileupload/" + item.filename;
				var filenameArr = (item.filename).split(".");
				var str = "";
				if(filenameArr[1].toUpperCase() == "PNG" || filenameArr[1].toUpperCase() == "GIF" || filenameArr[1].toUpperCase() == "JPEG" || filenameArr[1].toUpperCase() == "JPG"){
					$("#"+spanid).attr("src",url);
					return false;
				}else{
				}
			});
		},
		error:function(error){
			alert(error.status);
		}
		});
	}
	
	
/**
 * 下载附件
 * @param itemid 需要查找附件的id
 * @param itemtype 表名称
 * @param spanid 表格id
 * @return
 */
function loadFileListForWJ(itemid,itemtype,spanid,imageid){
	$.ajax({
		url:'attQueryByItemId.action',
		data:"model.itemid="+itemid+"&model.itemtype="+itemtype,
		type:"post",
		dataType:'json',
		success:function(msg){
			$("#"+spanid).empty();
			var mypath = $("#mypath").val();
			$.each(msg,function(index,item){
				//var url = "filedownload.action?filename="+item.filename+"&truefilename="+item.originalfilename;;
				var url = mypath + "/fileupload/" + item.filename;
				var filenameArr = (item.filename).split(".");
				var str = "";
				if(filenameArr[1].toUpperCase() == "PNG" || filenameArr[1].toUpperCase() == "GIF" || filenameArr[1].toUpperCase() == "JPEG" || filenameArr[1].toUpperCase() == "JPG"){
					str = "<a href="+url+" target=\"_blank\" style='margin-right:2px;'><img style='width:300px;height:300px;' src='"+url+"'/></a>&nbsp;";
					$("#"+imageid).append(str);
				}else{
					str = "<a href="+url+" target=\"_blank\">"+item.originalfilename+"</a>;&nbsp;";
					$("#"+spanid).append(str);
				}
			});
			if($("#"+imageid).html().trim() == ""){
				$("#"+imageid).css({"height":"10px"});
			}
		},
		error:function(error){
			alert(error.status);
		}
	});
}

//上传视频，成功后显示图片
function  openFileUploadMovies(id,tablename){
   	var rmd = new Date().getTime();
    window.top.$.ligerDialog.open(
	{ title: '附件上传', name:'winselector'+rmd,width: 400, height: 200, url: 'bussiness/callcenter/util/VideoUpload.jsp?itemid='+id+'&itemtype='+tablename+'&rmd='+rmd, 
		buttons: 
			[{ text: '上传', onclick: 
				function(item,dialog){
					var fn = dialog.frame.ajaxFileUpload || dialog.frame.window.ajaxFileUpload;
					var data = fn(function(data){
						dialog.close();
						loadDatass(id,tablename);
					});
				} 
			},
			{ text: '取消', onclick: 
				function(item,dialog){
					dialog.close();
				}  
			}]
	});
}