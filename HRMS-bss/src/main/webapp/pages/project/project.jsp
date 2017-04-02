<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable" id="projectable">
	<thead>
		<tr>
			<th>项目名称</th>
            <!-- <th>省</th>
            <th>区/县</th>
            <th>商业区</th> -->
            <th>城市</th>
            <th>项目详细地址</th>
            <th>项目描述</th>
            <th>创建者</th>
            <th>创建时间</th>
            <th>联系人</th>
            <th>联系方式</th>
            <th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="project">
		<tr>
			<td class="center">${project.projectname}</td>
			<%-- <td class="center">${project.proname}</td>
			<td class="center">${project.countyname}</td>
			<td class="center">${project.bname}</td> --%>
			<td class="center">${project.cityname}</td>
			<td class="center">${project.address}</td>
			<td class="center">${project.desc}</td>
			<td class="center">${project.createname}</td>
			<td class="center">${project.createtime}</td>
			<td class="center">${project.name}</td>
			<td class="center">${project.phone}</td>
			<td class="center">
			<a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro"
			data-projectname="${project.projectname}" data-proname="${project.proname}" data-cityname="${project.cityname}" 
			data-countyname="${project.countyname}" data-bname="${project.bname}" data-address="${project.address}"
			data-name="${project.name}" data-phone="${project.phone}" data-status="${project.status}"
			data-projectid="${project.projectid}" data-desc="${project.desc}" data-lng="${project.lng }" data-lat="${project.lat }"><i class="fa fa-edit"></i>修改</a>
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs deletePro" data-projectid="${project.projectid}" data-page="${paginator.page}">删除</a>
			<a href="javaScript:void(0);"  class="btn btn-danger btn-xs details" data-projectid="${project.projectid}" data-page="${paginator.page}">楼层</a>
			<a href="javaScript:void(0);"  class="btn btn-info btn-xs addProPic" data-projectid="${project.projectid}">添加大图</a>
			<a href="javaScript:void(0);"  class="btn btn-info btn-xs addSmallProPic" data-projectid="${project.projectid}">添加小图</a>
			</td>
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/project/showPlace?proname=" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
  <div id="addPdialog" style="display:none;">
  <form class="form1" action="" enctype="multipart/form-data" style="margin-right: 18px;">
    <table>
      <tr>
         <td>项目名称</td>
         <td><input type="text" id="projectName"/><span id="pname"><img src="img/delete.png" style="width: 15px;"></span></td>
      </tr>
      <!-- <tr>
         <td>省</td>
         <td><input type="text" id="proname"/><span id="pronamespan"></span></td>
      </tr>
      <tr>
         <td>区/县</td>
         <td><input type="text" id="countyname"/><span id="countynamespan"></span></td>
      </tr>
      <tr>
         <td>商业区</td>
         <td><input type="text" id="bname"/><span id="bnamespan"></span></td>
      </tr> -->
       <tr>
         <td>城市</td>
         <td><input type="text" id="citynameinput" readonly="readonly"/><span id="citynamespan"><img src="img/delete.png" style="width: 15px;"></span>
             <input type="hidden" id="cityid" value="0">
             <ul class="city_ul" id="city_ul"></ul>
         </td>
      </tr>
      <tr>
         <td>项目详细地址</td>
         <td><input type="text" id="address"/><span id="addresspan"><img src="img/delete.png" style="width: 15px;"></span></td>
      </tr>
      <tr>
         <td>项目描述</td>
         <td><input type="text" id="desc"/><span id="descspan"><img src="img/delete.png" style="width: 15px;"></span></td>
      </tr>
      <tr>
         <td>联系人</td>
         <td><input type="text" id="name"/><span id="namespan"><img src="img/delete.png" style="width: 15px;"></span></td>
      </tr>
      <tr>
         <td>联系方式</td>
         <td><input type="text" id="phone"/><span id="phonespan"><img src="img/delete.png" style="width: 15px;"></span></td>
      </tr>
    </table>
   </form>
      <div id="allmap" style="width:400px;height:200px;margin-bottom:20px;"></div>
   <input type="hidden" id="projectid">
   <input type="hidden" id="page" value="${paginator.page}">
   <div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck" page="${paginator.page}">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="return">取消</a>
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
		            			 <!--  <li id="pic0"><img src="img/bg.jpg"/>
		            			 <span class="file_del" data-index="0" data-id="0"  title="删除"></span></li>   -->
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

 <!--   <form action="" enctype="multipart/form-data" id="projectpic">
   <table>
       <tr>
        <td>项目图片</td>
        <td>
		  <input type="file" id="files" name='imgFile' style="width:259px;height:37px;opacity: 0;z-index:999;position: absolute;left: 22%;top:12px;" >
		  <input id='projectimg' name="projectimg" value="请选择图片上传">
		</td>
      </tr>
   </table>
  </form>  -->
<%--   	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="piccheck" page="${paginator.page}">确定</a>
	</div>
	--%>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="picreturn">取消</a>
	</div>  
</div>
<div id="addSmallProPic" style="display: none">
<div id="demo" class="demo">
 </div>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="picreturn2">取消</a>
	</div>  
</div>
<script type="text/javascript">
	// 百度地图API功能
	var plng=0;
	var plat=0;
	var map = new BMap.Map("allmap");    // 创建Map实例
	map.centerAndZoom(new BMap.Point(121.351723,31.294898), 11);  // 初始化地图,设置中心点坐标和地图级别
	map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
	map.setCurrentCity("上海");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

	function showInfo(e){
      var point = new BMap.Point(e.point.lng,e.point.lat);
	 var marker = new BMap.Marker(point);  // 创建标注
	plng=e.point.lng;
	 plat=e.point.lat;
	 map.clearOverlays();  
	 map.addOverlay(marker);              // 将标注添加到地图中
	}
	map.addEventListener("click", showInfo);
</script>

<script src="js/jquery/jquery.form.js"></script>
<!-- <script src="js/jquery/jquery.min.js"></script> -->
<script src="js/project/project.js"></script>
<script src="js/project/zyFile.js"></script>
<script src="js/project/zyUpload.js"></script>
<script src="js/project/jq22.js"></script>

