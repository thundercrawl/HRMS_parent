var currentPage = 0;
$(function(){
	var addOrUpdateMark = 0;//0为add 1为update
	var parameterCode;
	$("#addParam").on("click",function(){
		addOrUpdateMark = 0;
		$("#addPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:300,resizable:false,
			close:function(){
				$('#addPdialog').dialog('destroy');
			}});
		$("#parameterCode").val("");
		$("#paramName").val("");
		$("#startInterval").val("");
		$("#finalInterval").val("");
		$("#serviceType").val("");
		$("#paramValue").val("");
		$("#paramDescribe").val("");
		
	});
	$('#return').on('click',function(){
		$('#addPdialog').dialog('destroy');
	});
	
	$('#paramNameInput').keypress(function(event){  
	    var keycode = (event.keyCode ? event.keyCode : event.which);  
	    if(keycode == '13'){  
	    	$('#queryBtn').trigger('click');
	    }  
	});

	$('.updatePro').on('click',function(){
		currentPage = $(this).attr('data-page');
		addOrUpdateMark = 1;
		$("#addPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:300,resizable:false,
			close:function(){
				$('#addPdialog').dialog('destroy');
			}});
		parameterCode = $(this).attr('data-parameterCode');
		$("#parameterCode").val($(this).attr('data-parameterCode'));
		$("#paramName").val($(this).attr('data-parameterName'));
		$("#startInterval").val($(this).attr('data-startInterval'));
		$("#finalInterval").val($(this).attr('data-finalInterval'));
		$("#serviceType").val($(this).attr('data-serviceType'));
		$("#paramValue").val($(this).attr('data-parameterNumber'));
		$('#paramDescribe').val($(this).attr('data-businessDescribe'));
		$('#status').val($(this).attr('data-status'));
	});

	$('#formcheck').on('click',function(){
		var flag = 0;
		var parameterName=$('#paramName').val();
		var startInterval=$('#startInterval').val();
		var finalInterval=$('#finalInterval').val();
		var serviceType=$('#serviceType').val();
		var parameterNumber=$('#paramValue').val();
		var businessDescribe=$('#paramDescribe').val();
		var status=$('#status').val();
		flag = verifyIsEmpty(parameterName,parameterName,flag);
		flag = verifyIsEmpty(startInterval,startInterval,flag);
		flag = verifyIsEmpty(finalInterval,finalInterval,flag);
		flag = verifyIsEmpty(serviceType,serviceType,flag);
		flag = verifyIsEmpty(parameterNumber,parameterNumber,flag);
		flag = verifyIsEmpty(businessDescribe,businessDescribe,flag);
		flag = verifyIsEmpty(status,status,flag);
		if(flag==0&&addOrUpdateMark==0){
			add();
		}else if(flag==0&&addOrUpdateMark==1){
			update(parameterCode);
		}else{
			alert("请输入合法的数据，感谢您的配合！");
		}
		
		
	})

	$('.deleteParam').on('click',function(){
		$('#page-body').load("filter/configManage/deleteSysBusinessConfig?parameterCode="
				+ $(this).attr('data-parameterCode') + "&page="
				+ $(this).attr('data-page'));
	})

	$('#findproject').on('click',function(){
		var projectname = $('#findInput').val();
		if(projectname=="输入项目的名称"||projectname==""){
			$('#textspan').html("请输入合法的项目名称");
			$('#textspan').css("color","red");
		}
	});
	
	$('#queryBtn').on('click', function() {
		/*document.getElementById("queryForm").submit();*/
		var paramNameInput = $('#paramNameInput').val();
		$('#content').load(
				"filter/configManage/searchSysParamCofig?paramName="+ paramNameInput);
	});
	
	$('#findInput').on('focus',function(){
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


function add(){
	if(window.confirm("确定提交？")){
	var parameterName=$('#paramName').val();
	var startInterval=$('#startInterval').val();
	var finalInterval=$('#finalInterval').val();
	var serviceType=$('#serviceType').val();
	var parameterNumber=$('#paramValue').val();
	var businessDescribe=$('#paramDescribe').val();
	var status=$('#status').val();
	$('#content').load("filter/configManage/addSysBusinessConfig?parameterName="+parameterName+"&startInterval="+startInterval+"&finalInterval="+finalInterval+"&status="+status+"&serviceType"+serviceType+"&parameterNumber"+parameterNumber+"&businessDescribe"+businessDescribe);
	$('#addPdialog').dialog('destroy');
	/*$.ajax({
		url : 'filter/configManage/addSysBusinessConfig',
		type : 'post',
		data : {
			'parameterName':parameterName,
			'startInterval':startInterval,
			'finalInterval':finalInterval,
			'serviceType':serviceType,
			'parameterNumber':parameterNumber,
			'businessDescribe':businessDescribe,
			'status':status
		},
		cache : false,
		dataType : 'text',
		success : function(data) {
			alert(data)
			$('#page-body').load("filter/configManage/sysBusinessCofigPage");
			$('#addPdialog').dialog('destroy');
		}
	});*/
	}	
}


function update(parameterCode){
	if(window.confirm("确定提交？")){
	var parameterName=$('#paramName').val();
	var startInterval=$('#startInterval').val();
	var finalInterval=$('#finalInterval').val();
	var serviceType=$('#serviceType').val();
	var parameterNumber=$('#paramValue').val();
	var businessDescribe=$('#paramDescribe').val();
	var status=$('#status').val();
	$('#content').load("filter/configManage/updateSysBusinessConfig?parameterCode="+parameterCode+"&businessDescribe="+businessDescribe+"&parameterNumber="+parameterNumber+"&serviceType="+serviceType+"&parameterName="+parameterName+"&startInterval="+startInterval+"&status="+status+"&finalInterval="+finalInterval+"&page="+currentPage);
	$('#addPdialog').dialog('destroy');
	/*$.ajax({
		url : 'filter/configManage/updateSysBusinessConfig',
		type : 'post',
		data : {
			'parameterCode':parameterCode,
			'parameterName':parameterName,
			'startInterval':startInterval,
			'finalInterval':finalInterval,
			'serviceType':serviceType,
			'parameterNumber':parameterNumber,
			'businessDescribe':businessDescribe,
			'status':status
		},
		cache : false,
		dataType : 'text',
		success : function(data) {
			alert(data);
			$('#page-body').load("filter/configManage/sysBusinessCofigPage");
			$('#addPdialog').dialog('destroy');
		}
	});
*/	}	
}