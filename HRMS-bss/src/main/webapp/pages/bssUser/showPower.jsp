<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>权限名称</th>
            <th>权限描述</th>
            <th>父权限名称</th>
            <th>创建者</th>
            <th>创建时间</th>
            <th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="project">
		<tr>
			<td class="center">${project.powerName}</td>
			<td class="center">${project.desc}</td>
			<td class="center">${project.powerFname}</td>
			<td class="center">${project.createName}</td>
			<td class="center">${project.createTime}</td>
			<td class="center">
			  <a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePower"
			  powername="${project.powerName}" desc="${project.desc}" fname="${project.powerFname}"
			  status="${project.status}" powerid="${project.powerid}"><i class="fa fa-edit"></i>修改</a>
			 <a href="javaScript:void(0);" class="btn btn-danger btn-xs delete deletePower" powerid="${project.powerid}" data-page="${paginator.page}" status="0">删除</a>
			</td>
		  </tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/bssuser/showPower?powername" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
  <div id="addPdialog" style="display:none;">
  <form action="">
    <table class="table2">
      <tr>
         <td>权限名称</td>
         <td><input type="text" id="powername"/><span id="Pspan"></span></td>
      </tr>
      <tr>
         <td>权限描述</td>
         <td><input type="text" id="desc"/><span id="descspan"></span></td>
      </tr>
      <tr>
         <td>父权限名称</td>
         <td><input type="text" id="Fpowername" readonly="readonly"/></span>
             <input type="hidden" id="fpowerid" value="0"/>
             <ul class="power_ul" id="project_ul"></ul>
         </td>
      </tr>
    </table>
   </form>
   <input type="hidden" id="page" value="${paginator.page}">
   <input type="hidden" id="powerid" >
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
	</div>
   
  
  </div>
<script src="js/bssUser/power.js"></script>
