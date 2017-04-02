$(function() {
	var page=0;
	var vid=0,typef=0;
	 forIos=function(){
		$('#Option1').show();
		$('#iosid').show();
		$('#apdid').hide();
	}
	 forAndUrl=function(){
		 $('#iosid').show();
		 $('#apdid').hide();
	 }
	 forAndApk=function(){
		 $('#iosid').hide();
		 $('#apdid').show();
	 }
	 forNone=function(){
		 $('#iosid').hide();
		 $('#apdid').hide();
	 }
	forAndroid=function(){
		$('#Option1').hide();
		$('#forAnd').show();
		$('#apdid').hide();
		$('#iosid').hide();
	}
	$('#versionType').on('change',function(){
		var selectedVal = $(this).val();
		if(selectedVal == '1') {
			forIos();
		}
		if(selectedVal == '2') {
			forAndroid();
		}
	});
	
	$('#versionAdd').on('click', function() {
		$("#addPdialog").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
		});
		});
	$('#VersionCreQuit').on('click', function() {
		$("#addPdialog").dialog('destroy');
		});
	
	$('#forVersionSearch').on('click',function(){
		var versionId=$("#versionId").val();
		$('#versionSearchCondition').val($('#forid').serialize());
		$('#tid').load("filter/version/getQuerry",$('#forid').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	})
	var newUrl = "";
	$('#addVersion').on('submit', function() {
			$(this).ajaxSubmit({
				type: 'post', 
				url: 'filter/version/versionGetUrl',
				dataType:'json',
				async:false,
				data : {},
				success : function(data) {
					newUrl=data.message;
					sure();
				},
				error : function(data) {
					alert("上传文件失败");
				}
			});
		
		return false; // 阻止表单自动提交事件
	});
	
	$('#VersionCreSure').on('click',function(){
		 var versionNumber=$("#versionNumber2").val();
		 
		var myreg = /^[0-9]([.][0-9]{1}){0,1}([.][0-9]{1}){0,1}$/;
		if(!myreg.test(versionNumber)){ 
        alert('请输入正确的版本号格式，例如1.1！'); 
        return false; 
		}
		var files=$("#files").val();
		if(files!=null&& files!=""){
			if(files.substr(files.length-4)==".apk"){
				$('#addVersion').submit();
			}else{
				alert("请上传。apk文件");
				return false;
			}
		}else{
			sure();
		}
		
		
	})
	
	versionChange=function(versionId) {
		$('#versionDscChange').val($('#'+versionId+"id").val());
		$("#transfer-alert2").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
		});
		vid=versionId;
		typef = $('#'+versionId+"type").val();
		if(typef == '1'){
			$('#Option2').show();
		}else{
			$('#Option2').hide();
		}
		}
	$('#versionChangeQuit').on('click', function() {
		$("#transfer-alert2").dialog('destroy');
	});
	 getVersionUrl=function(a){
		$('#vurl').html($('#'+a).val())
		$("#addPdialog2").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
		});
	}
	$('#getVersionUrl').on('click', function() {
		$('#vurl').html($('#forUrl').val())
		$("#addPdialog2").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
		});
	});
	 function sure(){
		 var versionNumber=$("#versionNumber2").val();
			var versionDsc=$("#versionDsc").val();
			var versionType=$("#versionType").val();
			var url=$("#url").val();
			var forceUpdate=$("#forceUpdate").val();
			var code = $("#versionType option:selected").val();
			console.log("versionNumber:"+versionNumber);
			console.log("versionType:"+versionType);
			console.log("url:"+url);
			console.log("forceUpdate:"+forceUpdate);
			console.log("code:"+code);
		 $.ajax({
				url : 'filter/version/versionAdd',
				type : 'POST',
				data : {
					versionDsc:versionDsc,
					versionNumber:versionNumber,
					versionType:versionType,
					url:url,
					newUrl:newUrl,
					forceUpdate:forceUpdate,
					code:code
				},
				cache : false,
				dataType : 'json',
				success : function(data) {
					$("#addPdialog").dialog('destroy');
					$('#content').load("filter/version/versionShow");
				},
				error : function(data) {
					alert(data);
				}
			});
	 }
	$('#versionChangeSure').on('click', function() {
		var versionDscChange=$("#versionDscChange").val();
		var forceUpdateChange=$("#forceUpdateChange").val();
		console.log("versionDscChange:"+versionDscChange);
		console.log("forceUpdateChange:"+forceUpdateChange);
		console.log("vid:"+vid);
		$.ajax({
			url : 'filter/version/versionChange',
			type : 'POST',
			data : {
				versionDscChange:versionDscChange,
				vid:vid,
				forceUpdateChange:forceUpdateChange
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				$("#transfer-alert2").dialog('destroy');
				alert(data.errorMsg);
				console.log(data.errorMsg);
				console.log(data);
				$('#content').load("filter/version/versionShow");
			},
			error : function(data) {
				alert(data);
			}
		});
		
		});
	versionDelete=function(versionId) {
		$.ajax({
			url : 'filter/version/versionDelete',
			type : 'POST',
			data : {
				versionId:versionId
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				$('#content').load("filter/version/versionShow");
			},
			error : function(data) {
				alert(data);
			}
		});
	}
});
