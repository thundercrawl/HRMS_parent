<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript" src="js/cad/peizhi.js"></script>
<div class="top_title_fir">配置界面</div>
	<div class="outer_main clearfix">
		<div class="top_title">
			<div class="drop_top0">
				 <div class="clearfix">
					<p class="drop_val" >请选择项目</p>
					<img src="img/xiala.png" class="xiala">
					<img src="img/shangla.png" class="shangla">
				</div> 
				<ul class="uls"></ul>	
			</div>
			<div class="cad_change">
				<div class="cad_btn">更换CAD图片</div>
			</div>
			<div class="floor-btns">
				<span>楼层：</span>
				<!-- <div class="btner active">1L</div>
				<div class="btner">2L</div> -->
			</div>
		</div>
		<div class="top_content">
		<div class="clearfix">
			<div class="bottom_chart" id="bottom_chart">
				<div class="img_mask">
					<!-- <div class="ball"></div> -->
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
				</div>
				
			</div>
		</div>
		<div class="bottom_content">
			<div class="bottom-hide">
				<div class="bottom_title">
					配置信息
					<div class="blue_kuai"></div>
					<div class="font-gray delete_N">取消</div>
					<div class="delete_Y">删除</div>
				</div>
				<div class="bottom_detail">
					<div class="drop_part drop_part1">
						<p>类型</p>
						<div class="drop_down drop_down1">
							<div class="clearfix">
								<p>请选择...</p>
								<img src="img/xiala.png" class="xiala">
								<img src="img/shangla.png" class="shangla">
							</div>
							<ul class="uls"></ul>
						</div>
					</div>
					<div class="drop_part drop_part1">
						<p>资产</p>
						<div id="container" class="container">
					        <div id="content" class="content">
					            <div class="first"><input id="kw2" class="kw" onKeyup="getContent(this);" /></div>
					            <div id="append2" class="append"></div>
					        </div>
					    </div>
					</div>
					<div class="btner confirm_btn">确定</div>
				</div>
			</div>
		</div>
	</div>
	<div class="right_content clearfix">
		<div class="zichan_info clearfix">
			<div class="bottom_title">
				资产信息
				<div class="blue_kuai"></div>
			</div>
			<div class="right_detail clearfix">
				<div class="info-title clearfix">
					<div class="iteml">类型</div>
					<div class="itemr">资产</div>
				</div>
				<!-- <div class="info-item clearfix">
					<div class="iteml">会议室</div>
					<div class="itemr">011A</div>
				</div> -->
			</div>
			<div class="btner btn-blue btn-blue1">提交</div>
		</div>
	</div>
	<div class="mask"></div>
	<div class="alert">
		<p>温馨提示</p>
		<div class="blue_kuai"></div>
		<div class="alert-con">
			<p>您所设置的资产信息还未提交，是否提交所设置的资产信息？</p>
			<div class="btner btn-blue">提交</div>
			<div class="btner btn-white">取消</div>
		</div>
</div>
</div>
<div id="addProjectPic" style="display: none">
<div id="demo" class="demo">
	<form id="uploadForm" action="filter/project/addprojectPic" method="post" enctype="multipart/form-data">
						<div class="upload_box">
							<div class="upload_main">
								<div class="upload_choose">
	            					<div class="convent_choice">
	            						<div class="andArea">
	            							<div class="filePicker">点击选择文件</div>
	            							<input id="fileImage" type="file" size="30" name="fileselect[]" multiple>
	            						</div>
	            					</div>
									<span id="fileDragArea" class="upload_drag_area">或者将文件拖到此处</span>
								</div>
		            			<div class="status_bar">
		            				<div id="status_info" class="info">选中0张文件，共0B。</div>
		            				<div class="btns">
		            					<div class="webuploader_pick">继续选择</div>
		            					<div class="upload_btn">开始上传</div>
		            				</div>
		            			</div>
		            			<div class="img-group"><ul class="projectpic_url">
		            			</ul>
		            			</div>
		            			
								<div id="preview" class="upload_preview"></div>
							</div>
							<div class="upload_submit">
								<button type="button" id="fileSubmit" class="upload_submit_btn">确认上传文件</button>
							</div>
							<div id="uploadInf" class="upload_inf"></div>
						</div>
					</form>
 </div>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="picreturn">取消</a>
	</div>  
</div>
<script src="js/project/zyFile.js"></script>
<script src="js/project/zyUpload.js"></script>
<script src="js/project/jq22.js"></script>