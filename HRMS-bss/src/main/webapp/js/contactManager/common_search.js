var data="";
var id="";
//从后台加载一次所有公司信息,用date接受
$("#search-text").bind("focus",function (){
	$.ajax({
		url : 'filter/bookorder/searchCompany',
		type : 'POST',
		data : {
		},
		cache : false,
		async : false,
		dataType : 'json',
		success : function(d) {
			if (d.message == 'success') {
				for(var i=0;i<d.rows.length;i++){
					data+=d.rows[i].companyName+"<=>";
					id+=d.rows[i].companyId+",";
				}
				for(var i=0;i<data.split("<=>").length-1;i++){
					$("<li class=\""+id.split(",")[i]+"\">"+data.split("<=>")[i]+"</li>").appendTo($(".show-select"));	
				}
				$("#search-text").keyup(function(){
					if($("#search-text").val() !== ""){
						var str = $("#search-text").val();
						$(".show-select li").hide();
						$(".show-select li:contains('"+str+"')").css("display","block");
					}else if($("#search-text").val() == ""){
						$(".show-select li").hide();			
					}
				}).click(function(ev){
					if($("#search-text").val() !== ""){
						var str = $("#search-text").val();
						$(".show-select li").hide();
						$(".show-select li:contains('"+str+"')").css("display","block");
					}
					ev.stopPropagation();
				})
				$(".show-select li").click(function(ev){
					$(".show-select li").css("display","none");
					$("#search-text").val($(".show-select li").eq($(this).index()).html());
					$("#companyId").val($(".show-select li").eq($(this).index()).attr("class"));
					ev.stopPropagation();
				})
				$(document).click(function(){
					$(".show-select li").css("display","none");
				})
			}
		},
		error : function(d) {
		}
	});
});
