<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="PersonalBills1">
	<thead>
		<tr>
			<th>会员名称</th>
			<th>公司名称</th>
			<th>充值金额</th>
			<th>到账金额</th>
			<th>充值日期</th>
			<th>充值渠道</th>
			<th>备注</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		   <c:forEach items="${paginator.list}" var="pag">
         <tr class="even" >
         	<td class=" ">${pag.userName}</td>
         	<td class=" ">${pag.companyName } </td>
         	<td class=" ">${pag.depositFee}</td>
         	<td class=" ">${pag.realFee}</td>
         	<td class=" ">${pag.depositTime } </td>
         	<td class=" ">${pag.channelName}</td>
          	<td class=" ">${pag.remark}</td>
         </tr>
          </c:forEach>
		</c:if>
	</tbody>
</table>
<input type="text" hidden="true" value="userName=${userName}&userPhone=${userPhone}&companyName=${companyName }&sTime=${sTime}&eTime=${eTime}&channel=${channel}" id="huan">	
<input type="text" hidden="true" value="${page}" id="page">
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/PersonalBills/findDeposit?userName=${userName}&userPhone=${userPhone}&companyName=${companyName }&sTime=${sTime}&eime=${eTime}&channel=${channel}" name="url" />
	<jsp:param value="PersonalBills1" name="loadCmp"/>
</jsp:include>


