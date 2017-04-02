$(function(){
	var oppovalue=1;//商机状态和成功率
	//起租日截止日
	$('#startTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d ',
		formatDate: 'Y-m-d ',
	});
	$('#endTime').datetimepicker({
		lang: 'ch',
		timepicker: false,
		format: 'Y-m-d ',
		formatDate: 'Y-m-d ',
	});
	
	showProject();//显示项目
	showProduct();//显示产品
	$(".first_item").show();
	$(".second_item").hide();
	$(".third_item").hide();
	$("#secondStep").click(function(){
		if(($("#companyName").val()!=""&&$("#contactsName").val()!=""
			&&$("#contactsPhone").val()!=""&&$("#contactsEmail").val()!="")
			||($('#search-text').val()!="")){
			$(".first_item").hide();
			$(".third_item").hide();
			$(".second_item").show();
		}else if(($("#companyName").val()!=""&&$("#contactsName").val()!=""
			&&$("#contactsPhone").val()!=""&&$("#contactsEmail").val()!="")
			&&($('#search-text').val()!="")){
			alert("请选择已有公司或新建公司")
		}else{
			alert("请把信息补全后点击下一步")
		}
	})
	//翻页显示
	$("#firstStep").click(function(){
			$(".first_item").show();
			$(".third_item").hide();
			$(".second_item").hide();
	})
	$("#thirdStep").click(function(){
		if($("#intentionRoom").val()!=""&&$("#intentionWork").val()!=""
			&&$("#startTime").val()!=""&&$("#endTime").val()!=""
				&&$("#budget").val()!=""&&$("#agent").val()!=""
					&&($("#startTime").val()<=$("#endTime").val())){
		$(".first_item").hide();
		$(".second_item").hide();
		$(".third_item").show();
		$("#budget1").val($("#budget").val());
		$("#intentionRoom1").val($("#intentionRoom").val());
		}else if($("#startTime").val()>$("#endTime").val()){
			alert("截止时间应大于起租时间")
		}else{
			alert("请把信息补全后点击下一步")
		}
	})
	$("#secondStep2").click(function(){
		$(".first_item").hide();
		$(".third_item").hide();
		$(".second_item").show();
	})
    //选择联系人
	$("#search-text").change(function(){
		var companyId=$("#companyId").val();
		$.ajax({
			url : 'filter/opportunity/searchUser',
			type : 'POST',
			data : {
				companyId : companyId
			},
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == 'success') {
					var str = "";
					$('#show-contract').html(str);
					for(var i=0;i<data.rows.length;i++){
						str = "<option data-id="+data.rows[i].userId+">"+data.rows[i].userName+"    "+data.rows[i].userPhone+"</option>"
						$('#show-contract').append(str);
					}
					
				}
			},
			error : function(data) {
			}
		});
	})
	
