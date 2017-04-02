<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>角色名称</th>
            <th>角色描述</th>
            <th>创建者</th>
            <th>创建时间</th>
            <th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="project">
		<tr>
			<td class="center">${project.rolename}</td>
			<td class="center">${project.desc}</td>
			<td class="center">${project.creatname}</td>
			<td class="center">${project.creatTime}</td>
			<td class="center">
			  <a href="javaScript:void(0);" class="btn btn-info btn-xs edit updateRole"
			  rolename="${project.rolename}" desc="${project.desc}" roleid="${project.roleid}"><i class="fa fa-edit"></i>修改</a>
			  <a href="javaScript:void(0);" class="btn btn-danger btn-xs delete deleteROle" roleid="${project.roleid}" data-page="${paginator.page}">删除</a>
			</td>
		  </tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/bssuser/showUserRole?rolename=" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
  <div id="addRoledialog" style="display:none;">
  <form action="">
    <table class="table2">
      <tr>
         <td>角色名称</td>
         <td><input type="text" id="rolenames"/><span id="Roname"></span></td>
      </tr>
      <tr>
         <td>角色描述</td>
         <td><input type="text" id="desc"/><span id="descspan"></span></td>
      </tr>
    </table>
   </form>
   <input type="hidden" id="roleid">
   <input type="hidden" id="page" value="${paginator.page}">
   <div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="formcheck">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="return">取消</a>
	</div>
  
  
  </div>
<script src="js/bssUser/role.js"></script>
