$(function(){
	pageFunc = function(){
		if($(this).parent().hasClass('disabled') || $(this).parent().hasClass('active')) {
			return;
		}
		$('#'+$('#loadCmp').val()).load($(this).attr('data-href'), $('#'+$('#formParamName').val()).val(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	};
	$('.pagination>li>a').on('click', pageFunc);
});