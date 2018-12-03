var basepath;
jQuery(function ($){
	basepath = $("#basepath").val();
	var userid = $("#userid").val();
	getMess(userid);
	$(".my_info").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	$(".style_over").live("mouseover",function(){
		$(this).addClass("style_over_out");
	});
	$(".style_over").live("mouseout",function(){
		$(this).removeClass("style_over_out");
	});
	pass();             //判断是否具有最终列控权限
});
/**
     获取单个的信息
 */
function  getMess(mid){
	$.ajax({
		url:"conditioncontrolById.action", 
		data:"id="+mid,
		dataType:"json", 
		async:false,
		type:"post",
		success:function (mm) {
			if(mm.MZ!=""&&mm.MZ!=null){
				$("#Keyword").html("<div><span class=\"txt_title\">民族</span><span class=\"txt_value\">"+mm.MZMC+"</span><div>");
			}
			if(mm.XM!=""&&mm.XM!=null){
				$("#Keyword").append("<div><span class=\"txt_title\">姓名</span><span class=\"txt_value\">"+mm.XM+"</span><div>");
			}
			if(mm.XB!=""&&mm.XB!=null){
				if(mm.XB==1){
					$("#Keyword").append("<div><span class=\"txt_title\">性别</span><span class=\"txt_value\">男</span><div>");
				}else if(mm.XB=2){
					$("#Keyword").append("<div><span class=\"txt_title\">性别</span><span class=\"txt_value\">女</span><div>");
				}
				
			}if(mm.ZZ!=""&&mm.ZZ!=null){
				$("#Keyword").append("<div><span class=\"txt_title\">住址</span><span class=\"txt_value\">"+mm.ZZ+"</span><div>");
			}if(mm.SFZH!=""&&mm.SFZH!=null){
				$("#Keyword").append("<div><span class=\"txt_title\">身份证号</span><span class=\"txt_value\">"+mm.SFZH+"</span><div>");
			}if(mm.JG!=""&&mm.JG!=null){
				$("#Keyword").append("<div><span class=\"txt_title\">籍贯</span><span class=\"txt_value\">"+mm.JG+"</span><div>");
			}if(mm.QT!=""&&mm.QT!=null){
				$("#Keyword").append("<div><span class=\"txt_title\">其他</span><span class=\"txt_value\">"+mm.QT+"</span><div>");
			}
			
			var zt="";
			if(mm.ZT=="0")
			{
				zt="(列控)";
				$("#cxlk").show();
				$("#bj").show();
				$("#qy").hide();
				$("#firstLine").hide();
				$("#secondLine").show();
			}else if(mm.ZT=="1")
			{
				zt="(禁用)";
				$("#qy").show();
				$("#cxlk").hide();
				$("#bj").hide();
				$("#firstLine").show();
			}
			else if(mm.ZT=="2")
			{
				zt="(申请启用中)";
			}
			else if(mm.ZT=="3")
			{
				zt="(申请禁用中)";
			}
			else if(mm.ZT=="4")
			{
				zt="(申请编辑中)";
			}
			
			$("#zt").html(zt);
			$("#TJXLKBH").val(mm.TJXLKBH);
			$("#TJXXBH").val(mm.TJXXBH);
			$("#CJRBH").val(mm.CJRBH);
			$("#CJRXM").html(mm.CJRXM);
			$("#BMMC").html(mm.BMMC);
			$("#JCMC").html(mm.JCMC);
			$("#CJSJ").html(mm.CJSJ);
			$("#LKYXSJ").html(mm.LKYXSJ_Date);

			$("#LKYY").html(mm.YY);
			$("#YJYQ").html(mm.YJYQ);
			$("#LKLB1").html(mm.GKLBMC);
			$("#BZXX").html(mm.BZXX);

			var deptList=mm.yjDeptList;
			var itemdept="";
			$(deptList).each(function(i, value)
					{
				    var item1="<span id='"+value.YHBH+"' class=\"my_info ry_font\" onclick='getCJRXM(this.id)'>"+value.YHXM+"</span>("+value.JCMC+"-"+value.BMMC+")&nbsp;&nbsp;";
				    itemdept+=item1;
					});
			$("#YJBMMC").html(itemdept);

			var userList=mm.yjUserList;
			var itemuser="";
			$(userList).each(function(i, value)
					{
				    var item2="<span id='"+value.YHBH+"' class=\"my_info ry_font\" onclick='getCJRXM(this.id)'>"+value.YHXM+"</span>("+value.JCMC+"-"+value.BMMC+")&nbsp;&nbsp;";
				    itemuser+=item2;
					});
			$("#YJDXMC").html(itemuser);

			//循环输出审批记录
			$("#spjl_div").html("");
			var spjlList = mm.spjlList;
			$(spjlList).each(function(i,value) 
					{
			 var item1="<table  style=\"width: 900px;margin:0px auto;text-align:center\"><tr style=\"border-bottom: 1px solid #b2b2b2;height:40px;line-height:40px\">";
				item1+="<td width=\"20%\">"+value.CJSJ+"</td>";
				item1+="<td width=\"25%\" id='"+value.CJRBH+"' class=\"my_info ry_font\" onclick='getCJRXM(this.id)'>"+value.CJRXM+"</td>";
				item1+="<td width=\"18%\">"+value.JCMC+"</td>";
				item1+="<td width=\"15%\">";
					if(value.LB==0)
					{
						item1+="列控";
					}	
					if(value.LB==1)
					{
						item1+="启用";
					}
					if(value.LB==2)
					{
						item1+="禁用";
					}
					if(value.LB==3)
					{
						item1+="编辑";
					}
					item1+="</td>";
					item1+="<td width=\"10%\"   class=\"lc_zc_font\">";
					if(value.SPZT==0)
					{
						item1+="未审批";	
					}
					if(value.SPZT==1)
					{
						item1+="上报";	
					}
					if(value.SPZT==2)
					{
						item1+="拒绝";	
					}
					if(value.SPZT==3)
					{
						item1+="通过";	
					}
					if(value.SPZT==4)
					{
						item1+="打回";	
					}
				item1+="</td>";
				item1+="<td width=\"10%\" class=\"ry_font my_info\" id='"+value.SPBH+"' onclick=\"spdetail(this.id)\">详情>></td>";
				item1+="</tr></table>";
				item1+="<div id=\"div"+value.SPBH+"\">";
				//判断是否需要加载 默认 需要=true 
				item1+="<div id=\"is_load"+value.SPBH+"\" style=\"display:none\">true</div>";
				item1+="<div id=\"td_warn"+value.SPBH+"\" style=\"display:none;text-align:center;height:40px;line-height:40px;\">正在加载中...</div>";
				//流程图片
				item1+="<div id=\"lc_img"+value.SPBH+"\"  style=\"width:100%;padding-top: 20px;\"></div>";
				//文字
				item1+="<div id=\"lc_font"+value.SPBH+"\" style=\"background-color: #F2F3F3; width: 900px;margin:0px auto; border-radius:7px; \"></div>";
				item1+=" </div>";
				$("#spjl_div").append(item1);
			 });
		}, 
		error:function (error) {
			alert("获取单个信息失败****" + error.status);
		}
	});
}  

