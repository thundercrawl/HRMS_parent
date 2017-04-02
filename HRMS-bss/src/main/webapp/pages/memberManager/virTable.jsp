<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>虚拟会员ID</th>
			<th>名字</th>
			<th>电话</th>
			<th>操作</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
			<td class="center">${os.userId}</td>
			<td class="center">${os.userName}</td>
			<td class="center">${os.userPhone}</td>
			<td><input type="button" id="sysout" class="btn btn-primary" value="删除" onclick="memberDel(${os.userId})"></td>
			<%-- <input type="button" id="prohibition" value="禁用" class="btn btn-primary" onclick="prohibition(${os.userId})">
 					<input type="button" id="unprohibition" class="btn btn-primary" value="解禁" onclick="unprohibition(${os.userId})">
 					<input type="button" id="sysout" class="btn btn-primary" value="导出"> --%></td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>	
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="member/getVirMemberSearch" name="url"/>
	<jsp:param value="memSchi" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>