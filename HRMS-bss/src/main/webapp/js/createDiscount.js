//生成折扣码页面的js

//获取产品id信息
function getProductInfo(){
	var projectId = document.getElementById("discountProject").value;
	if(projectId==null||projectId==""||projectId=="项目选择"){
		alert("请选择项目！");
		$("#discountKind1").empty();
		var html = "<option class=a0 style=display:none>按类型</option>"
		+ "<option value=1>工位</option>"
		+ "<option value=3>办公室</option>";
		$("#discountKind1").append(html);
	}else{
		//产品类型
		var kind = document.getElementById("discountKind1").value; 
		
		$.ajax({
			url : 'filter/createDiscount/getProductInfo',
			type : 'post',
			data : {
				'projectId' : projectId,
				'productType' : kind
			},
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if(data==null||data.length==0){
					alert("该产品类型下暂无产品,请选择其他产品类型的产品生成折扣码！");
				}else{
					console.log(data);
					var html ="<option class=a0 style=display:none>按类型</option>";
					for(var i=0;i<data.length;i++)
					{	
						html += "<option value="+data[i].productId+">"+data[i].productName+"-"+data[i].money+"元/"+data[i].unitEnum+"</option>";
					}
					$("#discountProduct").empty();
					$("#discountProduct").append(html);
				}
			}
		});
	}
}

function createDiscountNumber(){
	var reg=/^[0-9]*$/;
	var discountNumber;
	var discountKind;//0 适用全部   1 按类型打折    2 按产品打折
	var discountMainKind = document.getElementById("discountMainKind").value;//打折的类型  
	if(discountMainKind=="choose-select0"){//全部打折
		discountNumber = document.getElementById("discountAllNO").value;
		if(discountNumber==null||discountNumber==""){
			alert("请输入折扣！");
		}else{
			if((!reg.test(discountNumber))||discountNumber>100||discountNumber<=0){
				alert("请输入1到100之间的整数折扣！");
			}else{
				discountKind = "0";
				$.ajax({
					url : 'filter/createDiscount/newNumber',
					type : 'post',
					data : {
						"discountKind":discountKind,
						"discountNumber" : discountNumber
					},
					cache : false,
					dataType : 'text',
					async : false,
					success : function(data) {
						var discountNumbers = data;
						$("#discountNumbers").html(discountNumbers);
					}
				});
			}
		}
	}
	if(discountMainKind=="choose-select1"){//按类型打折
		discountNumber = document.getElementById("discountKindNO").value;
		//产品类型
		var kind = document.getElementById("discountKind").value; 
		if(discountNumber==null||discountNumber==""){
			alert("请输入折扣！");
		}else{
			if((!reg.test(discountNumber))||discountNumber>100||discountNumber<=0){
				alert("请输入1到100之间的整数折扣！");
			}else{
				discountKind = "1";
				
				$.ajax({
					url : 'filter/createDiscount/newNumber',
					type : 'post',
					data : {
						"discountKind":discountKind,
						"productType" : kind,
						"discountNumber" : discountNumber
					},
					cache : false,
					dataType : 'text',
					async : false,
					success : function(data) {
						var discountNumbers = data;
						$("#discountNumbers").html(discountNumbers);
					}
				});
			}
		}
	}
	if(discountMainKind=="choose-select2"){//按产品打折
		discountNumber = document.getElementById("discountProjectNO").value;
		var productId = document.getElementById("discountProduct").value;
		if(discountNumber==null||discountNumber==""){
			alert("请输入折扣！");
		}else{
			if((!reg.test(discountNumber))||discountNumber>100||discountNumber<=0){
				alert("请输入1到100之间的整数折扣！");
			}else{
				discountKind = "2";
				$.ajax({
					url : 'filter/createDiscount/newNumber',
					type : 'post',
					data : {
						"discountKind":discountKind,
						"productId" : productId,
						"discountNumber" : discountNumber
					},
					cache : false,
					dataType : 'text',
					async : false,
					success : function(data) {
						var discountNumbers = data;
						$("#discountNumbers").html(discountNumbers);
					}
				});
			}
		}
	}
}