/*	//查询经纪人
	$("#source").change(function(){
		var source=$("#source").val();
		$.ajax({
			url : 'filter/opportunity/searchAgent',
			type : 'POST',
			data : {
				channelType : source
			},
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == 'success') {
					var str = "";
					$('#agent').html(str);
					for(var i=0;i<data.rows.length;i++){
						str = "<option data-id="+data.rows[i].agentId+">"+data.rows[i].agentName+"    "+data.rows[i].agentPhone+"</option>"
						$('#agent').append(str);
					}
					
				}
			},
			error : function(data) {
			}
		});
	})*/
	
	//查询房间
	$("#intentionRoom").click(function(){
		 $("#select_box").show();
		/* $(document).on("click",
			 function (event) {
				    var e = event || window.event;
				    var elem = e.srcElement || e.target;
				    debugger;
				    if(elem.parentElement.parentElement.parentElement!="select_items"&&elem.parentElement.id!="select_items"&&elem.parentElement.parentElement.id!="select_items"){
				    	if(elem.id!="intentionRoom"){
				    		$('#select_box').hide();
				    	}
				    }
				
		 })*/
		 
		var projectId=$("#project_ul option:selected").attr("data-id");
		var productId=$("#product_ul option:selected").attr("data-id");
		var startTime=$("#startTime").val();
		var endTime=$("#endTime").val();
		$.ajax({
			url : 'filter/opportunity/searchRoom',
			type : 'POST',
			data : {
				projectId : projectId,
				type : productId,
				startTime : startTime,
				endTime : endTime
			},
			cache : false,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.message == 'success') {
					var str = "";
					$('#select_items').html(str);
					for(var i=0;i<data.rows.length;i++){
						str ="<li><label><input type='checkbox' value='"+data.rows[i].houseNumber+"'>"+data.rows[i].houseNumber+"</label></li>" 
						$('#select_items').append(str);
					}
					//房间号码
					var roomNum="";
					$("#select_items li input").click(function(){
				        for(var i=0;i<$("input").length;i++){
				            if($("input[type='checkbox']").eq(i).is(':checked')){
				            	roomNum+=$("input[type='checkbox']").eq(i).val()+",";
				            }
				        }
				        $("#intentionRoom").val(roomNum);
				        roomNum="";
				    });
					//搜索房间
					$("#select2").keyup(function(){debugger
						if($("#select2").val() !== ""){
							var str = $("#select2").val();
							$("#select_items li").hide();
							$("#select_items li:contains('"+str+"')").css("display","block");
						}else if($("#select2").val() == ""){
							$("#select_items li").hide();			
						}
					}).click(function(){
						if($("#select2").val() !== ""){
							var str = $("#select2").val();
							$("#select_items li").hide();
							$("#select_items li:contains('"+str+"')").css("display","block");
						}
					})
					/*$(document)
							.bind(
									"click",
									function(e) {
										var target = $(e.target);
										if (target
												.closest("#select_box").length == 0) {
											$(
													"#select_box")
													.hide();
										}
									}) */
					/*$(document).on("click", function(){
					    $("#select_box").hide();
					});*/
					/*document.onclick = function (event) {
					    var e = event || window.event;
					    var elem = e.srcElement || e.target;
					    debugger;
					    if(elem.parentElement.parentElement.parentElement=="select_items"||elem.parentElement.id=="select_items"){
					    }else{
					    	
					    	if(elem.id!="intentionRoom"&&select_items){
					    		$('#select_box').hide();
					    	}
					    }
					}*/
				}
			},
			error : function(data) {
			}
		});
	})
	//经纪人联系人切换
	$("#source").change(function(){
		if($("#source").val()==2||$("#source").val()==3||$("#source").val()==4){
			$(".agentname").show();
			$("#agent").show();
			$(".agentname").html("联系人");
		}else if($("#source").val()==5||$("#source").val()==6||$("#source").val()==7||$("#source").val()==5){
			$(".agentname").hide();
			$("#agent").hide();
		}else if($("#source").val()==1){
			$(".agentname").show();
			$("#agent").show();
			$(".agentname").html("经纪人");
		}else{
			$(".agentname").show();
			$("#agent").show();
		}
	})
	//意向房源
   /* $(document).bind("click",function(event){  
        var e = event || window.event;   
        var elem = e.srcElement||e.t                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   arget;   
        while(elem)   
        {   
            if(elem.id == "select_box")   
            {   
                return;   
            }   
            elem = elem.parentNode;        
        }   
       
       $('#select_box').hide();  
     });  */
	
	//新建商机
	$('#accomplish').click(function() {
		var projectId=$("#project_ul option:selected").attr("data-id");
		var intentionProductType =$("#product_ul option:selected").attr("data-id");
		var companyId=$(".show-select li").eq($(this).index()).attr("class");
		var intentionHouseNum=$("#intentionRoom").val();
		var intentionTotal=$("#intentionRoom").val();
		var startTime=$("#startTime").val();
		var endTime=$("#endTime").val();
		var budget=$("#budget").val();
		var opportunityStatus=$("#oppStatus").val();
		var opportunityFrom=$("#source").val();
	//	var agentId=$("#startTime").val();
		var successRate=$("#startTime").val();
		var agentId=$("#startTime").val();
		var agentId=$("#startTime").val();
		var agentId=$("#startTime").val();
		var agentId=$("#startTime").val();
		var agentId=$("#startTime").val();
		var agentId=$("#startTime").val();
		$.ajax({
			url :"filter/opportunity/newOpportunity",
			type : "POST",
			dataType : 'json',
			data : {
				
			},
			success : function(data){
			}
		})
	})
})
	//商机失败
	$('#oppStatus').change(function() {
		oppovalue=$("#oppStatus").val();
	$("#successRate option[value='"+oppovalue+"']").attr("selected","true");
		if($("#oppStatus option:selected").text()=="流失（商机失败）"){
			$('.fail').show();
		}else if($("#oppStatus option:selected").text()!="流失（商机失败）"){
			$('.fail').hide();
		}
	})
	
	$('#successRate').change(function() {
		oppovalue=$("#successRate").val();
		 $("#oppStatus option[value='"+oppovalue+"']").attr("selected","true");
	})
	 	//意向
	var roomNum="";
	$("#select_items li input").click(function(){
		console.log(this);
        for(var i=0;i<$("input").length;i++){
            if($("input[type='checkbox']").eq(i).is(':checked')){
            	roomNum+=$("input[type='checkbox']").eq(i).val()+",";
            }
        }
        $("#intentionRoom").val(roomNum);
        roomNum="";
    });
function showProject(){
	$.ajax({
		url :"filter/opportunity/selectProject",
		type : "POST",
		dataType : 'json',
		data : {},
		success : function(data){
			var str = "";
			$('#project_ul').html(str);
			for(var i=0;i<data.length;i++){
				str = "<option data-id="+data[i].projectid+">"+data[i].projectname+"</option>"
				$('#project_ul').append(str);
			}
		}
	})
}
function showProduct(){
	$.ajax({
		url :"filter/opportunity/selectProduct",
		type : "POST",
		dataType : 'json',
		data : {},
		success : function(data){
			var str = "";
			$('#product_ul').html(str);
			for(var i=0;i<data.length;i++){
				str = "<option data-id="+data[i].typeNum+">"+data[i].typeValue+"</option>"
				$('#product_ul').append(str);
			}
			var stradd="<option data-id='5'>虚拟办公室</option>"
			$('#product_ul').append(stradd);
		}
	})
}
