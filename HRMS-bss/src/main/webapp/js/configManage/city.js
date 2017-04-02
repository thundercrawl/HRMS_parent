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
		$("#cityId").val("");
		$("#cityName").val("");
		$("#latitude").val("");
		$("#longitude").val("");
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
		$("#cityId").val($(this).attr('data-cityId'));
		$("#cityName").val($(this).attr('data-cityName'));
		$("#latitude").val($(this).attr('data-latitude'));
		$("#longitude").val($(this).attr('data-longitude'));
	});

	$('#formcheck').on('click', function() {
		var flag = 0;
		var cityId = $("#cityId").val();
		var cityName = $("#cityName").val();
		var latitude = $("#latitude").val();
		var longitude = $("#longitude").val();
		flag = verifyIsEmpty(cityId,cityId,flag);
		flag = verifyIsEmpty(cityName,cityName,flag);
		flag = verifyIsEmpty(latitude,latitude,flag);
		flag = verifyIsEmpty(longitude,longitude,flag);
		if (flag == 0 && addOrUpdateMark == 0) {
			add();
		} else if (flag == 0 && addOrUpdateMark == 1) {
			update();
		} else {
			alert("请输入合法的数据，感谢您的配合！");
		}

	})

	$('.deleteParam').on('click', function() {
		/*
		 * $('#page-body').load("filter/configManage/deleteSysBusinessConfig?paramId="+
		 * $(this).attr('data-paramid')+"&page="+$(this).attr('data-page'));
		 */
		$('#page-body').load("filter/configManage/deleteCity?cityId="
								+ $(this).attr('data-cityId') + "&page="
								+ $(this).attr('data-page'));
	})
	
	$('#queryBtn').on('click', function() {
		var paramNameInput = $('#paramNameInput').val();
		$('#page-body').load(
				"filter/configManage/searchCity?paramName="+ paramNameInput);
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
	if (window.confirm("确定提交？")) {
		var cityId = $("#cityId").val();
		var cityName = $("#cityName").val();
		var latitude = $("#latitude").val();
		var longitude = $("#longitude").val();
		$.ajax({
			url : 'filter/configManage/addCity',
			type : 'post',
			data : {
				'cityId' : cityId,
				'cityName' : cityName,
				'latitude' : latitude,
				'longitude' : longitude
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

function update() {
	if (window.confirm("确定提交？")) {
		var cityId = $("#cityId").val();
		var cityName = $("#cityName").val();
		var latitude = $("#latitude").val();
		var longitude = $("#longitude").val();
		$.ajax({
			url : 'filter/configManage/updateCity',
			type : 'post',
			data : {
				'cityId' : cityId,
				'cityName' : cityName,
				'latitude' : latitude,
				'longitude' : longitude
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