<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="MonBusinessRecord">
	<thead>
		<tr>
			<th>时间</th>
			<th>公司名称</th>
			<th>会员名称</th>
			<th>业务类型</th>
			<th>金额</th>
			<th>科目类型</th>
			<th>备注</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		   <c:forEach items="${paginator.list}" var="pag">
         <tr class="even" >
         	<td class=" ">${pag.businessRecTime}</td>
         	<td class=" ">${pag.companyName } </td>
         	<td class=" ">${pag.userName}</td>
         	<td class=" ">${pag.busiName}</td>
         	<td class=" ">${pag.fee}</td>
         	<td class=" ">${pag.categoryName}</td>
          	<td class=" ">${pag.remark}</td>
         </tr>
          </c:forEach>
		</c:if>
	</tbody>
</table>
<input type="text" hidden="true" value="userName=${userName}&userPhone=${userPhone}&companyName=${companyName }&sTime=${sTime}&eTime=${eTime}" id="huan">	
<input type="text" hidden="true" value="${page}" id="page">
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/PersonalBills/findMonBusinessRecord?userName=${userName}&userPhone=${userPhone}&companyName=${companyName }&sTime=${sTime}&eime=${eTime}" name="url" />
	<jsp:param value="MonBusinessRecord" name="loadCmp"/>
</jsp:include>

