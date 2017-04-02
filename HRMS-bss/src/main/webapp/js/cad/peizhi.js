//数据初始化
var picType = 3;//cad图片类型
var projectId = 0;//项目编号
var cadPicId = 0;//cad图片编号
var assetType = 1;//资产类型枚举
var assetId=0;//当前点击的配置资产编号
var floorNum = 0;//项目当前楼层
var flag=0;//资产数据是否改动0未改动，1为有改动
//数据初始化结束
var oLeft, oTop;
var value = [ [], [] ];
var values = [ [], [], [] ];
var imgScale = 1;
var pointAddArrs = [];
var locationArr = [ "会议室", "移动商务舱", "弹性工位", "独立办公室" ];

loadprojectInfo();
function loadprojectInfo() {
	// 加载项目列表
	$.ajax({
				url : "filter/cad/findProjectInfo",
				type : "POST",
				dataType : 'json',
				data : {},
				success : function(data) {
					var proStr = "";
					for (i = 0; i < data.data.list.length; i++) {
						var str = "name:" + data.data.list[i].projectname
								+ ",data_id:" + data.data.list[i].projectid
								+ ";";
						proStr = proStr + str;
					}
					proStr = proStr.substring(0, proStr.length - 1);
					var proArray = [ proStr,
							"name:移动商务舱,data_id:1;name:会议室,data_id:2;name:办公室,data_id:3" ];
					serchPush(proArray);
				}
			})
}

// 加载项目楼层CAD图片
function loadImg(projectid, floornum) {
	if (projectId == 0 || floorNum == 0) {
		alert("请等待加载完成后再试！");
	} else {
		floorNum = floornum;
		projectId = projectid;
		// 加载项目CAD图片
		$.ajax({
			url : "filter/cad/findCadPic",
			type : "POST",
			dataType : 'json',
			data : {
				projectId : projectid,
				floorNum : floornum
			},
			success : function(data) {
				console.log(data);
				// console.log(data.data.list);
				if (data.status == 1) {
					console.log("有图片");
					$("#canvas").show();
					$("#canvas").attr("src",data.data.list[0].photoUrl);
					cadPicId = data.data.list[0].cadId;
					loadCadConfig();
				} else {
					imgScale = 1;
					pointAddArrs = [];
					$("#canvas").hide();
					if (confirm(data.message)) {// 上传项目CAD图片
						uploadCadInfo();
					}
				}
			}
		})
	}
}
$(".cad_btn").click(function(){
	uploadCadInfo();
})

