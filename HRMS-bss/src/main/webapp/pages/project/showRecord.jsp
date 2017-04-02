<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="recordtable">
	<thead>
		<tr>
			<th>项目名称</th>
            <!-- <th>省</th>
            <th>市</th>
            <th>区/县</th>
            <th>商业区</th> -->
            <th>项目详细地址</th>
            <th>创建者</th>
            <th>创建时间</th>
            <th>联系人</th>
            <th>联系方式</th>
            <th>项目状态</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="project">
		<tr>
			<td class="center">${project.projectname}</td>
			<%-- <td class="center">${project.proname}</td>
			<td class="center">${project.cityname}</td>
			<td class="center">${project.countyname}</td>
			<td class="center">${project.bname}</td> --%>
			<td class="center">${project.address}</td>
			<td class="center">${project.createname}</td>
			<td class="center">${project.createtime}</td>
			<td class="center">${project.name}</td>
			<td class="center">${project.phone}</td>
			<c:if test="${project.status==1}">
			  <td class="center">未使用</td>
			</c:if>
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/project/showPlace" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
</jsp:include>
  <div id="addPdialog" style="display:none;">
  <form action="">
    <table>
      <tr>
         <td>项目名称</td>
         <td><input type="text" id="projectName"/><span id="pname"></span></td>
      </tr>
      <!-- <tr>
         <td>省</td>
         <td><input type="text" id="proname"/><span id="pronamespan"></span></td>
      </tr>
      <tr>
         <td>市</td>
         <td><input type="text" id="cityname"/><span id="citynamespan"></span></td>
      </tr>
      <tr>
         <td>区/县</td>
         <td><input type="text" id="countyname"/><span id="countynamespan"></span></td>
      </tr>
      <tr>
         <td>商业区</td>
         <td><input type="text" id="bname"/><span id="bnamespan"></span></td>
      </tr> -->
      <tr>
         <td>项目详细地址</td>
         <td><input type="text" id="address"/><span id="addresspan"></span></td>
      </tr>
      <tr>
         <td>联系人</td>
         <td><input type="text" id="name"/><span id="namespan"></span></td>
      </tr>
      <tr>
         <td>联系方式</td>
         <td><input type="text" id="phone"/><span id="phonespan"></span></td>
      </tr>
      <tr>
         <td>项目状态</td>
         <td>
         <div class="dataTables_length" id="simpledatatable_length">
         <label><select name="simpledatatable_length" aria-controls="simpledatatable" class="form-control input-sm" id="status">
             <option value="0">使用</option>
             <option value="1">未使用</option>
         </select></label>
         </div>
         </td>
      </tr>
    </table>
   </form>
   <a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck">确定</a>
   <a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
  </div>
<script src="js/project/project.js"></script>
