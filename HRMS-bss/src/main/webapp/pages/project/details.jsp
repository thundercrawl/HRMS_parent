<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectDET">
	<thead>
		<tr>
			<th>项目编号</th>
            <th>楼层编号</th>
            <th>描述</th>
            <th>操作</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="proDe">
		<tr class="even">
			<td class="center">${proDe.projectId}</td>
			<td class="center">${proDe.floorMsg}</td>
			<td class="center">${proDe.floorDescribe}</td>
			<td class="center">
			<a href="javaScript:void(0);" class="btn btn-info btn-xs edit updateDetail"
			data-projectid="${proDe.projectId}" data-page="${paginator.page}" data-floorMsg="${proDe.floorMsg}" data-floorDescribe="${proDe.floorDescribe} " ><i class="fa fa-edit"></i>修改</a>
			<a href="javaScript:void(0);" data-page="${paginator.page}" data-projectid="${proDe.projectId}" data-floorMsg="${proDe.floorMsg}"  class="btn btn-danger btn-xs delete deleteDetail" >删除</a>
			</td>
		</tr>
		</c:forEach>
	</c:if>
	</tbody>
</table>

 <div id="addDetaildialog" style="display:none;">
  <form action="">
    <table>
      <tr>
         <td>楼层编号</td>
         <td><input type="text" id="floorMsg"/><span id="floorMsgErr"></span></td>
      </tr>
      <tr>
         <td>描述</td>
         <td>
         <input type="text" id="floorDescribe"/><span id="floorDescribeErr"></span>
         </td>
      </tr>
    </table>
   </form>
   <input type="hidden" id="projectId" value="${projectId}">
   <input type="hidden" id="page" value="${paginator.page}">
   <div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="detailConfirm">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
	</div>
   
   
  </div>
  <div>
  <div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="backPage">返回 </a>
	</div>
  	
  </div>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/project/showDetails?projectId=${projectId}&floorMsg="  name="url" />
	<jsp:param value="details" name="loadCmp"/>
</jsp:include>
<script src="js/project/details.js"></script>
