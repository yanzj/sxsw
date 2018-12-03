var page=1;
var isend=false;  //判断当所有数据加载完成时，滚动条滑动不在加载数据
var mypath;
var loading = false;  //判断单次加载数据是否完成
var types;
var order_type='order_pcsj'; //排序类别，默认为order_pcsj
jQuery(function($){
	gklbList();
	mzList();
	types = $("#type").val();
	$(".float_style").live("mouseover",function(){
		$(this).addClass("my_info_mess");
	});
	$(".float_style").live("mouseout",function(){
		$(this).removeClass("my_info_mess");
	});
	 //文本框默认值点击后清空，移除点击后又赋给默认值
    $("input[holder]").each(function(){
        var $this = $(this);
        $this.addClass("holder");
        $this.val($this.attr("holder"));
    }).live("focusin",function(){
        var $this = $(this);
        if($this.val()==$this.attr("holder")){
          $this.removeClass("holder");
          $this.val("");
        }
    }).live("focusout",function(){
        var $this = $(this);
        if($this.val()==""){
            $this.val($this.attr("holder"));
            $this.addClass("holder");
        }
    }); 
	mypath = $("#mypath").val();
	//按回车键进行搜索
	$(document).keydown(function(event){
		if(event.keyCode==13){
			shousuo();
		}
	});
	
	//管控详情页面跳转
	if($("#searchTj").val()=="pcxx"){
		shousuo();
	}
	//限制字符个数
	$(".dian").each(function(){
		var maxwidth=18;
		if($(this).text().length>maxwidth){
			$(this).text($(this).text().substring(0,maxwidth));
			$(this).html($(this).html()+"....");
		}
	});
	if(types == 'sbr' || types == 'jsr'){
		$("#order_pcsj").css("color", "#386CB5");
		$("#order_pcsj #jt").remove();
	}
});

//按不同方式排序
function order_onclick(item_type,item_value){
	$("#dadiv").html("");
	$("#div_sort div").css("color", "#386CB5");
	$("#div_sort #jt").remove();
	
	//重新赋值
	$("#"+item_type).css("color", "#FC9B71");
	$("#"+item_type).html(item_value);
	$("#"+item_type).append("<span id=\"jt\">↓</span>");
	page=1;
	isend=false;
	order_type=item_type;
	if(!loading){
		loading = true;
		pclist(page,'search',order_type);
	}
}