/**
	  上控人点击详情
 */
function getCJRXM(cjrbh){
	if(cjrbh == null){
		cjrbh=$("#CJRBH").val();
	}
	var url = basepath+"system/user/UserMess.jsp?id="+cjrbh;
	window.top.my_openwindow("",url,700,450,"上控人详情信息");
}
/*
 * 审批历史记录 点击查看审批详情
 */
function spdetail(id)
{
	$("#td_warn"+id).html('正在加载中...');
	//判断是否需要继续加载
	var is_load=$("#is_load"+id).html();
	if(is_load=="false")
	{
		if($("#div"+id).is(":hidden"))
		{
			$("#div"+id).show();
		}
		else
		{
			$("#div"+id).hide();
		}
		return;
	}
	$("#td_warn"+id).show();
	//审批详情
	getlcMess(id);
}

function getlcMess(id){
	$.ajax({
		url:"approvalsconditionQueryByIds.action", 
		data:"id="+id, 
		dataType:"json", 
		async:true,
		type:"post",
		success:function (mm) {
			if(mm.CJRXM==null)
			{
				//$("#td_warn"+id).hide();
				$("#td_warn"+id).html('异常');
				return;
			}
			
			/*	$("#LKYXSJ").html(mm.LKYXSJ);
			$("#LKLB").html(mm.GKLBMC);
			if(mm.BZXX != "null")
			{
				$("#BZXX").html(mm.BZXX);
			}
			else
			{
				$("#BZXX").html("");
			} 
			$("#LKYY").html(mm.YY);
			$("#YJYQ").html(mm.YJYQ);*/

			//流程图标 start
			var item="<div style=\"margin-bottom: 10px; width:100%;\">";
			item+="<table style=\"margin: 0px auto;\">";
			item+="<tr>";
			item+="<td><img src=\""+basepath+"images/lkgl/fk_websubmitorg.png\" id=\"lc_tj_img"+id+"\" /></td>";
			item+="<td><img src=\""+basepath+"images/lkgl/fk_webdotlineorg_rey.png\" id=\"lc_tj_zx"+id+"\" /></td>";
			item+="<td><img src=\""+basepath+"images/lkgl/fk_webapprovalgrey.png\" id=\"lc_sp_img"+id+"\" /></td>";
			item+="<td><img src=\""+basepath+"images/lkgl/fk_webdotlinegrey.png\" id=\"lc_sp_zx"+id+"\" /></td>";
			item+="<td><img src=\""+basepath+"images/lkgl/fk_webpassgrey.png\" id=\"lc_pz_img"+id+"\" /></td>";
			item+="</tr>";
			item+="</table>";
			item+="</div>";
			$("#lc_img"+id).append(item);

			var item1="<div style=\" width: 720px;margin:0px auto;\">";
			item1+="<table style=\"width:100%\"><tr>";
			item1+="<td style=\"width: 33%;text-align: left;\"><img id=\"lc_tj_jt"+id+"\"  style=\"display: none;\" src=\""+basepath+"images/lkgl/fk_webtriggle.png\" /></td>";
			item1+="<td style=\"width: 33%;text-align: center;\"><img id=\"lc_sp_jt"+id+"\" style=\"display: none;\" src=\""+basepath+"images/lkgl/fk_webtriggle.png\" /></td>";
			item1+="<td style=\"width: 33%;text-align: right;\"><img id=\"lc_pz_jt"+id+"\"  style=\"display: none;\" src=\""+basepath+"images/lkgl/fk_webtriggle.png\" /></td>";
			item1+="</tr></table></div>";
			$("#lc_img"+id).append(item1);
			//流程图片 end
			
			//获取审批意见集合
			var spyjList=mm.spyjList;

			//提交申请人信息 start
			var item2="<table  style=\"width: 720px;margin-left: 80px; line-height: 32px;text-align: left;\"><tr style=\"height:10px\"></tr><tr>";
			item2+="<td width=\"25px;\"><img src=\""+basepath+"images/lkgl/fk_webblue.png\"/></td>";
			item2+="<td width=\"20%\"><span class=\"cl_cjsj\">"+mm.CJSJ+"</span></td>";
			item2+="<td width=\"25%\"><span class=\"my_info ry_font\">"+mm.CJRXM+"</span></td>";
			item2+="<td width=\"40%\"><span>"+mm.JCMC+"</span>-<span>"+mm.BMMC+"</span></td>";
			item2+="<td width=\"10%\" style=\"text-align: right;\"><span class=\"lc_zc_font\">提交申请</span></td></tr><tr style=\"height:10px\"></tr></table>";
			$("#lc_font"+id).append(item2);
			//提交申请人信息 end

			//循环审批意见集合 start
			$(spyjList).each(function(i, value)
				{
				var item3="<table style=\"width: 720px;margin-left: 80px; line-height: 32px;text-align: left;\"><tr class=\"lc_border-bottom\"><td></td>";
				item3+="<td colspan=\"4\">审批人&nbsp;：<span style=\"margin-left: 10px;\"></span>";
				var spczrList=value.spczrList;
				$(spczrList).each(function(i, values)
						{
					       item3+="<span>&nbsp;&nbsp;"+values.SPRXM+"&nbsp;&nbsp;</span>";
						});
				item3+="</td></tr>";
				if(value.CZZT==0)
				{
					item3+="<tr id=\"wsp\"><td><img src=\""+basepath+"images/lkgl/fk_webdot.png\" /></td>";
					item3+="<td  colspan=\"4\" ><span class=\"lc_zc_font\">未审批</span></td></tr><tr style=\"height:10px\"></tr>";
					//$("#lc_tab").append(item3);
					$("#lc_font"+id).append(item3);
				}
				else
				{
					item3+="<tr><td width=\"25px;\"><img src=\""+basepath+"images/lkgl/fk_webblue.png\"/></td>";
					item3+="<td width=\"20%\"><span class=\"cl_cjsj\">"+value.CZSJ+"</span></td>";
					item3+="<td width=\"25%\"><span class=\"my_info ry_font\">"+value.CZRXM+"</span></td>";
					item3+="<td width=\"40%\"><span>"+value.CZRJCMC+"</span>-<span>"+value.CZRBMMC+"</span></td>";
					item3+="<td width=\"10%\" style=\"text-align: right;\"><span class=\"lc_zc_font\">";
					if(value.CZZT==1)
					{
						item3+="上报";
					}
					else if(value.CZZT==2)
					{
						item3+="拒绝";
					}
					else if(value.CZZT==3)
					{
						item3+="通过";
					}
					else if(value.CZZT==4)
					{
						item3+="打回修改";
					}
					item3+="</span></td></tr>";
					item3+="<tr><td></td> <td></td>";
					item3+=" <td colspan=\"3\">审批意见：<span>"+value.SPYJ+"</span></td></tr></table>";
					$("#lc_font"+id).append(item3);
				}
				});
			//循环审批意见集合 end


			//判断审批状态
			if(mm.SPZT==0)
			{
				$("#lc_tj_jt"+id).show();
			}
			//上报
			else if(mm.SPZT==1)
			{
				$("#lc_sp_jt"+id).show();
				$("#lc_sp_img"+id).attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
				$("#lc_sp_zx"+id).attr('src',basepath+'images/lkgl/fk_webdotlineorg_rey.png');
				$("#lc_tj_zx"+id).attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
			}
			else if(mm.SPZT==2)
			{
				//拒绝
				$("#lc_pz_jt"+id).show();
				$("#div_spyj"+id).hide();
				$("#lc_sp_img"+id).attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
				$("#lc_pz_img"+id).attr('src',basepath+'images/lkgl/fk_webpassorg.png');
				$("#lc_tj_zx"+id).attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
				$("#lc_sp_zx"+id).attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
			}
			else if(mm.SPZT==3)
			{
				//通过
				$("#lc_pz_jt"+id).show();
				$("#div_spyj"+id).hide();
				$("#lc_sp_img"+id).attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
				$("#lc_pz_img"+id).attr('src',basepath+'images/lkgl/fk_webpassorg.png');
				$("#lc_tj_zx"+id).attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
				$("#lc_sp_zx"+id).attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');

			}
			else if(mm.SPZT==4)
			{
				//打回修改
				$("#lc_tj_jt"+id).show();
			}
			
            $("#is_load"+id).html("false");
			$("#td_warn"+id).hide();
		}
	});
	
}

