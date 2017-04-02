<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>参数码</th>
			<th>参数名称</th>
			<th>参数值</th>
			<th>描述</th>
			<th>状态</th>
			<!-- <th>创建时间</th>
			<th>最后更新时间</th>
			<th>操作员</th> -->
			<th></th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="sysParamConfig">
		<tr>
			 <td class="center">${sysParamConfig.paramId}</td>
			<td class="center">${sysParamConfig.paramName}</td>
			<td class="center">${sysParamConfig.paramValue}</td>
			<td class="center">${sysParamConfig.paramDescribe}</td>
			<c:if test="${sysParamConfig.status==1}">
			  <td class="center">使用</td>
			</c:if>
			<c:if test="${sysParamConfig.status==2}">
			  <td class="center">未使用</td>
			</c:if>  
			<%-- <td class="center">${sysParamConfig.createTime}</td>
			<td class="center">${sysParamConfig.updateTime}</td>
			<td class="center">${sysParamConfig.operId}</td> --%>
			
			<td class="center">
			<a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro"
			 data-paramName="${sysParamConfig.paramName}" data-paramId="${sysParamConfig.paramId}" data-paramValue="${sysParamConfig.paramValue}" 
			data-paramDescribe="${sysParamConfig.paramDescribe}"  data-status="${sysParamConfig.status}" data-page="${paginator.page}"><i class="fa fa-edit"></i>修改</a>
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs delete deleteParam" data-paramid="${sysParamConfig.paramId}" data-page="${paginator.page}">删除</a></td>
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/configManage/showSysParamConfig" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
</jsp:include>
  <div id="addPdialog" style="display:none;">
  <form action="">
    <table>
     <!--  <tr>
         <td>项目名称</td>
         <td><input type="text" id="paramId"/><span id="paramIdSpan"></span></td>
      </tr> -->
       <tr>
         <td>参数码</td>
         <td><input type="text" id="pId"/></td>
      </tr>
      <tr>
         <td>参数名称</td>
         <td><input type="text" id="pName"/></td>
      </tr>
      <tr>
         <td>参数值</td>
         <td><input type="text" id="pValue"/></td>
      </tr>
      <tr>
         <td>描述</td>
         <td><input type="text" id="pDescribe"/></td>
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
 <script src="js/configManage/configManage.js"></script>
<script src="js/pagination.js"></script>
