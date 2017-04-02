<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="class_item_fg">
	<table
		class="table table-striped table-bordered bootstrap-datatable dataTable responsive">
		<thead>
			<tr>
				<th>科目名称</th>
				<th>创建时间</th>
				<th>是否允许退款</th>
				<th>是否允许提现</th>
				<th>是否允许转账</th>
				<th>科目介绍</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="queryitem_fy">
			<c:if test="${!(empty paginator.list)}">
				<c:forEach items="${paginator.list}" var="project">
					<tr id="${project.walletItemId}tr">
						<td class="center" id="${project.walletItemId}name">${project.walletItemName}</td>
						<td class="center" id="${project.walletItemId}time">${project.createTime}</td>
						<td class="center" id="${project.walletItemId}refu"
							value="${project.refundStatus}"><c:if
								test="${project.refundStatus=='0'}">否</c:if> <c:if
								test="${project.refundStatus=='1'}">是</c:if></td>
						<td class="center" id="${project.walletItemId}with"
							value="${project.withdrawStatus}"><c:if
								test="${project.withdrawStatus=='0'}">否</c:if> <c:if
								test="${project.withdrawStatus=='1'}">是</c:if></td>
						<td class="center" id="${project.walletItemId}tran"
							value="${project.transferStatus}"><c:if
								test="${project.transferStatus=='0'}">否</c:if> <c:if
								test="${project.transferStatus=='1'}">是</c:if></td>
						<td class="center" id="${project.walletItemId}desc">${project.walletItemDesc}</td>
						<td><a href="javaScript:void(0);"
							class="btn btn-info btn-xs edit updateitem"
							value="${project.walletItemId}"><i class="fa fa-edit"></i>修改</a>
							<a href="javaScript:void(0);"
							class="btn btn-danger btn-xs deleteitem"
							value="${project.walletItemId}"><i class="fa fa-trash-o"></i>删除</a>
						</td>

					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="../common/paginator.jsp">
		<jsp:param value="filter/wallet/all" name="url" />
		<jsp:param value="wallet_item_info" name="loadCmp" />
		<jsp:param value="wallt_item_ip" name="formParam" />
	</jsp:include>
	<div class="alert-box" id="item_dialog">
		<h4 id="htitle">钱包科目信息</h4>
		<form class="form-horizontal" id="item_iteminfo" style="padding: 0 40px; margin-left: -20px;">
			<input type="hidden" id="walletItemId" name="walletItemId" /> <input
				type="hidden" id="createTimed" name="createTime" />
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-4 control-label">科目名称</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="walletItem_Name"
						name="walletItemName" placeholder=""> <i
						class="glyphicon glyphicon-remove alert-cha" id="walletItemName"></i>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-4 control-label">是否允许退款</label>
				<div class="col-sm-8">
					<select class="form-control " name="refundStatus" id="itemrefund">
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-4 control-label">是否允许提现
				</label>
				<div class="col-sm-8">
					<select class="form-control" name="withdrawStatus" id="itemwihdraw">
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-4 control-label">是否允许转账</label>
				<div class="col-sm-8">
					<select class="form-control" name="transferStatus"
						id="itemtransfer">
						<option value="0">否</option>
						<option value="1">是</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmail3" class="col-sm-4 control-label">科目介绍</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="walletItem_Desc"
						name="walletItemDesc" placeholder=""> <i
						class="glyphicon glyphicon-remove alert-cha" id="walletItemDesc"></i>
				</div>
			</div>
		</form>
		<div class="input-group col-md-3 colLee" style="display: inline-block;">
			<a class="btn btn-primary" id="formcheck_sure">确定</a>
		</div>
		<div class="input-group col-md-3 colLee" style="display: inline-block;">
			<a class="btn btn-primary" id="return_esc">取消</a>
		</div>
	</div>
	<!-- <div id="item_dialog" style="display: none;">
		<form id="item_iteminfo" action="">
			<table>
				<tr>
					<td><input type="hidden" id="walletItemId" name="walletItemId"/></td>
					<td><input type="hidden" id="createTimed" name="createTime"/></td>
				</tr>
				<tr>
					<td>科目名称</td>
					<td><div>
							<input type="text" id="walletItem_Name" name="walletItemName" /><span id="walletItemName"></span>
						</div></td>
				</tr>
				<tr>
					<td>是否允许退款 </td>
					<td><select type="select" name="refundStatus" id="itemrefund">
						<option value="0">否</option>
						<option value="1">是</option>
					</select><span id="refundStatus"></span></td>
				</tr>
				<tr>
					<td>是否允许提现 </td>
					<td><select type="select" name="withdrawStatus" id="itemwihdraw">
						<option value="0">否</option>
						<option value="1">是</option>
					</select><span id="withdrawStatus"></span></td>
				</tr>
				<tr>
					<td>是否允许转账  </td>
					<td><select type="select" name="transferStatus" id="itemtransfer">
						<option value="0">否</option>
						<option value="1">是</option>
					</select><span id="transferStatus"></span></td>
				</tr>
				<tr>
					<td>科目介绍</td>
					<td><div>
							<input type="text" id="walletItem_Desc" name="walletItemDesc" /><span id="walletItemDesc"></span>
						</div></td>
				</tr>

			</table>
		</form>
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck_sure">确定</a> 
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="return_esc">取消</a>
	</div> -->
</div>
<link href="css/walletItem.css" rel="stylesheet">
<script src="js/walletitem/walletItem.js"></script>