function commomTj(url,title,type){
	winOpen(url, title, 670, 550, '提交', '取消', function(data,dialog){
		if ("okpass" == $("#pass").val()) {
			TJXLK(data,type);
		}else{
			TJXTJ(data,type);
		}
	});
}

function TJXLK(data,type){
	var tip = "";
	var tip1 = "";
	if(type=="starts"){
		tip = "您具有审批权,确定启用此信息成为条件性列控？";
		tip1 = "启用";
	}else if(type=="edit"){
		tip = "您具有审批权,确定编辑此条件性列控？";
		tip1 = "编辑";
	}else if(type=="repealLK"){
		tip = "您具有审批权,确定禁用此条件性列控？";
		tip1 = "禁用";
	}
	window.top.$.ligerDialog.confirm(tip, "提示",function(ok) {
		if (ok) {
			window.top.$.ligerDialog.close();
			$("#bg").addClass("bg");
			top.$.ligerDialog.waitting('正在提交中,请稍候...');
			$.ajax({
				url:"addApprovalsTJXLKOKPass.action",
				data:data,
				dataType:"json",
				type:"post",
				success:function(mm){
					if ("success" == mm.result) {
						top.$.ligerDialog.success(tip1+"成功！");
						var userid = $("#userid").val();
						getMess(userid);
					} else {
						top.$.ligerDialog.error(tip1+"失败！");
					}
				},error:function(error){
					top.$.ligerDiloag.error(tip1+"失败！" + error.status,"错误");
				}
			});
			$("#bg").removeClass("bg");
			window.top.$.ligerDialog.closeWaitting();
		}
		});
}

