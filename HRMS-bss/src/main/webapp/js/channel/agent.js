$(function() {
	/*-------------------------查询渠道---------------------------------*/
	$("#query_my_agent_button").on("click",function(){
		$("#agentCurpage").val(0);
		$('#query_info_agent').val($('#query_my_agent').serialize());
		$('#agent_info_de').load("filter/channel/findMyAgent", $('#query_my_agent').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	});
});


	

