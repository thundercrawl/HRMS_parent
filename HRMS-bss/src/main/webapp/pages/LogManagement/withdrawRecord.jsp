<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="PersonalBills2">
	<thead>
		<tr>
			<th>会员名称</th>
			<th>公司名称</th>
			<th>申请提现金额</th>
			<th>实际提现金额</th>
			<th>提现日期</th>
			<th>提现方式</th>
			<th>备注</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		   <c:forEach items="${paginator.list}" var="pag">
         <tr class="even" >
         	<td class=" ">${pag.userName}</td>
         	<td class=" ">${pag.companyName } </td>
         	<td class=" ">${pag.withdrawFee}</td>
         	<td class=" ">${pag.realFee}</td>
         	<td class=" ">${pag.withdrawTime } </td>
         	<td class=" ">${pag.channel}</td>
          	<td class=" ">${pag.remark}</td>
         </tr>
          </c:forEach>
		</c:if>
	</tbody>
</table>
<input type="text" hidden="true" value="userId=${userId}&companyId=${companyId}&sTime=${sTime}&eTime=${eTime}&channel=${channel}" id="huan">	
<input type="text" hidden="true" value="${page}" id="page">
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/PersonalBills/findWithdraw?userId=${userId}&companyId=${companyId }&sTime=${sTime}&eTime=${eTime}&channel=${channel}" name="url" />
	<jsp:param value="PersonalBills2" name="loadCmp"/>
</jsp:include>