//点击高级搜索按钮
function gjsc_an(){
	if ($("#div_gjss").is(":hidden")) {
		$("#div_gjss").show(); //如果元素为隐藏,则将它显现
	} else {
		$("#div_gjss").hide(); //如果元素为显现,则将其隐藏
	}
}
//滚动加载
$(window).scroll(function() {
	if ($(document).scrollTop() >= $(document).height()- $(window).height()) {
		if(!isend && !loading){
			page += 1;
			loading = true;
			pclist(page,'more',order_type);
		}
	}
});
function shousuo(){
	var starttime = $("#starttime").val();
	var endtime = $("#endtime").val();
	if(endtime < starttime){
		top.my_alert("结束时间不能小于开始时间!","warn");
		return ;
	}
	page = 1;
	isend=false;
	$("#dadiv").html('');
	if(!loading){
		loading = true;
		pclist(page,'search',order_type);
	}
	
}
//数据加载
function pclist(page,type,order_type){
	
	//进入页面提示文字
    $("#div_btm").hide(); 
    
    //友好提示文字
    $("#loadover").show();
	$("#loadover").html('正在加载中...');
	
	var BD_RYBH = $("#BD_RYBH").val();
	var starttime=$("#starttime").val();
	var endtime=$("#endtime").val();
	var searchvalue=$("#searchvalue").val().trim();
	if("请输入搜索关键词"==searchvalue){
		searchvalue="";
	}
	//获取数据来源
	var source=$('#source').val();
	var lx = $("#lb").val();  //查询条件  管控类型
	var mz = $("#mz").val();  //查询条件   民族
	$.ajax({
		url:"huadongcommentlist.action",
		data:"page="+page+"&pagesize=10&searchvalue="+searchvalue+"&starttime="+starttime+"&endtime="+endtime+"&source="+source+"&lx="+lx+"&mz="+mz+"&type="+types+"&BD_RYBH="+BD_RYBH+"&order_type="+order_type,
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
					
					var itemcheck="";
					//当来源为添加任务时 显示复选框
					if(source=='rwcl'){
						itemcheck+="<div style=\"width:3%;float:left;text-align: center;\">";
						  if(value.ISCHECK)
						  {
						   itemcheck+="<input type=\"checkbox\" name=\"sourcecheck\" style=\"height: 100px;line-height: 100px;\" checked=\"checked\"  value='"+value.PCBH+","+value.XP+","+value.XM+","+value.GKLBMC+"'/>";
						  } 
						  else
						  {
						  itemcheck+="<input type=\"checkbox\" name=\"sourcecheck\"  style=\"height: 100px;line-height: 100px;\" value='"+value.PCBH+","+value.XP+","+value.XM+","+value.GKLBMC+"'/>";
						  }
					 itemcheck+="</div>";
					}
					var item2 = "<div style=\"width:230px;height:100px;float:left;\">";
					var item3 = "<table style=\"width:100%\">";
					var item4 = "<tr><td align=\"center\" colspan=\"2\" style=\"padding-top:40px;\"><span style=\"font-size: 20px;color: #4d4d4d;\">"+value.CJSJ+"</span></td></tr>";
					var item5 = "<tr><td align=\"center\" style=\"padding-top:16px;\"><span style=\"font-size: 18px; color: #4d4d4d;\">"+value.JCMC+"</span></td><td align=\"center\" style=\"text-align: left;padding-top:16px;\"><span style=\"font-size: 18px; color: #366cb3;\">"+value.CJRXM+"</span></td></tr>";
					var item6 = "</table>";
					var item7 = "</div>";
					var item8 = "<div style=\"float:left;height:124px;width:1px;border-right:1px solid #b2b2b2\"></div>";
					var item9 = "<div style=\"width:500px;float:left;\"><table style=\"width: 100%;\">";
					var item10 = "<tr><td rowspan=\"4\" style=\"margin-right:20px;text-align: center;\"><img style=\"width:124px;height:124px;\" src=\""+value.XP+"\"   class=\"controlps_img\" /></td>";
					var item11 = "<td style=\"width:350px;border-bottom:1px solid #b2b2b2;margin-bottom:6px;  font-size: 19px;color: #EF7844;font-weight: bold;\"><span class=\"float_style\" style=\"vertical-align: middle;\" onclick=\"pancharenxq('"+value.PCBH+"','"+value.XM+"');\">"+value.XM+"</span><span>";
					if(value.lsgkcount > 0){
						item11 += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/lsgk.png\" />";
					}
					if(value.tjlkcount > 0){
						item11 += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/tjlk.png\" />";
					}
					if(value.ztrycount > 0){
						item11 += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ztryxx.png\" />";
					}
					if(value.wffzcount > 0){
						item11 += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/fzxx.png\" />";
					}
					if(value.zjrycount > 0){
						item11 += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/jzxyr.png\" />";
					}
					if(value.siscount > 0){
						item11 += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/sisxyr.png\" />";
					}
					if(value.kssrycount > 0){
						item11 += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/ksszyry.png\" />";
					}
					if(value.qlzdcount > 0){
						item11 += "<img class=\"sf_span_style\" src=\""+mypath+"images/gkddxq/qbqlzd.png\" />";
					}
					item11 += "</span><span class=\"td_value\">";
					if(value.GKLBBH != ""){
						if(value.GZBH!=""){
							item11 +="<img src=\""+mypath+"images/common/fkweb_focusonforaimat.png\" style=\"vertical-align: middle;\"/>";
						}else{
							item11 +="<img src=\""+mypath+"images/common/fkweb_eyesongrey.png\" style=\"vertical-align: middle;\"/>";
						}
					}
					item11+="</span></td></tr>";
					item11 += "<tr style=\"margin-top:16px;\"><td><font style=\"font-size:14px;color: #b2b2b2;margin-right:20px;\">身份证号</font><span style=\"font-size:14px;color: #4d4d4d;\">"+value.SFZH+"</span></td>";
					var item12 = "</tr><tr style=\"margin-top:14px;\"><td><font style=\"font-size:14px;color: #b2b2b2;margin-right:20px;\">户口地址</font><span style=\"font-size:14px;color: #4d4d4d;\">"+value.HKSZD+"</span></td></tr>";
					var item13 = "<tr style=\"margin-top:14px;\"><td><font style=\"font-size:14px;color: #b2b2b2;margin-right:20px;\">民 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族</font><span style=\"font-size:14px;color: #4d4d4d;\">"+value.MZMC+"</span></td></tr>";
					var item14 = "</table></div>";
					var item15 = "<div style=\"float:left;width:1px;height:124px;margin:0 10px;background-color: #b2b2b2;\"></div>";
					item15 += "<div><table><tr style=\"border-bottom:1px solid #b2b2b2;\"><td style=\"padding-bottom:12px;padding-top:10px;width:168px;color: #386CB5;\"><span class=\"float_style style_font\" " +
							"onclick=\"sb('"+value.PCBH+"')\">信息上报</span><span style=\"margin-left: 20px\" class=\"float_style\" onclick=\"fprw('"+value.XM+"','"+value.PCBH+"','"+value.GKLBMC+"')\">分配任务</span></td></tr><tr>";
					if(types == "sbr"){
						    item15+="<div style=\"margin: 3px 3px 7px 0px;\">";
						    item15+="<span style=\"display: block;font-size:14px;color: #b2b2b2;\">已上报给：</span>";
							item15+="<span class=\"style_font\">"+value.JSRXM+"</span></div>";
							item15+="<span style=\display: block;font-size:14px;color: #b2b2b2;\">上报时间：</span>";
							item15+="<div style=\"color:#4d4d4d;\" class=\"style_font\">"+value.SBSJ+"</div></td>";
					}
					if(types == "jsr"){
						    item15+="<div style=\"margin: 10px 3px 10px 0px;\">";
							item15+="<span style=\"color: #b2b2b2;margin-top:10px;font-size:14px;color: #b2b2b2;\">上报人：</span><span class=\"style_font\">"+value.SBRXM+"</span></div>";
					        item15+="<span style=\"display: block;font-size:14px;color: #b2b2b2;\">上报时间：</span><div style=\"margin-top:3px;color:#4d4d4d;\" class=\"style_font\">"+value.SBSJ+"</div></td>";
					}
					var item16 = "<tr></table></div><div style=\"clear: both;\"></div>";
					var item17 = "</div>";
					$("#dadiv").append(item1 +itemcheck+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11+item12+item13+item14+item15+item16+item17);
				});
				loading = false;
			}
		}
	});
}
//点击盘查人进入详情
function pancharenxq(id,xm){
	var url = mypath+"pcxxMess.action?pcbh="+id;
	var tabid = "PCLB" + "-" + id;
	this.parent.f_click(tabid,xm,url);
} 

