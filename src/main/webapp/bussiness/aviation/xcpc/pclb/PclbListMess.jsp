<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String sfzhm = request.getParameter("sfzhm");
	String wdsp = request.getParameter("wdsp");
	String pcbh = request.getSession().getAttribute("pcbh").toString();//盘查编号
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/reportMain.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/Aqua/css/ligerui-all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>include/LigerUI/skins/ligerui-icons.css" />
<script type="text/javascript"
	src="<%=basePath%>include/jQuery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>include/LigerUI/js/ligerui.all.js"></script>
<script
	src="<%=basePath%>include/LigerUI/jquery-validation/jquery.validate.min.js"></script>
<script
	src="<%=basePath%>include/LigerUI/jquery-validation/jquery.metadata.js"
	type="text/javascript"></script>
<script
	src="<%=basePath%>include/LigerUI/jquery-validation/messages_cn.js"
	type="text/javascript"></script>
<script src="<%=basePath%>js/jquery.lightbox.min.js"
	type="text/javascript"></script>
<link rel="stylesheet"
	href="<%=basePath%>css/jquery.lightbox.packed.css" type="text/css" />
<script src="<%=basePath%>layer/jquery.js?v=1.83.min"></script>
<script src="<%=basePath%>layer/layer.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>css/common.css" />
<style type="text/css">
.liger-button {
	float: left;
	margin-left: 20px;
}
/*hr标签上方*/
.sbxx {
	font-weight: bold;
	font-size: 14px;
	cursor: pointer
}
.pcxx {
	font-weight: bold;
	font-size: 16px;
	cursor: default
}

a:hover {
	font-size: 15px;
	background-color: #fff;
}

hr {
	height: 2px;
	border: none;
	border-top: 2px double #AECAF0;
}
/*表格显示*/
.showmsg {
	float: left;
	margin-left: 30px;
	margin-top: 15px;
}

.tablecss {
	border: 1px solid #AECAF0;
	width: 500px;
	text-align: center;
}

.tablecss tr {
	border: 1px solid #AECAF0;
	width: 250px
}

.tablecss td {
	border: 1px solid #AECAF0;
	width: 250px
}
/*左边框*/
.leftdiv {
	border: 1px solid #AECAF0;
	width: 150px;
	height: 70px;
	margin-left: 30px;
	margin-top: 22px;
	text-align: center;
}

.rightdiv {
	border: 1px solid #AECAF0;
	width: 150px;
	height: 70px;
	margin-top: 22px;
	text-align: center;
}

.leftdiv font {
	cursor: pointer;
	font-weight: bold;
}

.rightdiv font {
	cursor: pointer;
	font-weight: bold;
}

.topbox {
	width: 100%;
	height: 27px;
	font-size: 12px;
	line-height: 27px;
	border-bottom: 1px solid #BED5F3;
	background: #E3F9FF;
}

.libox {
	width: auto;
	height: 100%;
	margin-right: 14px;
	background: url(/aviation/images/Icon/28.png) no-repeat 0 5px;
	padding-left: 10px;
	float: left;
	list-style-type: none
}

.libox1 {
	background: url(/aviation/images/Icon/27.png) no-repeat 0 5px;
}

.libox a {
	text-decoration: none;
	cursor: pointer;
	color: #2C4D79;
	padding-left: 10px;
}

.libox a:hover {
	background: none;
	border: none;
}

.item_style {
	width: auto;
	border-radius: 5px;
	margin-bottom: 10px;
	margin-left: 0px;
	padding: 6px;
}

.controlps_img {
	width: 120px;
	height: 120px;
	margin-right: 16px;
}

.controlps_imgone {
	width: 50px;
	height: 50px;
	margin-right: 10px;
}

.trone {
	width: 360px;
	border-bottom: #b2b2b2 solid 1px;
}