// 上传或修改CAD图片
function uploadCadInfo() {
	if (projectId == 0 || floorNum == 0) {
		alert("请等待加载完成后再试！");
	} else {
		$('.projectpic_url').find("li").remove();
		$('.upload_preview').html("");
		$("#addProjectPic").dialog({
			modal : true,
			autoOpen : true,
			height : 'auto',
			width : 670,
			resizable : false,
			close : function() {
				$('#addProjectPic').dialog('destroy');
			}
		});
	}
}
// 加载项目下同一资产类型下的所有资产
function loadAsset(projectid, assetType) {
	var url = "";
	if (assetType == 1) {
		url = "filter/cad/findseatinfo";
	}
	if (assetType == 2) {
		url = "filter/cad/findmeetroom";
	}
	if (assetType == 3) {
		url = "filter/cad/findofficeinfo";
	}
	if(projectid!=0){
		$.ajax({
			url : url,
			type : "POST",
			dataType : 'json',
			data : {
				projectId : projectId
			},
			success : function(data) {
				console.log(data);
				var proStr = "";
				for (i = 0; i < data.length; i++) {
					var str = "name:" + data[i].name + ",data_id:"
							+ data[i].assetId + ";";
					proStr = proStr + str;
				}
				proStr = proStr.substring(0, proStr.length - 1);
				value[2] = spiltFunc(proStr, ";", ",", ":");
				for (var i = 0; i < value.length; i++) {
					values[i].length = 0;
					for (var j = 0; j < value[i].length; j++) {
						values[i].push(value[i][j]);
					}
				}
			}
		})
	}
}
// 加载之前已经配置的资产信息
function loadCadConfig() {
	$(".location_img").remove();
	if(cadPicId!=0){
		$.ajax({
			url : "filter/cad/findCadConfig",
			type : "POST",
			dataType : 'json',
			data : {
				cadPicId : cadPicId
			},
			success : function(data) {
				//console.log("加载配置信息：" + data.data.list[0].dataStr);
				if(data.status==1){
					for (var j = 0; j < data.data.list.length; j++) {
						pointAddArrs.push(data.data.list[j].dataStr.split(","));
						// "711.00px,454.00px,苏河水岸空间 移动商务舱 B03,10,1 1 11011"
					}
					initPoint();
				}
			}
		})
	}
}
//删除配置的点
function deleteCadConfig(){
	if(cadPicId!=0&&assetId!=0){
		if(confirm("确认删除此配置？")){
		$.ajax({
			url : "filter/cad/deleteCadAsset",
			type : "POST",
			dataType : 'json',
			data : {
				cadPicId : cadPicId,
				assetId:assetId
			},
			success : function(data) {
				
			}
		})
		}
	}else{
		alert("请先选择需要删除的资产！");
	}
}
// 加载项目楼层信息
function loadFloorInfo() {
	$.ajax({
		url : "filter/cad/projectFloorInfo",
		type : "POST",
		dataType : 'json',
		data : {
			projectId : projectId
		},
		success : function(data) {
			$(".floor-btns").text("");// 清空数据
			console.log("加载项目楼层信息：" + data);
			if (data.status == 1 && data.data.list.length > 0) {
				var floorStr = "<span>楼层：</span>";
				floorStr = floorStr + "<div class='btner active'>"
						+ data.data.list[0].floorMsg + "L</div>";
				floorNum = data.data.list[0].floorMsg;
				for (var j = 1; j < data.data.list.length; j++) {
					floorStr = floorStr + "<div class='btner'>"
							+ data.data.list[j].floorMsg + "L</div>";
				}
				$(".floor-btns").append(floorStr);
				$(".floor-btns").find(".btner").click(function() {
					var $this = $(this);
					if (pointAddArrs.length > 0&&flag==1) {
						$(".alert,.mask").show();
						$(".alert").find(".btn-blue").click(function() {
							// 推送配置信息到后台
							var mydata = "";
							mydata = pointAddArrs.join(":");
							$.ajax({
								url : "filter/cad/configCadAsset",
								type : "POST",
								dataType : 'json',
								data : {
									str : mydata,
									cadPicId : cadPicId
								},
								success : function(data) {
									console.log("资产配置成功");
									flag=0;
								}
							})
							// 推送配置信息到后台
							var btn_floor = $this.html();
							floorNum = btn_floor.replace("L", "");
							console.log("当前楼层：" + floorNum);
							$this.addClass("active").siblings().removeClass("active");
							// 换楼层初始化页面start
							imgScale = 1;
							console.log("当前配置：" + pointAddArrs);
							pointAddArrs = [];
							loadImg(projectId, floorNum);
							// 换楼层初始化页面end
						})
					}
						
					
					})
				loadImg(projectId,floorNum);
			}else if (data.status == 3) {
				$("#canvas").hide();
				imgScale = 1;
				pointAddArrs = [];
				alert(data.message);
			}

		}
	})
}
function initPoint() {
	for (var i = 0; i < pointAddArrs.length; i++) {
		drawPoint($(".img_mask"), pointAddArrs[i][0], pointAddArrs[i][1],
				pointAddArrs[i][2], pointAddArrs[i][3], pointAddArrs[i][4])
		var strs = pointAddArrs[i][2].split(" ");
		$(".info-title").eq(0).after("<div class=\"info-item clearfix\"><div class=\"iteml\">"+strs[1]+"</div><div class=\"itemr\">"+strs[2]+"</div></div>");
        distShow();
	}
}

$(function() {
	showPeizhiInfo();
	// serchPush();
	mouseEve();
    smartZoom(0.5);
    mouseZoom();
    clickImgMask();
})
/**
*  图片放大缩小
*  smartZoom(scale,distanceX,distanceY)
*  scale 图片缩放比例
*  distanceX  移动图片最终X轴偏移值
*  distanceY  移动图片最终Y轴偏移值
*  @return
*/
var _imgW = $('#canvas').width(),
    _imgH = $('#canvas').height(),
    imgScale = 1;
