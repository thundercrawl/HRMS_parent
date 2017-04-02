<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>商业区编号</th>
			<th>商业区名称</th>
			<th>所属区县编号</th>
			<th></th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="ofcSpaceType">
		<tr>
			<td class="center">${ofcSpaceType.cbdId}</td>
			<td class="center">${ofcSpaceType.cbdName}</td>
			<td class="center">${ofcSpaceType.countyId}</td>
			<td class="center">
			<a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro"
			 data-cbdId="${ofcSpaceType.cbdId}" data-spaceName="${ofcSpaceType.cbdName}" data-countyId="${ofcSpaceType.countyId}" 
			  ><i class="fa fa-edit"></i>修改</a>
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs delete deleteParam" <%-- data-paramid="${ofcSpaceType.paramId}" --%> data-page="${paginator.page}">删除</a></td>
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/configManage/showSysCbdInfo" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
</jsp:include>
  <div id="addPdialog" style="display:none;">
  <form action="">
    <table>
      <tr>
         <td>商业区编号</td>
         <td><input type="text" id="cbdId"/><span id="cbdIdSpan"></span></td>
      </tr> 
      <tr>
         <td>商业区名称</td>
         <td><input type="text" id="cbdName"/><span id="cbdNameSpan"></span></td>
      </tr>
      <tr>
         <td>所属区县编号</td>
         <td><input type="text" id="countyId"/><span id="countyIdSpan"></span></td>
      </tr>
    </table>
   </form>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
	</div>
  
   
  </div>
  <script src="js/configManage/sysCbdInfo.js"></script>
<script src="js/pagination.js"></script>
