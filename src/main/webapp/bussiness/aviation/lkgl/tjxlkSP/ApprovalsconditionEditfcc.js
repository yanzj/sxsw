var basepath;
$(function(){
	basepath = $("#basepath").val();
	//鼠标放上去的样式
	$(".my_info").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".my_info").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	var itemid = $("#itemid").val();
	var type=$("#type").val();
	if(type=="wjs")
	{
		$("#div_spyj").show();
		passOk();        //判断是否有最终的审批权限
	}
	getMess(itemid);

});
function getMess(mid){
	//类别
	//var LB=$("#LB").val();
	$.ajax({
		url:"approvalsconditionQueryById.action", 
		//data:"id="+mid+"&LB="+LB,
		data:"id="+mid,
		dataType:"json", 
		async:false,
		type:"post",
		success:function (mm) {
			//列控条件关键词 start
			if(mm.MZ!=""&&mm.MZ!=null){
				$("#Keyword").html("<div><span class=\"txt_title\">民族</span><span class=\"txt_value\">"+mm.MZMC+"</span><div>");
			}
			if(mm.XM!=""&&mm.XM!=null){
				$("#Keyword").append("<div><span class=\"txt_title\">姓名</span><span class=\"txt_value\">"+mm.XM+"</span><div>");
			}
			if(mm.XB!=""&&mm.XB!=null){
				if(mm.XB==1){
					$("#Keyword").append("<div><span class=\"txt_title\">性别</span><span class=\"txt_value\">男</span><div>");
				}else if(mm.XB==2){
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
			//列控条件关键词 end

			if(mm.LB==0)
			{
				$("#lbs").html("列控");
			}
			else if(mm.LB==1)
			{
				$("#lbs").html("启用");
			}
			else if(mm.LB==2)
			{
				$("#lbs").html("禁用");
			}
			else if(mm.LB==3)
			{
				$("#lbs").html("编辑");
			}

			if(mm.SPZT == 0){
				$("#spzt").html("未审批");
			}
			else if(mm.SPZT ==1){
				$("#spzt").html("上报中");
			}
			else if(mm.SPZT == 2){
				$("#spzt").html("审批中");
			}
			else if(mm.SPZT == 3){
				$("#spzt").html("批准");
			}
			else if(mm.SPZT == 4){
				$("#spzt").html("打回修改");
			}
			$("#CJRXM").html(mm.CJRXM);
			$("#CJRBH").val(mm.CJRBH);
			$("#JCMC").html(mm.JCMC);
			$("#BMMC").html(mm.BMMC);
			$("#CJSJ").html(mm.CJSJ);

			//管控信息 start
			var LKYXSJ;  //列控有效时间
			var GKLBMC;  //管控类别
			var YY;      //原因
			var YJYQ;    //预警要求 
			var BZXX;    //备注信息
			//列控
			if(mm.LB==0)
			{
				LKYXSJ=mm.LKYXSJ;	
				GKLBMC=mm.GKLBMC;
				YY=mm.YY;
				YJYQ=mm.YJYQ;
				BZXX=mm.BZXX;
				$("#div_cxyy").hide();
				$("#div_xgjl").hide();
			}
			//禁用
			else if(mm.LB==2)
			{
				LKYXSJ=mm.ccModel.LKYXSJ_Date;	
				GKLBMC=mm.ccModel.GKLBMC;
				YY=mm.ccModel.YY;
				YJYQ=mm.ccModel.YJYQ;
				BZXX=mm.ccModel.BZXX;

				//禁用  撤销原因
				$("#cxYY").html(mm.YY);
				if(mm.BZXX != "null")
				{
					$("#cxBZXX").html(mm.BZXX);
				}
				else
				{
					$("#cxBZXX").html("");
				}
				$("#div_xgjl").hide();
			}
			//启用
			if(mm.LB==1||mm.LB==3)
			{
				LKYXSJ=mm.ccModel.LKYXSJ_Date;
				GKLBMC=mm.ccModel.GKLBMC;
				YY=mm.ccModel.YY;
				YJYQ=mm.ccModel.YJYQ;
				BZXX=mm.ccModel.BZXX;
				$("#div_cxyy").hide();
                $("#TJXLKBH").val(mm.ccModel.TJXLKBH);
				//修改记录
				var xgjlList=mm.historicalList;
				var item="";
				$(xgjlList).each(function(i, value)
				{
					if(value.ZDMC=="LKYXSJ")
					{
						 item+="<div><span>有效时间&nbsp;&nbsp;</span>";
						 item+="<span>由&nbsp;'"+getdatetwo(value.OLD_VALUE)+"'&nbsp;延期至&nbsp;'"+getdatetwo(value.NEW_VALUE)+"'</span></div>";
					     return;
					}
					if(value.ZDMC=="earlyobject"||value.ZDMC=="earlyonduty"){
				    	return;
				    }
					if(value.ZDMC=="BZXX")
					{
						item+="<div><span>备注信息&nbsp;&nbsp;</span>";
					}
					if(value.ZDMC=="YY")
					{
						item+="<div><span>原因&nbsp;&nbsp;</span>";
					}
					if(value.ZDMC=="YJYQ")
					{
						item+="<div><span>预警要求&nbsp;&nbsp;</span>";
					}
					if(value.ZDMC=="GKLBBH")
					{
						item+="<div><span>列控类别&nbsp;&nbsp;</span>";
					}
					 item+="<span>'"+value.OLD_VALUE+"'&nbsp;更改为&nbsp;'"+value.NEW_VALUE+"'</span></div>";
				    
				});
				var bjyjxx = "";
				if (mm.addYjdx.length > 0) {
					bjyjxx += "<div><font class=\"bjxxfont\">预警对象：</font><span class = \"bjxxspan\">新添加的预警对象是：&nbsp;&nbsp;";
					$(mm.addYjdx).each(function(i, value) {
						bjyjxx += value.NEW_VALUE + "&nbsp;&nbsp;";
					});
					bjyjxx += "</span></div>";
				}
				if (mm.deleteYjdx.length > 0) {
					bjyjxx += "<div><span class = \"bjxxspan\" style=\"margin-left:105px;\">移除的预警对象是：&nbsp;&nbsp;";
					$(mm.deleteYjdx).each(function(i, value) {
						bjyjxx += value.OLD_VALUE + "&nbsp;&nbsp;"
					});
					bjyjxx += "</span></div>";
				}
				if (mm.addYjbm.length > 0) {
					bjyjxx += "<div><font class=\"bjxxfont\">预警值班账号：</font><span style=\"font-size: 12px;margin-left:12px;color: #4c4c4c;\">新添加的预警值班账号是：";
					$(mm.addYjbm).each(function(i, value) {
						bjyjxx += value.NEW_VALUE + "&nbsp;&nbsp;";
					});
					bjyjxx += "<span></div>";
				}
				if (mm.deleteYjbm.length > 0) {
					bjyjxx += "<div><span class = \"bjxxspan\" style=\"margin-left:105px;\">移除的预警值班账号是：&nbsp;&nbsp;";
					$(mm.deleteYjbm).each(function(i, value) {
						bjyjxx += value.OLD_VALUE + "&nbsp;&nbsp;"
					});
					bjyjxx += "<span></div>";
				}
				$("#div_xgjls").html(item+bjyjxx);
			}

			$("#LKYXSJ").html(LKYXSJ);
			$("#LKLB").html(GKLBMC);
			if(mm.BZXX != "null")
			{
				$("#BZXX").html(BZXX);
			}
			else
			{
				$("#BZXX").html("");
			} 
			$("#LKYY").html(YY);
			$("#YJYQ").html(YJYQ);
			//管控信息 end

			//预警部门/预警对象  start
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
			//end

			//获取审批意见集合
			var spyjList=mm.spyjList;
			//提交申请人信息 start
			var item1="<tr><td width=\"25px;\">";
			var bz_img="<img src=\""+basepath+"images/lkgl/fk_webblue.png\"/></td>";
			var item2="<td width=\"20%\"><span class=\"cl_cjsj\">"+mm.CJSJ+"</span></td>";
			var item3="<td width=\"25%\"><span class=\"my_info ry_font\">"+mm.CJRXM+"</span></td>";
			var item4="<td width=\"40%\"><span>"+mm.JCMC+"</span>-<span>"+mm.BMMC+"</span></td>";
			var item5="<td width=\"10%\" style=\"text-align: right;\"><span class=\"lc_zc_font\">提交申请</span></td></tr><tr style=\"height:25px\"></tr>";
			$("#lc_tab").append(item1+bz_img+item2+item3+item4+item5);
			//提交申请人信息 end

			//循环审批意见集合 start
			$(spyjList).each(function(i, value)
					{
				var item1="<tr  class=\"lc_border-bottom\"<td></td>";
				var item2="<td colspan=\"4\">审批人&nbsp;：<span style=\"margin-left: 10px;\"></span>";
				var spczrs="";
				var spczrList=value.spczrList;
				$(spczrList).each(function(i, values)
						{
					spczrs+="<span>&nbsp;&nbsp;"+values.SPRXM+"&nbsp;&nbsp;</span>";
						});
				var item3="</td></tr>";
				if(value.CZZT==0)
				{
					var item4="<tr id=\"wsp\"><td><img src=\""+basepath+"images/lkgl/fk_webdot.png\" /></td>";
					var item5="<td  colspan=\"4\" ><span class=\"lc_zc_font\">未审批</span></td></tr><tr style=\"height:10px\"></tr>";
					$("#lc_tab").append(item1+item2+spczrs+item3+item4+item5);
					$("#spyjbh").val(value.SPYJBH);
				}
				else
				{
					var item4="<tr><td><img src=\""+basepath+"images/lkgl/fk_webblue.png\"/></td>";
					var item5="<td><span class=\"cl_cjsj\">"+value.CZSJ+"</span></td>";
					var item6="<td><span class=\"my_info ry_font\">"+value.CZRXM+"</span></td>";
					var item7="<td><span>"+value.CZRJCMC+"</span>-<span>"+value.CZRBMMC+"</span></td>";
					var item8="<td style=\"text-align: right;\"><span class=\"lc_zc_font\">";
					var CZZT="";
					if(value.CZZT==1)
					{
						CZZT="通过";
					}
					else if(value.CZZT==2)
					{
						CZZT="拒绝";
					}
					else if(value.CZZT==3)
					{
						CZZT="批准";
					}
					else if(value.CZZT==4)
					{
						CZZT="打回修改";
					}
					var item9="</span></td></tr>";
					var item10="<tr><td></td> <td></td>";
					var item11=" <td colspan=\"3\">审批意见：<span>"+value.SPYJ+"</span></td></tr>";
					$("#lc_tab").append(item1+item2+spczrs+item3+item4+item5+item6+item7+item8+CZZT+item9+item10+item11);
				}
					});
			//循环审批意见集合 end


			//判断审批状态
			if(mm.SPZT==0)
			{
				$("#lc_tj_jt").show();
			}
			//上报
			else if(mm.SPZT==1)
			{
				$("#lc_sp_jt").show();
				$("#lc_sp_img").attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
				$("#lc_sp_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg_rey.png');
				$("#lc_tj_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
			}
			else if(mm.SPZT==2)
			{
				//拒绝
				$("#lc_pz_jt").show();
				$("#div_spyj").hide();
				$("#lc_sp_img").attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
				$("#lc_pz_img").attr('src',basepath+'images/lkgl/fk_webpassorg.png');
				$("#lc_tj_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
				$("#lc_sp_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
			}
			else if(mm.SPZT==3)
			{
				//通过
				$("#lc_pz_jt").show();
				$("#div_spyj").hide();
				$("#lc_sp_img").attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
				$("#lc_pz_img").attr('src',basepath+'images/lkgl/fk_webpassorg.png');
				$("#lc_tj_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
				$("#lc_sp_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');

			}
			else if(mm.SPZT==4)
			{
				//打回修改
				$("#lc_tj_jt").show();
			}
		}
	});
}
function getCJRXM(cjrbh){
	if(cjrbh==null){
		cjrbh=$("#CJRBH").val();
	}
	var url = basepath+"system/user/UserMess.jsp?id="+cjrbh;
	window.top.my_openwindow("",url,700,450,"上控人详情信息");
}

//当页面来源于我收到
function passOk(){
	$.ajax({
		url:"approvalsModify.action",
		dataType:"json",
		async:false,
		success:function(data){
			if("okpass"==data.result){
				$("#ok").show();
				$("#sb").hide();
			}else{
				$("#sb").show();
				$("#ok").hide();
			}
		}
	});
}	

//审批意见文字 友好提醒 start
function yj_onfocus()
{
	var value=$("#SPYJ").val();
	if(value=='请填写审批意见')
	{$("#SPYJ").val('');
	$("#SPYJ").css('color','black');
	}
}

function yj_onblur()
{
	var value=$("#SPYJ").val();
	if(value=='')
	{$("#SPYJ").val('请填写审批意见');
	$("#SPYJ").css('color','gray');}
}
//审批意见文字 友好提醒  end

//审批拒绝
function over(){
	var spyj = $("#SPYJ").val();
	if(spyj.trim()=="请填写审批意见"){
		alert("请填写审批意见");
		return;
	}
	var id =$("#itemid").val();
	var spyjbh= $("#spyjbh").val();
	window.top.$.ligerDialog.confirm("确定要拒绝该审批?",function(ok){
		if(ok){
			$.ajax({
				url:"refuseApprovalscondition.action",
				data:"id="+id+"&spyjbh="+spyjbh+"&spyj="+spyj,
				type:"post",
				dataType:"json",
				success:function(data){
					if("noOperate"==data.result){
						$.ligerDialog.success("已经有人审批！");
					}else{
						$.ligerDialog.success("审批成功！");
						$("#div_spyj").hide();
					}
				}
			});
		}
	});
}

//审批通过
function pass(){
	var spyj = $("#SPYJ").val();
	if(spyj.trim()=="请填写审批意见"){
		alert("请填写审批意见");
		return;
	}
	var LB=$("#LB").val();   //类别
	var TJXLKBH=$("#TJXLKBH").val();  //条件性列控编号
	var id =$("#itemid").val();  //审批编号
	var spyjbh= $("#spyjbh").val();
	
	$.ajax({
		url:"passapprovalscondition.action",
		data:"id="+id+"&spyjbh="+spyjbh+"&spyj="+spyj+"&LB="+LB+"&TJXLKBH="+TJXLKBH,
		type:"post",
		dataType:"json",
		async:false,
		success:function(data){
			if("noOperate"==data.result){
				$.ligerDialog.success("已经有人审批！");
			}
			else  if("success"==data.result){
				$.ligerDialog.success("审批成功");
				$("#div_spyj").hide();  //审批意见隐藏

				$("#lc_pz_jt").show();
				$("#lc_tj_jt").hide();
				$("#lc_sp_jt").hide();

				$("#wsp").html('');
				$("#lc_sp_img").attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
				$("#lc_pz_img").attr('src',basepath+'images/lkgl/fk_webpassorg.png');
				$("#lc_tj_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
				$("#lc_sp_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');
				var item4="<tr><td><img src=\""+basepath+"images/lkgl/fk_webblue.png\"/></td>";
				var item5="<td><span class=\"cl_cjsj\">当前时间</span></td>";
				var item6="<td><span class=\"my_info ry_font\">操作人姓名</span></td>";
				var item7="<td><span>机场名称</span>-<span>部门名称</span></td>";
				var item8="<td style=\"text-align: right;\"><span class=\"lc_zc_font\">";
				var CZZT="通过";
				var item9="</span></td></tr>";
				var item10="<tr><td></td> <td></td>";
				var item11=" <td colspan=\"3\">审批意见：<span>"+spyj+"</span></td></tr>";
				$("#lc_tab").append(item4+item5+item6+item7+item8+CZZT+item9+item10+item11);
			}else{
				$.ligerDialog.error("通过失败");
			}
		}
	});
}

function back(){
	var spyj = $("#SPYJ").val();
	if(spyj.trim()=="请填写审批意见"){
		alert("请填写审批意见");
		return;
	}
	$("#cz_but").hide();
	$("#dhxg_but").show();
	$("input[name='box']").show();
	$("#dhxg_but").html("<input  onclick=\"okback()\" type=\"button\" style=\"background-color: #366CB4;border: 1px solid #366CB4\"  class=\"button\" value=\"确认打回\" />&nbsp; &nbsp;");
	$("#dhxg_but").append("<input  onclick=\"qxcz()\" type=\"button\" style=\"background-color: #F07844; border: 1px solid #F07844\" class=\"button\" value=\"取消操作\" />");
}

function okback(){
	var CJRBH=$("#CJRBH").val();
	var value = $("#SPYJ").val();
	if(value=="请填写审批意见"){
		value = "无审批意见";
	}
	var id =$("#itemid").val();
	var str = document.getElementsByName("box");
	var objarray = str.length;
	var chestr="";
	for (var i = 0;i < objarray;i++){
		if(str[i].checked == true){
			chestr+=str[i].value+",";
		}
	}
	if(chestr == ""){
		$.ligerDialog.success("请选择打回要修改的项！");
	}else{
		alert("待完善");
	}
}

function qxcz(){
	var str = document.getElementsByName("box");
	var objarray = str.length;
	for (var i=0;i<objarray;i++){
		str[i].style.display="none";
	}
	$("#cz_but").show();
	$("#dhxg_but").hide();
}

//通过 ，继续上报
function sb(){
	var spyj = $("#SPYJ").val();
	if(spyj.trim()=="请填写审批意见"){
		alert("请填写审批意见");
		return;
	}

	var id =$("#itemid").val();
	var spyjbh= $("#spyjbh").val();
	var url = basepath+"bussiness/aviation/util/choosekjr.jsp";
	winOpen(url,"可见人",500,300,'完成','取消',function(data,dialog){
		$.ajax({
			url:"pass_continue_sb.action?spyj="+spyj+"&id="+id+"&&spyjbh="+spyjbh,
			data:data,
			dataType:"json",
			type:"post",
			success:function (data) {
				if("noOperate"==data.result){
					$.ligerDialog.success("已经有人审批！");
				}
				else if("success" == data.result){
					$.ligerDialog.success("上报成功");
					$("#div_spyj").hide();  //审批意见隐藏

					$("#lc_pz_jt").hide();
					$("#lc_tj_jt").hide();
					$("#lc_sp_jt").show();

					$("#lc_sp_img").attr('src',basepath+'images/lkgl/fk_webapprovalorg.png');
					$("#lc_pz_img").attr('src',basepath+'images/lkgl/fk_webpassgrey.png');
					$("#lc_sp_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg_rey.png');
					$("#lc_tj_zx").attr('src',basepath+'images/lkgl/fk_webdotlineorg.png');

					dialog.close();
				}else{
					$.ligerDialog.error("上报失败");
				}
			},
		});
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