$('.img_mask').height($("#canvas").height()); 
function smartZoom(scale,distanceX,distanceY){
    if(!distanceX) distanceX = 0 ;
    if(!distanceY) distanceY = 0 ; 
    var offsetL,
        offsetT;
    var _imgL,
        _imgT, 
        curW,
        curH;
    $('#zoomIn').unbind('click');
    $('#zoomIn').click(function(){
        $(".location_img").remove();
        for(var i=0;i<pointAddArrs.length;i++){
            drawPoint($(".img_mask"),pointAddArrs[i][0],pointAddArrs[i][1],pointAddArrs[i][2],pointAddArrs[i][3],pointAddArrs[i][4])
        }
        imgScale = imgScale / scale;
        if(imgScale > 4) imgScale = 4;
        // console.log(imgScale)
        curW = _imgW * imgScale,
        curH = _imgH * imgScale;
        $('#canvas').width(curW);
        offsetL = (_imgW - curW) / 2 ;
        offsetT = (_imgH - curH) / 2 ;
        $('#canvas').css({
            left: distanceX + offsetL,
            top: distanceY + offsetT
        });
        $('.img_mask').width(curW);
        $('.img_mask').height(curH);
        $('.img_mask').css({
            left: distanceX + offsetL,
            top: distanceY + offsetT
        });
    });

    $('#zoomOut').unbind('click');
    $('#zoomOut').click(function(){
        $(".location_img").remove();
        for(var i=0;i<pointAddArrs.length;i++){
            drawPoint($(".img_mask"),pointAddArrs[i][0],pointAddArrs[i][1],pointAddArrs[i][2],pointAddArrs[i][3],pointAddArrs[i][4])
        }
        imgScale = imgScale * scale;
        if(imgScale < 0.5) imgScale = 0.5;
        // console.log(imgScale)
        curW = _imgW * imgScale,
        curH = _imgH * imgScale;
        $('#canvas').width(curW);
        offsetL = (_imgW - curW) / 2 ;
        offsetT = (_imgH - curH) /2 ;
        // console.log(distanceX)
        $('#canvas').css({
            left: distanceX + offsetL,
            top: distanceY + offsetT
        });
        $('.img_mask').width(curW);
        $('.img_mask').height(curH);
        $('.img_mask').css({
            left: distanceX + offsetL,
            top: distanceY + offsetT
        });
    })
}

