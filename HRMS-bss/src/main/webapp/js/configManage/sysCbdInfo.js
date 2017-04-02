$(function() {
	var addOrUpdateMark = 0;// 0为add 1为update
	$("#addParam").on("click", function() {
		addOrUpdateMark = 0;
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
		$("#cbdId").val("");
		$("#cbdName").val("");
		$("#countyId").val("");
	});
	$('#return').on('click', function() {
		$('#addPdialog').dialog('destroy');
	});

	$('.updatePro').on('click', function() {
		addOrUpdateMark = 1;
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
		$("#cbdId").val($(this).attr('data-cbdId'));
		$("#cbdName").val($(this).attr('data-cbdName'));
		$("#countyId").val($(this).attr('data-countyId'));
	});

	$('#formcheck').on('click', function() {
		var flag = 1;
		flag = 0;
		if (flag == 0 && addOrUpdateMark == 0) {
			add();
		} else if (flag == 0 && addOrUpdateMark == 1) {
			update();
		} else {
			alert("请输入合法的数据，感谢您的配合！");
		}

	})
	$('#queryBtn').on('click', function() {
		var paramNameInput = $('#paramNameInput').val();
		var paramIdInput = $('#paramIdInput').val();
		$('#page-body').load(
				"filter/configManage/searchSysCbdInfo?paramName="+ paramNameInput+"&paramId="+paramIdInput);
	});

	$('.deleteParam').on('click', function() {
		/*
		 * $('#page-body').load("filter/configManage/deleteSysBusinessConfig?paramId="+
		 * $(this).attr('data-paramid')+"&page="+$(this).attr('data-page'));
		 */
		$('#page-body').load("filter/configManage/deleteSysAssetConfig");
	})

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
	var cbdName = $('#cbdName').val();
	var countyId = $('#countyId').val();
	$('#content').load("filter/configManage/addSysCbdInfo?cbdName="+cbdName+"&countyId="+countyId);
	$('#addPdialog').dialog('destroy');
	/*if (window.confirm("确定提交？")) {
		var cbdName = $('#cbdName').val();
		var countyId = $('#countyId').val();
		$.ajax({
			url : 'filter/configManage/addSysCbdInfo',
			type : 'post',
			data : {
				'cbdName' : cbdName,
				'countyId' : countyId
			},
			cache : false,
			dataType : 'text',
			success : function(data) {
				alert(data);
				$('#addPdialog').dialog('destroy');
			}
		});
	}*/
}

function update() {
	if (window.confirm("确定提交？")) {
		var cbdId = $('#cbdId').val();
		var cbdName = $('#cbdName').val();
		var countyId = $('#countyId').val();
		$.ajax({
			url : 'filter/configManage/updateSysCbdInfo',
			type : 'post',
			data : {
				'cbdId' : cbdId,
				'cbdName' : cbdName,
				'countyId' : countyId
			},
			cache : false,
			dataType : 'text',
			success : function(data) {
				alert(data);
				$('#addPdialog').dialog('destroy');
			}
		});
	}
}