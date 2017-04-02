$(function() {
	var addOrUpdateMark = 0;// 0为add 1为update
	var spaceId;
	var page;
	var pUrl="";
	$("#addParam").on("click", function() {
		addOrUpdateMark = 0;
		$("#addPdialog").dialog({
			modal : true,
			autoOpen : true,
			height : 'auto',
			width : 330,
			resizable : false,
			close : function() {
				$('#addPdialog').dialog('destroy');
			}
		});
		$("#spaceId").val("");
		$("#spaceName").val("");
		$("#projectId").val("");
		$("#spaceDescribe").val("");
		$("#photoUrl").val("");
	});
	
	$("body").delegate("#return","click",function(){$('#addPdialog').dialog('destroy');});
	
	
	/*$('#return').on('click', function() {
		$('#addPdialog').dialog('destroy');
	});*/
	$("body").delegate(".updatePro","click",function(){
		addOrUpdateMark = 1;
		$("#addPdialog").dialog({
			modal : true,
			autoOpen : true,
			height : 'auto',
			width : 330,
			resizable : false,
			close : function() {
				$('#addPdialog').dialog('destroy');
			}
		});
		spaceId=$(this).attr('data-spaceId');
		page=$(this).attr('data-page');
		$("#projectId").val($(this).attr('data-projectId'));
		$("#spaceDescribe").val($(this).attr('data-spaceDescribe'));
		/*$("#file").val($(this).attr('data-photoUrl'));*/
		$("#spaceName").val($(this).attr('data-spaceName'));
		var te = $(this).attr('data-projectId');
		$('#selectProject > option').each(function(){if($(this).val() ==te) $(this).selected()})});
	/*$('.updatePro').on('click', function() {
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
		spaceId=$(this).attr('data-spaceId');
		page=$(this).attr('data-page');
		$("#spaceName").val($(this).attr('data-spaceName'));
		$("#projectId").val($(this).attr('data-projectId'));
		$("#spaceDescribe").val($(this).attr('data-spaceDescribe'));
		$("#photoUrl").val($(this).attr('data-photoUrl'));
	});*/

	/*$("#projectable").delegate("#formcheck","click",function(){$('#projectpic').submit();});*/
	
	
	$('#formcheck').on('click', function() {
		$('#projectpic').submit();
	})
/*$("body").delegate(".deleteParam","click",function(){if(confirm("确定删除？")){
	$('#content').load("filter/configManage/deleteOfcSpaceType?spaceId="+$(this).attr('data-spaceId')+"&page="+$(this).attr('data-page'),function(){
		alert(message);
	});
	
	}});*/
	$('.deleteParam').on('click', function() {
		if(confirm("确定删除？")){
		$('#content').load("filter/configManage/deleteOfcSpaceType?spaceId="+$(this).attr('data-spaceId')+"&page="+$(this).attr('data-page'),function(){
			alert(message);
		});
		
		}
		
		})

	$('#queryBtn').on('click', function() {
		var paramNameInput = $('#paramName').val();
		var spaceIdInput = $('#pId').val();
		$('#projectable').load("filter/configManage/showOfcSpaceType?page=0&paramName="+paramNameInput+"&pId="+spaceIdInput, function(){
			$('.pagination>li>a').on('click', pageFunc);
		})
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
	
	$('#projectpic').on('submit', function() {
		$(this).ajaxSubmit({
			type: 'post', // 提交方式 get/post
			url: 'filter/configManage/addProjectPic', // 需要提交的 url
			dataType:'json',
			async:false,
			data:{},
			success: function(data) {
				var flag = 0;
				var spaceName = $('#spaceName').val();
				var projectId = $('#selectProject option:selected').val();
				var spaceDescribe = $('#spaceDescribe').val();
				var photoUrl = $('#file').val();
				flag = verifyIsEmpty(spaceName,spaceName,flag);
				flag = verifyIsEmpty(projectId,projectId,flag);
				flag = verifyIsEmpty(spaceDescribe,spaceDescribe,flag);
				flag = verifyIsEmpty(photoUrl,photoUrl,flag);
				pUrl=data.message;
				if (flag == 0 &&  addOrUpdateMark== 0) {
					add();
				} else if (flag == 0 && addOrUpdateMark == 1) {
					update(spaceId,page);
				} else {
					alert("请输入合法的数据，感谢您的配合！");
				}
			}, 
			error: function(){
				alert("当前网络有问题,请稍后重试!")
			}
		});
		return false; // 阻止表单自动提交事件
	});
	
	function add() {
		if (window.confirm("确定提交？")) {
			var spaceName = $('#spaceName').val();
			var projectId = $('#selectProject option:selected').val();
			var spaceDescribe = $('#spaceDescribe').val();
			$.ajax({
				url : 'filter/configManage/addOfcSpaceType',
				type : 'post',
				data : {
					'spaceName' : spaceName,
					'projectId' : projectId,
					'spaceDescribe' : spaceDescribe,
					'photoUrl' : pUrl
				},
				cache : false,
				dataType : 'text',
				success : function(data) {
					$('#addPdialog').dialog('destroy');
				}
			});
		}
	}

	function update(spaceId,page) {
		if (window.confirm("确定提交？")) {
			var spaceName = $('#spaceName').val();
			var projectId = $('#selectProject option:selected').val();
			var spaceDescribe = $('#spaceDescribe').val();
			$('#content').load("filter/configManage/updateOfcSpaceType?spaceName="+spaceName+"&spaceId="+spaceId+"&projectId="+projectId+"&spaceDescribe="+spaceDescribe+"&photoUrl="+pUrl+"&page="+page);
			$('#addPdialog').dialog('destroy');
		/*	$.ajax({
				url : 'filter/configManage/updateOfcSpaceType',
				type : 'post',
				data : {
					'spaceId' : spaceId,
					'spaceName' : spaceName,
					'projectId' : projectId,
					'spaceDescribe' : spaceDescribe,
					'photoUrl' : photoUrl
				},
				cache : false,
				dataType : 'text',
				success : function(data) {
					$('#page-body').load(
							"filter/configManage/searchOfcSpaceType?page="+ page);
					$('#addPdialog').dialog('destroy');
				}
			});*/
		}
	}
	
	
	
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

})





