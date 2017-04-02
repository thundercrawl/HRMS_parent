$(function(){
	$('#findmeeting').click(function(){
		var rname = $('#rname').val();
		var projectid = $('#findprojectid').val();
		
			$('#textspan').hide();
			$('#formParam').val($('#meetingfrom').serialize());
			$('#projectable_meet').load('filter/project/findmeeting',$('#meetingfrom').serialize(),function(){
				//downMenu("#findprojectid","#project_ul");
				$('.pagination>li>a').on('click', pageFunc);
			});
			$('#textspan').hide();
			//downMenu("#projectname","#project_ul");
	})	
	
	/*----------------------下拉框---------------------------*/
	downMenu("#findprojectid","#project_ul");
	downMenu("#projectname","#project_ul");
})
  showProject();
function showProjectFlood(projectid){
	$.ajax({
		url :"filter/project/selectProjectFlood",
		type : "POST",
		dataType : 'json',
		data : {
			'projectid' : projectid
		},
		success : function(data){
			var str = "";
			for(var i=0;i<data.length;i++){
				str = "<li>"+data[i].floorMsg+"</li>"
				$('#flood_ul').append(str);
			}
			$("#flood_ul > li").click(function(){
				$('#rname').val('');
				$('#flood').val($(this).text());
			})
		}
	})
}

downMenu("#select","#select_ul");

$("#select").click(function(){
	$("#flood").val("");
	$("#flood_ul").hide();
});
function showProject(){
	$.ajax({
		url :"filter/project/selectProject",
		type : "POST",
		dataType : 'json',
		data : {},
		success : function(data){
			var str = "";
			$('#project_ul').html(str);
			for(var i=0;i<data.length;i++){
				str = "<li data-id="+data[i].projectid+">"+data[i].projectname+"</li>"
				$('#select_ul').append(str);
				$('#project_ul').append(str);
			}
			$('#select_ul > li').click(function(){
				$('#select').val($(this).text());
				var projectid = $(this).attr('data-id');
				$('#projectid').val(projectid);
				$('#flood_ul').html("");
				showProjectFlood(projectid);
			})
			$("#project_ul > li").click(function(){
				$('#projectname').val($(this).text());
				$('#findprojectid').val($(this).attr('data-id'))
				/*$('#rname').val('')
				$('#formParam').val($('#meetingfrom').serialize());
				$('#projectable_meet').load('filter/project/findmeeting',$('#meetingfrom').serialize(),function(){
					downMenu("#findprojectid","#project_ul");
					$('.pagination>li>a').on('click', pageFunc);
				});*/
			})
		}
	})
}

function downMenu(clickClass,dropMenu){
    $(clickClass).click(function(event){
        event=event||window.event;
        event.stopPropagation();
        $(dropMenu).toggle();
    });
    $(dropMenu).click(function(){
        $(dropMenu).toggle();
    });
    $(document).click(function(e){
        $(dropMenu).hide();
    });
  }