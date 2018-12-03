// 后台地址
var baseUrl = "http://192.168.100.122:8088/sxsw";

//工具集合Tools
window.T = {};
// 获取当前页面名称(不带后缀名)
var pageName = function() {
	var a = location.href;
	var b = a.split("/");
	var c = b.slice(b.length - 1, b.length).toString(String).split(".");
	return c.slice(0, 1);
};
T.pageName = pageName;

// token
var token = localStorage.getItem("token");
var newname = "";
if (isEmpty(token))
{
	if (T.pageName() != 'login')
	{
		parent.location.href = 'login.jsp';
	}
}
//ajax全局配置
$.ajaxSetup({
	dataType : "json",
	cache : false,
    headers: {
	        "token": token
	    },
	xhrFields : 
	{
		withCredentials : true
	},
	complete : function(xhr) {
		alert(this.type)
		if(this.type=='OPTIONS'){return;}
		// 未登录或者token过期，则跳转到登录页面
		if (xhr.responseJSON.code == 401)
		{
			localStorage.removeItem('token');
			localStorage.removeItem('newname');
			parent.location.href = 'login.jsp';
		}

	}
});

//判断是否为空
function isEmpty(value) {
	return !value || !/\S/.test(value)
}