//管控类型
function gklbList(){
	 $.ajax({
		 url:"loadTsdict.action",
		 data:"sszdlx=GKLB",
		dataType:"json",
		beforeSend:function(){
			$("#lb").append("<option  selected='selected' value=''>"+"正在加载中,请稍候..."+"</option>");
		},
		success:function(data){
			$("#lb").empty();
			var text = "<option selected=\"selected\" value=\"\">--请选择管控类别--</option>";
		    $.each(data,function(n,value) {  
			    text +="<option value='"+value.id+"'>"+value.text+"</option>";
		    });
		    $("#lb").append(text);
		}
     });
}
//民族
function mzList(){
	 $.ajax({
		url:"loadTsdict.action",
		data:"sszdlx=GA_MZ",
		dataType:"json",
		beforeSend:function(){
			$("#mz").append("<option  selected='selected' value=''>"+"正在加载中,请稍候..."+"</option>");
		},
		success:function(data){
			$("#mz").empty();
			var text = "<option selected=\"selected\" value=''>--请选择民族--</option>";
		    $.each(data,function(n,value) {  
		    	text +="<option value='"+value.id+"'>"+value.text+"</option>";
		    });
		    $("#mz").append(text);
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
		if ($(this).attr('checked') == true) {
			checkboxs += $(this).val() + ":-:";
		}
	});
	data = checkboxs;
	return data;
}

/**分配任务*/
function fprw(ryxm,pcbh,gklbmc){
    var userimg=$("#userimg").attr("src");
	var url = "bussiness/aviation/rwcl/fbrw/FbrwAdd.jsp?itemid="+pcbh+"&itemtype=inventorys&name="+ryxm+"&gklbmc="+gklbmc+"&userimg="+userimg;
	window.top.my_openwindow("",url,630,600,"发布任务");
	
}

/**上报信息 */
function sb(pcbh){
	var url = mypath+"bussiness/aviation/xcpc/pclb/ShangbaoxxAdd.jsp?pcbh="+pcbh;
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
       				top.my_alert("上报成功!","success");
       			    window.top.my_closewindow();
       			}
			}, 
			error:function (error) {
				top.my_alert("上报失败!" + error.status,"error");
		}});
	 });
}
/**上报人信息*/
function getCJRXM(cjrbh){
	var mypath = $("#mypath").val();
	var url = mypath+"system/user/UserMess.jsp?id="+cjrbh;
	window.top.my_openwindow("",url,700,450,"上报人详情信息");
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