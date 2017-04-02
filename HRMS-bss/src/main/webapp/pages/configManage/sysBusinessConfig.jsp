<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>参数code</th>
			<th>参数名称</th>
			<th>起始区间值</th>
			<th>终止区间值</th>
			<th>业务类型</th>
			<th>参数值</th>
			<th>描述</th>
			<th>状态</th>
			<th>创建时间</th>
			<th>操作员</th>
			<th></th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="sysBusinessConfig">
		<tr>
			<td class="center">${sysBusinessConfig.parameterCode}</td>
			<td class="center">${sysBusinessConfig.parameterName}</td>
			<td class="center">${sysBusinessConfig.startInterval}</td>
			<td class="center">${sysBusinessConfig.finalInterval}</td>
			<td class="center">${sysBusinessConfig.serviceType}</td>
			<td class="center">${sysBusinessConfig.parameterNumber}</td>
			<td class="center">${sysBusinessConfig.businessDescribe}</td>
			 <c:if test="${sysBusinessConfig.status==1}">
			  <td class="center">使用</td>
			 </c:if> 
			 <c:if test="${sysBusinessConfig.status==2}">
			  <td class="center">未使用</td>
			 </c:if> 
			<td class="center">${sysBusinessConfig.createTime}</td>
			<td class="center">${sysBusinessConfig.operId}</td>
			<td class="center">
			<a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro"
			 data-parameterCode="${sysBusinessConfig.parameterCode}" data-parameterName="${sysBusinessConfig.parameterName}" data-startInterval="${sysBusinessConfig.startInterval}" 
			data-finalInterval="${sysBusinessConfig.finalInterval}" data-serviceType="${sysBusinessConfig.serviceType}" data-parameterNumber="${sysBusinessConfig.parameterNumber}" 
			data-businessDescribe="${sysBusinessConfig.businessDescribe}" 
			  data-status="${sysBusinessConfig.status}" data-page="${paginator.page}" ><i class="fa fa-edit"></i>修改</a>
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs delete deleteParam" data-parameterCode="${sysBusinessConfig.parameterCode}" data-page="${paginator.page}">删除</a></td>
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/configManage/showSysBusinessCofig" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
</jsp:include>
  <div id="addPdialog" style="display:none;">
  <form action="">
    <table>
     <!--  <tr>
         <td>参数code</td>
         <td><input type="text" id="parameterCode"/><span id="parameterCodeSpan"></span></td>
      </tr>  -->
      <tr>
         <td>参数名称</td>
         <td><input type="text" id="paramName"/><span id="paramNameSpan"></span></td>
      </tr>
      <tr>
         <td>起始区间值</td>
         <td><input type="text" id="startInterval"/><span id="startIntervalSpan"></span></td>
      </tr>
      <tr>
         <td>终止区间值</td>
         <td><input type="text" id="finalInterval"/><span id="finalIntervalSpan"></span></td>
      </tr>
      <tr>
         <td>业务类型</td>
         <td><input type="text" id="serviceType"/><span id="serviceTypeSpan"></span></td>
      </tr>
      <tr>
         <td>参数值</td>
         <td><input type="text" id="paramValue"/><span id="paramValueSpan"></span></td>
      </tr>
      <tr>
         <td>描述</td>
         <td><input type="text" id="paramDescribe"/><span id="paramDescribeSpan"></span></td>
      </tr>
      <tr>
         <td>状态</td>
         <td>
         <div class="dataTables_length" id="simpledatatable_length">
         <select name="simpledatatable_length" aria-controls="simpledatatable" class="form-control input-sm" id="status">
             <option value="0">使用</option>
             <option value="1">未使用</option>
         </select>
         </div>
         </td>
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
 <script src="js/configManage/SysBusinessConfig.js"></script>
<script src="js/pagination.js"></script>
