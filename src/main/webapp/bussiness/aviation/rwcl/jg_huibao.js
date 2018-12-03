        //验证非空
        function checkData(){
        	var infodesc = $("#infodesc").val();
      		if(infodesc == null || infodesc == ""){
      			$.ligerDialog.warn("内容不能为空！");
      			return false;
      		}
   			return true;
   		}
        //组装发送到后台的数据
        function addPost(){
        	var infodesc = $("#infodesc").val();
        	var RWCLJGBH = $("#RWCLJGBH").val();
        	var ssxmbh = $("#ssxmbh").val();
        	var CLRBH = $("#CLRBH").val();
			var dataPost = {"ssxmbh":ssxmbh,"taskresults.RWCLJGBH":RWCLJGBH,"infodesc":infodesc,"CLRBH":CLRBH};
			return dataPost;
        }
        /**提交验证*/
        function f_validate() { 
            if (checkData()) {
                $.ligerDialog.waitting('正在保存中,请稍候...');
                 return addPost();
            }
            return null;
        }