<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table
	class="table table-striped table-hover table-bordered dataTable no-footer"
	aria-describedby="editabledatatable_info">
	<thead>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">所属项目</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">所属楼层</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">门牌号码</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">名称</th>
			<!-- <th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">门禁控制器</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">门禁控制器IP</th> -->
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">蓝牙编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
		<tbody>
			<c:forEach items="${paginator.list}" var="c">
				<tr class="even">
					<td class=" " style="white-space: nowrap;">${c.projectName}</td>
					<td class=" " style="white-space: nowrap;">${c.floorInfo}</td>
					<td class=" " style="white-space: nowrap;">${c.doorNumber}</td>
					<td class=" " style="white-space: nowrap;">${c.doorName}</td>
					<%-- <td class=" " style="white-space: nowrap;">${c.stationName}</td>
					<td class=" " style="white-space: nowrap;">${c.controllerIp}</td> --%>
					<td class=" " style="white-space: nowrap;">${c.bluetoothCode}</td>
					<td style="white-space: nowrap;"><a href="javaScript:void(0);"
						class="btn btn-info btn-xs "
						onclick="editdoor(${c.doorId},'${c.doorNumber}','${c.doorName}','${c.projectIdc}','${c.projectName}','${c.floorInfo}','${c.bluetoothCode}')">
							<i class="fa fa-edit"></i>修改
					</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<input value="${paginator.page}" style="display: none;" id="curpage">
<input
	value="devicesysid=${devicesysid}&ip=${ip}&doornumber=${doornumber}&projectid=${projectid}"
	style="display: none;" id="url">
<jsp:include page="../common/paginator.jsp">
	<jsp:param
		value="filter/thirdparty/door/showdoor?devicesysid=${devicesysid}&ip=${ip}&doornumber=${doornumber}&projectid=${projectid}"
		name="url" />
	<jsp:param value="cabinet_table" name="loadCmp" />
</jsp:include>
<div id="alert" style="display: none;">
	<form action="">
		<table>
			<tr>
				<td>所属项目</td>
				<td><select id="addprojectid">
						<option value="">请选择</option>
						<c:forEach items="${projectlist}" var="p">
							<option value="${p.projectid}">${p.projectname}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>所属楼层</td>
				<td><input type="text" id="addfloor"></td>
			</tr>
			<tr>
				<td>门牌号码</td>
				<td><input type="text" id="adddoornumber"></td>
			</tr>
			<tr>
				<td>名称</td>
				<td><input type="text" id="adddoorname"></td>
			</tr>
			<tr>
				<td>门禁控制器</td>
				<td><input type="text" id="adddevicesysid"></td>
				<%-- <td><select id="adddevicesysid">
						<option value="">请选择</option>
						<c:forEach items="${doorcontrollerlist}" var="p">
							<option value="${p.deviceSysId}">${p.stationName}</option>
						</c:forEach>
				</select></td> --%>
			</tr>
			<tr>
				<td>蓝牙编号</td>
				<td><input type="text" id="addbluetooth"></td>
			</tr>

		</table>
		
	</form>
	
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" onclick="suredoor()">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);"	class="btn btn-primary" onclick="cancledoor();">取消</a>
	</div>
	<div class="input-group col-md-12">
		 <span style="color: red" id="addspan"></span>
	</div>
	
</div>
<div id="alertedit" style="display: none;">
	<form action="">
		<table>
			<tr>
				<td>所属项目</td>
				<td><select id="editprojectid">
						<option value="" id="showprojectid"></option>
						<c:forEach items="${projectlist}" var="p">
							<option value="${p.projectid}">${p.projectname}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>所属楼层</td>
				<td><input type="text" id="editfloor"></td>
			</tr>
			<tr>
				<td>门牌号码</td>
				<td><input type="text" id="editdoornumber"> <input
					type="text" id="editdoorid" style="display: none;"></td>
			</tr>
			<tr>
				<td>名称</td>
				<td><input type="text" id="editdoorname"></td>
			</tr>
			<%-- <tr>
				<td>门禁控制器</td>
				<td><select id="editdevicesysid">
						<option value="" id="showdevicesysid" style="display: none;"></option>
						<c:forEach items="${doorcontrollerlist}" var="p">
							<option value="${p.deviceSysId}">${p.stationName}</option>
						</c:forEach>
				</select></td>
			</tr> --%>
			<tr>
				<td>蓝牙编号</td>
				<td><input type="text" id="editbluetooth"></td>
			</tr>

		</table>
	</form>
	
	
		<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" onclick="suredooredit()">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		  <a href="javaScript:void(0);"	class="btn btn-primary" onclick="cancledooredit();">取消</a>
	</div>
	<div class="input-group col-md-12">
		 <span style="color: red" id="editspan"></span>
	</div>
	
</div>

<script src="js/thirdparty/door.js"></script>