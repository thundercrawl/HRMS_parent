$(function() {
	var addOrUpdateMark = 0;// 0为add 1为update
	var rankId;
	var currentPage = 0;
	/*alert("Ceshi")
	alert($('#tbody').attr("data-totalCnt"))
	alert($('#tbody').attr("data-pageSize"))
	alert($('#tbody').attr("data-page"))*/
	$("#addParam").on("click", function() {
		addOrUpdateMark = 0;
		$("#rankId").val("");
		$("#assetType").val("");
		$("#assetRank").val("");
		$("#rankDescribe").val("");
		$("#addPdialog").dialog({
			modal : true,
			autoOpen : true,
			height : 'auto',
			width : 300,
			resizable : false,
			close : function() {
				$('#addPdialog').dialog('destroy');
			}
		});
		
	});
	$('#return').on('click', function() {
		$('#addPdialog').dialog('destroy');
	});
	$('.updatePro').on('click', function() {
		addOrUpdateMark = 1;
		currentPage = $(this).attr('data-page');
		$("#addPdialog").dialog({
			modal : true,
			autoOpen : true,
			height : 'auto',
			width : 300,
			resizable : false,
			close : function() {
				$('#addPdialog').dialog('destroy');
			}
		});
		rankId =$(this).attr('data-rankId');
		$("#rankDescribe").val($(this).attr('data-rankDescribe'));
		var te= $(this).attr('data-spaceId');
		$('#selectSpace > option').each(function(){if($(this).val() ==te) $(this).selected()})});
	

	$('#formcheck').on('click', function() {
		var flag = 0;
		var assetType = $('#selectSpace option:selected').text();
		var rankDescribe = $('#rankDescribe').val();
		/*var status = $('#status').val();*/
		flag = verifyIsEmpty(assetType,assetType,flag);
		flag = verifyIsEmpty(rankDescribe,rankDescribe,flag);
		/*flag = verifyIsEmpty(status,status,flag);*/
		if (flag == 0 && addOrUpdateMark == 0) {
			add();
		} else if (flag == 0 && addOrUpdateMark == 1) {
			update(rankId,currentPage);
		} else {
			alert("请输入合法的数据，感谢您的配合！");
		}

	})
$('.deleteParam').on('click',function(){if(confirm("确定操作？")){
	$('#content').load("filter/configManage/deleteSysAssetConfig?rankId="+$(this).attr('data-rankId')+"&page="+$(this).attr('data-page'),function(){
		alert($('#forMessage').val());
	});
	}});


	/*$('.deleteParam').on('click', function() {
		$('#projectable').load("filter/configManage/deleteSysAssetConfig?rankId="+$(this).attr('data-rankId')+"&page="+$(this).attr('data-page'));
	})*/
	
	$('#queryBtn').on('click', function() {
		var paramNameInput = $('#rankId').val();
		var fromTime = $('#fromTime').val();
		var toTime = $('#toTime').val();
		$('#projectable').load(
				"filter/configManage/showSysAssetCofig?rankId="+ paramNameInput+"&page=0&fromTime="+fromTime+"&toTime="+toTime);
	});

	$('#findproject').on('click', function() {
		var projectname = $('#findInput').val();
		if (projectname == "输入项目的名称" || projectname == "") {
			$('#textspan').html("请输入合法的项目名称");
			$('#textspan').css("color", "red");
		}
	});

	$('#findInput').on('focus', function() {
		$('#textspan').html("");
	})
	
	 $('.form_datetime').datetimepicker({
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
		});
		$('.form_date').datetimepicker({
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
		});
		$('.form_time').datetimepicker({
			lang: 'ch',
			timepicker: false,
			format: 'Y-m-d',
			formatDate: 'Y-m-d',
		});
	
})

function verifyIsEmpty(id,idValue,flag){
	if(flag==1){
		if(idValue==""){
			$("#"+id+"Span").style = "18px";
			$("#"+id+"Span").html('X');
			$("#"+id+"Span").css("color","red");
		}else{
			$("#"+id+"Span").style = "18px";
			$("#"+id+"Span").html('√');
			$("#"+id+"Span").css("color","green");
		}
	}else if(flag==0){
		if(idValue==""){
			$("#"+id+"Span").style = "18px";
			$("#"+id+"Span").html('X');
			$("#"+id+"Span").css("color","red");
			flag = 1;
		}else{
			$("#"+id+"Span").style = "18px";
			$("#"+id+"Span").html('√');
			$("#"+id+"Span").css("color","green");
			flag = 0;
		}
	}
	
	return flag;
}

function add() {
	var assetType = $('#selectSpace option:selected').text();
	var spaceId = $('#selectSpace option:selected').val();
	var rankDescribe = $('#rankDescribe').val();
	/*var status = $('#status').val();*/
	$('#content').load("filter/configManage/addSysAssetConfig?assetType="+assetType+"&rankDescribe="+rankDescribe+"&spaceId="+spaceId);
	$('#addPdialog').dialog('destroy');
	/*if (window.confirm("确定提交？")) {
		var assetType = $('#assetType').val();
		var assetRank = $('#assetRank').val();
		var rankDescribe = $('#rankDescribe').val();
		var status = $('#status').val();
		$.ajax({
			url : 'filter/configManage/addSysAssetConfig',
			type : 'post',
			data : {
				'assetType' : assetType,
				'assetRank' : assetRank,
				'rankDescribe' : rankDescribe,
				'status' : status
			},
			cache : false,
			dataType : 'text',
			success : function(data) {
				$('#page-body').load("filter/configManage/sysAssetCofigPage");
				$('#addPdialog').dialog('destroy');
			}
		});
	}*/
}

function update(rankId,currentPage) {
	if (window.confirm("确定提交？")) {
		var assetType = $('#selectSpace option:selected').text();
		var rankDescribe = $('#rankDescribe').val();
		/*var status = $('#status').val();*/
		$('#content').load("filter/configManage/updateSysAssetConfig?assetType="+assetType+"&rankDescribe="+rankDescribe+"&rankId="+rankId+"&page="+currentPage);
		$('#addPdialog').dialog('destroy');
		/*alert(rankId)
		$.ajax({
			url : 'filter/configManage/updateSysAssetConfig',
			type : 'post',
			data : {
				'rankId' : rankId,
				'assetType' : assetType,
				'assetRank' : assetRank,
				'rankDescribe' : rankDescribe,
				'status' : status
			},
			cache : false,
			dataType : 'text',
			success : function(data) {
				alert(data);
				$('#page-body').load("filter/configManage/sysAssetCofigPage");
				$('#addPdialog').dialog('destroy');
			}
		});*/
	}
}