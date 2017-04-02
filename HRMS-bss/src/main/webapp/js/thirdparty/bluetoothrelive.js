$(function() {
});
	function unUserRelieve(type) {
		var phone=$("#userPhone").val();
		if(phone==""){
			alert("请输入手机号码")
		}else if(phone!=""){
	if(window.confirm('确定要解除该成员所有蓝牙权限吗？')){
		$.ajax({
			url : "filter/thirdparty/bluetooth/relieve",
			dataType : "json",
			type : "POST",
			data : {
				"phone" : phone,
				"type" : type
			},
			cache : false,
			success : function(data) {
				if (data.message == "success") {
					alert("解除成功");
				}else{
					alert("解除失败");
				}
				
			},
			error : function(data) {
			}
		});
	}else{
		return false;
	}
}}
function uncomRelieve(){
	var  companyId=$('#companyId').val(); 
	if(companyId==""){
		alert("请选择下拉框中存在的公司")
	}else if(companyId!=""){
		var companyName=$("#companyName").val();
	if(window.confirm('确定要解除'+companyName+'公司所有蓝牙权限吗？')){
		$.ajax({
			url : "filter/thirdparty/bluetooth/relieve",
			dataType : "json",
			type : "POST",
			data : {
				"companyId" : companyId,
				"type" : 1
			},
			cache : false,
			success : function(data) {
				if (data.message == "success") {
					alert("解除成功");
				}else{
					alert("解除失败");
				}

			},
			error : function(data) {
			}
		});
     }else{
        return false;
}
	}
}


