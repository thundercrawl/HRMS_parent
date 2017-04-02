$(function(){
	$('#companyName').bind('input propertychange', function() {
		var s = $(this).val().length;
		if(s==11){
			//$('#hrefId').attr('href','#'+$(this).val()); 
		}
	});
	$("#show-table").scroll(function () {
		if ($("#show-table").scrollTop() == 0) {

		}
	});
	resize();
	$(window).resize(function(){
		resize();	
	}) 
	if($(".select-result").height()>74){
		$(".select-result").css({"height":"74"})	
	};
	if($(".person-choose").height()>74){
		$(".person-choose").css({"height":"74"})	
	};
	$(".please-choose").click(function(ev){
		$(this).next().show();	
		ev.stopPropagation();	
	})
	$(".person-choose li").click(function(ev){
		$(this).parent().prev().find("span").html($(this).html());	
		$(this).parent().hide();
		ev.stopPropagation();	
	})
	$(".select-result li").click(function(ev){
		$(this).parent().prev().val($(this).html());
		$(this).parent().hide();
		$("<li>"+$(this).html()+"<img src='img/wrong.png'></li>").appendTo(".click-result");
		$(".click-result li img").unbind("click");
		$(".click-result li img").bind('click',function(){
			$(this).parent().hide();
		})
		ev.stopPropagation();	
	})
	function emsType1(emsType){
		if(emsType=="社区消息"||"按公司"==emsType){
			emsType = 2;
		}
		else if(emsType=="系统消息"||"所有会员"==emsType){
			emsType = 1;
		}
		else if(emsType=="其他消息"||"按个人"==emsType){
			emsType = 3;
		}
		return emsType;
	}
	//推送范围
	function emsInfoRange(){
		var sendType = $(".please-choose").eq(1).find("span").html();
		if(sendType=="请选择"){
			$(".kindly-reminder-content").html("请选择推送范围！");
			$(".cover-layer").show();	
		}
		return sendType = emsType1(sendType);
	}
	//消息类型
	function emsInfoType(){
		var emsType = $(".person-choose li").parent().prev().find("span").html();
		if(emsType=="请选择"){
			$(".kindly-reminder-content").html("请选择消息类型！");
			$(".cover-layer").show();	
		}
		return emsType = emsType1(emsType);
	}
	//查询个人和公司信息  查询所有
	function findAllInfo(sendType){
		$.ajax({ 
			url:"filter/ems/findInfo",
			type:"post",
			async:false,
			data:{
			"sendType":sendType
			},
			dataType:"json",
			success:function(data){
				if(data.message=="true"){
					if(sendType==3){
						var info3 = Handlebars.compile($("#info3").html());
						$('#tableInfo').html(info3(data.row));
					}
					else{
						var info2 = Handlebars.compile($("#info2").html());
						$('#tableInfo').html(info2(data.row));
					}
				}else{
					$(".kindly-reminder-content").html(data.errorMsg);
					$(".cover-layer").show();	
				}
			
			},
			error:function(){
				$(".kindly-reminder-content").html("查询失败!");
				$(".cover-layer").show();	
			}
		});
	}
	//查询个人和公司信息  带条件
	function findInfo(sendType){
		var param = document.getElementById("companyName").value,companyName="",userPhone="";
		if(param==""||param==null||param.trim()==""){
			param==null
		}
		if(sendType==3){
			//个人
			$("#find-methods-left").html("联系电话:");
			userPhone = param;
		}
		else if(sendType==2){
			//公司
			$("#find-methods-left").html("公司名称:");
			companyName = param;
		}
		$.ajax({ 
			url:"filter/ems/findInfo",
			type:"post",
			async:false,
			data:{
			"sendType":sendType,
			"companyName":companyName,
			"userPhone":userPhone
			},
			dataType:"json",
			success:function(data){
				if(data.message=="true"){
					if(sendType==3){
						var info3 = Handlebars.compile($("#info3").html());
						$('#tableInfo').html(info3(data.row));
					}
					else{
						var info2 = Handlebars.compile($("#info2").html());
						$('#tableInfo').html(info2(data.row));
					}
				}else{
					$(".kindly-reminder-content").html(data.errorMsg);
					$(".cover-layer").show();	
				}
			
			},
			error:function(){
				$(".kindly-reminder-content").html("查询失败!");
				$(".cover-layer").show();	
			}
		});
	}
	$("#btn-searchs").click(function() {
		findInfo(emsInfoRange());
	});
	
	//消息内容
	$("#fBut").click(function() {
		var msgContent = document.getElementById("msgContent").value.trim();
		if(msgContent==""||msgContent.trim()==""){
			$(".kindly-reminder-content").html("消息内容不能为空！");
			$(".cover-layer").show();	
		}
		var sendType = emsInfoRange();
		var emsType = emsInfoType();
		if(sendType==1){
			return false;
		}
		$(".toggle-find-methods").show();
		$(".circle-table").show();
		if(sendType==3){
			//个人
			$("#find-methods-left").html("联系电话:");
		}
		else if(sendType==2){
			//公司
			$("#find-methods-left").html("公司名称:");
		}
		findAllInfo(sendType);
	});
	$("#seBut").click(function() {
		var sendType = emsInfoRange();
		var emsType = emsInfoType();
		var msgContent = document.getElementById("msgContent").value;
		if(msgContent==""||msgContent.trim()==""){
			$(".kindly-reminder-content").html("消息内容不能为空！");
			$(".cover-layer").show();	
		}
		var length = $('input[name="infoid"]:checked').length;
		if(length==0&&sendType!=1){
			$(".kindly-reminder-content").html("请选择接收者！");
			$(".cover-layer").show();	
			return false;
		}
		var sendPre = "";
		var i =0;
		$('input[name="infoid"]:checked').each(function(){ 
			i++;
			if(length==i){
				sendPre+=$(this).val();
			}else{
				sendPre+=$(this).val()+",";
			}
           
        });
		$.ajax({ 
			url:"filter/ems/addEmsInfo",
			type:"post",
			async:false,
			data:{
			"msgContent":msgContent,
			"sendType":sendType,
			"emsType":emsType,
			"sendPre":sendPre
			},
			dataType:"json",
			success:function(data){
				if(data.message=="true"){
					alert("新增成功！");
					//window.location.href="filter/ems/homePage";
				}else{
					$(".kindly-reminder-content").html(data.errorMsg);
					$(".cover-layer").show();	
				}
			
			},
			error:function(){
				$(".kindly-reminder-content").html("提交失败!");
				$(".cover-layer").show();	
			}
		});
	});
	$(document).click(function(){
		$(".select-result").hide();	
		$(".person-choose").hide();	
	})
	$(".btn-sures").eq(0).click(function(){
		if($(".please-choose").eq(1).find("span").html()=="请选择"){
			$(".cover-layer").show();	
		}else{
			
		}
	})
	$(".kindly-reminder-top").find("img").click(function(){
		$(".cover-layer").hide();	
	})
	/*$(".show-table tbody tr:even").css("background","#adf5e1");
	$(".show-table tbody tr:odd").css("background","#EDF9B1");*/
	$(".show-table tbody tr").bind("click",function(){
		//如果当前点中选中的
		if($(this).find("input").prop("checked")==true){
			$(this).find("input").prop("checked",false);
		//如果当前点中没选中的
		}else{	
			$(this).find("input").prop("checked",true);
		}
	})
	$(".show-table tbody tr input").click(function(e){
		e.stopPropagation();
	})
	$(".btn-searchs").click(function(){
		
		var str = $(this).prev().val();
		if(str !== ''){
			$("tr").css("background","");
			$("tr:contains('"+str+"')").css("backgroundColor","#adf5e1");	
		}
		var i;
		for(i=0;i<$("tr").length;i++){
			if($("tr").eq(i).css("backgroundColor") == "rgb(173, 245, 225)"){
				result(i);
			}
		}
	})
	$(".toggle-find-methods").show();
	$(".circle-table").hide();
})
function resize(){
	for(var i=0;i<$(".push-search-content").length;i++){
		var str = $(".push-search-content").eq(i).width()-50;
		 $(".push-search-content").eq(i).find(".btn-sures").css("left",(str/2+10)+"px");
	}
}
function result(i){
	// var str1=$("<a href='#result' class='result'>搜索</a>");
	// $(".btn-searchs").prependTo(str1);
//	$(".btn-searchs").attr("href","#result")
	$('table tr').eq(i).attr("id","result");	
	return false;
}