$(function(){
//	downMenu("#select","#select_ul");
//	downMenu("#flood","#flood_ul");
//	
//	downMenu("#projectname","#project_ul");
	showProject();
	 showRank();

/*-----------------------------------------------------*/
	$('#formParam').val($('#officeform').serialize());
	$('#addOffice').on('click',function(){
		$("#addOdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:355,resizable:false,
			close:function(){
				$('#addOdialog').dialog('destroy');
			}});
		$('#officeName').val('');
		$('#rank_select2').val('');
		$('#rank_id2').val('0');
		$('#homeNum').val('');
		$('#Finfo').val('');
		$('#areainfo').val('');
		$('#space').val('');
		$('#describ').val('');
		$('#officeid').val('0');
		$('#select').val("");
		$('#flood').val("");
		$('#rankimg').hide();
		$('#meetimg').hide();
		$('#offimg').hide();
		$('#proimg').hide();
		$('#floodimg').hide();
		$('#spceimg').hide();
		$('#contentimg').hide();
		$('#areaimg').hide();
		$('#descimg').hide();
	})
	$('#return').on('click',function(){
		$('#addOdialog').dialog('destroy');
	});
	
	$('#officeName').on('focus',function(){
		$('#textspan').hide();
	})

	
	$('#formcheck').click(function(){
		var office = $('#officename').val();
		var rank_select = $('#rank_id2').val();
		var homeNum = $('#homeNum').val();
		var flood = $('#flood').val();
		var areainfo = $('#areainfo').val();
		var content = $('#space').val();
		var desc = $('#describ').val();
		var projectid = $('#projectid').val();
		var officeid = $('#officeid').val();
		var area = $('#officeArea').val();
		var re = /^[0-9]+.?[0-9]*$/;
		var Num = /^\d+$/;
		var descNum = 0;
		var rankflag=1;
		
		if(rank_select==0){
			$('#rankimg').show();
			rankflag = 1;
		}else{
			$('#rankimg').hide();
			rankflag = 0;
		}
		if(desc.trim()==""){
			$('#descimg').show();
			descNum = 1;
		}else{
			$('#descimg').hide();
			descNum = 0;
		}
		var spNum = 0;
		if(areainfo.trim()==""){
			$('#spceimg').show();
			spNum = 1;
		}else{
		    $('#spceimg').hide();
		    spNum = 0;
		}
		var floodNum = 0;
		if(!Num.test(flood)){
			$('#floodimg').show();
			floodNum = 1;
		}else{
			$('#floodimg').hide();
			floodNum = 0;
		}
		var proNum = 0;
		if(projectid==0){
			$('#proimg').show();
			proNum = 1;
		}else{
			$('#proimg').hide();
			proNum = 0;
		}
		var offNum = 0;
		if(office.trim()==""){
			$('#offimg').show();
			offNum = 1;
		}else{
			$('#offimg').hide();
			offNum = 0;
		}
		var areaNum=0;
		if(!re.test(area)){
			$('#areaimg').show();
			areaNum = 1;
		}else{
			$('#areaimg').hide();
			areaNum = 0;
		}
		var home=0;
		if(homeNum==""){
			$('#meetimg').show();
			home = 1;
		}else{
			$('#meetimg').hide();
			home = 0;
		}
		var contentN = 0;
		if(!Num.test(content)){
			$('#contentimg').show();
			contentN = 1;
		}else{
			$('#contentimg').hide();
			contentN = 0;
		}
		if(descNum==0&&spNum==0&&floodNum==0&&proNum==0&&offNum==0&&areaNum==0&&home==0&&contentN==0){
			$('#content').load("filter/project/addOffice?officename="+office+"&page="+$(this).attr('page')+
					"&homeNum="+homeNum+"&flood="+flood+"&areainfo="+areainfo+"&officearea="+area+
					"&content="+content+"&desc="+desc+"&projectid="+projectid+"&officeid="+officeid
					+"&rankSelect="+rank_select,function(){
				$('.pagination>li>a').on('click', pageFunc);
			});
			$('#addOdialog').dialog('destroy');
		}
	})
	
	$('.updateOff').on('click',function(){
		$("#addOdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:355,resizable:false,
			close:function(){
				$('#addOdialog').dialog('destroy');
			}});
		$('#officename').val($(this).attr('data-projectname'));
		$('#rank_id2').val($(this).attr('data-rankId'));
		$('#rank_select2').val($(this).attr('data-rankDescribe'));
		$('#homeNum').val($(this).attr('data-proname'));
		$('#flood').val($(this).attr('data-flood'));
		$('#areainfo').val($(this).attr('data-area'));
		$('#space').val($(this).attr('data-bname'));
		$('#describ').val($(this).attr('data-address'));
		$('#officeid').val($(this).attr('data-officeid'));
		$('#status').val($(this).attr('data-status'));
		$('#officeArea').val($(this).attr('officearea'));
		$('#projectid').val($(this).attr('projectid'));
		$('#select').val($(this).attr('projectname'));
		$('#rankimg').hide();
		$('#meetimg').hide();
		$('#offimg').hide();
		$('#proimg').hide();
		$('#floodimg').hide();
		$('#spceimg').hide();
		$('#contentimg').hide();
		$('#areaimg').hide();
		$('#descimg').hide();
	})
	$('.deleteOff').click(function(){
		if(confirm("确认删除？")){
			$.ajax({
				url :"filter/project/deletOffAjax",
				type : "POST",
				dataType : 'json',
				data : {
					officeid:$(this).attr('officeid'),
					page:$(this).attr('data-page'),
					projectid:$('#projectid').val()
					},
				success : function(data){
					if(data.status=='1'){
						var projectid = data.data.projectid;
						$('#projectable').load("filter/project/deletOffLoad?"+
								"&page="+data.data.page+"&projectid="+projectid,
								function(){
							$('.pagination>li>a').on('click', pageFunc);
						});
					}else{
						alert(data.message);
					}
				}
		})
		}
	})
	function showFileName(){
		var length = document.getElementById("files").files.length;
		for(var i=0;i<length;i++){
			var file = document.getElementById("files").files[i];
			$("#projectimg").val(file.name);
		}
	}
	$('#files').on('change', showFileName);
	 
	$('#addOfficePic').click(function(){
		$("#officePic").dialog({ modal:true,autoOpen: true,height:'auto', width:355,resizable:false,
			close:function(){
				$('#officePic').dialog('destroy');
			}});
		$("#projectimg").val("请选择图片上传");
	})
	$('#returnpic').click(function(){
		$('#officePic').dialog('destroy');
	})
	$('#formPic').click(function(){
		var picname = $('#projectimg').val();
		var name = picname.split(".");
		if(name[1]=="png"||name[1]=="jpg"){
			$('#prpjectpic').on('submit', function() {
				$(this).ajaxSubmit({
					type: 'post', // 提交方式 get/post
					url: 'filter/project/addofficePic', // 需要提交的 url
					dataType:'json',
					async:false,
					data: JSON.stringify($('#prpjectpic').serializeArray()),
					success: function(data) { // data 保存提交后返回的数据，一般为 json 数据
						if(data != 1) {
							var file = $("#files") 
							file.after(file.clone().val("")); 
							file.remove();
							$(".alert-mask").hide();
							$("#prpjectpic").hide();
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
			$('#prpjectpic').submit();
		}else{
			alert("您选择的文件不合法！")
		}
	})
	
})
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
function showRank(){
	$.ajax({
		url :"filter/project/selectAssetRank",
		type : "POST",
		dataType : 'json',
		data : {assetName:'办公室'},
		success : function(data){
			var str2 = "";
			$('#rank_select_url2').html(str2);
			for(var i=0;i<data.length;i++){
				str2 = "<li data-id="+data[i].rankId+">"+data[i].rankDescribe+"</li>";
				$('#rank_select_url2').append(str2);
			}
			$("#rank_select_url2 > li").click(function(){
				$('#rank_select2').val($(this).text());
				$('#rank_id2').val($(this).attr('data-id'));
			})
			downMenu("#rank_select2", "#rank_select_url2");
			
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
				$('#findprojectid').val($(this).attr('data-id'));
				/*$('#officeName').val('');
				$('#formParam').val($('#officeform').serialize());
				$('#projectable').load('filter/project/findoffice',$('#officeform').serialize(),function(){
					downMenu("#findprojectid","#project_ul");
					$('.pagination>li>a').on('click', pageFunc);
				});*/
			})
		}
	})
}
function lock(assetid,lockstatus){
	var btnvalue=$('#lock-'+assetid).val();
	if(btnvalue=="锁定"){
	$.ajax({
		url : 'filter/project/lock',
		type : 'POST',
		data : {
			assetid : assetid,
			type: 3
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
				type: 3
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