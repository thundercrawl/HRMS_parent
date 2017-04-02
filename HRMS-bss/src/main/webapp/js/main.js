/**
 * Created by XuQiang on 2015/11/19.
 */

$(function() {
	$('input[type=text]').focus(function() {
		$(this).addClass("add-border");
		$(this).next().addClass("add-color");
		if (!this.initValue) {
			this.initValue = this.placeholder;
		}
		if (this.placeholder === this.initValue) {
			this.placeholder = '';
		}
	}).blur(function() {
		$(this).removeClass("add-border");
		$(this).next().removeClass("add-color");
		if (this.placeholder === '' || this.placeholder === null) {
			this.placeholder = this.initValue;
		}
	});
	//	迁入迁出
	 move = function(){
		$(this).addClass("action_btn");
		$(this).siblings().removeClass("action_btn");
	 }
	//	城市选择
	$(".city-choose").click(function() {
		$("#city-choose-hide").toggle();
		$("#show-location").addClass("location-box-shadow")
	})
	$("#city-choose-hide > li").click(function() {
		var txt = $(this).text();
		$(this).parent().siblings(".city-choose").children("div.input").children("span.selected").replaceWith("<span class='selected'>" + txt + "</span>");
		$("#city-choose-hide").hide();
		$("#show-location").removeClass("location-box-shadow")
	});

	//	模块选择
	$("#module-choose-hide").hide();
	$("#module-choose").click(function() {
		$("#module-choose-hide").toggle();
		$(this).parent().toggleClass("location-box-shadow");
	});
	$("#module-box").children().each(function() {
		$(this).hide();
	});
	$("#module-choose-hide > li").click(function() {
		$("#module-box").css("display", "block");
		$("#module-box > li").eq($(this).index()).toggle();
		$(this).children("div").toggleClass("selected")
	});

	var changeArr = ["animated bounce", "animated flash", "animated lightSpeedIn", "animated rollIn", "animated bounceInRight"];
	var len = changeArr.length;
	var k = -1;

	function Index() {
		k++;
		if (k > (len - 1))
			k = 0;
	}
	
	changeTab = function() {
		$(this).addClass('btn-select').siblings().removeClass('btn-select');
		var index = $(this).index();
		Index();
		$(".special-slider-ul>li").eq(index).show()
			.attr("class", changeArr[k])
			.siblings().hide();
	};
	
	
});
function downMenu(clickClass,dropMenu){
    $(clickClass).click(function(event){
        event=event||window.event;
        event.stopPropagation();
        $(dropMenu).toggle();
    });
    $(dropMenu).click(function(){
        $(dropMenu).toggle();
    });
    $(document).click(function(e){
        $(dropMenu).hide();
    });
}
