//数据初始化
var picType = 3;//cad图片类型
var projectId = 0;//项目编号
var cadPicId = 0;//cad图片编号
var assetType = 1;//资产类型枚举
var floorNum = 0;//项目当前楼层
var flag=0;//资产数据是否改动0未改动，1为有改动
//数据初始化结束
var imgScale= 1;
var pointAddArrs = [];
$('.img_mask').height($("#canvas").height());
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
				var objArr = spiltFunc(proStr,";",",",":");
				    var values = [objArr];
				    setDropVal($(".drop_top0 > div"),values);
			}
		})
}
var titile="";
function loadRentInfo(){
	//console.log("加载租用信息");
	$.ajax({
		url : "filter/cad/findAsset",
		type : "POST",
		dataType : 'json',
		data : {
			projectId : projectId,
			assetId : assetId,
			assetType:assetType,
			floorNum:floorNum
		},
		success : function(data) {
			
			var str="";
			if(data.status==1){
				for(var i=0;i<data.data.list.length;i++){
					console.log(data.data.list[0].list);
					for(var j=0;j<data.data.list[i].list.length;j++){
						var onestr="<div class=\"clearfix\"><p class=\"cp_name\">公司名称：</p><p>"
						+data.data.list[i].list[j].companyName+"</p>"
					+"</div><div class=\"clearfix\"><p class=\"cp_name\">管理员：</p><p>"+
					data.data.list[i].list[j].userName+"</p>"
					+"</div><div class=\"clearfix\"><p class=\"cp_name\">联系方式：</p><p>"
					+"189-239-48283"+"</p>"
					+"</div><div class=\"clearfix\"><p class=\"cp_name\">租期</p><p>"
					+data.data.list[i].rentStartTime+"~"+data.data.list[i].actualEndTime+"</p></div>";
					console.log(onestr);
						str=str+onestr;
					}
				}
			}
			//str=str+onestr;
			$(".info_gongwei .bottom_title").html(titile+"<div class=\"blue_kuai\"></div><span class=\"title_info\">"+assetId+"</span>")
		  $(".info_gongwei .info_bottom").html(str);
		}
	})
}
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
					$('.img_mask').height($("#canvas").height());
					$("#canvas").attr("src",data.data.list[0].photoUrl);
					cadPicId = data.data.list[0].cadId;
					loadAllAsset();
					loadCadConfig();
				} else {
					imgScale = 1;
					pointAddArrs = [];
					$("#canvas").hide();
					if (confirm("该楼层没有CAD配置！请前往配置！")) {// 上传项目CAD图片
					}
				}
			}
		})
	}
}

//加载之前已经配置的资产信息
function loadCadConfig() {
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
				$(".location_img").remove();
				if(data.status==1){
					var strInfo=[];
					
					for (var j = 0; j < data.data.list.length; j++) {
						strInfo.push(data.data.list[j].dataStr);
						console.log(data.data.list[j].dataStr);
						// "711.00px,454.00px,苏河水岸空间 移动商务舱 B03,10,1 1 11011"
					}
					for(var i=0;i<strInfo.length;i++){
					    strInfo[i] = strInfo[i].split(",");
					}
					pointAddArrs = strInfo;
					
					drawpoint();
				}
			}
		})
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
			//console.log("加载项目楼层信息：" + data);
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
					
						// 推送配置信息到后台
						var btn_floor = $this.html();
						floorNum = btn_floor.replace("L", "");
						//console.log("当前楼层：" + floorNum);
						$this.addClass("active").siblings().removeClass("active");

						// 换楼层初始化页面start
						imgScale = 1;
						pointAddArrs = [];
						loadImg(projectId, floorNum);
						// 换楼层初始化页面end
					
					})
				loadImg(projectId,floorNum);
			}else if (data.status == 3) {
				imgScale = 1;
				pointAddArrs = [];
				$("#canvas").hide();
				alert(data.message);
			}

		}
	})
}
function loadAllAsset(){
//	loadAssetInfoSeat();
//	loadAssetInfoMeet();
//	loadAssetInfoOffice();
	 loadAssetInfo(1);
	 loadAssetInfo(2);
	 loadAssetInfo(3);
}

