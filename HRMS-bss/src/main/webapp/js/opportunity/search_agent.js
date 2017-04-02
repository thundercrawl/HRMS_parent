var data="";
var id="";
var name="";
var source=1;
//从后台加载一次所有公司信息,用date接受
$(function(){
	search(source);
	$("#source").change(function(){
		source=$("#source").val();
		search(source);
	})
});
function search(source){
$.ajax({
	url : 'filter/opportunity/searchAgent',
	type : 'POST',
	data : {
		channelType : source
	},
	cache : false,
	async : false,
	dataType : 'json',
	success : function(d) {debugger
		$(".agent").empty();
	   data="";
	   id="";
	   name="";
		if (d.message == 'success') {
			for(var i=0;i<d.rows.length;i++){
				data+=d.rows[i].agentPhone+"<=>";
				id+=d.rows[i].agentId+",";
				name+=d.rows[i].agentName+",";
			}
			for(var i=0;i<data.split("<=>").length-1;i++){
				$("<li class=\""+id.split(",")[i]+"\">"+data.split("<=>")[i]+"  "+name.split(",")[i]+"</li>").appendTo($(".agent"));	
			}
		}
	},
});
}
$(function(){
	
	$("#search-agent").keyup(function(){
		if($("#search-agent").val() !== ""){
			var str = $("#search-agent").val();
			$(".agent li").hide();
			$(".agent li:contains('"+str+"')").css("display","block");
		}else if($("#search-agent").val() == ""){
			$(".agent li").hide();			
		}
	}).click(function(ev){
		if($("#search-agent").val() !== ""){
			var str = $("#search-agent").val();
			$(".agent li").hide();
			$(".agent li:contains('"+str+"')").css("display","block");
		}
		ev.stopPropagation();
	})
	$(".agent li").click(function(ev){
		$(".agent li").css("display","none");
		$("#search-agent").val($(".agent li").eq($(this).index()).html());
		$("#agentId").val($(".agent li").eq($(this).index()).attr("class"));
		ev.stopPropagation();
	})
	$(document).click(function(){
		$(".agent li").css("display","none");
	})
})
