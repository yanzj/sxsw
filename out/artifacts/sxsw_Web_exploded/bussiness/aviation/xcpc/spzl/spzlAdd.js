var pcbh;
var id;
var userid;
jQuery(function($) {
	pcbh = $("#pcbh").val();
	id = $("#id").val();
	userid = $("#userid").val();
});

//上传视频
function upload(){
	openFileUploadMovies(id,"inventoryveo");
}
//提交数据
function f_validate(){
	var spmc = $("#spmc").val(); //同行人员
	var spms = $("#spms").val(); //电话号码
	var dataPost = {"model.PCSPBH" : id,"model.SSPCBH" : pcbh,"model.SPMC":spmc,"model.SPMS":spms,"model.SPSCRYBH":userid};
	return dataPost;
}