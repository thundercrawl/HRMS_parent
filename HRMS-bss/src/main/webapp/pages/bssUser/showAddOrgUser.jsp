<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
		    <th>选项&nbsp;<input type="checkbox" onclick="check(this)"></th>
			<th>姓名</th>
            <th>性别</th>
            <th>年龄</th>
            <th>联系方式</th>
            <th>邮箱</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="project">
		<tr>
		    <td class="center"><input type="checkbox" name="check" value="${project.userid}"></td>
			<td class="center">${project.username}</td>
			<td class="center">${project.gender}</td>
			<td class="center">${project.age}</td>
			<td class="center">${project.phone}</td>
			<td class="center">${project.email}</td>
		  </tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/bssuser/showuser?username=" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
<input type="hidden" value="${paginator.page}" id="page">
<div id="adduserdialog" style="display: none">
    <table>
       <tr>
          <td><input type="checkbox" name="usercheck" value="2"></td>
          <td>4545</td>
       </tr>
    </table>
    
    
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		  <a href="javaScript:void(0)" class="btn btn-primary btn-xs" id="sure">确定</a>
                   </div>
                   <div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0)" class="btn btn-primary btn-xs" id="return">取消</a>
                    </div>
   
    
</div>
<script src="js/bssUser/addorguser.js"></script>
