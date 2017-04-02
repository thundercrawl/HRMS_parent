<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<span id="showorderid">订单编号:${orderid}</span>
<table
	class="table table-striped table-hover table-bordered dataTable no-footer"
	aria-describedby="editabledatatable_info">
	<thead>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">公司名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">项目名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">资产类型</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">资产名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">楼层</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">门牌号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">起始时间</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">结束时间</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">容量</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">已授权人数</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 171px;">操作</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${list}" var="c">
			<tr class="even">
				<td style="white-space: nowrap;">${c.companyName}</td>
				<td style="white-space: nowrap;">${c.projectName}</td>
				<td style="white-space: nowrap;"><c:if
						test="${c.isMeetingRoom==0}">
         	办公室
         	</c:if> <c:if test="${c.isMeetingRoom==1}">
         	会议室
         	</c:if></td>
				<td style="white-space: nowrap;"><c:if
						test="${c.isMeetingRoom==0}">
         	${c.OName}
         	</c:if> <c:if test="${c.isMeetingRoom==1}">
         	${c.rname}
         	</c:if></td>
				<td style="white-space: nowrap;">${c.floorMsg}</td>
				<td style="white-space: nowrap;">${c.doorNumber}</td>
				<td style="white-space: nowrap;">${c.rentStartTime}</td>
				<td style="white-space: nowrap;">${c.rentEndTime}</td>
				<td style="white-space: nowrap;">${c.capacity}</td>
				<td style="white-space: nowrap;">${c.boundedCount}</td>
				<td style="white-space: nowrap;"><c:if
						test="${(c.capacity>c.boundedCount)&&c.doorId!=null&&now<c.rentEndTime}">
						<a href="javaScript:void(0);" class="btn btn-info btn-xs "
							onclick="adddoorcard('${c.orderId}','${c.orderDetailId}','${c.projectId}','${c.projectName}','${c.floorMsg}','${c.doorId}','${c.doorNumber}','${c.rentStartTime}','${c.rentEndTime}','${c.companyName}','${c.companyId}')">
							<i class="fa fa-edit"></i>添加授权
						</a>
					</c:if> <c:if test="${c.capacity<c.boundedCount}">
         	授权已满&nbsp;&nbsp;
         	</c:if> <c:if test="${c.doorId==null}">
         	此门设备不全&nbsp;&nbsp;
         	</c:if> <c:if test="${now>c.rentEndTime}">
         	已过期
         	</c:if></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div id="alert" style="display: none;">
	<form action="">
		<table>
			<tr>
				<td>订单编号</td>
				<td><input type="text" id="addorderId" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>订单明细编号</td>
				<td><input type="text" id="addorderDetailId"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td>公司名称</td>
				<td><input type="text" id="addcompanyName" readonly="readonly">
					<input type="text" id="addcompanyId" style="display: none;">
				</td>
			</tr>
			<tr>
				<td>所属项目</td>
				<td><input type="text" id="addprojectName" readonly="readonly">
					<input type="text" id="addprojectId" style="display: none;">
				</td>
			</tr>
			<tr>
				<td>楼层信息</td>
				<td><input type="text" id="addfloorMsg" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>门牌号</td>
				<td><input type="text" id="adddoorNumber" readonly="readonly">
					<input type="text" id="adddoorId" style="display: none;"></td>
			</tr>
			<tr>
				<td>起始时间</td>
				<td><input type="text" id="addrentStartTime"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td>结束时间</td>
				<td><input type="text" id="addrentEndTime" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>会员</td>
				<td><select id="adduserId">
						<option value="">请选择</option>
				</select></td>
			</tr>
			<tr>
				<td>卡号</td>
				<td><input type="text" id="addcardnumber"><br>
				<span style="color: red" id="addcardnumberspan"></span></td>
			</tr>
			<tr>
				<td>请输入密码</td>
				<td><input type="password" id="addpassword"><br>
				<span style="color: red" id="addpasswordspan"></span></td>
			</tr>
			<tr>
				<td>确认密码</td>
				<td><input type="password" id="surepassword"><br>
				<span style="color: red" id="surepasswordspan"></span></td>
			</tr>
		</table>
	</form>
	<a href="javaScript:void(0);" class="btn btn-primary shiny"
		onclick="suredoorcard()">确定</a> <a href="javaScript:void(0);"
		class="btn btn-primary shiny" onclick="cancledoorcard();">取消</a><span
		style="color: red" id="addspan"></span>
</div>
<script src="js/thirdparty/adddoorcard.js"></script>