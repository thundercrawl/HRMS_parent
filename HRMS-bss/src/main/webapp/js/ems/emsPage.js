var data=null;
var page;
$(function(){
	page=$(".pagination>li.active").text()-1;

$(".btn.edit").on("click",function(){
	var id=$(this).attr("value");
});

$("#formcheck_sure").on("click",function(){
});
$(".btn.deleteitem").on("click",function(){
	var id=$(this).attr("value");
	if(confirm("确认删除？")){
		$.ajax({
			url : 'filter/ems/delete',
			type : 'POST',
			data : {
				walletItemId : id
			},
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == 'success') {
					$("#"+id+"tr").remove();
				}else{
					alert("删除失败，该科目正在使用中！");
				}
			},
			error : function(data) {
			}
		});
	}
	
});
});
