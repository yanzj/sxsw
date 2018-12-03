var page=1;
var isend=false;  //判断当所有数据加载完成时，滚动条滑动不在加载数据
var mypath;//项目访问路径
var loading = false;	//判断单次加载数据是否完成
jQuery(function($){
	GKLBBHQueryList();
	mzQueryList();
	$(".float_style").on("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".float_style").on("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	if($("#welcomeJsp").val()=="welcome"){
		var RYXM=$("#RYXM").val().trim();
		var SFZH=$("#GMSFZHM").val().trim();
		if(RYXM!="输入姓名"){
			$("#XM").val(RYXM);
		}
		if(SFZH!="输入身份证号"){
			$("#SFZH").val(SFZH);
		}
		shousuo();
	}
	//文本框默认值点击后清空，移除点击后又赋给默认值
	$("input[holder]").each(function(){
		var $this = $(this);
		$this.addClass("holder");
		$this.val($this.attr("holder"));
	}).on("focusin",function(){
		var $this = $(this);
		if($this.val()==$this.attr("holder")){
			$this.removeClass("holder");
			$this.val("");
		}
	}).on("focusout",function(){
		var $this = $(this);
		if($this.val()==""){
			$this.val($this.attr("holder"));
			$this.addClass("holder");
		}
	}); 
	mypath = $("#mypath").val();
	//限制字符个数
	$(".dian").each(function(){
		var maxwidth=20;
		if($(this).text().length>maxwidth){
			$(this).text($(this).text().substring(0,maxwidth));
			$(this).html($(this).html()+'···');
		}
	});

	//按回车键进行搜索
	$(document).keydown(function(event){
		if(event.keyCode==13){
			shousuo();
		}
	});

	//复选框--勾选了其他的，‘全部’的勾选就取消
	$("input:checkbox[name='box']").on("click",function(){
		if($(this).val()!="全部"){
			$("#qb").attr("checked",false);
		}else{
			$("#lk").attr("checked",false);
			$("#jy").attr("checked",false);
			$("#sqqyz").attr("checked",false);
			$("#sqjyz").attr("checked",false);
			$("#sqbjz").attr("checked",false);
		}
	});
});


//滚动加载
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(!isend&& loading == false){
			page += 1;
			loading = true;
			userlist(page,'more');
		}
	}
});
//点击名字进入详情
function openDialog(BD_RYBH,casename) {
	var url = mypath+"bussiness/aviation/xxcx/gkdd/gkddMess.jsp?BD_RYBH=" + BD_RYBH+"&casename="+casename;
	var tabid = "GDPJ" + "-" + BD_RYBH;
	this.parent.f_click(tabid,casename,url);
}
//搜索查询
function shousuo(){
	var starttime = $("#starttime").val();
	var endtime = $("#endtime").val();
	if(endtime < starttime){
		top.my_alert("结束时间不能小于开始时间!","warn");
		return ;
	}
	//默认的复选框‘全部’勾选
	var checkbox="";
	$("input:checkbox[name='box']:checked").each(function(){
		checkbox += $(this).val()+",";
	});
	if(checkbox==""){
		$("#qb").attr("checked",true);
	}
	page=1;
	isend=false;
	$("#dadiv").html('');
	if(!loading){
		loading = false;
		userlist(page,'search');
	}
}
//数据交互
function userlist(page,type){
	//进入页面提示文字
	$("#div_btm").hide(); 

	//友好提示文字
	$("#loadover").show();
	$("#loadover").html('正在加载中...');

	var starttime=$("#starttime").val();
	var endtime=$("#endtime").val();
	var data = "page="+page+"&pagesize=10"+"&starttime="+starttime+"&endtime="+endtime;
	var GKLBMC = $("#GKLBBH").val();   //人员类别
	var MZMC = $("#MZ").val();         //民族
	var RYXM=$("#XM").val();  //姓名
	var RYXB=$("#XB").val();  //姓别
	//获取数据来源
	var source=$('#source').val();
	var GMSFZHM=$("#SFZH").val().trim();  //身份证号
	var ZZXZ=$("#ZZXZ").val();  //住址
	var checkbox="";
	$("input:checkbox[name='box']:checked").each(function(){
		checkbox += $(this).val()+",";
	});

	data+="&GKLBMC="+GKLBMC+"&MZMC="+MZMC+"&RYXM="+RYXM+"&RYXB="+RYXB+"&GMSFZHM="+GMSFZHM+"&ZZXZ="+ZZXZ+"&checkbox="+checkbox+"&source="+source,

	$.ajax({
		url:"commentlistMore.action",
		data:data,
		dataType:"json",
		type:"post",
		success:function(data){
			var value=data.msg;
			//加载更多
			if(type=='more'&&value.length==2){
				$("#loadover").show();
				$("#loadover").html('数据加载完成');
				isend=true;
				loading = false;
				return;
			}
			//搜索
			else if(type=='search'&&value.length==2){
				$("#loadover").show();
				$("#loadover").html('暂无数据');
				loading = false;
				return; 
			}else{
				$("#loadover").hide();
				var objArray = JSON.parse(value);
				if(objArray.length<10){
					$("#loadover").show();
					$("#loadover").html('数据加载完成');
					isend=true;
				}
				$(objArray).each(function (i, value) { 
					var item1 = "<div class=\"item_style\">";
					var item2="<table style=\"width: 98%;\">";
					var itemcheck="";
					//当来源为添加任务时 显示复选框
					if(source=='rwcl'){
						if(value.ISCHECK){
							itemcheck="<tr><td width=\"3%\" rowspan=\"6\" style=\"text-align: center;\"><input type=\"checkbox\" name=\"sourcecheck\"  checked=\"checked\"  value='"+value.RYBH+","+value.XP+","+value.XM+","+value.GKLBMC+"'/></td></tr>";
						}else{
							itemcheck="<tr><td width=\"3%\" rowspan=\"6\" style=\"text-align: center;\"><input type=\"checkbox\" name=\"sourcecheck\"  value='"+value.RYBH+","+value.XP+","+value.XM+","+value.GKLBMC+"'/></td></tr>";
						}
					}
					var item3="<tr><td rowspan=\"5\"  style=\"width:13%;text-align: center;\"><img src=\""+value.XP+"\"   class=\"controlps_img\" /></td></tr>";
					var item4="<tr><td style=\"font-size: 19px;color: #EF7844;font-weight: bold;\"><span  onclick=\"javascript:openDialog('"+ value.BD_RYBH+ "','"+value.XM+"')\"  class=\"float_style\" >"+value.XM+"</span><span class=\"td_value\" style=\"margin-left: 30px;font-size: 14px;\">";
					if(value.GZBH!=""){
						item4 += "<img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\" />";
					}else{
						item4 += "<img src=\""+mypath+"images/common/fkweb_eyesongrey.png\" />";
					}
					item4 += "</span></td><td><span><span id=\"oneSearch_bt\" class=\"gk_span\">"+value.GKLBMC +"</span>"+value.CJSJ+"&nbsp;&nbsp;&nbsp;"+value.CJRXM+"</span></td>";
					item4 +="<td><span style=\"color:#F07844;font-weight:bold;\">";
					if(value.ZT==0){
						item4 +="列控";
					}else if(value.ZT==1){
						item4 +="禁用";
					}else if(value.ZT==2){
						item4 +="申请启用中";
					}else if(value.ZT==3){
						item4 +="申请禁用中";
					}else if(value.ZT==4){
						item4 +="申请编辑中";
					}
					item4 += "</span></td></tr>";
					var item5="<tr><td style=\"width: 25%\"><span>身份证号：</span><span class=\"td_value\">"+value.SFZH+"</span></td><td style=\"width: 30%\">户口地址：<span class=\"td_value dian\">"+value.HKSZDMC+"</span></td><td style=\"width: 20%\">出生日期：<span class=\"td_value\">"+value.CSRQ+"</span></td></tr><tr><td>护           照       号：<span class=\"td_value\">暂未开放</span></td><td>民      族：<span class=\"td_value\">"+value.MZMC+"</span></td><td>年      龄：<span class=\"td_value\">"+value.NL+"</span></td></tr>";
					var item6="	<tr><td>通行证号：<span class=\"td_value\">暂未开放</span></td><td>性       别：<span class=\"td_value\">";
					if(value.XB==1){
						item6 += "男";
					}else if(value.XB==2){
						item6 += "女";
					}else{
						item6 += "";
					}
					item6 += "</span></td></tr></table></div>";	
					$("#dadiv").append(item1 +item2+itemcheck+item3+item4+item5+item6);
				});

				//限制字符个数
				$(".dian").each(function(){
					var maxwidth=20;
					if($(this).text().length>maxwidth){
						$(this).text($(this).text().substring(0,maxwidth));
						$(this).html($(this).html()+'···');
					}
				});
				loading = false;
			}
		}
	});
}
//获取人员类别下拉框值
function GKLBBHQueryList() {
	$.ajax({
		url:"loadTsdict.action",
		data:"sszdlx=GKLB",
		dataType : "json",
		async : false,
		type:"post",
		beforeSend : function() {
			$("#GKLBBH").append(
					"<option  selected='selected' value='"+-1+"'>" + "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#GKLBBH").empty();
			var text = " <option selected=\"selected\" value=''>--请选择人员类别--</option>";
			$.each(data, function(n, value) {
				text += "<option value='"+value.id+"'>" + value.text + "</option>";
			});
			$("#GKLBBH").append(text);
		}
	});
}
//获取民族下拉框值
function mzQueryList() {
	$.ajax({
		url:"loadTsdict.action",
		data:"sszdlx=GA_MZ",
		dataType : "json",
		async : false,
		type:"post",
		beforeSend : function() {
			$("#MZ").append("<option  selected='selected' value='"+-1+"'>" + "正在加载中,请稍候..." + "</option>");
		},
		success : function(data) {
			$("#MZ").empty();
			var text = " <option selected=\"selected\" value=''>--请选择民族--</option>";
			$.each(data, function(n, value) {
				text += "<option value='"+value.id+"'>" + value.text + "</option>";
			});
			$("#MZ").append(text);
		}
	});
}
/**
选择函数 当模块打开的方式来源于任务模块
 */
function f_select() {
	var checkboxs = "";
	//复选框选中的预警信息列表
	$("input[name='sourcecheck']").each(function() {
		//获取选中的checkbox
		if($(this).prop('checked') == true) {
			checkboxs += $(this).val() + ":-:";
		}
	});
	data = checkboxs;
	return data;
}