.td_value {
	color: black;
	margin-left: 15px;
}
.td_text {
	color: #B6B6B6;
}
</style>
<script type="text/javascript">
		var form;
		var pcbh = "<%=pcbh%>";
		var sfzhm = "<%=sfzhm%>";
		var basepath = "<%=basePath%>";
		var wdsp = "<%=wdsp%>";
		var msgjson = "";
        $(function (){
			 $(".talks").bind("mouseover",function(){
			 	 $(this).children(".delete_flag").show();
			 }).bind("mouseout",function(){
			     $(this).children(".delete_flag").hide();
			 });
    		 $(".float_style").live("mouseover",function(){
    			 $(this).addClass("my_info_mess");
    		 });
    		 $(".float_style").live("mouseout",function(){
    			 $(this).removeClass("my_info_mess");
    		 });
    		 sbxxlist(pcbh);
    		 jsxxlist(pcbh);
        });
        /**
	  	  点击头像 放大
	  	  */
	  	function touxiang(imguser,ryxm){
	  		window.top.my_openwindow("",imguser,270,350,ryxm);
        }
        /**分配任务   zad 2015-11-12 */
        function fprw(ryxm,gklbmc){
            var itemid = pcbh;
    	    var name= ryxm;
    	    var userimg= $("#userimg").attr("src");
	    	var url = "bussiness/aviation/rwcl/fbrw/FbrwAdd.jsp?itemid="+itemid+"&itemtype=inventorys&name="+name+"&gklbmc="+gklbmc+"&userimg="+userimg;
	    	window.top.my_openwindow("",url,630,600,"发布任务");
        }
        /**上报信息 */
        function sb(){
        	var url = "<%=basePath%>" + "bussiness/aviation/xcpc/pclb/ShangbaoxxAdd.jsp?pcbh="+pcbh;
			winOpen(url, "信息上报", 560,420, '提交', '取消', function(data, dialog) {
		      $.ajax({
					url:"shangbao.action", 
					data:data,
					dataType:"json", 
					type:"post",
					success:function (mm) {
		       			if("error"==mm.result){
		       				top.my_alert("上报失败!","error");
		       			}else{
		       			    $("#sbxxDiv").html("");
		       			    sbxxlist(pcbh);
		       				top.my_alert("上报成功!","success");
		       			    window.top.my_closewindow();
		       			}
					}, 
					error:function (error) {
						top.my_alert("上报失败!" + error.status,"error");
				}});
			 });
        }
        //关注
        function  getGz(RYBH){
         	var gz = $("#gz").val();
           	$.ajax({
         			url:"GZ.action", 
         			data:"GZ="+gz+"&RYBH="+RYBH, 
         			dataType:"json", 
         	   	 	async:false,
         			type:"post",
         			success:function (mm) {
         				if("savsuccess" == mm.result){
         	     		 	$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\"<%=basePath%>images/common/fkweb_focusonforaimat.png\" style=\"vertical-align: middle;\"/>");
         	     		 	top.my_alert("关注成功!","success");
         				}else if("delsuccess" == mm.result){
         					$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\"<%=basePath%>images/common/fkweb_eyesongrey.png\" style=\"vertical-align: middle;\"/>");
         					top.my_alert("取消关注成功!","success");
         				}else if("saverror" == mm.result){
         					$("#guanzhu").html("<input type=\"hidden\" value=\"0\" id=\"gz\"/><img src=\"<%=basePath%>images/common/fkweb_focusonforaimat.png\" style=\"vertical-align: middle;\"/>");
         					top.my_alert("该信息已关注!","success");
         				}else if("delerror" == mm.result){
         					$("#guanzhu").html("<input type=\"hidden\" value=\"1\" id=\"gz\"/><img src=\"<%=basePath%>images/common/fkweb_eyesongrey.png\" style=\"vertical-align: middle;\"/>");
         					top.my_alert("该信息已取消关注!","success");
         				}
         			}, 
         		error:function (error) {
         			alert("获取单个信息失败****" + error.status);
         		}
         	});
         } 
        /**控制打开界面*/
    	function winOpen(url, title, width, height, button1, button2, callback) {
    		window.top.$.ligerDialog.open({width : width,height : height,url : url,title : title,
    			buttons : [{text : button1,onclick : function(item, dialog) {
    							var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
    							var data = fn();
    							if (data) {
    								callback(data);
    								dialog.close();
    							}
    						}
    					},{text : button2,onclick : function(item, dialog) {
    							dialog.close();
    						}
    					}]
    		});
    	}
        //引用函数
    	;!function(){
    		layer.use('<%=basePath%>layer/extend/layer.ext.js', function(){
	 		    // 初始加载即调用，所以需放在ext回调里
	   		    layer.ext = function(){
	   		        layer.photosPage({
	   		            html:'',
	   		            title: '',
	   		            id: 100, //相册id，可选
	   		            parent:'#imgs'
	   		        });
    			};
    		});
    	}();
	//打开语音
	function openYY(filename){
	    var str= filename.split("/");
	    var filename=str[str.length-1];
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
	//打开同行人页面详情
	function openTxr(PCBH,RYXM){
		var url = "pcxxMess.action?pcbh=" + PCBH;
		var tabid = "PCLB" + "-" + PCBH;
		this.parent.f_click(tabid,RYXM,"<%=basePath%>" + url);
	}
	//点击打开创建人信息
	function getCJRXX(rybh){
		var url = "<%=basePath%>system/user/UserMess.jsp?id="+rybh;
		window.top.my_openwindow("",url,700,450,"创建人详情信息");
	}
	
	//点击打开盘查人信息
	function ryDetail(rybh,ryxm){
		var url = "bussiness/aviation/xxcx/gkdd/gkddMess.jsp?BD_RYBH=" + rybh+"&casename="+ryxm;
		var tabid = "GDPJ" + "-" + rybh;
		this.parent.f_click(tabid,ryxm,"<%=basePath%>" + url);
	}
    //列控
    function control(BD_RYBH,BD_RYXM){     
        var url ="<%=basePath%>bussiness/aviation/lkgl/lkdx/LKXcpcLKAdd_new.jsp?BD_RYBH="+BD_RYBH+"&BD_RYXM="+BD_RYXM; 
    	window.top.my_openwindow("", url, 750, 560, "创建审批");
    }
    //现场盘查
    function xcpcAdd(PCBH,PCJGBH){
    	var url = "<%=basePath%>bussiness/aviation/xcpc/XcpcAdd.jsp?pcjgbh=" + PCJGBH + "&pcbh=" + PCBH;
		if(PCJGBH == ""){
			winOpen(url, "", 600, 480, '提交', '取消', function(data, dialog) {
				$.ajax({
					url : "addInterrogations.action",
					data : data,
					dataType : "json",
					type : "post",
					success : function(data) {
						if ("success" == data.result) {
							pcjglist(PCBH);
							top.$.ligerDialog.success("添加盘查视频资料成功！");
							window.top.my_closewindow();
						} else {
							top.$.ligerDialog.error("添加盘查视频资料失败！");
						}
					},
					error : function(error) {
						top.$.ligerDialog.error("添加盘查视频资料失败！" + error.status,"错误");
					}
				});
			}); 
		}else{
			winOpen(url, "", 600, 480, '提交', '取消', function(data, dialog) {
				$.ajax({
					url : "updateInterrogation.action",
					data : data,
					dataType : "json",
					type : "post",
					success : function(data) {
						if ("success" == data.result) {
							pcjglist(PCBH);
							top.$.ligerDialog.success("修改盘查视频资料成功！");
							window.top.my_closewindow();
						} else {
							top.$.ligerDialog.error("修改盘查视频资料失败！");
						}
					},
					error : function(error) {
						top.$.ligerDialog.error("修改盘查视频资料失败！" + error.status,"错误");
					}
				});
			}); 
		}
	}
    //视频添加
    function videoAdd(PCBH){
    	var url = "<%=basePath%>bussiness/aviation/xcpc/spzl/SpzlAdd.jsp?pcbh=" + PCBH;
		winOpen(url, "", 600, 480, '提交', '取消', function(data, dialog) {
			$.ajax({
				url : "addInventoryveo.action",
				data : data,
				dataType : "json",
				type : "post",
				success : function(data) {
					if ("success" == data.result) {
						spzllist(PCBH);
						top.$.ligerDialog.success("添加盘查视频资料成功！");
						window.top.my_closewindow();
					} else {
						top.$.ligerDialog.error("添加盘查视频资料失败！");
					}
				},
				error : function(error) {
					top.$.ligerDialog.error("添加盘查视频资料失败！" + error.status,"错误");
				}
			});
		}); 
    }
    //播放视频
    function openSp(id,name,splj){
    	var sppath = "<%=basePath%>"+splj;
    	var url = "bussiness/aviation/xcpc/spzl/SpzlMessage.jsp?spurl="+sppath;
    	this.parent.f_click("SP-"+id,name,"<%=basePath%>"+url);
    }
    
    //加载盘查结果信息
    function pcjglist(pcbh){
    	$.ajax({
    		url:"interrogationsMore.action",
    		data:"pcbh="+pcbh,
    		dataType:"json",
    		type:"post",
    		success:function(data){
    			$("#pcjgDiv").html("");
    			var value = data.msg;
   				var objArray = JSON.parse(value);
   				$(objArray).each(function (i, value) { 
   					var item = "<div style=\"width:auto;height:60px;\">";
   					item += "<table><tr style=\"height: 30px;\"><td style=\"color: #EF7844;width: 80px;\">联系信息</td>";
   					item += "<td><img src=\"<%=basePath%>images/common/fk_phoneicon.png\" />&nbsp;&nbsp;<span id=\"SJHM\">"+value.SJHM +"</span></td></tr>";
   					item += "<tr><td></td><td><img src=\"<%=basePath%>images/common/fk_addressicon.png\" />&nbsp;&nbsp;<span id=\"SJHM\">"+value.ZZDZ +"</span></td></tr></table></div>";
   					item += "<div style=\"height: 1px;background-color: #b2b2b2; clear: both; margin-top: 5px;margin-bottom: 5px;\"></div>";
   					item += "<div style=\"width:auto;height:110px;\"><div style=\"width:40%;height:110px;float:left;\">";
   					item += "<div style=\"width:auto;height:100px;float:left;\"><span style=\"color: #EF7844;\">航班信息 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div>";
   					item +="<div style=\"width:60%;height:100px;float:left;\"><table><tr><td style=\"width:100%;height:30px\"><span id=\"CZHBXX\">"+value.CZHBXX+"</span></td></tr>";
   					item += "<tr><td style=\"width:100%;height:30px\"><span id=\"HBH\" style=\"font-size: 18px;color: #386CB5;font-weight: bold;\">"+value.HBH+"</span></td></tr>";
   					item += "<tr><td style=\"width:100%;height:30px\"><span id=\"CFD\" style=\"font-size: 18px;font-weight: bold;\">"+value.CFD+"</span>&nbsp;&nbsp;---&nbsp;&nbsp;<span id=\"MDD\" style=\"font-size: 18px;font-weight: bold;\">"+value.MDD+"</span></td></tr></table></div></div>";
   					item += "<div style=\"width:59%;height:110px;float:left;\"><table><tr><td style=\"width:250px;height:25px\"><span style=\"color:#EF7844;\">出行信息</span></td><td style=\"width:390px;height:25px\"></td></tr>";
   					item += "<tr><td style=\"width:250px;height:25px\" class=\"td_text\">出行目的&nbsp;&nbsp;&nbsp;&nbsp;<span id=\"CXMD\" class=\"td_value\">"+value.CXMD +"</span></td>";
   					item += "<td style=\"width:390px;height:25px\" class=\"td_text\">交通工具&nbsp;&nbsp;&nbsp;&nbsp;<span id=\"JTGJ\" class=\"td_value\">"+value.JTGJ +"</span></td></tr>";
   					item += "<tr><td style=\"width:250px;height:25px\" class=\"td_text\">同行人员&nbsp;&nbsp;&nbsp;&nbsp;<span id=\"CFDone\" class=\"td_value\">"+value.TXRY +"</span></td><td style=\"width:390px;height:25px\"><span id=\"MDDone\"></span></td></tr>";
   					item += "<tr><td style=\"width:250px;height:25px\" class=\"td_text\">携带物品&nbsp;&nbsp;&nbsp;&nbsp;<span id=\"XDWP\" class=\"td_value\">"+value.XDWP +"</span></td><td style=\"width:390px;height:25px\"></td></tr></table></div></div>";
					if(value.picCount > 0 || value.yyCount > 0){
						item += "<div style=\"height: 1px;background-color: #b2b2b2; clear: both; margin-top: 5px;\"></div>";
					}
					if(value.picCount > 0){
						item += "<div id=\"imgs\" style=\"width:79%;float:left;margin-bottom: 7px;\"><p><span style=\"color:#EF7844;\">图片&nbsp;&nbsp;(<span id=\"tpcount\">"+value.picCount+"</span>) </span></p>";
						var attlist = value.attlist;
						$(attlist).each(function (j, att) {
							if(att.WJLX == 0){
								item += "<div style=\"background-color:#D1D1D1;width:15%;height:80%;float:left;margin:0 5px;margin-top:5px;border-radius:8px\"><img height=\"100%\" width=\"100%\" src=\"<%=basePath%>"+att.FWQLJ+"\" class=\"float_style\" /></div>";
							}
						});
						item += "</div>";
					}
					if(value.yyCount > 0){
						item += "<div id=\"imgs\" style=\"width:79%;float:left;margin-bottom: 7px;\"><p><span style=\"color:#EF7844;\">语音&nbsp;&nbsp;(<span id=\"yycount\">"+value.yyCount+"</span>) </span></p>";
						var attlist = value.attlist;
						$(attlist).each(function (j, att) {
							if(att.WJLX == 1){
								var str = att.FWQLJ.replace('.amr', '.mp3');
								item +=  "<div style=\"background-color:#D1D1D1;width:80%;height:30px;;float:left;margin:0 5px;margin-top:5px;border-radius:8px\"><table width=\"100%\" height=\"80%\">";
								item +=  "<tr><td><img height=\"15px\" width=\"15px\"src=\"<%=basePath%>images/userHeadImage.png\" /></td><td><a id=\""+att.FJBH+"\" href=\"<%=basePath%>"+str+"\" onclick=\"openYY('"+att.FWQLJ+"')\" target=\"_Blank\">"+att.YYWJ+"秒</a></td></tr></table></div>";
							}
						});
						item +=  "</div>";
					} 
					$("#pcjgDiv").append(item);
   				});
    		},
    		error : function(error) {
    			top.$.ligerDialog.error("滚动加载失败！" + error.status,"错误");
    		}
    	});
    }
    //加载视频资料
    function spzllist(){
    	$.ajax({
    		url:"inventoryveoMore.action",
    		data:"pcbh="+pcbh,
    		dataType:"json",
    		type:"post",
    		success:function(data){
    			$("#spzlDiv").html('');
    			var value = data.msg;
   				var objArray = JSON.parse(value);
   				var item = "<div style=\"height: 1px;background-color: #b2b2b2; clear: both; margin-top: 5px;margin-bottom:15px;\"></div>";
   				item += "<p><span style=\"color:#EF7844;\">视频资料&nbsp;&nbsp;(<span id=\"tpcount\">"+objArray.length+"</span>)</span></p>";
   				$("#spzlDiv").append(item);
   				$(objArray).each(function (i, value) { 
   					var attlist = value.attlist;
   					$(attlist).each(function (j, att) { 
   						var item1 = "<div style=\"background-color:#D1D1D1;width:15%;height:80%;float:left;margin:0 5px;margin-top:5px;border-radius:8px;text-align: center;\">";
						item1 += "<img height=\"100%\" width=\"100%\" src=\"<%=basePath%>images/splogo.png\" class=\"float_style\" onclick=\"openSp('" + value.PCSPBH + "','" + value.SPMC + "','" + att.FWQLJ + "')\"/><span>" + value.SPMC + "</span></div>";
						$("#spzlDiv").append(item1);
					});
				});

			},
			error : function(error) {
				top.$.ligerDialog.error("滚动加载失败！" + error.status, "错误");
			}
		});
	}
	  //加载上报信息
    function sbxxlist(pcbh){
    	$.ajax({
    		url:"inventorySbInfo.action",
    		data:"pcbh="+pcbh,
    		dataType:"json",
    		type:"post",
    		success:function(data){
    			var value = data.msg;
   				var objArray = JSON.parse(value);
   				if(objArray.length>0){
   					var item = "<div style=\"height: 1px;width:920px;background-color: #b2b2b2; clear: both; margin-top: 5px;margin-bottom:15px;\"></div>";
   					item +="<p><span style=\"color:#EF7844;\">上报信息&nbsp;&nbsp;(<span id=\"tpcount\">"+objArray.length+"</span>) </span></p>";
   	   				$(objArray).each(function (i, value) { 
   					  	item+="<table width=\"85%\" style=\"margin-top:15px;\">";
   					    item+=" <tr style=\"height:25px;line-height:25px\">";
   					    item+=" <td style=\"width:27%\"><span>上报时间：</span><span>"+value.SBSJ+"</span></td>";
   					    item+=" <td style=\"width:33%\"><span>上报原因：</span><span>"+value.SBYY+"</span></td>";
   					    item+=" <td style=\"width:37%\"><span>接收人：</span><span>"+value.JSRXM+"</span></td>";
   					    item+=" </tr>";
   					  	item+=" </table>";
   	   				});
   	   				$("#sbxxDiv").append(item);
   				}
    		},
    		error : function(error) {
    			top.$.ligerDialog.error("滚动加载失败！" + error.status,"错误");
    		}
    	});
    }
	
	//加载我接收的信息
	function jsxxlist(pcbh){
	   $.ajax({
	     url:"inventoryJSInfo.action",
	     data:"pcbh="+pcbh,
	     dataType:"json",
	     type:"post",
	     success:function(data){
	     var value = data.msg;
   				var objArray = JSON.parse(value);
   				if(objArray.length>0){
   					var item = "<div style=\"height: 1px;width:920px;background-color: #b2b2b2; clear: both; margin-top: 5px;margin-bottom:15px;\"></div>";
   					item +="<p><span style=\"color:#EF7844;\">接收信息&nbsp;&nbsp;(<span id=\"tpcount\">"+objArray.length+"</span>) </span></p>";
   	   				$(objArray).each(function (i, value) { 
   					  	item+="<table width=\"85%\" style=\"margin-top:15px;\">";
   					    item+=" <tr style=\"height:25px;line-height:25px\">";
   					    item+=" <td style=\"width:27%\"><span>上报时间：</span><span>"+value.SBSJ+"</span></td>";
   					    item+=" <td style=\"width:33%\"><span>上报原因：</span><span>"+value.SBYY+"</span></td>";
   					    item+=" <td style=\"width:37%\"><span>上报人：</span><span>"+value.SBRXM+"</span></td>";
   					    item+=" </tr>";
   					  	item+=" </table>";
   	   				});
   	   				$("#jsxxDiv").append(item);
   				}
    		},
	     error:function(error){
	     
	     }
	   });
	}
</script>

</head>
<body class="body_style" style="margin-left:44px;">
	<div style="width:auto;height:auto;">
		<div style="margin-bottom: 20px;width: 100%;margin-top: 10px;">
			<div style="width:216px;height:96px;float:left;">
				<table style="height:100%;width:100%; border-radius:8px"
					bgcolor="#BCD2EE">
					<tr></tr>
					<tr>
						<td align="center" colspan="2"><span id="CJSJ"
							style="font-size: 14pt; color: #666;">${iimodel.CJSJ }</span></td>
					</tr>
					<tr>
						<td align="center"><span id="JCMC"
							style="font-size: 15px; color: #666;">${iimodel.JCMC }</span></td>
						<td align="center"><span class="float_style"
							style="font-size: 15px; color: #386AB1;"
							onclick="getCJRXX('${iimodel.CJRBH}')">${iimodel.CJRXM }</span></td>
					</tr>
					<tr></tr>
				</table>
			</div>
			<div style="margin-left:12px;margin-right:12px;height:120px;float:left;">
				<div
					style="width: 1px; height:120px;background-color: #b2b2b2;margin: auto;">
				</div>
			</div>
			<div style="width:496px;float: left;">
				<table>
					<tr>
						<td rowspan="5"><img src="${iimodel.XP}" id="userimg" class="controlps_img" /></td>
					</tr>
					<tr class="trone">
						<td style="font-size: 13px;color: #EF7844;font-weight: bold;width:360px;">
							<span id="RYXM" class="float_style" style="font-size: 19px;color: #EF7844;font-weight: bold;vertical-align: middle;margin-right: 20px;"
							onclick="ryDetail('${iimodel.BD_RYBH}','${iimodel.XM}')">${iimodel.XM}</span>
							<span>
								<c:if test="${iimodel.lsgkcount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/lsgk.png" />
								</c:if>
								<c:if test="${iimodel.tjlkcount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/tjlk.png" />
								</c:if>
								<c:if test="${iimodel.ztrycount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/ztryxx.png" />
								</c:if>
								<c:if test="${iimodel.wffzcount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/fzxx.png" />
								</c:if>
								<c:if test="${iimodel.zjrycount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/jzxyr.png" />
								</c:if>
								<c:if test="${iimodel.siscount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/sisxyr.png" />
								</c:if>
								<c:if test="${iimodel.kssrycount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/ksszyry.png" />
								</c:if>
								<c:if test="${iimodel.qlzdcount > 0}">
									<img class="sf_span_style" src="<%=basePath%>images/gkddxq/qbqlzd.png" />
								</c:if>
							</span>
							<c:choose>
								<c:when test="${iimodel.GKLBBH!=null}">
							        <span id="guanzhu" class="float_style" style="margin-left: 20px;" onclick="getGz('${iimodel.RYBH}')"> <c:choose>
											<c:when test="${fn:length(iimodel.GZBH) > 0}">
												<input type="hidden" value="0" id="gz" />
												<img src="<%=basePath%>images/common/fkweb_focusonforaimat.png" style="vertical-align: middle;"/>
											</c:when>
											<c:otherwise>
												<input type="hidden" value="1" id="gz" />
												<img src="<%=basePath%>images/common/fkweb_eyesongrey.png" style="vertical-align: middle;"/>
											</c:otherwise>
										</c:choose> </span>
								</c:when>
								<c:otherwise>
									<span class="float_style" style="vertical-align: middle;margin-left: 10px;" onclick="control('${iimodel.BD_RYBH}','${iimodel.XM}')">列控</span>
								</c:otherwise>
								</c:choose>
						</td>
					</tr>
					<tr>
						<td>
						    <font style="font-size:14px;color: #b2b2b2;margin-right:20px;">身份证号</font>
						    <span id="GMSFZHM" style="font-size:14px;color: #4d4d4d;">${iimodel.SFZH}</span>
						</td>
					</tr>
					<tr>
						<td>
							<font style="font-size:14px;color: #b2b2b2;margin-right:20px;">户口地址</font>
							<span id="ZJZZ" style="font-size:14px;color: #4d4d4d;">${iimodel.HKSZD}</span>
						</td>
					</tr>
					<tr>
						<td>
						 <font style="font-size:14px;color: #b2b2b2;margin-right:20px;">民 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族</font>
						 <span id="SSZD_VALUE" style="font-size:14px;color: #4d4d4d;">${iimodel.MZMC}</span>
						</td>
					</tr>
				</table>
			</div>
			<div style="margin-left:12px;margin-right:12px;height:120px;float:left;">
				<div
					style="width: 1px; height:120px;background-color: #b2b2b2;margin: auto;">
				</div>
			</div>
			<div style="width:160px;float:left;">
				<div style="height:37px;">
				   <span style="font-size:14px;color: #386CB5;" class="float_style" onclick="fprw('${iimodel.XM}','${iimodel.GKLBMC}')">分配任务</span>
				   <span style="font-size:14px;color: #386CB5;margin-left:26px;" class="float_style" onclick="sb()">信息上报</span>
			    </div>
			    <div style="width: 160px; height:1px;background-color: #b2b2b2;margin-top: auto;"></div>
				<div style="margin-top:16px;height:40px;">
				   <span style="font-size:14px;color: #386CB5;" class="float_style" onclick="xcpcAdd('${iimodel.PCBH}','${ientity.PCJGBH}')">编辑内容</span>
				   <span style="font-size:14px;color: #386CB5;margin-left:26px;" id="sb" class="float_style" onclick="videoAdd('${iimodel.PCBH}')">上传视频</span>
				</div>
			</div>
			<div style="clear: both;"></div>
		</div>
		 <div
			style="height: 1px;width:920px;background-color: #b2b2b2; clear: both; margin-top: 5px;margin-bottom: 5px;"></div>
		<div id="pcjgDiv" style="margin-top: 10px;margin-bottom: 10px;">
			<c:choose>
				<c:when test="${ientity==null}">
					<div style="width: 98%; text-align: center;margin-top: 20PX">无现场信息</div>
				</c:when>
				<c:otherwise>

					<div style="width:auto;height:60px;">
						<table>
							<tr style="height: 30px;">
								<td style="color: #EF7844;padding-right: 20px;">联系信息</td>
								<td>
									<img src="<%=basePath%>images/common/fk_phoneicon.png" style="margin-right: 20px;vertical-align: middle;"/>
									<span id="SJHM" style="vertical-align: middle;">${ientity.SJHM }</span></td>
							</tr>
							<tr>
								<td></td>
								<td>
									<img src="<%=basePath%>images/common/fk_addressicon.png" style="margin-right: 20px;vertical-align: middle;"/>
									<span id="ZZDZ" style="vertical-align: middle;">${ientity.ZZDZ }</span></td>
							</tr>
						</table>


					</div>
					<div
						style="height: 1px;background-color: #b2b2b2; clear: both; margin-top: 5px;margin-bottom: 5px;"></div>
					<div style="width:auto;height:110px; ">
						<div style="width:40%;height:110px;float:left;">
							<div style="width:auto;height:100px;float:left;">
								<span style="color: #EF7844;margin-right: 20px;">航班信息 </span>
							</div>
							<div style="width:60%;height:100px;float:left;">
								<table>
									<tr>
										<td style="width:100%;height:30px">
											<span id="CZHBXX">${ientity.CZHBXX}</span>
										</td>
									</tr>
									<tr>
										<td style="width:100%;height:30px">
											<span id="HBH" style="font-size: 18px;color: #386CB5;font-weight: bold;">${ientity.HBH}</span>
										</td>
									</tr>
									<tr>
										<td style="width:100%;height:30px">
											<span id="CFD" style="font-size: 18px;font-weight: bold;margin-right: 10px;">${ientity.CFD}</span>--->
											<span id="MDD" style="font-size: 18px;font-weight: bold;margin-left: 10px; ">${ientity.MDD}</span>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div style="width:59%;height:110px;float:left;">
							<table>
								<tr>
									<td style="width:250px;height:25px">
										<span style="color:#EF7844;">出行信息</span>
									</td>
									<td style="width:390px;height:25px"></td>
								</tr>
								<tr>
									<td style="width:250px;height:25px;margin-right: 25px;" class="td_text">
										出行目的<span id="CXMD" class="td_value">${ientity.CXMD }</span>
									</td>
									<td style="width:390px;height:25px;margin-right: 25px;" class="td_text">
										交通工具<span id="JTGJ" class="td_value">${ientity.JTGJ }</span>
									</td>
								</tr>
								<tr>
									<td style="width:250px;height:25px;margin-right: 25px;" class="td_text">
										同行人员<span id="CFDone" class="td_value">${ientity.TXRY }</span>
									</td>
									<td style="width:390px;height:25px">
										<span id="MDDone"></span>
									</td>
								</tr>
								<tr>
									<td style="width:250px;height:25px;margin-right: 25px;" class="td_text">
										携带物品<span id="XDWP" class="td_value">${ientity.XDWP }</span>
									</td>
									<td style="width:390px;height:25px"></td>
								</tr>
							</table>
						</div>
					</div>
					<c:if test="${ientity.picCount > 0 || ientity.yyCount > 0 }">
						<div
							style="height: 1px;background-color: #b2b2b2; clear: both; margin-top: 5px;"></div>
					</c:if>
					<c:if test="${ientity.picCount > 0}">
						<div id="imgs" style="width:79%;float:left;margin-bottom: 7px;">
							<p>
								<span style="color:#EF7844;">
									图片<span id="tpcount" style="margin-left: 10px;">(${ientity.picCount})</span> 
								</span>
							</p>
							<c:forEach var="att" items="${ientity.attlist}">
								<c:if test="${att.WJLX == 0}">
									<div
										style="background-color:#D1D1D1;width:15%;height:80%;float:left;margin:0 5px;margin-top:5px;border-radius:8px">
										<img height="100%" width="100%"
											src="<%=basePath%>${att.FWQLJ}" class="float_style" />
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
					<c:if test="${ientity.yyCount > 0}">
						<div style="width:20%;float:left;margin-bottom: 7px;">
							<p>
								<span style="color:#EF7844;">
									语音<span id="yycount" style="margin-left: 10px;">(${ientity.yyCount})</span> 
								</span>
							</p>
							<c:forEach var="att" items="${ientity.attlist}">
								<c:if test="${att.WJLX == 1}">
									<c:set var="string1" value="${att.FWQLJ}" />
									<c:set var="string2"
										value="${fn:replace(string1,'.amr', '.mp3')}" />
									<div
										style="background-color:#D1D1D1;width:80%;height:30px;;float:left;margin:0 5px;margin-top:5px;border-radius:8px">
										<table width="100%" height="80%">
											<tr>
												<td><img height="15" width="15"
													src="<%=basePath%>images//userHeadImage.png" /></td>
												<td><a id="${att.FJBH}" href="<%=basePath %>${string2}"
													onclick="openYY('${att.FWQLJ}')" target="_Blank">${att.YYWJ}秒</a>
												</td>
											</tr>
										</table>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:if>

				</c:otherwise>
			</c:choose>
		</div>
		<c:if test="${fn:length(txrlist)>0}">
			<div
				style="height: 1px;background-color: #b2b2b2; clear: both; margin-top: 5px;margin-bottom:15px;"></div>
			<div style="width:auto;clear: both;">
				<p>
					<span style="color:#EF7844;">同行人<span
						id="txrcunt" style="margin-left: 10px;">(${fn:length(txrlist)})</span> </span>
				</p>
				<br />
				<c:forEach var="item" items="${txrlist}" varStatus="idx">
					<div
						style="background-color:#E6E6E6;width:213px;height:122px;;float:left;margin:2px 6px;border-radius:4px;">
						<table width="99%" height="98%">
							<tr>
								<td rowspan="4" style="width:100px" align="center"><img
									height="90px" width="90px" src="${item.XP}" /></td>
								<td><span 
									style="font-size: 14px;color: #386CB5;font-weight: bold;"
									class="float_style"
									onclick="openTxr('${item.PCBH}','${item.XM }')">${item.XM}</span>
								</td>
							</tr>
							<tr style="height: 20px">
								<td >${item.MZMC}</td>
							</tr>
							<tr style="height: 20px">
								<td></td>
							</tr>
							<tr style="height: 20px">
								<td></td>
							</tr>
							<tr>
								<td colspan="2"><span style="font-size: 13px;padding-left: 5px">${item.SFZH}</span>
								</td>
							</tr>
						</table>
					</div>
				</c:forEach>
			</div>
		</c:if>
		<div id="spzlDiv" style="width:99%;float:left;margin-bottom: 7px;">
			<c:if test="${fn:length(videoList) > 0}">
				<div
					style="height: 1px;background-color: #b2b2b2; clear: both; margin-top: 5px;margin-bottom:15px;"></div>
				<p>
					<span style="color:#EF7844;">
						视频资料<span id="tpcount" style="margin-left: 10px;">(${fn:length(videoList)})</span>
					</span>
				</p>
				<c:forEach var="item" items="${videoList}" varStatus="idx">
					<c:forEach var="attitem" items="${item.attlist}" varStatus="idx">
						<div style="background-color:#D1D1D1;width:15%;height:80%;float:left;margin:0 5px;margin-top:5px;border-radius:8px;text-align: center;">
							<img height="100%" width="100%" src="<%=basePath%>images/splogo.png" class="float_style"
								onclick="openSp('${item.PCSPBH}','${item.SPMC}','${attitem.FWQLJ}')" />
							<span>${item.SPMC}</span>
						</div>
					</c:forEach>
				</c:forEach>

			</c:if>
		</div>
		<div id="sbxxDiv" style="width:99%;float:left;margin-bottom: 30px;"></div>
		<div id="jsxxDiv" style="width:99%;float:left;margin-bottom: 30px;"></div>
	</div>
</body>