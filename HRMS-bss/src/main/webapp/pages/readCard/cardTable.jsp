<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive"
	id="my-table">
	<thead>
		<tr>
			<th></th>
			<th>订单编号</th>
			<th>用户名</th>
			<th>门牌号</th>
			<th class="mkwidth">项目名</th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${!(empty doorList)}">
			<c:forEach items="${doorList}" var="os">
				<tr>
					<td>
						<div class="checkbox">
							<label> <input type="checkbox" id="blankCheckbox"
								value="${os.doorId}" name="tt" class="checkTt" aria-label="...">
							</label>
						</div>
					</td>
					<td class="center">${os.orderId}</td>
					<td class="center">${os.userName}</td>
					<td class="center">${os.doorNumber}</td>
					<td class="center">${os.projectName}</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
