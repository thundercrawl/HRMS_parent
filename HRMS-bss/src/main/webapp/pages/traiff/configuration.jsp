<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive">
	<thead>
		<tr>
			<!-- 			<td class="center">编辑</td> -->
			<th class="center">名称</th>
			<th class="center">单价</th>
			<th class="center">计费单元</th>
			<th class="center">精度</th>
			<th class="center">向上向下</th>
			<th class="center">操作</th>
		</tr>
	</thead>
	<tbody id="queryrate_fy">
		<c:if test="${!(empty paginator.list)}">
			<c:forEach items="${paginator.list}" var="project">
				<tr>
					<%-- 		    <td class="center"><input type="checkbox" name="ratepldl" value="${project.rateId}"></td> --%>
					<td class="center">${project.rateName}</td>
					<td class="center">${project.ratePriceFee}</td>
					<td class="center">${project.unitName}</td>
					<td class="center">${project.ratePrecisionName}</td>
					<td class="center">${project.rateTypeName}</td>
					<td><a href="javaScript:void(0);"
						class="btn btn-info btn-xs edit updaterate"
						data-rateid="${project.rateId}" data-ratecode="${project.code}"
						data-ratename="${project.rateName}"
						data-rateprice="${project.ratePriceFee}"
						data-rateunit="${project.unit}"
						data-rateprecision="${project.ratePrecision}"
						data-ratetype="${project.rateType}"><i class="fa fa-edit"></i>修改</a>
						<a href="javaScript:void(0);"
						class="btn btn-danger btn-xs deleterate"
						data-rate-id="${project.rateId}"><i class="fa fa-trash-o"></i>删除</a>
						<input type="checkbox" name="check_rate_id"
						class="check_rate_delete" value="${project.rateId}"></td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<input type="hidden" value="${page }" id="curPage" name="curPage">
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/tariff/traiffconfigure" name="url" />
	<jsp:param value="projectable_rate" name="loadCmp" />
	<jsp:param value="projectable_ip" name="formParam" />
</jsp:include>
<div id="addPdialog" style="display: none;">
	<form action="" style="margin-right: 60px;">
		<table>
			<tr>
				<td><input type="hidden" id="rate_id_add" /></td>
			</tr>
			<tr>
				<td><input type="hidden" id="rate_code_add" /></td>
			</tr>
			<tr>
				<td>名称</td>
				<td><input type="text" id="rate_name_add" maxlength="20" /><span
					id="span_name_add"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>单价</td>
				<td><input type="number" id="rate_price_add" maxlength="14" /><span
					id="span_price_add"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<tr>
				<td>计费单元</td>
				<td><select type="select" id="rate_unit_sec">
						<option value=""></option>
						<c:forEach items="${rateunit }" var="unit">
							<option value="${unit.typeNum }">${unit.typeValue }</option>
						</c:forEach>
				</select><span id="span_unit_add"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr>
			<%-- <tr>
				<td>精度</td>
				<td><select id="rate_ratePrecision_add" class="ratePrecision">
						<option value=""></option>
						<c:forEach items="${ratepress }" var="press">
							<option value="${press.typeNum }">${press.typeValue }</option>
						</c:forEach>
				</select> <span id="span_ratePrecision_add"
					style="display: none; color: red; font-size: 18px">X</span></td>

				<!--          <input type="text" id="rate_ratePrecision_add"/><span id="span_ratePrecision_add"></span></td> -->
			</tr>
			<tr>
				<td>取整方式</td>
				<td><select id="rate_rateType_add">
						<option value=""></option>
						<c:forEach items="${ratetype }" var="rattype">
							<option value="${rattype.typeNum }">${rattype.typeValue }</option>
						</c:forEach>
				</select> <span id="span_rateType_add"
					style="display: none; color: red; font-size: 18px">X</span></td>
			</tr> --%>

		</table>
	</form>


	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck_rate">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="return_rate">取消</a>
	</div>
	 
</div>
<script src="js/tariff/rate.js"></script>