/**
*  图片拖动
*  变量distanceX,distanceY  为smartZoom()里面的实参
*  @return
*/
function mouseZoom(){
    var down_xAis,
        down_yAis,
        move_xAis,
        move_yAis,
        up_xAis,
        up_yAis,
        distanceXArr = [],
        distanceYArr = [];
    var imgL,
        imgT,
        ballL,
        ballT;
    $('#bottom_chart').mousedown(function(event){
        down_xAis = event.clientX;
        down_yAis = event.clientY;
        var _distanceX,
            _distanceY;
        var distanceX = 0,
            distanceY = 0; 
        ballL = Number($('.img_mask').css('left').split('px')[0]),
        ballT = Number($('.img_mask').css('top').split('px')[0]);
        imgL = Number($('#canvas').css('left').split('px')[0]),
        imgT = Number($('#canvas').css('top').split('px')[0]);
        $('#bottom_chart').mousemove(function(event){
            move_xAis = event.clientX - down_xAis ;
            move_yAis = event.clientY - down_yAis ;
            $('#canvas').css({
                left:imgL + move_xAis,
                top: imgT + move_yAis
            })
            $('.img_mask').css({
                left:ballL + move_xAis,
                top: ballT + move_yAis
            })
            //拖动清除空点start
            var objs = $(".location_img");
            for(var i=0;i<objs.length;i++){
                var index = objs.eq(i).attr("src").substr(objs.eq(i).attr("src").length-6,1);
                if(index === "-"){
                    objs.eq(i).remove();
                }
            }
            //拖动清除空点end
        })

        $('#bottom_chart').mouseup(function(event){
            $('#bottom_chart').unbind('mousemove')
            $('#bottom_chart').unbind('mouseup')
            up_xAis = event.clientX;
            up_yAis = event.clientY;
            _distanceX = up_xAis - down_xAis;
            _distanceY = up_yAis - down_yAis;
            distanceXArr.push(_distanceX);
            distanceYArr.push(_distanceY);
            for(var i=0;i<distanceXArr.length;i++){
                distanceX += distanceXArr[i]
            }
            for(var j=0;j<distanceXArr.length;j++){
                distanceY += distanceYArr[j]
            }
            smartZoom(0.5,distanceX,distanceY);
            clickImgMask();
        });
    })
}
/**
*  点击图片打点start
*/
function clickImgMask(){
    $(".img_mask").unbind("click");
    $(".img_mask").click(function(ev){
        var $this = $(this),
            oEvent=ev||event,
            opp = $(document).scrollTop(),
            ql = oEvent.clientX - $(".img_mask").offset().left,
            qt = oEvent.clientY - $(".img_mask").offset().top + opp,
            bt_wid = $(".img_mask").width(),
            bt_hei = $(".img_mask").height();
            oLeft = ql/bt_wid*100+"%";
            oTop = qt/bt_hei*100+"%";
        //移除空点start
        var objs = $(".location_img");
        for(var i=0;i<objs.length;i++){
            var index = objs.eq(i).attr("src").substr(objs.eq(i).attr("src").length-6,1);
            if(index === "-"){
                objs.eq(i).remove();
            }
        }
        $(".bottom-hide").show();
        $(".delete_Y").hide();
        $(".delete_N").show();
        //移除空点end
        $(".location_img").remove();
        drawPoint($(".img_mask"),oLeft,oTop,"","-1");
        for(var i=0;i<pointAddArrs.length;i++){
            drawPoint($(".img_mask"),pointAddArrs[i][0],pointAddArrs[i][1],pointAddArrs[i][2],pointAddArrs[i][3],pointAddArrs[i][4])
        }
        confirmClick();
    })


}
/**
*  点击图片打点end 
*/
function mouseEve() {
	$(".btn-blue1").unbind("click");
	$(".btn-blue1").click(function() {
		// 推送配置信息到后台
		if (pointAddArrs.length > 0&&flag==1) {
			var mydata = "";
			mydata = pointAddArrs.join(":");
			$.ajax({
				url : "filter/cad/configCadAsset",
				type : "POST",
				dataType : 'json',
				data : {
					str : mydata,
					cadPicId : cadPicId
				},
				success : function(data) {
					console.log("资产配置成功");
					flag=0;
					
				}
			})
		}
	});
	$(".delete_N").unbind("click");
	$(".delete_N").click(
			function() {
				// 移除空点start
				var objs = $(".location_img");
				for (var i = 0; i < objs.length; i++) {
					var index = objs.eq(i).attr("src").substr(
							objs.eq(i).attr("src").length - 6, 1);
					if (index === "-") {
						objs.eq(i).remove();
					}
				}
				$(".bottom-hide").hide();
				// 移除空点end
			})
	$(".alert,.mask").hide();
	$(".floor-btns").find(".btner").click(function() {
		var $this = $(this);
		$(".alert,.mask").show();
		$(".alert").find(".btn-blue").click(function() {
			// 推送配置信息到后台
			if (pointAddArrs.length > 0&&flag==1) {
				var mydata = "";
				mydata = pointAddArrs.join(":");
				$.ajax({
					url : "filter/cad/configCadAsset",
					type : "POST",
					dataType : 'json',
					data : {
						str : mydata,
						cadPicId : cadPicId
					},
					success : function(data) {
						console.log("资产配置成功");
					}
				})
			}
			var btn_floor = $this.html();
			floorNum = btn_floor.replace("L", "");
			console.log("当前楼层：" + floorNum);
			$this.addClass("active").siblings().removeClass("active");

			// 换楼层初始化页面start
			imgScale = 1;
			console.log("当前配置：" + pointAddArrs);
			pointAddArrs = [];
			loadImg(projectId, floorNum);
			$(".location_img").remove();
			// 换楼层初始化页面end
		})
	})
	$(".alert").find(".btner").click(function() {
		$(".alert,.mask").hide();
	})
	$(".bottom_chart").unbind("mouseover").unbind("mouseleave");
	$(".top_title > p").unbind("click");
	$(".delete_pei span").unbind("mouseover").unbind("mouseleave").unbind(
			"click");
	$(".delete_pei span").mouseover(function() {
		$(this).css({
			"color" : "red"
		});
	})
	$(".delete_pei span").mouseleave(function() {
		$(this).css({
			"color" : "#666"
		});
	})
	$(".info-item").unbind("click");
	$(".info-item").click(
			function() {
				var str = $(this).find(".iteml").html();
				var objs = $(".location_img");
				for (var i = 0; i < objs.length; i++) {
					var biu = objs.eq(i).attr("str_id").split(" ")[1];
					var str2 = objs.eq(i).attr("src").substr(
							objs.eq(i).attr("src").length - 6, 1);
					str2 += "0";
					objs.eq(i).attr("src", "img/location" + str2 + ".png");
					if (str === biu) {
						var str1 = objs.eq(i).attr("src").substr(
								objs.eq(i).attr("src").length - 6, 1);
						str1 += "1";
						objs.eq(i).attr("src", "img/location" + str1 + ".png");
					}
				}
			})
}
// 展示配置信息
function showPeizhiInfo() {
	$("#canvas").unbind("click");
	$("#canvas").click(function() {
		$(".delete_pei").hide();
		var $this = $(this);
		strs = [ "苏河一号", "请选择...", "请选择..." ];
		$(".bottom-hide").show();
		$(".drop_down1").eq(0).find("p").html(strs[1]);
		$(".drop_part").eq(1).find("input").val(strs[2]);
		$(".location_img").unbind("click");
		$(".location_img").click(function() {
			var $here = $(this);
			oLeft = $(this).css("left");
			oTop = $(this).css("top");
			// 移除空点start
			var objs = $(".location_img");
			for (var i = 0; i < objs.length; i++) {
				var index = objs.eq(i).attr("src").substr(objs.eq(i).attr("src").length - 6,1);
				if (index === "-") {
					objs.eq(i).remove();
				}
			}
			// 移除空点end
			var strs1 = $(this).attr("str_id").split(" ");
			var pos_arr = [$(this).css("left"),$(this).css("top") ]
			$(".delete_Y").show();
			$(".delete_N").hide();
			$(".bottom-hide").show();
			$(".drop_top0").eq(0).find("p").html(strs1[0]);
			$(".drop_down1").eq(0).find("p").html(strs1[1]);
			$(".drop_part").eq(1).find("input").val(strs1[2]);
			$(".delete_Y").unbind("click");
			$(".delete_Y").click(function() {
				$here.remove();
				$(".bottom-hide").hide();
				for (var i = 0; i < pointAddArrs.length; i++) {
					if (pointAddArrs[i][0] == pos_arr[0] && pointAddArrs[i][1] == pos_arr[1]) {
						pointAddArrs.splice(i,1);
					}
				}
			})
		})
		confirmClick();
	});
}
/**
 * 信息配置  点击确定修改信息
 * 
 * @returns
 */
