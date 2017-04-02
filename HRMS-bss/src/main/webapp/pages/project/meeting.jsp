<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive"
	id="projectable_meet">
	<thead>
		<tr>
			<th>所属项目</th>
			<th>会议室名称</th>
			<th>门牌号</th>
			<th>所属楼层</th>
			<th>区域信息</th>
			<th>会议室容量（人数）</th>
			<th>会议室面积（m²）</th>
			<th>简要描述</th>
			<!-- <th>查看图片</th>  -->
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!(empty paginator.list)}">
			<c:forEach items="${paginator.list}" var="BssMeetingroomInfo">
				<tr>
					<td class="center">${BssMeetingroomInfo.projectName}</td>
					<td class="center">${BssMeetingroomInfo.rname}</td>
					<td class="center">${BssMeetingroomInfo.houseNumber}</td>
					<td class="center">${BssMeetingroomInfo.floorInfo}</td>
					<td class="center">${BssMeetingroomInfo.areaInfo}</td>
					<td class="center">${BssMeetingroomInfo.capacity}</td>
					<td class="center">${BssMeetingroomInfo.meetingArea}</td>
					<td class="center">${BssMeetingroomInfo.description}</td>
					<!-- <td><a href="javaScript:void(0);" class="btn btn-info btn-xs edit">查看</a></td> -->
					<td><a href="javaScript:void(0);"
						class="btn btn-info btn-xs edit updateMeeting"
						data-rankId="${BssMeetingroomInfo.rankId}"
						data-rankDescribe="${BssMeetingroomInfo.rankDescribe}"
						data-rname="${BssMeetingroomInfo.rname}"
						data-hn="${BssMeetingroomInfo.houseNumber}"
						data-finfo="${BssMeetingroomInfo.floorInfo}"
						data-ainfo="${BssMeetingroomInfo.areaInfo}"
						data-meetingid="${BssMeetingroomInfo.meetingroomId}"
						data-cap="${BssMeetingroomInfo.capacity}"
						area="${BssMeetingroomInfo.meetingArea}"
						data-desc="${BssMeetingroomInfo.description}"
						projectid="${BssMeetingroomInfo.projectId}"
						projectname="${BssMeetingroomInfo.projectName}"><i
							class="fa fa-edit"></i>修改</a> <%--  <a href="javaScipt:void(0);" class="btn  btn-info btn-xs addMeetingPic" meetingId="${ meetingroomId}">添加图片</a> --%>
						<a href="javaScript:void(0)" class="btn btn-danger btn-xs delete"
						data-id="${BssMeetingroomInfo.meetingroomId}" data-status="2"
						page="${paginator.page}"><i class="fa fa-trash-o"></i>删除</a>
			         <c:if test="${BssMeetingroomInfo.lockstatus==1}"> 
			          <input type="button" class="btn btn-info  btn-xs" value="锁定" id="lock-${BssMeetingroomInfo.meetingroomId}" onclick="lock(${BssMeetingroomInfo.meetingroomId},${BssMeetingroomInfo.lockstatus})">
			          </c:if>
				     <c:if test="${BssMeetingroomInfo.lockstatus==0}">
                     <input type="button" class="btn btn-info  btn-xs" value="解锁" id="lock-${BssMeetingroomInfo.meetingroomId}" onclick="lock(${BssMeetingroomInfo.meetingroomId},${BssMeetingroomInfo.lockstatus})">
                     </c:if>
				</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/project/showMeeting" name="url" />
	<jsp:param value="projectable_meet" name="loadCmp" />
	<jsp:param value="formParam" name="formParam" />
</jsp:include>
<div id="addMdialog" style="display: none;">
	<table class="table2">

		<tr>
			<td>会议室名称</td>
			<td><input type="text" id="meetingroomId" /><span
				id="meetspan"><img alt="" src="img/delete.png"
					style="width: 20px;"></span></td>
		</tr>
		<tr>
			<td>门牌号</td>
			<td><input type="text" id="houseNumber" /><span
				id="numberspan"><img alt="" src="img/delete.png"
					style="width: 20px;"></span></td>
		</tr>
		<tr>
			<td>会议室等级</td>
			<td style="position: relative"><input id="rank_select"
				style="height: 30px;width: 100%;" readonly="true" /><span id="rankimg"><img alt=""
					style="width: 20px;" src="img/delete.png"></span> <input
				id="rank_id" type="hidden" />
				<ul class="rank_select_url select_ul" id="rank_select_url"></ul></td>
		</tr>
		<tr>
			<td>所属项目</td>
			<td style="position: relative"><input id="select"
				style="height: 30px;width: 100%;" readonly="true" /><span id="proimg"><img alt=""
					style="width: 20px;" src="img/delete.png"></span> <input
				id="projectid" type="hidden" value="0" />
				<ul class="select_ul" id="select_ul"></ul></td>
		</tr>
		<tr>
			<td>所属楼层</td>
			<td style="position: relative"><input id="flood" style="height: 30px;width: 100%;" readonly="true" /><span
				id="floodimg"><img alt="" style="width: 20px;"
					src="img/delete.png"></span>
				<ul class="select_ul" id="flood_ul"></ul></td>
		</tr>
		<tr>
			<td>区域信息</td>
			<td><input type="text" id="areaInfo" /><span id="areaspan"><img
					alt="" style="width: 20px;" src="img/delete.png"></span></td>
		</tr>
		<tr>
			<td>会议室容量</td>
			<td><input type="text" id="capacity" /><span id="capspan"><img
					alt="" src="img/delete.png" style="width: 20px;"></span></td>
		</tr>
		<tr>
			<td>会议室面积</td>
			<td><input type="text" id="meetingarea" /><span
				id="Areatspan"><img alt="" src="img/delete.png"
					style="width: 20px;"></span></td>
		</tr>
		<tr>
			<td>简要描述</td>
			<td><input type="text" id="description" /><span
				id="descspan"><img alt="" src="img/delete.png"
					style="width: 20px;"></span></td>
		</tr>
	</table>
	<center>
		<input type="hidden" id="page" value="${paginator.page}"> <input
			type="hidden" id="meetingid">
		<div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck">确定</a>
		</div>
		<div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);"	class="btn btn-primary" id="return">取消</a>
		</div>
		 
	</center>
</div>

<div id="addmeetingPic" style="display: none">
	<form class="form1" action="" id="Meetingform" enctype="multipart/form-data">
		<table>
			<tr>
				<td>会议室图片</td>
				<td><input type="file" id="files" name='imgFile'
					style="width: 262px; height: 37px; opacity: 0; z-index: 999; position: absolute; left: 22%; top: 10px;">
					<input id='projectimg' name="projectimg" value="请选择图片上传"></td>
			</tr>
		</table>
	</form>
	<div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="formPic">确定</a>
		</div>
		<div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="returnpic">取消</a>
		</div>
	 
</div>
<script src="js/project/meeting.js"></script>
