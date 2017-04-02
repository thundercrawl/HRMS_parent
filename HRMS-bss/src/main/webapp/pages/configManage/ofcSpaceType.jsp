<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>空间类别编号</th>
			<th>空间类别名称</th>
			<th>项目编号</th>
			<th>简介内容</th>
			<th>图片URL</th>
			<th></th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="ofcSpaceType">
		<tr>
			<td class="center">${ofcSpaceType.spaceId}</td>
			<td class="center">${ofcSpaceType.spaceName}</td>
			<td class="center">${ofcSpaceType.projectId}</td>
			<td class="center">${ofcSpaceType.spaceDescribe}</td>
			<td class="center">${ofcSpaceType.photoUrl}</td>
			<td class="center">
			<a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro"
			 data-spaceId="${ofcSpaceType.spaceId}" data-spaceName="${ofcSpaceType.spaceName}" data-projectId="${ofcSpaceType.projectId}" 
			data-spaceDescribe="${ofcSpaceType.spaceDescribe}"  
			  data-photoUrl="${ofcSpaceType.photoUrl}" data-page="${paginator.page}" ><i class="fa fa-edit"></i>修改</a>
			<a class="btn btn-danger btn-xs delete deleteParam"  data-spaceId="${ofcSpaceType.spaceId}"  data-page="${paginator.page}">删除</a></td>
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/configManage/showOfcSpaceType" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
</jsp:include>
  <div id="addPdialog" style="display:none;">
  <form action="" enctype="multipart/form-data" id="projectpic">
    <table>
      <!-- <tr>
         <td>资产等级编号</td>
         <td><input type="text" id="spaceId"/><span id="spaceIdSpan"></span></td>
      </tr>  -->
      <tr>
         <td>空间类别名称</td>
         <td><input type="text" id="spaceName"/><span id="spaceNameSpan"></span></td>
      </tr>
      <tr>
        <td>项目</td>
         <td> <select name="selectProject" id="selectProject">
         <c:if test="${!(empty proList)}">
         <option value="0"></option>
											<c:forEach items="${proList}" var="ps">
											<option value="${ps.projectId}">${ps.projectName}</option>
											</c:forEach>
										</c:if>   
      </select>   
        </td>
      </tr>
      <tr>
         <td>简介内容</td>
         <td><input type="text" id="spaceDescribe"/><span id="spaceDescribeSpan"></span></td>
      </tr>
      <tr>
         <td>图片URL</td>
         <td><input type="file" id="file" name='file'> </td>
      </tr>
    </table>
   </form>
  
    <div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="formcheck">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="return">取消</a>
	</div>
   
  </div>
