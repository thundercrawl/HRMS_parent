
$(function() {

	var oms = document.getElementById("virtualShow");
	var omsearch = document.getElementById("memSchid");
	oms.style.display = "none";
	omsearch.style.display = "none";
	$('#virtualMemberManager').on('click', function() {
		omsearch.style.display = "none";
		$.ajax({
			url : 'filter/member/virtualMemberManager',
			type : 'POST',
			data : {
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				oms.style.display = "block";
				$('#vmem').html(virtualMem(data.rows));
			},
			error : function(data) {
				alert(data);
			}
		});
	})
	
	$("#transfer-alert").hide();
	$("#transfer-alert2").hide();
	
	$('#memberCreate').on('click', function() {
			$("#transfer-alert").show();
		});
	
	$('#companyCreate').on('click', function() {
		$("#transfer-alert2").show();
	});
	
	$('#memCreQuit').on('click', function() {
		$("#transfer-alert").hide();
	});
	
	$('#comCreQuit').on('click', function() {
		$("#transfer-alert2").hide();
	});
	

	
	
	$('#permissionSettings').on('click', function() {
		$.ajax({
			url : 'filter/member/permissionSettings',
			type : 'POST',
			data : {

			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				alert(data.errorMsg);
			},
			error : function(data) {
				alert(data);
			}
		});
	})
	
	
	$('#forSearch').on('click', function() {
		oms.style.display = "none";
		omsearch.style.display = "block";
	})
	

	$('#forMemSearch').on('click', function() {
		var memNum = document.getElementById("memNum").value;
		$.ajax({
			url : 'filter/member/memberSearch',
			type : 'POST',
			data : {
				memNum : memNum
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				$('#memSchBody').html(memsch(data.rows));
			},
			error : function(data) {
				alert(data);
			}
		});
	})
	
	
	prohibition = function() {
		var id = document.getElementById("hideUse").value;
		$.ajax({
			url : 'filter/member/prohibition',
			type : 'POST',
			data : {
				id : id
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
	});