function confirmClick(){
    $(".confirm_btn").unbind("click");
    $(".confirm_btn").click(function(){
    	flag=1;
        //移除空点start
        var objs = $(".location_img");

        for(var i=0;i<objs.length;i++){
            var imgSrc = objs.eq(i).attr("src");
            if(imgSrc === "img/location-1.png"){
                objs.eq(i).remove();
                imgShow();
            }
        }
        //移除空点end
        $(".bottom-hide").hide();
        var str = '';
        var str_0 = $(".drop_val").eq(0).html();
        var str_1 = $(".drop_down1").eq(0).find("p").html();
        var str_2 = $(".container").eq(0).find("input").val();
        str +=str_0+" "+str_1+" "+str_2+" ";
        var indexPoint = $.inArray(str_1,locationArr)+'0';
        var datp = '';
        // 此处未取到资产类型
        var datp_0 = $(".drop_val").eq(0).attr("data_id");
        var datp_1 = $(".drop_down1").eq(0).find("p").attr("data_id");
        var datp_2 = $(".container").eq(0).find("input").attr("data_id");
        if (!datp_0) {
			alert("请选择项目！");
			return;
		}
		if (!datp_1) {
			alert("请选择资产类型！");
			return;
		}
		if (!datp_2) {
			alert("请选择资产编号！");
			return;
		}
        datp += datp_0+" "+datp_1+" "+datp_2+" ";
        var imgObjs = $(".location_img");
        for(var r = 0;r<imgObjs.length;r++){
            var str_id_i = imgObjs.eq(r).attr("str_id");
            var src = imgObjs.eq(r).attr("src");
            var src_i = src.substr(src.length-5,1);
            if(src_i == '1'){
                var info_items = $(".info-item");
                var _bool = false;
                for(var i=0;i<info_items.length;i++){
                    if(info_items.eq(i).find(".itemr").html() == str_2){
                        _bool = true;
                    }
                }
                if(_bool){
                    alert("该资产信息已配置，请重新配置...");
                }else{
                    imgObjs.eq(r).attr("src","img/location"+indexPoint+".png").attr("data_id",datp).attr("str_id",str);
                    $(".infoShow").find(".iteml").html(str_1);
                    $(".infoShow").find(".itemr").html(str_2);
                    for(var i=0;i<pointAddArrs.length;i++){
                        if(str_id_i == pointAddArrs[i][2]){
                            pointAddArrs[i][2] = str;
                            pointAddArrs[i][3] = indexPoint;
                            pointAddArrs[i][4] = datp;
                        }
                    }
                }
                
            }
        }
        // drawPoint($("body"),oLeft,oTop,str,indexPoint,datp);
        var obj_all = $(".info-item");
        var bool_jie = false;
        for(var i=0;i<obj_all.length;i++){
            var iteml_str = obj_all.eq(i).find(".iteml").html();
            var itemr_str = obj_all.eq(i).find(".itemr").html();
            if(itemr_str == str_2){
                bool_jie =true;
            }
        }
        if(!bool_jie){
            drawPoint($(".img_mask"),oLeft,oTop,str,indexPoint,datp);
            $(".info-title").eq(0).after("<div class=\"info-item clearfix\"><div class=\"iteml\">"+str_1+"</div><div class=\"itemr\">"+str_2+"</div></div>");
            distShow();
            pointAddArrs.push([oLeft,oTop,str,indexPoint,datp]);
        }
        imgShow();
        distShow();
    })
}
/**
 * 资产信息 配置信息表和配置图的消失隐藏操作
 * 
 * @returns
 */
