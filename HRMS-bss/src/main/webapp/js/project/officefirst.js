$(function() {
	downMenu("#select", "#select_ul");
	downMenu("#flood", "#flood_ul");
	
	downMenu("#projectname", "#project_ul");
	downMenu("#rank_select2", "#rank_select_url2");
	downMenu("#findprojectid","#project_ul");
	$("#rank_select2").click(function(){
		$("#rank_select_url2").hide();
	});
	$("#select").click(function(){
		$("#flood").val("");
		$("#flood_ul").hide();
	});
	$("#flood").click(function(){
		
		if($("#flood").val()==""&&$("#select").val()==""){
			$("#flood_ul").hide();
			alert("请先选择项目")
		}
		$("#select_ul").hide();
	});
	$('#findoffice').click(
			function() {
				var officeName = $('#officeName').val();
				var projectid = $('#projecid').val();
				$('#formParam').val($('#officeform').serialize());
				$('#projectable').load('filter/project/findoffice',
						$('#officeform').serialize(), function() {
					//downMenu("#findprojectid","#project_ul");
					$('.pagination>li>a').on('click', pageFunc);	
						});
				$('#textspan').hide();
				//downMenu("#projectname", "#project_ul");
			})
})

function downMenu(clickClass, dropMenu) {
	$(clickClass).click(function(event) {
		event = event || window.event;
		event.stopPropagation();
		$(dropMenu).toggle();
	});
	$(dropMenu).click(function() {
		$(dropMenu).toggle();
	});
	$(document).click(function(e) {
		$(dropMenu).hide();
	});
}