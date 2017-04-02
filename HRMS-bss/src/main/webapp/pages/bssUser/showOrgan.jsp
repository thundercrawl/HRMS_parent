<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>组织名称</th>
            <th>组织简介</th>
            <th>创建者</th>
            <th>创建时间</th>
            <th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="project">
		<tr>
			<td class="center">${project.orgname}</td>
			<td class="center">${project.desc}</td>
			<td class="center">${project.creatName}</td>
			<td class="center">${project.creatTime}</td>
			<td class="center">
			  <a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro"
			  orgname="${project.orgname}" desc="${project.desc}" orgid="${project.orgid}"><i class="fa fa-edit"></i>修改</a>
			  <a href="javaScript:void(0);" class="btn btn-danger btn-xs delete deletePro" data-orgid="${project.orgid}" data-page="${paginator.page}" data-status="1">删除</a>
			  <a href="javaScript:void(0);" class="btn btn-info btn-xs addorguser" data-orgid="${project.orgid}" orgname="${project.orgname}" data-page="${paginator.page}">查看成员</a>
			</td>
		  </tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/bssuser/showOrgan?orgname" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
  <div id="addOdialog" style="display:none;">
  <form action="">
    <table class="table2">
      <tr>
         <td>组织名称</td>
         <td><input type="text" id="orgname"/><span id="uname"></span></td>
      </tr>
      <tr>
         <td>组织描述</td>
         <td><input type="text" id="desc"/><span id="descspan"></span></td>
      </tr>
    </table>
   </form>
   <input type="hidden" id="page" value="${paginator.page}">
   <input type="hidden" id="orgid">
   <div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
	</div>
  
  
  </div>
<script src="js/bssUser/organ.js"></script>
