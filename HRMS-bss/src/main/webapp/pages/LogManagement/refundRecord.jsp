<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="PersonalBills3">
	<thead>
		<tr>
			<th>会员名称</th>
			<th>公司名称</th>
			<th>订单编号</th>
			<th>申请退款金额</th>
			<th>实际退款金额</th>
			<th>退款日期</th>
			<th>退款方式</th>
			<th>备注</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		   <c:forEach items="${paginator.list}" var="pag">
         <tr class="even" >
         	<td class=" ">${pag.userName}</td>
         	<td class=" ">${pag.companyName } </td>
         	<td class=" ">${pag.orderId}</td>
         	<td class=" ">${pag.refundFee}</td>
         	<td class=" ">${pag.realFee}</td>
         	<td class=" ">${pag.refundTime } </td>
         	<td class=" ">${pag.channel}</td>
          	<td class=" ">${pag.remark}</td>
         </tr>
          </c:forEach>
		</c:if>
	</tbody>
</table>
<input type="text" hidden="true" value="userName=${userName}&userPhone=${userPhone}&companyName=${companyName }&orderId=${orderId}&sTime=${sTime}&eTime=${eTime}&channel=${channel}" id="huan">	
<input type="text" hidden="true" value="${page}" id="page">
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/PersonalBills/findRefund?userName=${userName}&userPhone=${userPhone}&companyName=${companyName }&orderId=${orderId}&sTime=${sTime}&eime=${eTime}&channel=${channel}" name="url" />
	<jsp:param value="PersonalBills3" name="loadCmp"/>
</jsp:include>