function distShow(){
    $('.info-item').unbind('click');
    $('.info-item').click(function(){
        $('.info-item').removeClass("infoShow");
        var $_this = $(this),
            dist1 = $_this.find('.iteml').html(),
            dist2 = $_this.find('.itemr').html(),
            $img = $('.location_img');
        $_this.addClass("infoShow");
        // $(".drop_top0").eq(0).find("p").html(strs1[0]);
        $(".drop_down1").eq(0).find("p").html(dist1);
        $(".drop_part").eq(1).find("input").val(dist2);

        var curStateArr = [],
            curStateArr1 = [];
        $(".delete_N").hide();
        $(".delete_Y").show();
        $(".bottom-hide").show();                  
        for(var i= 0; i<$img.length;i++){
            curStateArr1.push($img.eq(i).attr('src').slice(12,13));
        }
        $img.each(function(index){
            curStateArr.push($img.eq(index).attr('src').slice(12,13));
            var imgDistArr = $img.eq(index).attr('str_id').split(' ');
            if(dist1 == imgDistArr[1] && dist2 == imgDistArr[2]){
                var curState1 = $img.eq(index).attr('src').slice(13,14);
                    // console.log(curState1)
                if(curState1 == '0'){
                    curState1 = '1'
                }else{
                    curState1 = '0';
                    $(".bottom-hide").hide();
                } 
                for(var j=0;j<curStateArr1.length;j++){
                    $img.eq(j).attr('src','img/location'+curStateArr1[j]+'0.png')
                }
                $img.removeClass("blue_light");
                if(curState1 == '1'){
                    $img.eq(index).addClass("blue_light");
                }
                $img.eq(index).attr('src','img/location'+curStateArr[index]+curState1+'.png');
                // $img.eq(index).trigger("click");
                // $('.info-item').delegate()
            }
        })
        $(".delete_Y").unbind("click");
        $(".delete_Y").click(function(){
            $(".infoShow").remove();
            var strs1 = $(".blue_light").attr("str_id").split(" ");
            for(var i=0;i<pointAddArrs.length;i++){
                if(pointAddArrs[i][2].split(" ")[2] == strs1[2]){
                    pointAddArrs.splice(i,1);
                }
            }
            $(".blue_light").remove();
        })
    });
}
/**
 * 图片点击 配置信息表和配置图的消失隐藏操作
 * 
 * @returns
 */
