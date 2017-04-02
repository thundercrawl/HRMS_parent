<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table
	class="table table-striped table-hover table-bordered dataTable no-footer"
	aria-describedby="editabledatatable_info" id="cabinet_table">
	<thead>
		<thead>
		<tr role="row">
			<th>用户名称</th>
			<th>用户手机号</th>
			<th>公司名称</th>
			<th>项目名</th>
			<th>门编号</th>
			<th>授权起始时间</th>
			<th>授权终止时间</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
		<tbody>
			<c:forEach items="${paginator.list}" var="c">
				<tr class="even">
					<td style="white-space: nowrap;">${c.userName}</td>
					<td style="white-space: nowrap;">${c.userPhone}</td>
					<td style="white-space: nowrap;">${c.companyName}</td>
					<td style="white-space: nowrap;">${c.projectName}</td>
					<td style="white-space: nowrap;">${c.doorNumber}</td>
					<td style="white-space: nowrap;">${c.startTime}</td>
					<td style="white-space: nowrap;">${c.endTime}</td>
					<td style="white-space: nowrap;" class="status-${c.userBluetoothId }">${c.statusName}</td>
					<td style="white-space: nowrap;">
							<c:if test="${c.status==1}">
							<input type="button" id="prohibition" value="禁用" class="btn btn-info btn-xs prohibition-${c.userBluetoothId }" onclick="prohibition(${c.userBluetoothId},${c.status })">
							</c:if>
							<c:if test="${c.status!=1}">
							<input type="button" id="prohibition" value="解禁" class="btn btn-info btn-xs prohibition-${c.userBluetoothId }" onclick="prohibition(${c.userBluetoothId},${c.status })"></c:if>
							</a>
							<a href="javaScript:void(0);" class="btn btn-info btn-xs "
								onclick="del(${c.userBluetoothId})"> <i
								class="fa fa-edit"></i>删除
							</a>
						</td>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<input type="text" hidden="true" value="${page}" id="page">
<jsp:include page="../common/paginator.jsp">
	<jsp:param  value="filter/thirdparty/bluetooth/findBluetooth?userName=${userName}&userPhone=${userPhone}&companyName=${companyName}&doorNumber=${doorNumber}&startTime=${startTime}&endTime=${endTime}&type=${type}&orderNo=${orderNo }"	name="url" />
	<jsp:param value="cabinet_table" name="loadCmp" />
</jsp:include>


<script src="js/thirdparty/bluetooth.js"></script>