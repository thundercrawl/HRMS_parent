<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="PersonalBills12">
	<thead>
		<tr>
			<th>交易流水号</th>
			<th>会员姓名</th>
			<th>交易金额</th>
			<th>科目</th>
			<th>交易时间</th>
			<th>交易渠道</th>
			<th>备注</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		   <c:forEach items="${paginator.list}" var="pag">
         <tr class="even" >
        	 <td class=" ">${pag.id}</td>
         	<td class=" ">${pag.userName }</td>
         	<td class=" ">${pag.actualPayFee}</td>
         	<td class=" ">${pag.walletItemName}</td>
         	<td class=" ">${pag.time } </td>
         	<td class=" ">${pag.payWayName}</td>
          	<td class=" ">${pag.remark}</td>
         </tr>
          </c:forEach>
		</c:if>
	</tbody>
</table>
<input type="text" hidden="true" value="pageSize=10&userName=${userName}&userPhone=${userPhone}&companyName=${companyName }&fromTime=${fromTime}&toTime=${toTime}&payWay=${payWay}" id="huan">	
<input type="text" hidden="true" value="${page}" id="page">
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/PersonalBills/findRecOut" name="url" />
	<jsp:param value="PersonalBills12" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>


