<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>公司ID</th>
			<th>名称</th>
			<th>昵称</th>
			<th>邮箱</th>
			<th>电话</th>
			<th>地址</th>
			<!-- <th>公司业务</th>
			<th>公司简介</th> -->
			<th>操作</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
			<td class="center">${os.companyId}</td>
			<td class="center">${os.companyName}</td>
			<td class="center">${os.nickname}</td>
			<td class="center">${os.companyEmail}</td>
			<td class="center">${os.companyPhone}</td>
			<td class="center">${os.companyAddress}</td>
			<%-- <td class="center">${os.companyBusiness}</td>
			<td class="center">${os.companyIntroduction}</td> --%>
			
			<%-- <input type="hidden" id="pagenum" value=${paginator.getPage() }> --%>
<%-- 		<input type="button" id="companyDel" class="btn btn-primary" value="删除"  onclick="comDel('${os.companyId}')"> --%>
<%-- <a id="comDetails" class="btn btn-primary" onclick="comDetails('${os.companyId}')">详情</a> --%>
		<td>	<input type="button" id="comChange" class="btn btn-primary" value="修改" onclick="comChange('${os.companyId}')">
		<input type="button" id="comDetails" class="btn  btn-primary " value="成员" onclick="memSearch1('${os.companyId}')">
		<input type="button"  class="btn  btn-primary " value="创建会员" onclick="createCOMMember('${os.companyId}')">
				<input type="button" id="comArea" class="btn  btn-primary " value="场地" onclick="companyArea('${os.companyId}','${os.companyName }')">
				<input type="button" id="companyDel" class="btn btn-primary" value="解散公司"  onclick="comDel('${os.companyId}')">
		</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>
	
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/member/getCompanySearch?companyId=${companyId}&companyName=${companyName }&companyAddress=${companyAddress }&companyPhone=${ companyPhone}" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>