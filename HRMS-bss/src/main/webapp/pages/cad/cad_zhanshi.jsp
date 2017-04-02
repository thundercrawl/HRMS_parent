<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="js/cad/zhanshi.js"></script>
<div class="top_title_fir">苏河一号展示界面</div>
	<div class="outer_main">
		<div class="top_title">
			<div class="drop_top0">
				<div class="clearfix">
					<p class="drop_val" data_id="0">请选择项目...</p>
					<img src="img/xiala.png" class="xiala">
					<img src="img/shangla.png" class="shangla">
				</div>
				<ul class="uls"></ul>	
			</div>
			<div class="floor-btns">
				<span>楼层：</span>
			</div>
		</div>
		<div class="top_content top_content2">
		<div class="clearfix">
			<div class="bottom_chart" id="bottom_chart">
				<div class="img_mask">
					<!-- <div class="ball"></div> -->
					<div class="info_gongwei">
						<div class="bottom_title">
							会议室
							<div class="blue_kuai"></div>
							<span class="title_info">112A</span>
						</div>
						<div class="info_bottom">
							<div class="clearfix">
								<p class="cp_name">公司名称：</p>
								<p>上海移动商务公司</p>
							</div>
							<div class="clearfix">
								<p class="cp_name">管理员：</p>
								<p>陈美美</p>
							</div>
							<div class="clearfix">
								<p class="cp_name">联系方式：</p>
								<p>189-239-48283</p>
							</div>
							<div class="clearfix">
								<p class="cp_name">租期</p>
								<p>2016/01/01~2016/03/31</p>
							</div>
						</div>
					</div>
				</div>
				<img src="img/map.jpg" id="canvas" >
				<div class="zoom_btn">
					<img src="img/zoomIn.png" id = "zoomIn">
					<img src="img/zoomOut.png" id = "zoomOut">
				</div>
				<!-- 房间介绍 -->
				<div class="introduce clearfix">
					<div class="clearfix">
						<img src="img/meeting0.png">
						<p>会议室</p>
					</div>
					<div class="clearfix">
						<img src="img/movehouse0.png">
						<p>移动商务舱</p>
					</div>
					<div class="clearfix">
						<img src="img/tanxing0.png">
						<p>弹性工位</p>
					</div>
					<div class="clearfix">
						<img src="img/duli0.png">
						<p>独立办公室</p>
					</div>
					<div class="clearfix">
						<img src="img/redfang.png">
						<p>占用</p>
					</div>
					<div class="clearfix">
						<img src="img/bluefang.png">
						<p>空置</p>
					</div>
				</div>
			</div>
		</div>
		<div class="bottom_content bottom_content1">
			<div class="bottom_title">
				会议室
				<div class="blue_kuai"></div>
			</div>
			<div class="bottom_detail bottom_detail1 meetDetail">
			</div>
		</div>
		<div class="bottom_content bottom_content2">
			<div class="bottom_title">
				移动商务舱
				<div class="blue_kuai"></div>
			</div>
			<div class="bottom_detail bottom_detail1 seatDetail">
			</div>
		</div>
		<div class="bottom_content bottom_content3">
			<div class="bottom_title">
				独立办公室
				<div class="blue_kuai"></div>
			</div>
			<div class="bottom_detail bottom_detail1 officeDetail">
			</div>
		</div>
	</div>
</div>