function loadAssetInfo(assettype){
	if(assettype==1){
		$(".seatDetail").html("");
	}
	if(assettype==2){
		$(".meetDetail").html("");
	}
	if(assettype==3){
		$(".officeDetail").html("");
	}
	$.ajax({
		url : "filter/cad/findAsset",
		type : "POST",
		dataType : 'json',
		data : {
			projectId : projectId,
			cadId : cadPicId,
			floorNum:floorNum,
			assetType:assettype
		},
		success : function(data) {
//			console.log("-----");
//			console.log(data);
			if(data.status==1){
				var str="";
				for(var i=0;i<data.data.list.length;i++){
//					var assinfo=data.data.list[i];
//					console.log("加载下方资产信息：" + data.data.list[i]);
					if(data.data.list[i].status=='0')
						str=str+"<p class=\"red_zhan\">"+data.data.list[i].houseNum+"</p>";
					else
						str=str+"<p class=\"blue_kong\">"+data.data.list[i].houseNum+"</p>";
				}
				if(assettype==1){
					$(".seatDetail").append(str);
				}
				if(assettype==2){
					$(".meetDetail").append(str);
				}
				if(assettype==3){
					$(".officeDetail").append(str);
				}
			}else{
				//alert("当前CAD无资产配置信息");
			}
			
		}
	})
}
function drawpoint(){
    imgScale= 1;
	if(typeof(pointAddArrs[0]) !== 'string'){
	    for(var i=0;i<pointAddArrs.length;i++){
	        drawPoint($(".img_mask"),pointAddArrs[i][0],pointAddArrs[i][1],pointAddArrs[i][2],pointAddArrs[i][3],pointAddArrs[i][4])
	    } 
	}else{
	    drawPoint($(".img_mask"),pointAddArrs[0],pointAddArrs[1],"")
	}
	showInfo(); 
}

$(function(){
    showInfo();
    changeFloor();
    smartZoom(0.5);
    mouseZoom();
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
    _imgH = $('#canvas').height();
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
        });
    })
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

function changeFloor(){
    $(".alert,.mask").hide();
    $(".floor-btns").find(".btner").click(function(){
        var $this = $(this);
        $this.addClass("active").siblings().removeClass("active");
        var btn_floor = $this.html();
		floorNum = btn_floor.replace("L", "");
		console.log("当前楼层：" + floorNum);
        //换楼层初始化页面start
        imgScale=1;
        pointAddArrs = [];
        loadImg(projectId, floorNum);
        $(".location_img").remove();
        //换楼层初始化页面end
    })
}
function setDropVal(obj,value){//展示下拉框
    obj.unbind("click");
    obj.click(function(event){
    	event = event || window.event;
        event.stopPropagation();
        var $this = $(this).parent();
        $this.find(".xiala").hide();
        $this.find(".shangla").show();
        var this_className = $this.attr("class");
        var class_index = Number(this_className.substr(this_className.length-1));
        data = value[class_index];//????
        var str='';
        for(var i=0;i<data.length;i++){
            str+="<li data_id=\""+data[i].data_id+"\">"+data[i].name+"</li>"
        }
        $this.find(".uls").html(str).toggle();
        $this.find(".uls").find("li").unbind("click");
        $this.find(".uls").find("li").click(function(){
            var $li = $(this);
            if(class_index == 0){//点击左上角搜索框，初始化页面start
                //换楼层初始化页面start
            	projectId = $li.attr("data_id");
            	loadFloorInfo();
                imgScale=1;
                pointAddArrs = [];
                $(".location_img").remove();
                //换楼层初始化页面end
                $this.find("p").html($li.html()).attr("data_id",$li.attr("data_id"));
            }//点击左上角搜索框，初始化页面end
            else{
                $this.find("p").html($li.html()).attr("data_id",$li.attr("data_id"));
            }
            $this.find(".uls").toggle();
            $this.find(".xiala").show();
            $this.find(".shangla").hide();
        })
    })
    $(document).click(function(){
        obj.find(".uls").hide();
    })
}
if(typeof(pointAddArrs[0]) !== 'string'){
    for(var i=0;i<pointAddArrs.length;i++){
        drawPoint($(".img_mask"),pointAddArrs[i][0],pointAddArrs[i][1],pointAddArrs[i][2],pointAddArrs[i][3],pointAddArrs[i][4])
    } 
}else{
    drawPoint($(".img_mask"),pointAddArrs[0],pointAddArrs[1],"")
}
function showInfo(){
    $(".location_img").unbind("click");
    $(".location_img").click(function(event){
    	event = event || window.event;
        event.stopPropagation();
        var $this = $(this);
        var strs = $this.attr("str_id").split(" ");
        var assetData=$this.attr("data_id").split(" ");
        assetId=assetData[2];
        assetType=assetData[1];
        console.log("assetId:"+assetId+"assetType:"+assetType);
        if(assetType==1)
        	titile="移动商务舱";
        if(assetType==2)
        	titile="会议室";
        if(assetType==3)
        	titile="办公室";
        var left=Number($this.css("left").substr(0,$this.css("left").length-2))+7+"px";
	    var top= Number($this.css("top").substr(0,$this.css("top").length-2))+7+"px";
	    console.log(top)
	    $(".info_gongwei").show().css({"left":left,"top":top});
        loadRentInfo();
    })
    $(document).click(function(){
        $(".info_gongwei").hide();
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
}