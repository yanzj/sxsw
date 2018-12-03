var actionNodeID;
var actionNodeType;
var form;
$(function () {
	
	$("#tab1").ligerTab({
		contextmenu:false,
		onBeforeSelectTabItem:function(tabid){ 
			
			if(tabid == "yTab"){
				
				}
			
			if(tabid == "gTab"){
				alert("gTab");
				}
			if(tabid == "syTab"){
				alert("syTab");
				}
			
			if(tabid == "sTab"){
				alert("sTab");
				}
			}
		}
		
	);
	//var divHeight = $("#tab1").height() - 28;
	/*$(".my-tab-div").css("height",divHeight);
	$("#userframe").attr("src","system/user/treeTabList.jsp");*/
});


/*function winOpen(url,title,width,height,button1,button2,callback){
	window.top.$.ligerDialog.open({
		width: width, height: height, url: url, title: title, buttons: [{
			text: button1, onclick: function (item, dialog) {
				var fn = dialog.frame.f_validate || dialog.frame.window.f_validate;
				var data = fn();
				if(data){
					callback(data);
					dialog.close();
				}
			}
		},{
			text: button2, onclick: function (item, dialog) {
				dialog.close();
			}
		}]
     });
}*/