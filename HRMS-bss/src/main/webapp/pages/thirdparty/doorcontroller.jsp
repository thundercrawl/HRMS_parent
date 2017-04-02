<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table
	class="table table-striped table-hover table-bordered dataTable no-footer"
	aria-describedby="editabledatatable_info">
	<thead>
		<tr role="row">
			<th class="sorting" style="white-space: nowrap;" tabindex="0"
				aria-controls="editabledatatable" rowspan="1" colspan="1"
				style="width: 243px;">终端设备编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">终端名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">终端IP</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">终端类型</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">终端状态</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">操作</th>

		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
		<tbody>
			<c:forEach items="${paginator.list}" var="c">
				<tr class="even">
					<td class=" " style="white-space: nowrap;">${c.deviceSysId}</td>
					<td class=" " style="white-space: nowrap;">${c.stationName}</td>
					<td class=" " style="white-space: nowrap;">${c.stationIp}</td>
					<td class=" " style="white-space: nowrap;">${c.appTypeName}</td>
					<td class=" " style="white-space: nowrap;">${c.statusName}</td>
					<td style="white-space: nowrap;"><a href="javaScript:void(0);"
						class="btn btn-info btn-xs "
						onclick="editdoorcontroller(${c.deviceSysId},'${c.stationName}','${c.stationIp}','${c.appTypeName}','${c.statusName}')">
							<i class="fa fa-edit"></i>修改
					</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<input value="${paginator.page}" style="display: none;" id="curpage">
<input value="devicesysid=${devicesysid}&ip=${ip}"
	style="display: none;" id="url">
<jsp:include page="../common/paginator.jsp">
	<jsp:param
		value="filter/thirdparty/doorcontroller/showdoorcontroller?devicesysid=${devicesysid}&ip=${ip}"
		name="url" />
	<jsp:param value="cabinet_table" name="loadCmp" />
</jsp:include>
<div id="alert" style="display: none;">
	<form action="">
		<table>
			<tr>
				<td>终端名称</td>
				<td><input type="text" id="adddoorcontrollername"></td>
			</tr>
			<tr>
				<td>终端IP</td>
				<td><input type="text" id="addip"></td>
			</tr>
			<tr>
				<td>终端类型</td>
				<td><select id="addtype">
						<option value="">请选择</option>
						<option value="A">门禁控制器终端</option>
						<option value="C">IC 收款机终端等</option>
				</select></td>
			</tr>
			<tr>
				<td>终端状态</td>
				<td><select id="addstatus">
						<option value="">请选择</option>
						<option value="1">在线</option>
						<option value="0">脱机</option>
				</select></td>
			</tr>
		</table>
	</form>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" onclick="suredoorcontroller()">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary" onclick="cancledoorcontroller();">取消</a>
	</div>
	<div class="input-group col-md-12">
		<span style="color: red" id="addspan"></span>
	</div>
	
</div>
<div id="alertedit" style="display: none;">
	<form action="">
		<table>
			<tr>
				<td>终端名称</td>
				<td><input type="text" id="editdoorcontrollername"> <input
					type="text" id="editdevicesysid" style="display: none;"></td>
			</tr>
			<tr>
				<td>终端IP</td>
				<td><input type="text" id="editip"></td>
			</tr>
			<tr>
				<td>终端类型</td>
				<td><input type="text" id="edittype" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>终端状态</td>
				<td><input type="text" id="editstatus" readonly="readonly">
				</td>
			</tr>
		</table>
	</form>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary"	onclick="sureeditdoorcontroller()">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a	href="javaScript:void(0);" class="btn btn-primary"	onclick="cancleeditdoorcontroller();">取消</a>
	</div>
	<div class="input-group col-md-12">
		<span style="color: red" id="editspan"></span>
	</div>
	 	
</div>
<script src="js/thirdparty/doorcontroller.js"></script>