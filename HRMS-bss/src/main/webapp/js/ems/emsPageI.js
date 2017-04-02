
$(function(){
	//点击查询
	$("#query_ems_info").on("click",function(){
		$('#query_emsparams').val($('#query_ems_params').serialize());
		$('#ems_page_info').load("filter/ems/showEmsInfo?page=0", $('#query_ems_params').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	});
});
//跳转到消息推送
function add_emsInfo(){
	$("#add_emsInfo").on('click', function() {
		alert("新增消息推送");
//		("filter/ems/home")
	});
}
$("#ems_dialog").dialog({
	modal : true,
	autoOpen : true,
	height : 'auto',
	width : 450,
	resizable : false,
	close : function() {
		$('#ems_dialog').dialog('close');
	}
});



