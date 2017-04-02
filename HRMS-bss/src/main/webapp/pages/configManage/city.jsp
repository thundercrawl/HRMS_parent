<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>城市编号</th>
			<th>城市名称</th>
			<th>纬度</th>
			<th>经度</th>
			<th></th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="city">
		<tr>
			<td class="center">${city.cityId}</td>
			<td class="center">${city.cityName}</td>
			<td class="center">${city.latitude}</td>
			<td class="center">${city.longitude}</td>
			<td class="center">
			<a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro"
			 data-cityId="${city.cityId}" data-cityName="${city.cityName}" data-latitude="${city.latitude}" 
			 data-latitude="${city.longitude}"  ><i class="fa fa-edit"></i>修改</a>
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs delete deleteParam" data-cityId="${city.cityId}" data-page="${paginator.page}">删除</a></td>
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/configManage/showCity" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
</jsp:include>
  <div id="addPdialog" style="display:none;">
  <form action="">
    <table>
      <tr>
         <td>省编号</td>
         <td><input type="text" id="cityId"/><span id="cityIdSpan"></span></td>
      </tr> 
      <tr>
         <td>省名称</td>
         <td><input type="text" id="cityName"/><span id="cityNameSpan"></span></td>
      </tr>
      <tr>
         <td>纬度</td>
         <td><input type="text" id="latitude"/><span id="latitudeSpan"></span></td>
      </tr>
      <tr>
         <td>经度</td>
         <td><input type="text" id="longitude"/><span id="longitudeSpan"></span></td>
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
  <script src="js/configManage/city.js"></script>
<script src="js/pagination.js"></script>