function imgShow(){
    var $img = $(".location_img");
    $img.unbind("click");
    $img.bind("click",function(){
        //移除空点start
        for(var i=0;i<$img.length;i++){
            var imgSrc = $img.eq(i).attr("src");
            if(imgSrc === "img/location-1.png"){
                $img.eq(i).remove();
            }
        }
        //移除空点end
        $(".img_mask").unbind("click");
        var curStateArr = [];
        $(".bottom-hide").show();
        var curState = $(this).attr('src').substr($(this).attr("src").length-6,1),
            curState1 = $(this).attr('src').substr($(this).attr("src").length-5,1);
        if(curState1 == '0'){
            curState1 = '1'
        }else{
            curState1 = '0';
            $(".bottom-hide").hide();
        }
        for(var i= 0; i<$img.length;i++){
            curStateArr.push($img.eq(i).attr('src').substr($(this).attr("src").length-6,1))
        }
        for(var j=0;j<curStateArr.length;j++){
            $img.eq(j).attr('src','img/location'+curStateArr[j]+'0.png')
        }
        
        $(this).attr('src','img/location'+curState+curState1+'.png');
        oLeft = $(this).css("left");
        oTop = $(this).css("top");
        //移除空点start
        var objs = $(".location_img");
        for(var i=0;i<objs.length;i++){
            var _imgSrc = objs.eq(i).attr("src");
            if(_imgSrc === "img/location-1.png"){
                objs.eq(i).remove();
            }
        }
        //移除空点end
        $(".delete_Y").show();
        $(".delete_N").hide();
        $(".delete_Y").unbind("click");
        $(".delete_Y").click(function(){
            $this.remove();
            $(".infoShow").remove();
            $(".bottom-hide").hide();
            for(var i=0;i<pointAddArrs.length;i++){
                if(pointAddArrs[i][2].split(" ")[2] == strs1[2]){
                    pointAddArrs.splice(i,1);
                }
            }
        })
        var $this = $(this);
        var strs1 = $this.attr("str_id").split(" ");
        $(".drop_top0").eq(0).find("p").html(strs1[0]);
        $(".drop_down1").eq(0).find("p").html(strs1[1]);
        $(".drop_part").eq(1).find("input").val(strs1[2]);
        /*判断列表上存储点的列表*/
        $(".info-item").each(function(i){
            $(".info-item").eq(i).removeClass("infoShow");
            if(($(".info-item").eq(i).find(".iteml").html()==strs1[1]) && ($(".info-item").eq(i).find(".itemr").html()==strs1[2])){
                $(".info-item").eq(i).addClass("infoShow");
            }
        })
    })
}
function drawPoint(obj,left,top,str,index,data_id){//需要添加标记的div   左距  右距  str_id
    for(var i=0;i<pointAddArrs.length;i++){
        if(pointAddArrs[i][0] == left && pointAddArrs[i][1] == top){
            pointAddArrs[i][2] = str;
        }
    }
    var objs = $(".location_img");
    for(var i=0;i<objs.length;i++){
        var img_left = objs.eq(i).css("left");
        var img_top = objs.eq(i).css("top");
        if(img_left == left && img_top == top){
            objs.eq(i).attr("str_id",str);
            objs.eq(i).attr("src","img/location"+index+".png");
            return;
        }
    }
    obj.append("<img src=\"img/location"+index+".png\" style=\"top:"+top+";left:"+left+";\" str_id=\""+str+"\" data_id=\""+data_id+"\" class=\"location_img\">");
    distShow();
    imgShow();
}
function spiltFunc(arr,str,str1,str2){//依次为数组 切割点1 切割点2 切割点3 
    var value = [];
    var data_1 = arr.split(str);
    for(var i=0;i<data_1.length;i++){
        data_1[i] = data_1[i].split(str1);
    }
    for(var i=0;i<data_1.length;i++){
        for(var j=0;j<data_1[i].length;j++){
            data_1[i][j] = data_1[i][j].split(str2);
        }
        var name = data_1[i][0][0];
        var name_value = data_1[i][0][1];
        var data_id = data_1[i][1][0];
        var data_id_value = data_1[i][1][1];
        value.push({name:name_value,data_id:data_id_value});
    }
    return value;
}
/* 搜索框start */
var data;
var idKw;
var idAppend;
var idIndex;
function serchPush(datas) {

	// 接收到的两个下拉框字符串
	// datas =
	// ["name:苏荷一号,data_id:01;name:苏荷二号,data_id:02;name:苏荷三号,data_id:03","name:会议室,data_id:11;name:移动商务舱,data_id:12;name:弹性工位,data_id:13"];
	value[0] = spiltFunc(datas[0], ";", ",", ":");
	value[1] = spiltFunc(datas[1], ";", ",", ":");
	for (var i = 0; i < value.length; i++) {
		for (var j = 0; j < value[i].length; j++) {
			values[i].push(value[i][j]);
		}
	}
	/*
	 * $(".drop_down1").unbind("click"); $(".drop_down1").click(function(){
	 * $(".drop_down1").find("li").unbind("click");
	 * $(".drop_down1").find("li").click(function(){ var data_ids =
	 * $(this).attr("data_id"); console.log(data_ids); loadAsset(1,1); }) //
	 * data_3 =
	 * "name:011A,data_id:21;name:011B,data_id:22;name:011C,data_id:23;name:011D,data_id:24";//接收到的搜索框字符串 })
	 */
	$(".kw").unbind("click");
	$(".kw")
			.click(
					function() {
						$(this).val("");
						$(".kw").removeAttr("onKeyup");
						$(this).attr("onKeyup", "getContent(this);");
						$(".kw").parent().next().empty();
						$(".kw").parent().next().hide();
						idKw = "#" + $(this).attr("id");
						idAppend = "#" + $(this).parent().next().attr("id");
						idIndex = Number(idKw.substr(idKw.length - 1));
						data = values[idIndex];
						$(this).parent().parent().unbind("mouseleave");
						$(this)
								.parent()
								.parent()
								.mouseleave(
										function() {
											if ($(".kw").val() == ""
													&& $(".drop_down1 p")
															.html() == "请选择...") {
												$(".kw").val("请选择类型...");
											} else if ($(".kw").val() == ""
													&& $(".drop_down1 p")
															.html() !== "请选择...") {
												$(".kw").val("请选择资产...");
											}
											$(idAppend).hide();
										})
						$(document)
								.ready(
										function() {
											$(document).unbind("keydown");
											$(document)
													.keydown(
															function(e) {
																e = e
																		|| window.event;
																var keycode = e.which ? e.which
																		: e.keyCode;
																if (keycode == 38) {
																	if (jQuery
																			.trim($(
																					idAppend)
																					.html()) == "") {
																		return;
																	}
																	movePrev();
																} else if (keycode == 40) {
																	if (jQuery
																			.trim($(
																					idAppend)
																					.html()) == "") {
																		return;
																	}
																	$(idKw)
																			.blur();
																	if ($(
																			".item")
																			.hasClass(
																					"addbg")) {
																		moveNext();
																	} else {
																		$(
																				".item")
																				.removeClass(
																						'addbg')
																				.eq(
																						0)
																				.addClass(
																						'addbg');
																	}

																} else if (keycode == 13
																		|| keycode == 108) {
																	dojob();
																}
															});

											var movePrev = function() {
												$(idKw).blur();
												var index = $(".addbg")
														.prevAll().length;
												if (index == 0) {
													$(".item")
															.removeClass(
																	'addbg')
															.eq(
																	$(".item").length - 1)
															.addClass('addbg');
												} else {
													$(".item").removeClass(
															'addbg').eq(
															index - 1)
															.addClass('addbg');
												}
											}

											var moveNext = function() {
												var index = $(".addbg")
														.prevAll().length;
												if (index == $(".item").length - 1) {
													$(".item").removeClass(
															'addbg').eq(0)
															.addClass('addbg');
												} else {
													$(".item").removeClass(
															'addbg').eq(
															index + 1)
															.addClass('addbg');
												}

											}

											var dojob = function() {
												$(idKw).blur();
												var value = $(".addbg").text();
												if (value !== "") {
													$(idKw).val(value);
													$(idAppend).hide().html("");
												}
											}
										});
					})
	setDropVal($(".drop_down1 > div"), values);
	setDropVal($(".drop_top0 > div"), values);
	console.log(values)
}
function setDropVal(obj, value) {// 展示下拉框
	obj.unbind("click");
	obj.click(function(event) {
		event = event || window.event;
        event.stopPropagation();
		var $this = $(this).parent();
		$this.find(".xiala").hide();
		$this.find(".shangla").show();
		var this_className = $this.attr("class");
		var class_index = Number(this_className
				.substr(this_className.length - 1));
		data = value[class_index];// ????
		var str = '';
		for (var i = 0; i < data.length; i++) {
			str += "<li data_id=\"" + data[i].data_id + "\">" + data[i].name
					+ "</li>"
		}
		$this.find(".uls").html(str).toggle();
		$this.find(".uls").find("li").unbind("click");
		$this.find(".uls").find("li").click(
				function() {
					var $li = $(this);
					if (class_index == 0) {// 点击左上角搜索框，初始化页面start
						projectId = $li.attr("data_id");
						console.log("项目编号" + projectId);
						if(flag==1){
							$(".alert,.mask").show();
							$(".alert").find(".btn-blue").click(
									function() {
										// 换楼层初始化页面start
										if (pointAddArrs.length > 0) {
											var mydata = "";
											mydata = pointAddArrs.join(":");
											$.ajax({
												url : "filter/cad/configCadAsset",
												type : "POST",
												dataType : 'json',
												data : {
													str : mydata,
													cadPicId : cadPicId
												},
												success : function(data) {
													console.log("资产配置成功");
													loadFloorInfo();
												}
											})
										}

										
									})
									$(".alert").find(".btner").click(function() {
							$(".alert,.mask").hide();
						})
						}else{
							loadFloorInfo();
							
						}
						imgScale = 1;
						pointAddArrs = [];
						$(".location_img").remove();
						// 换楼层初始化页面end
						$this.find("p").html($li.html()).attr(
								"data_id", $li.attr("data_id"));
						
					}// 点击左上角搜索框，初始化页面end
					else {
						$this.find("p").html($li.html()).attr("data_id",
								$li.attr("data_id"));
						if (class_index == 1) {
							console.log("资产类型" + $li.attr("data_id"));
							assetType = $li.attr("data_id");
							loadAsset(projectId, assetType);
						}
					}
					$this.find(".uls").toggle();
					$this.find(".xiala").show();
					$this.find(".shangla").hide();
				})
	})
	$(document).click(function(){
		obj.parent().find(".uls").hide();
    })
}
function getContent(obj) {
	var kw = jQuery.trim($(obj).val());
	if (kw == "") {
		$(idAppend).hide().html("");
		return false;
	}
	var html = "";
	for (var i = 0; i < data.length; i++) {
		if (data[i].name.indexOf(kw) >= 0) {
			html = html
					+ "<div class='item' data_id=\""
					+ data[i].data_id
					+ "\" onmouseenter='getFocus(this)' onClick='getCon(this);'>"
					+ data[i].name + "</div>"
		}
	}

	if (html != "") {
		$(idAppend).show().html(html);
	} else {
		$(idAppend).hide().html("");
	}
}
function getFocus(obj) {
	$(".item").removeClass("addbg");
	$(obj).addClass("addbg");
}
function getCon(obj) {
	var value = $(obj).text();
	var data_id_obj = $(obj).attr("data_id");
	$(idKw).val(value).attr("data_id", data_id_obj);
	$(idAppend).hide().html("");
}
/*搜索框end*/