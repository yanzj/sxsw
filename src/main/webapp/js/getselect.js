/**
用来获取后台下拉框数据
id 下拉框的id
dtype:数据类型
dkey:默认的选择
valueID:获取值得text id
*/
function  getSelect(id,dtype,dkey,valueID){
	var m = $("#"+id).ligerComboBox({
			    width : 180,
			    url:"getHTMLSelect.action",
			    parms:[{name: 'dictType', value: dtype}],
			    isMultiSelect:false,
			    valueField: 'id',
			    selectBoxWidth: 200,
			    onSelected: function (newvalue){
				        $("#"+valueID).val(newvalue);
		                }
			}); 
  	m.selectValue(dkey);
}
