<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>资产等级编号</th>
			<th>资产类型</th>
			<th>资产等级</th>
			<th>等级描述</th>
			<th>状态</th>
			<th>创建时间</th>
			<th>操作员</th>
			<th></th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody id="tbody"  data-totalCnt="${paginator.totalCnt}"  data-page="${paginator.page}">
		<c:forEach items="${paginator.list}" var="sysAssetConfig">
		<tr>
			<td class="center">${sysAssetConfig.rankId}</td>
			<td class="center">${sysAssetConfig.assetType}</td>
			<td class="center">${sysAssetConfig.assetRank}</td>
			<td class="center">${sysAssetConfig.rankDescribe}</td>
			 <c:if test="${sysAssetConfig.status==2}">
			  <td class="center">未使用</td>
			 </c:if>
			 <c:if test="${sysAssetConfig.status==1}">
			  <td class="center">使用</td>
			 </c:if>  
			 <c:if test="${sysAssetConfig.status==null}">
			  <td class="center"></td>
			 </c:if>  
			<td class="center">${sysAssetConfig.createTime}</td>
			<td class="center">${sysAssetConfig.ofcUserInfo.adminLname}</td>
			<c:if test="${sysAssetConfig.status==2}">
			  <td class="center">
			<a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro"
			 data-rankId="${sysAssetConfig.rankId}" data-assetType="${sysAssetConfig.assetType}" data-spaceId="${sysAssetConfig.ofcSpaceType.spaceId}" data-assetRank="${sysAssetConfig.assetRank}"  data-page="${paginator.page}"
			data-rankDescribe="${sysAssetConfig.rankDescribe}"  
			  data-status="${sysAssetConfig.status}" ><i class="fa fa-edit"></i>修改</a>
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs delete deleteParam"  data-rankId="${sysAssetConfig.rankId}"  data-page="${paginator.page}">上线</a></td>
			 </c:if>
			<c:if test="${sysAssetConfig.status==1}">
			  <td class="center">
			<a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro"
			 data-rankId="${sysAssetConfig.rankId}" data-assetType="${sysAssetConfig.assetType}" data-spaceId="${sysAssetConfig.ofcSpaceType.spaceId}" data-assetRank="${sysAssetConfig.assetRank}"  data-page="${paginator.page}"
			data-rankDescribe="${sysAssetConfig.rankDescribe}"  
			  data-status="${sysAssetConfig.status}" ><i class="fa fa-edit"></i>修改</a>
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs delete deleteParam"  data-rankId="${sysAssetConfig.rankId}"  data-page="${paginator.page}">下线</a></td>
			 </c:if>
			
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/configManage/showSysAssetCofig" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
</jsp:include>
  <div id="addPdialog" style="display:none;">
  <form action="">
    <table>
      <!-- <tr>
         <td>资产等级编号</td>
         <td><input type="text" id="rankId"/><span id="rankIdSpan"></span></td>
      </tr>  -->
      <tr>
         <td>资产类型</td>
         <td> <select name="selectSpace" id="selectSpace">
         <c:if test="${!(empty proList)}">
         <option value=""></option>
											<c:forEach items="${proList}" var="ps">
											<option value="${ps.spaceId}">${ps.spaceName}</option>
											</c:forEach>
										</c:if>   
      </select>   
      </td>
      </tr>
      <tr>
         <td>等级描述</td>
         <td><input type="text" id="rankDescribe"/><span id="rankDescribeSpan"></span></td>
      </tr>
      <!-- <tr>
         <td>状态</td>
         <td>
         	<div class="dataTables_length" id="simpledatatable_length">
		         <select name="simpledatatable_length" aria-controls="simpledatatable" class="form-control input-sm" id="status">
		             <option value="1">使用</option>
		             <option value="2">未使用</option>
		         </select>
        	 </div>
         </td>
      </tr> -->
    </table>
   </form>
    <div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck">确定</a>
	</div>
    <div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
	</div>
   
   
  </div>
