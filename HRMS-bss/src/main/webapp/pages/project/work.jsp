<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive"
	id="projectable">
	<thead>
		<tr>
			<th>所属项目</th>
			<th>工位名称</th>
			<th>门牌号</th>
			<th>工位编号</th>
			<th>所属楼层</th>
			<th>区域信息</th>
			<th>工位面积（m²）</th>
			<th>简要描述</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!(empty paginator.list)}">
			<c:forEach items="${paginator.list}" var="project">
				<tr>
					<td class="center">${project.projectname}</td>
					<td class="center">${project.seatname}</td>
					<td class="center">${project.houseNum}</td>
					<td class="center">${project.seatNum}</td>
					<td class="center">${project.floor}</td>
					<td class="center">${project.areainfo}</td>
					<td class="center">${project.seatArea}</td>
					<td class="center">${project.desc}</td>
					<td><a href="javaScript:void(0);"
						class="btn btn-info btn-xs edit updateSeat"
						data-rankId="${project.rankId}"
						data-rankDescribe="${project.rankDescribe}"
						seatName="${project.seatname}" houseNum="${project.houseNum}"
						seatNum="${project.seatNum}" seatid="${project.seatid}"
						flood="${project.floor}" areainfo="${project.areainfo}"
						desc="${project.desc}" seatArea="${project.seatArea}"
						projectid="${project.projectid}"
						projectname="${project.projectname}"><i class="fa fa-edit"></i>修改</a>
						<a href="javaScript:void(0);"
						class="btn btn-danger btn-xs delete deletePro"
						seatid="${project.seatid}" page="${paginator.page}">删除</a>
						<c:if test="${project.lockstatus==1}"> 
			              <input type="button" class="btn btn-info  btn-xs" value="锁定" id="lock-${project.seatid}" onclick="lock(${project.seatid},${project.lockstatus})">
			            </c:if>
				        <c:if test="${project.lockstatus==0}">
                         <input type="button" class="btn btn-info  btn-xs" value="解锁" id="lock-${project.seatid}" onclick="lock(${project.seatid},${project.lockstatus})">
                        </c:if></td>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/project/showwork" name="url" />
	<jsp:param value="projectable" name="loadCmp" />
	<jsp:param value="formParam" name="formParam" />
</jsp:include>
<div id="addWdialog" style="display: none;">
	<table class="table2">
		<tr>
			<td>工位名称</td>
			<td><input type="text" id="workName" /><span id="nameimg"><img
					alt="" src="img/delete.png" style="width: 14px;"></span></td>
		</tr>
		<tr>
			<td>门牌号</td>
			<td><input type="text" id="homeNum" /><span id="homeimg"><img
					alt="" src="img/delete.png" style="width: 14px;"></span></td>
		</tr>
		<tr>
			<td>工位等级</td>
			<td style="position: relative"><input id="rank_select"
				 style="height: 30px;width: 100%;"  readonly="true" /><span id="rankimg"><img alt=""
					style="width: 14px;" src="img/delete.png"></span> <input
				id="rank_id" type="hidden" />
				<ul class="rank_select_url select_ul" id="rank_select_url"></ul></td>
		</tr>
		<tr>
			<td>工位编号</td>
			<td><input type="text" id="seatNum" /><span id="seatimg"><img
					alt="" src="img/delete.png" style="width: 14px;"></span></td>
		</tr>
		<tr>
			<td>所属项目</td>
			<td style="position: relative"><input id="select"
				 style="height: 30px;width: 100%;"  readonly="true" /><span id="proimg"><img alt=""
					src="img/delete.png" style="width: 14px;"></span> <input
				id="projectid" type="hidden" value="0" />
				<ul class="select_ul" id="select_ul"></ul></td>
		</tr>
		<tr>
			<td>所属楼层</td>
			<td style="position: relative"><input id="flood" style="height: 30px;width: 100%;" readonly="true" /><span
				   id="floodimg"><img alt="" src="img/delete.png"
					style="width: 14px;"></span>
				<ul class="select_ul" id="flood_ul"></ul></td>
		</tr>
		<tr>
			<td>区域信息</td>
			<td><input type="text" id="areaInfo" /><span
				id="spaceimg"><img alt="" src="img/delete.png"
					style="width: 14px;"></span></td>
		</tr>
		<tr>
			<td>简要描述</td>
			<td><input type="text" id="desc" /><span id="descimg"><img
					alt="" src="img/delete.png" style="width: 14px;"></span></td>
		</tr>
		<tr>
			<td>工位面积</td>
			<td><input type="text" id="seatArea" /><span id="areaimg"><img
					alt="" src="img/delete.png" style="width: 14px;"></span></td>
		</tr>
	</table>
	<center>
		<input type="hidden" id="page" value="${paginator.page}"> <input
			type="hidden" id="seatid">
		<div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck">确定</a>
		</div>
		<div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="return">取消</a>
		</div>

	</center>
</div>

<div id="addworkPics" style="display: none">
	<form action="" id="Workform" enctype="multipart/form-data"
		method="post">
		<table>
			<tr>
				<td>工位图片</td>
				<td><input type="file" id="files" name='imgFile'
					style="width: 243px; height: 37px; opacity: 0; z-index: 999; position: absolute; left: 22%; top: 10px;">
					<input id='projectimg' name="projectimg" value="请选择图片上传"></td>
			</tr>
		</table>
	</form>

	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="formPic">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="returnPic">取消</a>
	</div>


</div>
<script src="js/project/work.js"></script>
