$(function(){
	$('#findasset').click(function(){
			$('#textspan').hide();
			$('#formParam').val($('#assetform').serialize());
			$('#projectable_asset').load('filter/inRentAsset/findasset',$('#assetform').serialize(),function(){
				$('.pagination>li>a').on('click', pageFunc);
			});
	})
	
	downMenu("#projectName","#project_ul");
	downMenu("#productName","#product_ul");
	showProject();
	$('#productName').val("办公室");
//$('#assetType').val(1);
})
function showProject(){
	$.ajax({
		url :"filter/inRentAsset/selectProject",
		type : "POST",
		dataType : 'json',
		data : {},
		success : function(data){
			var str = "";
			$('#project_ul').html(str);
			for(var i=0;i<data.length;i++){
				str = "<li data-id="+data[i].projectid+">"+data[i].projectname+"</li>";
				$('#project_ul').append(str);
			}
			$("#project_ul > li").click(function(){
				$('#projectName').val($(this).text());
				$('#findprojectid').val($(this).attr('data-id'))
			})
		}
	})
	$("#product_ul > li").click(function(){
				$('#productName').val($(this).text());
				$('#assetType').val($(this).attr('data-id'))
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