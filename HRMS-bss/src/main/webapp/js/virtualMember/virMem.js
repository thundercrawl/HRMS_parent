$(function() {
	
	
	$('#memberCreate').on('click', function() {
			$("#transfer-alert").dialog({ modal:true,autoOpen: true,height:'auto', width:360,resizable:false,
			});
		});
	
	$('#virMemCreQuit').on('click', function() {
		$("#transfer-alert").dialog('destroy');
	});
	
	
	$('#forVirMemSearch').on('click',function(){
		var virMemId=$("#virMemId").val();
		$('#virmemberSearchCondition').val($('#forid').serialize());
		$('#tid').load("filter/member/getVirQuerry",$('#forid').serialize(), function(){
			$('.pagination>li>a').on('click', pageFunc);
		});
	})
	
	prohibition = function(uid) {
		$.ajax({
			url : 'filter/member/prohibition',
			type : 'POST',
			data : {
				uid : uid
			},
			cache : false,
			dataType : 'json',
			success : function(data) {

			},
			error : function(data) {
				alert(data);
			}
		});
	}
	/*unprohibition = function(uid) {
		var status=1;
		$.ajax({
			url : 'member/unprohibition',
			type : 'POST',
			data : {
				uid : uid,
				status:status
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				
			},
			error : function(data) {
				alert(data);
			}
		});
	}
	*/
	memberDel = function(uid) {
		$.ajax({
			url : 'filter/member/memberDel',
			type : 'POST',
			data : {
				uid : uid
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				$('#content').load("filter/member/virMemberShow");
			},
			error : function(data) {
				alert(data);
			}
		});
	}
	
	$('#virMemCreSure').on('click', function() {
		var virmemberName=$("#virmemberName").val();
		var virmemberPsw=$("#virmemberPsw").val();
		var virmemberPhone=$("#virmemberPhone").val();
		var virmemberMail=$("#virmemberMail").val();
		$.ajax({
			url : 'filter/member/virMemberSave',
			type : 'POST',
			data : {
				virmemberName:virmemberName,
				virmemberPsw:virmemberPsw,
				virmemberPhone:virmemberPhone,
				virmemberMail:virmemberMail
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				$("#transfer-alert").dialog('destroy');
			},
			error : function(data) {
				alert(data);
			}
		});
		
	});
});