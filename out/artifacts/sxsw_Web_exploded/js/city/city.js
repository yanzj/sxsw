/* 
 * 这是一个省市县级联的选择器采用ajax的方式来调用数据源 
 * ajax页面接收3个参数，type,value,pid 这2个参数作为查询条件 
 * 其中level代表地区等级，1=省，2=市，3=县 
 * 另一个参数parentid代表要查询的地区的父级地区 
 *  
 */    
function AreaPicker(config) {  
	
	/* 
	 * 私有属性 
	 */  
	var provId = "#" + config.provId;  
	var cityId = "#" + config.cityId;  
	var townId = "#" + config.townId;  
	var provDefStr = config.provDefStr? config.provDefStr : "--请选择省份--";  
	var cityDefStr = config.cityDefStr? config.cityDefStr : "--请选择地区--";  
	var townDefStr = config.townDefStr? config.townDefStr : "--请选择县市--";  
	var loadingStr = config.loadingStr? config.loadingStr : "正在加载...";  
	var asynSrc = config.url;  
	var asynTimeout = config.timeout ?config.timeout : 5000;  
	var asynMethod = config.method? config.method : "post";  
	var asynCache = config.cache? config.cache : false;  
	var asynDataType = config.asynDataType? config.cache : "json";  
	var async = config.async?config.async:true;



	/** 
	 * 私有方法，作用是初始化选择器的三个下拉框 
	 *  
	 * @param pct 
	 *            参数（p=省，c=地，t=县） 
	 */  
	var initSelect = function(pct) {  
		if (pct.indexOf("p") >= 0) {  
			$(provId).html("<option value=\"\">" + provDefStr + "</option>");  
			$(provId).show();  
		}  
		if (pct.indexOf("c") >= 0){  
			$(cityId).html("<option value=\"\">" + cityDefStr + "</option>");  
			$(cityId).show();  
		}  
		if (pct.indexOf("t") >= 0){  
			$(townId).html("<option value=\"\">" + townDefStr + "</option>");  
			$(townId).show();  
		}  
	};  


	/** 
	 * 私有方法，作用是从数据源页面异步读取地区信息，根据objId，填充到相应的select中 
	 *  
	 * @param objId  用来装查询结果的下拉框对象的id 
	 * @param param  传送给数据源页面的参数，格式为{param:1,level:1} 
	 * @returns 数据源页面的输出内容（例如：235,潮州市;236,东莞市;237,佛山市;238） 
	 */  
	var asynGetArea = function(objId, param, type) { 
		//发送ajax之前  
		var bef = function() {  
			$(objId).html("<option value=\"\">"+loadingStr+"</option>");  
		};
		//发送ajax之后并且服务器返回成功  
		var succ = function(code) { 
			if (type == "province") {  
				$(provId).html("<option value=\"\">" + provDefStr + "</option>");  
			}else if (type == "city"){  
				$(cityId).html("<option value=\"\">" + cityDefStr + "</option>");  
			}else if (type == "county"){  
				$(townId).html("<option value=\"\">" + townDefStr + "</option>");  
			}  
			var htmlCode = ""; 
			if(code.length > 1 && type == "city" || type == "county"){
				$.each(code, function(n, value) {
					if(n!=0){
						htmlCode += "<option value='" + value.id + "'>" + value.text + "</option>";
					}
				});
			}else{
				$.each(code, function(n, value) {
					htmlCode += "<option value='" + value.id + "'>" + value.text + "</option>";
				});
			}
			
			$(objId).append(htmlCode);  
		}; 
		//success方法  
		var successWarpper = function(data) {  
			succ(data);  
		}; 
		//发送ajax之后并且状态错误  
		var err = function(e1, e2) {  
			$(objId).html("<option value=\"\">加载失败: " + e1 + "," + e2 + "</option>");  
		};  
		//ajax各种配置项  
		var asynConfig = {  
				type : asynMethod,  
				async : async,
				cache :asynCache,
				dataType :asynDataType,
				url : asynSrc,  
				data : param,  
				timeout : asynTimeout,  
				beforeSend : bef,  
				success : successWarpper,  
				error : err  
		};  
		//发出请求  
		$.ajax(asynConfig);  
	};  


	/** 
	 * 绑定下拉列表的change和focus事件，用来实现联动效果 
	 */  
	var bindSelect = function() {
		//省份下拉框改变事件的处理函数  
		var provChange = function() {  
			initSelect("ct");  
			var selectVal = $(provId).val();   
			if (selectVal)  
				asynGetArea(cityId,"type=city&id="+selectVal,"city");  
		};  
		//城市下拉框改变事件的处理函数  
		var cityChange = function() {  
			initSelect("t");  
			var pid = $(provId).val();  
			var selectVal = $(cityId).val();  
			if (selectVal)  
				asynGetArea(townId,"type=county&id="+selectVal+"&pid="+pid,"county");  
		};
		//绑定各个事件
		$(provId).change(provChange); 
		$(cityId).change(cityChange);  
	};  




	/** 
	 * 公有方法，用来初始化地区选择器，暴露给外部调用的入口 
	 */  
	return {  
		pick : function() {  
			initSelect("pct");  
			asynGetArea(provId, "type=province","province");  
			bindSelect();  
		}  
	};  
}  
