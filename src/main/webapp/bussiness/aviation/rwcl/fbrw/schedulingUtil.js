
function f_selectTeam(s){
	var path = $("#basePath").val();
	//关注人
	//payattention(关注表)
	if("payattention"==s){
		var gzids=$("#zlidsgz").val();
		window.top.$.ligerDialog.open({ title: '关注人员信息列表', name:'winselector',width: 1150, height: 600, url:'payattentionQueryListByUserid.action?page=1&pagesize=10&source=rwcl&gzIds='+gzids,
			buttons: [
			          { text: '确定', onclick: f_selectTeamOKGZ },
			          { text: '取消', onclick: function(item,dialog){dialog.close();} }
			         ]                                                                                                                                                                   
		});
		function f_selectTeamOKGZ(item, dialog){
			var fn = dialog.frame.f_select || dialog.frame.window.f_select;
			var data = fn();
			if(data.length>0)
			{
				
				$("#zlidsgz").val('');  //情况预警信息id
				$("#gzxx").html('');    
				
				var strs= new Array(); //定义一数组 
				strs=data.split(":-:"); //字符分割 
				for ( var i = 0; i < strs.length; i++) {
					var str= new Array(); //定义一数组 
					str=strs[i].split(","); //字符分割 
					if(str.length>1)
					{
						var item1="<div id=\""+str[0]+"\" class=\"ckzl_div\">";
						var item2="  <div class=\"ckzl_divtop\">";
						var item3="    <div>关注人</div>";
						var item4="    <img class=\"ckzl_divtop_image nav_href\" onclick=\"removespayattention('"+str[0]+"')\" src=\""+path+"images/common/fk_closeicon.png\"/>";
						var item5="  </div>";
						var item6="  <div class=\"ckzl_divbottom\">";
						var item7="     <img src=\""+str[1]+"\" class=\"clzl_divbottom_image\"/>";
						var item8="     <div class=\"ckzl_divbottom_text\">"+str[2]+" </div>";
						var item9="     <div class=\"ckzl_divbottom_texts\"> "+str[3]+"</div>";
						var item10=" </div>";
						var item11="</div>";
						var content=item1+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11;
						$("#gzxx").append(content);
						var gzids=$("#zlidsgz").val();
						$("#zlidsgz").val(gzids+","+str[0]);
					}
				}
			
				
			}
			dialog.close();
		}
	
		
	
	}
	//盘查信息 
	else if("inventoryinfo"==s){
		var pcids=$("#zlidspc").val();
		window.top.$.ligerDialog.open({ title: '盘查信息列表', name:'winselector',width: 1150, height: 600, url:'inventorysAlllist.action?page=1&pagesize=10&source=rwcl&pcIds='+pcids,
			buttons: [
			          { text: '确定', onclick: f_selectTeamOKPC },
			          { text: '取消', onclick: function(item,dialog){dialog.close();} }
			         ]                                                                                                                                                                   
		});
		function f_selectTeamOKPC(item, dialog){
			var fn = dialog.frame.f_select || dialog.frame.window.f_select;
			var data = fn();
			if(data.length>0)
			{
				
				$("#zlidspc").val('');  //情况预警信息id
				$("#pcxx").html('');    
				var strs= new Array(); //定义一数组 
				strs=data.split(":-:"); //字符分割 
				for ( var i = 0; i < strs.length; i++) {
					var str= new Array(); //定义一数组 
					str=strs[i].split(","); //字符分割 
					if(str.length>1)
					{
						var item1="<div id=\""+str[0]+"\" class=\"ckzl_div\">";
						var item2="  <div class=\"ckzl_divtop\">";
						var item3="    <div>盘查信息</div>";
						var item4="    <img class=\"ckzl_divtop_image nav_href\" onclick=\"removesinventorys('"+str[0]+"')\" src=\""+path+"images/common/fk_closeicon.png\"/>";
						var item5="  </div>";
						var item6="  <div class=\"ckzl_divbottom\">";
						var item7="     <img src=\""+str[1]+"\" class=\"clzl_divbottom_image\"/>";
						var item8="     <div class=\"ckzl_divbottom_text\">"+str[2]+" </div>";
						var item9="     <div class=\"ckzl_divbottom_texts\"> "+str[3]+"</div>";
						var item10=" </div>";
						var item11="</div>";
						var content=item1+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11;
						$("#pcxx").append(content);
						var pcids=$("#zlidspc").val();
						$("#zlidspc").val(pcids+","+str[0]);
					}
				}
			
				
			
				
			}
			dialog.close();
		}
	
		
	}
	//预警信息
	else if("earlywarning"==s){
		var yjids=$("#zlidsyj").val();
		window.top.$.ligerDialog.open({ title: '预警信息列表', name:'winselector',width: 1150, height: 600, url:'earlywarningQueryListByUserid.action?page=1&pagesize=10&source=rwcl&yjIds='+yjids,
			buttons: [
			          { text: '确定', onclick: f_selectTeamOKYJ },
			          { text: '取消', onclick: function(item,dialog){dialog.close();} }
			         ]                                                                                                                                                                   
		});
		function f_selectTeamOKYJ(item, dialog){
			var fn = dialog.frame.f_select || dialog.frame.window.f_select;
			var data = fn();
			if(data.length>0)
			{	
				$("#zlidsyj").val('');  //情况预警信息id
				$("#yjxx").html('');    
				
				var strs= new Array(); //定义一数组 
				strs=data.split(":-:"); //字符分割 
				for ( var i = 0; i < strs.length; i++) {
					var str= new Array(); //定义一数组 
					str=strs[i].split(","); //字符分割 
					if(str.length>1)
					{
						var item1="<div id=\""+str[0]+"\" class=\"ckzl_div\">";
						var item2="  <div class=\"ckzl_divtop\">";
						var item3="    <div>预警信息</div>";
						var item4="    <img class=\"ckzl_divtop_image nav_href\" onclick=\"removesearlywarning('"+str[0]+"')\" src=\""+path+"images/common/fk_closeicon.png\"/>";
						var item5="  </div>";
						var item6="  <div class=\"ckzl_divbottom\">";
						var item7="     <img src=\""+str[1]+"\" class=\"clzl_divbottom_image\"/>";
						var item8="     <div class=\"ckzl_divbottom_text\">"+str[2]+" </div>";
						var item9="     <div class=\"ckzl_divbottom_texts\"> "+str[3]+"</div>";
						var item10=" </div>";
						var item11="</div>";
						var content=item1+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11;
						$("#yjxx").append(content);
						var yjids=$("#zlidsyj").val();
						$("#zlidsyj").val(yjids+","+str[0]);
					}
				}
			}
			dialog.close();
		}
	}
	//管控人员
	else if("controlledpeople"==s){
		var gkids=$("#zlidsgk").val();
		window.top.$.ligerDialog.open({ title: '管控人员列表', name:'winselector',width: 1150, height: 600, url:'gkddcommentlist.action?page=1&pagesize=10&source=rwcl&gkIds='+gkids,
			buttons: [
			          { text: '确定', onclick: f_selectTeamOKGK },
			          { text: '取消', onclick: function(item,dialog){dialog.close();} }
			         ]                                                                                                                                                                   
		});
		function f_selectTeamOKGK(item, dialog){
			var fn = dialog.frame.f_select || dialog.frame.window.f_select;
			var data = fn();
			if(data.length>0)
			{	
				$("#zlidsgk").val('');  //清空管控人员id
				$("#gkxx").html('');    
				
				var strs= new Array(); //定义一数组 
				strs=data.split(":-:"); //字符分割 
				for ( var i = 0; i < strs.length; i++) {
					var str= new Array(); //定义一数组 
					str=strs[i].split(","); //字符分割 
					if(str.length>1)
					{
						var item1="<div id=\""+str[0]+"\" class=\"ckzl_div\">";
						var item2="  <div class=\"ckzl_divtop\">";
						var item3="    <div>管控人员</div>";
						var item4="    <img class=\"ckzl_divtop_image nav_href\" onclick=\"removecontrolledpeople('"+str[0]+"')\" src=\""+path+"images/common/fk_closeicon.png\"/>";
						var item5="  </div>";
						var item6="  <div class=\"ckzl_divbottom\">";
						var item7="     <img src=\""+str[1]+"\" class=\"clzl_divbottom_image\"/>";
						var item8="     <div class=\"ckzl_divbottom_text\">"+str[2]+" </div>";
						var item9="     <div class=\"ckzl_divbottom_texts\"> "+str[3]+"</div>";
						var item10=" </div>";
						var item11="</div>";
						var content=item1+item2+item3+item4+item5+item6+item7+item8+item9+item10+item11;
						$("#gkxx").append(content);
						var yjids=$("#zlidsgk").val();
						$("#zlidsgk").val(yjids+","+str[0]);
					}
				}
			}
			dialog.close();
		}
		
	}
	//案事件
	else if("events"==s){
		var asjids=$("#zlidsasj").val();	
		window.top.$.ligerDialog.open({ title: '案事件信息列表', name:'winselector',width: 1150, height: 600, url:'eventslist.action?page=1&pagesize=10&source=rwcl&asjids='+asjids,
			buttons: [
			          { text: '确定', onclick: f_selectTeamOKASJ },
			          { text: '取消', onclick: function(item,dialog){dialog.close();} }
			         ]                                                                                                                                                                   
		});
		function f_selectTeamOKASJ(item, dialog){
			var fn = dialog.frame.f_select || dialog.frame.window.f_select;
			var data = fn();
			if(data.length>0)
			{	
				$("#zlidsasj").val('');  //清空案事件idd
				$("#asjxx").html('');    
				
				var strs= new Array(); //定义一数组 
				strs=data.split(":-:"); //字符分割 
				for ( var i = 0; i < strs.length; i++) {
					var str= new Array(); //定义一数组 
					str=strs[i].split(","); //字符分割 
					if(str.length>1)
					{
						var item1="<div id=\""+str[0]+"\" class=\"ckzl_div_asj\" style=\"border:0px solid #000\">";
						var item2="  <div class=\"ckzl_divtop_asj\">";
						var item3="    <div>案事件</div>";
						var item4="    <img class=\"ckzl_divtop_image nav_href\" onclick=\"removeevents('"+str[0]+"')\" src=\""+path+"images/common/fk_closeicon.png\"/>";
						var item5="  </div>";
						var item6="  <div class=\"ckzl_divbottom_asj\" style=\"border:0px solid #FF0000\">";
						var item8="     <div class=\"ckzl_divbottom_text_asj\">"+str[1]+"-"+str[2]+" </div>";
						var item9="     <div class=\"ckzl_divbottom_text_asj_time\">"+str[3]+"</div>";
						var item10="    <div class=\"ckzl_divbottom_text_asj_number\">"+str[4]+"</div>";
						var item11="    <div class=\"ckzl_divbottom_text_asj_type\">"+str[5]+"</div>";
						var item12="    <div class=\"ckzl_divbottom_text_asj_airport\">"+str[6]+"&nbsp;<span class=\"ckzl_divbottom_t\">报</span></div>";
						var item13=" </div>";
						var item14="</div>";
						var content=item1+item2+item3+item4+item5+item6+item8+item9+item10+item11+item12+item13+item14;
						$("#asjxx").append(content);
						var yjids=$("#zlidsasj").val();
						$("#zlidsasj").val(yjids+","+str[0]);
					}
				}
			}
			dialog.close();
		}
	}

	return false;
}
/*
 * 删除
 */
//移出预警
function removesearlywarning(id)
{
	$("#"+id).remove();
	var items=$("#zlidsyj").val();
	items=items.replace(id,"");
	$("#zlidsyj").val(items);
}

//移除盘查
function removesinventorys(id)
{
	$("#"+id).remove();
	var items=$("#zlidspc").val();
	items=items.replace(id,"");
	$("#zlidspc").val(items);
}

//移除关注
function removespayattention(id)
{
	$("#"+id).remove();
	var items=$("#zlidsgz").val();
	items=items.replace(id,"");
	$("#zlidsgz").val(items);
}
//移除管控人员
function removecontrolledpeople(id)
{
	$("#"+id).remove();
	var items=$("#zlidsgk").val();
	items=items.replace(id,"");
	$("#zlidsgk").val(items);
}
//移除案事件信息
function removeevents(id)
{
	$("#"+id).remove();
	var items=$("#zlidsasj").val();
	items=items.replace(id,"");
	$("#zlidsasj").val(items);
	
}
