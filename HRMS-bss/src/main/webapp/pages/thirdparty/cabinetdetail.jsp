<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table
	class="table table-striped table-hover table-bordered dataTable no-footer"
	aria-describedby="editabledatatable_info">
	<thead>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="text-align: center;">全选 <input
				type="checkbox" onclick="checkAlldetail(this)">
			</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">大储物柜编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">大储物柜名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">小储物柜编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" style="width: 243px;">类型</th>
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
					<td class=" " style="text-align: center;"><input
						type="checkbox" name="promotions" value="${c.cabinetDetailNo}">
					</td>
					<td class=" ">${code}</td>
					<td class=" ">${cabinetName}</td>
					<td class=" ">${c.cabinetDetailNo}</td>
					<td class=" ">${c.cabinetlTypeString}</td>
					<td class=" ">${c.statusString}</td>
					<td style="white-space: nowrap;"><a href="javaScript:void(0);"
						class="btn btn-info btn-xs "
						onclick="editcabinetdetail('${code}','${cabinetName}',${c.cabinetDetailNo},${c.status},'${c.statusString}','${c.cabinetDetailType}','${c.cabinetlTypeString}')">
							<i class="fa fa-edit"></i>修改
					</a>
					<!-- <a href="javaScript:void(0);"
						class="btn btn-info btn-xs "
						onclick="">
							<i class="fa fa-edit"></i>重置
					</a> --></td>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<input value="${paginator.page}" style="display: none;" id="curpage">
<input
	value="cabinetdetailid=${cabinetdetailid}&status=${status}&cabinetid=${cabinetid}"
	style="display: none;" id="url">
<jsp:include page="../common/paginator.jsp">
	<jsp:param
		value="filter/thirdparty/cabinetdetail/showcabinetdetail?cabinetid=${cabinetid}&cabinetName=${cabinetName}&cabinetdetailid=${cabinetdetailid}&status=${status}&code=${code}"
		name="url" />
	<jsp:param value="cabinet_table" name="loadCmp" />
</jsp:include>
<div id="alertdetail" style="display: none;">
	<form action="" style="margin-right: 25px;">
		<table>
			<tr>
				<td>小储物柜编号</td>
				<td><input type="text" id="addcabinetdetailid"> <input
					type="text" id="cabinetid" hidden="true" value="${cabinetid}">
				</td>
			</tr>
			<tr>
				<td>类型</td>
				<td><select id="addtype">
						<option value="S">小箱柜</option>
						<option value="M">中箱柜</option>
						<option value="B">大箱柜</option>
				</select></td>
			</tr>
			<tr>
				<td>状态</td>
				<td><select id="addstatus">
						<option value="1">未使用</option>
						<option value="2">已使用</option>
				</select></td>
			</tr>
		</table>
	</form>
	
		<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" onclick="surecabinetsdetail('${code}','${cabinetName }')">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);"	class="btn btn-primary" onclick="cancledetail();">取消</a>
	</div>
	<div class="input-group col-md-12">
		 <span id="addsmallspan" style="color: red"></span>
	</div>
	 
</div>
<div id="alerteditdetail" style="display: none;">
	<form action=""  style="margin-right: 25px;">
		<table>
			<tr>
				<td>小储物柜编号</td>
				<td><input type="text" id="editcabinetdetailid"
					readonly="readonly"></td>
			</tr>
			<tr>
				<td>类型</td>
				<td><select id="edittype">
						<option value="" id="showtype" style="display: none;"></option>
						<option value="S">小箱柜</option>
						<option value="M">中箱柜</option>
						<option value="B">大箱柜</option>
				</select></td>
			</tr>
			<tr>
				<td>状态</td>
				<td><select id="editstatus">
						<option value="" id="showstatus" style="display: none;"></option>
						<option value="1">未使用</option>
						<option value="2">已使用</option>
				</select></td>
			</tr>
		</table>
	</form>
	
		<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary"	onclick="sureeditcabinetsdetail()">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a	href="javaScript:void(0);" class="btn btn-primary"	onclick="cancleeditdetail();">取消</a>
	</div>
	<div class="input-group col-md-12">
		  <span id="editsmallspan" style="color: red"></span>
	</div>
	
</div>
<script src="js/thirdparty/cabinetdetail.js"></script>