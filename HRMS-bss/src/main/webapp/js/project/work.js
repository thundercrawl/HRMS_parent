$(function(){
	$('#formParam').val($('#workform').serialize());
	$('#addWork').on('click',function(){
		$("#addWdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:344,resizable:false,
			close:function(){
				$('#addWdialog').dialog('destroy');
			}});
		$('#workName').val('');
		$('#rank_select').val('');
		$('#rank_id').val('0');
		$('#homeNum').val('');
		$('#seatNum').val('');
		$('#Finfo').val('');
		$('#areaInfo').val('');
		$('#desc').val('');
		$('#seatid').val(0)
		$('#select').val("");
		$('#flood').val("");
		$('#rankimg').hide();
		$('#nameimg').hide();
		$('#homeimg').hide();
		$('#seatimg').hide();
		$('#proimg').hide();
		$('#floodimg').hide();
		$('#spaceimg').hide();
		$('#descimg').hide();
		$('#areaimg').hide();
	})
	$('#return').on('click',function(){
		$('#addWdialog').dialog('destroy');
	});
	$('.updateSeat').on('click',function(){
		$("#addWdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:320,resizable:false,
			close:function(){
				$('#addWdialog').dialog('destroy');
			}});
		$('#rank_id').val($(this).attr('data-rankId'));
		$('#rank_select').val($(this).attr('data-rankDescribe'));
		$('#workName').val($(this).attr('seatName'));
		$('#homeNum').val($(this).attr('houseNum'));
		$('#seatNum').val($(this).attr('seatNum'));
		$('#flood').val($(this).attr('flood'));
		$('#areaInfo').val($(this).attr('areainfo'));
		$('#desc').val($(this).attr('desc'));
		$('#seatid').val($(this).attr('seatid'));
		$('#seatArea').val($(this).attr('seatArea'));
		$('#projectid').val($(this).attr('projectid'));
		$('#select').val($(this).attr('projectname'));
		$('#rankimg').hide();
		$('#nameimg').hide();
		$('#homeimg').hide();
		$('#seatimg').hide();
		$('#proimg').hide();
		$('#floodimg').hide();
		$('#spaceimg').hide();
		$('#descimg').hide();
		$('#areaimg').hide();
	})
	
	$('#formcheck').click(function(){
		var seatname = $('#workName').val();
		var rank_select = $('#rank_id').val();
		var houseNum = $('#homeNum').val();
		var seatNum = $('#seatNum').val();
		var flood = $('#flood').val();
		var areainfo = $('#areaInfo').val();
		var desc = $('#desc').val();
		var area = $('#seatArea').val();
		var projectid = $('#projectid').val();
		var seatid = $('#seatid').val();
		var page = $('#page').val();
		var re = /^[0-9]+.?[0-9]*$/;
		var Num = /^\d+$/;
		var sNum = 0;
		var rankflag=1;
		if(rank_select==0){
			$('#rankimg').show();
			rankflag = 1;
		}else{
			$('#rankimg').hide();
			rankflag = 0;
		}
		if(seatNum==''){
			$('#seatimg').show();
			sNum = 1;
		}else{
			$('#seatimg').hide();
			sNum = 0;
		}
		var proNum = 0;
		if(projectid==0){
			$('#proimg').show();
			proNum = 1;
		}else{
			$('#proimg').hide();
			proNum = 0
		}
		var nameNum = 0;
		if(seatname.trim()==""){
			$("#nameimg").show();
			nameNum = 1;
		}else{
			$("#nameimg").hide();
			nameNum = 0;
		}
		var hNum = 0;
		if(houseNum==""){
			$("#homeimg").show();
			hNum = 1;
		}else{
			$("#homeimg").hide();
			hNum = 0;
		}
		var floodNum = 0;
		if(!Num.test(flood)){
			$("#floodimg").show();
			floodNum = 1;
		}else{
			$("#floodimg").hide();
			floodNum = 0;
		}
		var areaNum = 0;
		if(areainfo.trim()==""){
			$("#spaceimg").show();
			areaNum = 1;
		}else{
			$("#spaceimg").hide();
			areaNum = 0;
		}
		var descNum = 0;
		if(desc.trim()==""){
			$("#descimg").show();
			descNum = 1;
		}else{
			$("#descimg").hide();
			descNum = 0;
		}
		var areaNum = 0;
		if(!re.test(area)){
			$("#areaimg").show();
			areaNum = 1;
		}else{
			$("#areaimg").hide();
			areaNume = 0;
		}
		if(nameNum==0&&hNum==0&&floodNum==0&&areaNum==0&&descNum==0&&areaNume==0&&proNum==0&&sNum==0){
			$('#content').load('filter/project/saveOrupdateSeat?seatname='+seatname+"&houseNum="+houseNum
					+"&seatNum="+seatNum+"&flood="+flood+"&areainfo="+areainfo+"&desc="+desc+"&page="+page+"&seatid="+seatid+
					"&seatArea="+area+"&projectid="+projectid+"&rankSelect="+rank_select);
			$('#addWdialog').dialog('destroy');
		}
	})
	$('.deletePro').on('click',function(){
		if(confirm("确认删除？")){
			$.ajax({
				url :"filter/project/deletSeatAjax",
				type : "POST",
				dataType : 'json',
				data : {
					seatid:$(this).attr('seatid'),
					page:$(this).attr('page'),
					projectid:$('#findprojectid').val()},
				success : function(data){
					if(data.status=='1'){
						var projectid = data.data.projectid;
						$('#content').load("filter/project/deletSeatLoad?"+
								"&page="+data.data.page+"&projectid="+projectid,
								function(){
							downMenu("#findprojectid","#project_ul");
							$('.pagination>li>a').on('click', pageFunc);
						});
					}else{
						alert(data.message);
					}
				}
			})
		}
//		var projectid = $('#projectid').val();
//		$('#projectable').load('filter/project/deletSeat?seatid='+$(this).attr('seatid')+"&page="+$(this).attr('page')+"&projectid="+projectid);
	})
	$('#findwork').click(function(){
		var rname = $('#workname').val();
		var projectid = $('#findprojectid').val();
		$('#formParam').val($('#workform').serialize());
		$('#projectable').load('filter/project/findwork',$('#workform').serialize(),function(){
			$('.pagination>li>a').on('click', pageFunc);
				downMenu("#findprojectid","#project_ul");
		});
		$('#textspan').hide();
		
	})
	$('#findwork').on('focus',function(){
		$('#textspan').hide();
	})
	/*----------------------下拉框---------------------------*/
	downMenu("#select","#select_ul");
	downMenu("#flood","#flood_ul");
	downMenu("#rank_select", "#rank_select_url");
	$("#rank_select").click(function(){
		$("#rank_select_url").hide();
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
	
/*-----------------------------------------------------*/
	function showFileName(){
		var length = document.getElementById("files").files.length;
		for(var i=0;i<length;i++){
			var file = document.getElementById("files").files[i];
			$("#projectimg").val(file.name);
		}
	}
	$('#files').on('change', showFileName);
	
  showProject();
   showRank();
  $('#addWorkPic').click(function(){
	  $("#addworkPics").dialog({ modal:true,autoOpen:true,height:'auto', width:320,resizable:false,
			close:function(){
				$('#addworkPics').dialog('destroy');
			}});
	  $("#projectimg").val("请选择图片上传");
  })
  
  $('#returnPic').click(function(){
	  $('#addworkPics').dialog('destroy');
  })
  
  $('#formPic').click(function(){
	  var picname = $('#projectimg').val();
		var name = picname.split(".");
		if(name[1]=="png"||name[1]=="jpg"){
			$('#Workform').on('submit', function() {
				$(this).ajaxSubmit({
					type: 'post', // 提交方式 get/post
					url: 'filter/project/addWorkPic', // 需要提交的 url
					dataType:'json',
					async:false,
					data: JSON.stringify($('#Workform').serializeArray()),
					success: function(data) { // data 保存提交后返回的数据，一般为 json 数据
						if(data != 1) {
							var file = $("#files") 
							file.after(file.clone().val("")); 
							file.remove();
							alert("保存成功")
						} else {
						    alert("保存失败")	
						}
					}, 
					error: function(){
						alert("当前网络有问题,请稍后重试!")
					}
				});
				return false; // 阻止表单自动提交事件
			});
			$('#Workform').submit();
		}else{
			alert("您选择的文件不合法！")
		}
  })
  
})
/*-------------------------*/
function showRank(){
	$.ajax({
		url :"filter/project/selectAssetRank",
		type : "POST",
		dataType : 'json',
		data : {assetName:'工位'},
		success : function(data){
			var str2 = "";
			$('#rank_select_url').html(str2);
			for(var i=0;i<data.length;i++){
				str2 = "<li data-id="+data[i].rankId+">"+data[i].rankDescribe+"</li>";
				$('#rank_select_url').append(str2);
			}
			$("#rank_select_url > li").click(function(){
				$('#rank_select').val($(this).text());
				$('#rank_id').val($(this).attr('data-id'));
			})
			downMenu("#rank_select", "#rank_select_url");
			
		}
	})
}
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
			$('#select_ul > li').on('click',function(){
				$('#select').val($(this).text());
				var projectid = $(this).attr('data-id');
				$('#projectid').val(projectid);
				$('#flood_ul').html("");
				showProjectFlood(projectid);
			})
			$("#project_ul > li").on('click',function(){
				$('#projectname').val($(this).text());
				$('#findprojectid').val($(this).attr('data-id'))
				//$('#workname').val('')
				/*$('#formParam').val($('#workform').serialize());
				$('#projectable').load('filter/project/findwork',$('#workform').serialize(),function(){
					$('.pagination>li>a').on('click', pageFunc);
					downMenu("#findprojectid","#project_ul");
				});*/
			})
		}
	})
}

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
			$("#flood_ul > li").on('click',function(){
				$('#flood').val($(this).text());
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
function lock(assetid,lockstatus){
	var btnvalue=$('#lock-'+assetid).val();
	if(btnvalue=="锁定"){
	$.ajax({
		url : 'filter/project/lock',
		type : 'POST',
		data : {
			assetid : assetid,
			type:1
		},
		cache : false,
		dataType : 'json',
		success : function(data) {
			if(data.result=="success"){
				alert("锁定成功")
				$('#lock-'+assetid).val("解锁");
			}else if(data.result=="notFind"){
				alert("资产不存在")
			}else{
				alert("锁定失败")
			}
		},
		error : function(data) {
			alert(error);
		}
	});
	}else if(btnvalue=="解锁"){
		$.ajax({
			url : 'filter/project/unlock',
			type : 'POST',
			data : {
				assetid : assetid,
				type: 1
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				if(data.result=="success"){
					alert("解锁成功")
					$('#lock-'+assetid).val("锁定");
				}else{
					alert("解锁失败")
				}
			},
			error : function(data) {
				alert(error);
			}
		});
		}
}