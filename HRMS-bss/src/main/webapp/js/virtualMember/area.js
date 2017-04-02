$(function() {
	$('#areaSearch').on('click',function(){
		var companyId=$("#companyId").val();
		var companyName=$("#companyName").val();
		$('#areaSearchCondition').val($('#forid').serialize());
		$('#tid').load("filter/member/getAreaQuerry",$('#forid').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	})
})