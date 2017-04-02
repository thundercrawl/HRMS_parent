var data=null;
var page;
$(function(){
	page=$(".pagination>li.active").text()-1;

$(".btn.edit").on("click",function(){
	$("#htitle").html("修改钱包科目信息");
	var id=$(this).attr("value");
	var itemname=$("#"+id+"name").text();
	var refund=$("#"+id+"refu").attr("value");
	var withdraw=$("#"+id+"with").attr("value");
	var transfer=$("#"+id+"tran").attr("value");
	var createTime=$("#"+id+"time").text();
	var Desc=$("#"+id+"desc").text();
	$("#walletItemId").val(id);
	$("#walletItem_Name").val(itemname);
	
	$("#itemrefund").val(refund);
	$("#itemwihdraw").val(withdraw);
	$("#itemtransfer").val(transfer);
	$("#createTimed").val(createTime);
	$("#walletItem_Desc").val(Desc)
	
	$("#item_dialog").dialog({
		modal : true,
		autoOpen : true,
		height : 'auto',
		width : 390,
		resizable : false,
		close : function() {
			$("#walletItemId").val("");
			$("#walletItem_Name").val("");
			$("#itemrefund").val("");
			$("#itemwihdraw").val("");
			$("#itemtransfer").val("");
			$("#walletItem_Desc").val("")
			$('#item_dialog').dialog('close');
		}
	});
	
});

$("#formcheck_sure").on("click",function(){
	data=null
	var itemname=$("#walletItem_Name").val();
	var walletItem_Desc=$("#walletItem_Desc").val();
	if(itemname==""){
		$("#walletItemName").css("display","block");
	}else if(walletItem_Desc==""){
		$("#walletItemDesc").css("display","block");
	}else{
		data=$('#item_iteminfo').serialize();
		
		$.ajax({
			url : 'filter/wallet/addOrUpdate',
			type : 'POST',
			data : data,
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == 'success') {
					$('#item_dialog').dialog('destroy');
					$('#wallet_item_info').load("filter/wallet/searchWalletItem?page="+page, $('#wallt_item_ip').val(), function(){
						$('.pagination>li>a').on('click', pageFunc);
					});
					
				}else{
					alert("该科目名称已存在！");
				}
			},
			error : function(data) {
			}
		});
	}
	
});

$("#return_esc").on("click",function(){
	$('#item_dialog').dialog('destroy');
});
$(".btn.deleteitem").on("click",function(){
	var id=$(this).attr("value");
	if(confirm("确认删除？")){
		$.ajax({
			url : 'filter/wallet/delete',
			type : 'POST',
			data : {
				walletItemId : id
			},
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == 'success') {
					$("#"+id+"tr").remove();
				}else{
					alert("删除失败，该科目正在使用中！");
				}
			},
			error : function(data) {
			}
		});
	}
	
});
});
