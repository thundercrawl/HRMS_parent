<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="PersonalBills4">
	<thead>
		<tr>
			<th>会员名称</th>
			<th>会员手机号码</th>
			<th>公司名称</th>
			<th>实际支付金额</th>
			<th>保证金</th>
			<th>订单编号</th>
			<th>订单状态</th>
			<th>支付方式</th>
			<th>交易时间</th>
			<th>支付渠道</th>
			<th>应付金额</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		   <c:forEach items="${paginator.list}" var="pag">
         <tr class="even" >
         	<td class=" ">${pag.userName}</td>
         	<td class=" ">${pag.userPhone}</td>
         	<td class=" ">
         	<c:if test="${pag.companyName!='null'}">
         	${pag.companyName } </c:if>
         	</td>
         	<td class=" ">${pag.actualPayFee}</td>
         	<td class=" ">${pag.ensurePriceFee } </td>
         	<td class=" ">${pag.orderNo}</td>
          	<td class=" ">${pag.orderStatus}</td>
          	<td class=" ">${pag.payActionName}</td>
          	<td class=" ">${pag.payTime}</td>
          	<td class=" ">${pag.payWayName}</td>
          	<td class=" ">${pag.shouldPayFee}</td>
         </tr>
          </c:forEach>
		</c:if>
	</tbody>
</table>
<input type="text" hidden="true" value="${page}" id="page">
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/PersonalBills/findPayBills?userName=${userName}&userPhone=${userPhone}&companyName=${companyName }&fromTime=${fromTime}&toTime=${toTime}&payWay=${payWay}&orderNo=${ orderNo}" name="url" />
	<jsp:param value="PersonalBills4" name="loadCmp"/>
</jsp:include>


