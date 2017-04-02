var currentPage = 0;
$(function() {
	var addOrUpdateMark = 0;// 0为add 1为update
	var paramId;
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
		$("#pId").val("");
		$("#pName").val("");
		$("#pValue").val("");
		$("#pDescribe").val("");

	});
	$('#return').on('click', function() {
		$('#addPdialog').dialog('destroy');
	});
	
	/*$('#paramNameInput').keypress(function(event){  
	    var keycode = (event.keyCode ? event.keyCode : event.which);  
	    if(keycode == '13'){  
	    	$('#queryBtn').trigger('click');
	    }  
	});  */
	
	$('.updatePro').on('click', function() {
		$('#pId').val($(this).attr('data-paramId'));
		$('#pName').val($(this).attr('data-paramName'));
		$('#pValue').val($(this).attr('data-paramValue'));
		$('#pDescribe').val($(this).attr('data-paramDescribe'));
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
	});

	$('#formcheck').on('click', function() {
		var flag = 0;
		var paramId = $('#pId').val();
		var paramName = $('#pName').val();
		var paramValue = $('#pValue').val();
		var paramDescribe = $('#pDescribe').val();
		var ParamId = $('#paramId').val();
		var ParamName = $('#paramName').val();
		flag = verifyIsEmpty(paramId,paramId,flag);
		flag = verifyIsEmpty(paramName,paramName,flag);
		flag = verifyIsEmpty(paramValue,paramValue,flag);
		flag = verifyIsEmpty(paramDescribe,paramDescribe,flag);
		if (flag == 0 && addOrUpdateMark == 0) {
			add(ParamId,ParamName);
			} else if (flag == 0 && addOrUpdateMark == 1) {
			update(ParamId,ParamName);
		} else {
			alert("请输入合法的数据，感谢您的配合！");
		}
	})

	$('.deleteParam').on('click',function() {
		if (window.confirm("确定提交？")) {
			var paramid = $('#paramId').val();
			var paramname = $('#paramName').val();
				$('#content').load(
						"filter/configManage/deleteSysParamConfig?paramId="+ $(this).attr('data-paramid') + "&page="
								+ $(this).attr('data-page')+"&paramid="+paramid+"&paramname="+paramname);
		}
			})

	$('#findproject').on('click', function() {
		var projectname = $('#findInput').val();
		if (projectname == "输入项目的名称" || projectname == "") {
			$('#textspan').html("请输入合法的项目名称");
			$('#textspan').css("color", "red");
		}
	});
	$('#paramStatusUl').find('li').on('click',function(){
		alert(this.val())
	})
	
	$('#queryBtn').on('click', function() {
		$('#companySearchCondition').val($('#queryForm').serialize());
		$('#content').load("filter/configManage/searchSysParamCofig",$('#queryForm').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
		/*$('#content').load(
				"filter/configManage/searchSysParamCofig?paramName="+ paramNameInput);*/
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

function add(paramid,paramname) {
	if (window.confirm("确定提交？")) {
		var paramId = $('#pId').val();
		var paramName = $('#pName').val();
		var paramValue = $('#pValue').val();
		var paramDescribe = $('#pDescribe').val();
		/*var status = $('#status').val();*/
		$('#content').load("filter/configManage/addSysParamConfig?paramName="+paramName+"&paramValue="+paramValue+"&paramDescribe="+paramDescribe+"&paramId="+paramId+"&status=1"+"&paramid="+paramid+"&paramname="+paramname);
		$('#addPdialog').dialog('destroy');
		/*$.ajax({
			url : 'filter/configManage/addSysParamConfig',
			type : 'post',
			data : {
				'paramName' : paramName,
				'paramValue' : paramValue,
				'paramDescribe' : paramDescribe,
				'status' : status
			},
			cache : false,
			dataType : 'text',
			success : function(data) {
				$('#page-body').load("filter/configManage/sysParamCofigPage");
				$('#addPdialog').dialog('destroy');
			}
		});*/
	}
}

function update(paramid,paramname) {
	if (window.confirm("确定提交？")) {
		var paramId = $('#pId').val();
		var paramName = $('#pName').val();
		var paramValue = $('#pValue').val();
		var paramDescribe = $('#pDescribe').val();
		$('#content').load("filter/configManage/updateSysParamConfig?paramName="+paramName+"&paramValue="+paramValue+"&paramDescribe="+paramDescribe+"&paramId="+paramId+"&page="+currentPage+"&status=1"+"&paramid="+paramid+"&paramname="+paramname);
		$('#addPdialog').dialog('destroy');
		/*$.ajax({
			url : 'filter/configManage/updateSysParamConfig',
			type : 'post',
			data : {
				'paramId' : paramId,
				'paramName' : paramName,
				'paramValue' : paramValue,
				'paramDescribe' : paramDescribe,
				'status' : status
			},
			cache : false,
			dataType : 'text',
			success : function(data) {
				$('#page-body').load("filter/configManage/sysParamCofigPage");
				$('#addPdialog').dialog('destroy');
			}
		});*/
	}
}