function TJXTJ(data){
	window.top.$.ligerDialog.close();
	$("#bg").addClass("bg");
	top.$.ligerDialog.waitting('正在提交中,请稍候...');
	$.ajax({
		url:"addApprovalsTJXLK.action",
		data:data,
		dataType:"json",
		type:"post",
		success:function(mm){
			if("success"==mm.result){
				top.$.ligerDialog.success("列控成功！");
			}else{
				top.$.ligerDialog.error("列控失败！");
			}
			
		},error:function(error){
			$.ligerDialog.error("列控失败！"+error.status,"错误");
		}
	
		
	});
}
//启用
function starts(){
	var TJXLKBH=$("#TJXLKBH").val();
	var url = basepath + "bussiness/aviation/lkgl/tjxlk/tjxlkStartsEdit.jsp?TJXLKBH="+TJXLKBH+"&LB=1";
	commomTj(url,"启用条件列控","starts");
}

//编辑
function edit(){
	var TJXLKBH=$("#TJXLKBH").val();
	var url = basepath + "bussiness/aviation/lkgl/tjxlk/tjxlkStartsEdit.jsp?TJXLKBH="+TJXLKBH+"&LB=3";
	commomTj(url,"编辑条件列控","edit");
}
//撤销条件性列控 
function repealLK(){
	var TJXLKBH=$("#TJXLKBH").val();
	var TJXXBH=$("#TJXXBH").val();
	var url = basepath + "bussiness/aviation/lkgl/tjxlk/tjlkRepeal.jsp?TJXLKBH="+TJXLKBH+"&TJXXBH="+TJXXBH+"";
	commomTj(url,"禁用条件列控","repealLK");
}
//判断是否是局长、副局长来做操作
function pass() {
	$.ajax({
		url : "approvalsModify.action",
		dataType : "json",
		async : false,
		type:"post",
		success : function(data) {
			if ("okpass" == data.result) {
				$("#pass").val("okpass");
				$("#spry").hide();
			} else {
				$("#pass").val("");
			}
		}
	});
}
/**控制打开界面*/
function winOpen(url, title, width, height, button1, button2, callback) {
	window.top.$.ligerDialog.open({
		width : width,
		height : height,
		url : url,
		title : title,
		buttons : [
		           {
		        	   text : button1,
		        	   onclick : function(item, dialog) {
		        		   var fn = dialog.frame.f_validate
		        		   || dialog.frame.window.f_validate;
		        		   var data = fn();
		        		   if (data) {
		        			   callback(data, dialog);
		        		   }
		        	   }
		           }, {
		        	   text : button2,
		        	   onclick : function(item, dialog) {
		        		   dialog.close();
		        	   }
		           } ]
	});
}
