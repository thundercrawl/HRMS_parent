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
				style="width: 243px;">授权编号</th>
			<th class="sorting" style="white-space: nowrap;" tabindex="0"
				aria-controls="editabledatatable" rowspan="1" colspan="1"
				style="width: 243px;">订单编号</th>
			<th class="sorting" style="white-space: nowrap;" tabindex="0"
				aria-controls="editabledatatable" rowspan="1" colspan="1"
				style="width: 243px;">订单明细编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">授权时间</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">门信息</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">卡号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">公司名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">会员名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">密码</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">起始时间</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">到期时间</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">状态</th>

			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
		<tbody>
			<c:forEach items="${paginator.list}" var="c">
				<tr class="even">
					<td style="white-space: nowrap;">${c.doorCardId}</td>
					<td style="white-space: nowrap;">${c.orderId}</td>
					<td style="white-space: nowrap;">${c.orderDetailId}</td>
					<td style="white-space: nowrap;">${c.createTime}</td>
					<td style="white-space: nowrap;">项目:${c.doorId.project.projectName}&nbsp;楼层:${c.doorId.floorInfo}&nbsp;门牌号:${c.doorId.doorNumber}</td>
					<td style="white-space: nowrap;">${c.cardCode}</td>
					<td style="white-space: nowrap;">${c.companyId.companyName}</td>
					<td style="white-space: nowrap;"><c:if
							test="${c.userId.userName==null||c.userId.userName==''}">
         	${c.userId.userPhone}
         	</c:if> <c:if
							test="${c.userId.userName!=null&&c.userId.userName!=''}">
         	${c.userId.userName}
         	</c:if></td>
					<td style="white-space: nowrap;">${c.password}</td>
					<td style="white-space: nowrap;">${c.startTime}</td>
					<td style="white-space: nowrap;">${c.endTime}</td>
					<td style="white-space: nowrap;">${c.statusName}</td>
					<td style="white-space: nowrap;"><c:if test="${c.status==4}">
							<a href="javaScript:void(0);" class="btn btn-info btn-xs "
								onclick="editlose(${c.doorCardId})"> <i class="fa fa-edit"></i>挂失
							</a>
							<a href="javaScript:void(0);" class="btn btn-info btn-xs "
								onclick="editdestroy(${c.doorCardId})"> <i
								class="fa fa-edit"></i>销户
							</a>
						</c:if> <c:if test="${c.status==2}">
							<a href="javaScript:void(0);" class="btn btn-info btn-xs "
								onclick="editpermission(${c.doorCardId})"> <i
								class="fa fa-edit"></i>授权
							</a>
							<a href="javaScript:void(0);" class="btn btn-info btn-xs "
								onclick="editdestroy(${c.doorCardId})"> <i
								class="fa fa-edit"></i>销户
							</a>
						</c:if></td>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<input value="${paginator.page}" style="display: none;" id="curpage">
<input
	value="orderid=${orderid}&cardnumber=${cardnumber}&doorid=${doorid}&datetimepickerfrom=${datetimepickerfrom}&datetimepickerto=${datetimepickerto}&companyid=${companyid}&status=${status}&datetimepickercreate=${datetimepickercreate}"
	style="display: none;" id="url">
<jsp:include page="../common/paginator.jsp">
	<jsp:param
		value="filter/thirdparty/doorcard/showdoorcard?orderid=${orderid}&cardnumber=${cardnumber}&doorid=${doorid}&datetimepickerfrom=${datetimepickerfrom}&datetimepickerto=${datetimepickerto}&companyid=${companyid}&status=${status}"
		name="url" />
	<jsp:param value="cabinet_table" name="loadCmp" />
</jsp:include>
<div id="alert" style="display: none;">
	<form action="">
		<input value="" id="showdoorcardid" style="display: none;">
		<table>
			<tr>
				<td>状态</td>
				<td><select id="editstatus">
						<option value="" id="showstatus"></option>
						<c:forEach items="${enumlist}" var="p">
							<option value="${p.typeNum}">${p.typeValue}</option>
						</c:forEach>
				</select></td>
			</tr>

		</table>
	</form>
	<a href="javaScript:void(0);" class="btn btn-primary shiny"
		onclick="suredoorcard()">确定</a> <a href="javaScript:void(0);"
		class="btn btn-primary shiny" onclick="cancledoorcard();">取消</a><span
		style="color: red" id="addspan"></span>
</div>

<script src="js/thirdparty/doorcard.js"></script>