<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="activitytable">
	<thead>
		<tr>
			<th>活动名称</th>
            <th>活动描述</th>
            <th>活动状态</th>
            <th>开始时间</th>
            <th>终止时间</th>
            <th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="activity">
		<tr>
			<td class="center">${activity.activityName}</td>
			<td class="center">${activity.activityDesc}</td>
			<td class="center">${activity.statusName}</td>
			<%-- <c:if test="${activity.status==2}"><td class="center">已上线</td></c:if>
			<c:if test="${activity.status==3}"><td class="center">已下线</td></c:if>
			<c:if test="${activity.status==1}"><td class="center">未上线</td></c:if> --%>
			<td class="center">${activity.startTime}</td>
			<td class="center">${activity.endTime}</td>
			<td class="center">
			<c:if test="${activity.statusName=='未上线'}">
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs updateAct"
			data-activityId="${activity.activityId}" data-activityName="${activity.activityName}" data-activityDesc="${activity.activityDesc}" 
			data-strategyType="${activity.strategyType}" data-strategyConfig="${activity.strategyConfig}" >
			<i class="fa fa-edit"></i>修改</a>
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs deleteAct" data-activityId="${activity.activityId}" data-page="${paginator.page}">删除</a>
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs onLine" data-activityId="${activity.activityId}" data-page="${paginator.page}">上线</a>
			</c:if>
			<c:if test="${activity.statusName=='已上线'}">
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs offLine" data-activityId="${activity.activityId}" data-page="${paginator.page}">下线</a>
			<a href="javaScript:void(0);"  class="btn btn-danger btn-xs details" data-activityId="${activity.activityId}" data-page="${paginator.page}">中奖人员</a>
			</c:if>
			<c:if test="${activity.statusName=='已下线'}">
			<a href="javaScript:void(0);"  class="btn btn-danger btn-xs details" data-activityId="${activity.activityId}" data-page="${paginator.page}">中奖人员</a>
			</c:if>
			</td>
		</tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/activity/checkActivity" name="url"/>
	<jsp:param value="activitytable" name="loadCmp"/>
</jsp:include>
  <div id="addActivityDetail" style="display:none;">
  <form action="">
    <table>
      <tr>
         <td>活动名称</td>
         <td><input type="text" id="activityName"/><span id="activityNameErr"></span></td>
      </tr>
      <tr>
         <td>活动描述</td>
         <td>
         <input type="text" id="activityDesc"/><span id="activityDescErr"></span>
         </td>
      </tr>
      <tr>
         <td>策略配置</td>
         <td>
         <input type="text" id="strategyConfig"/><span id="strategyConfigErr"></span>
         </td>
      </tr>
    </table>
   </form>
   <input id="strategyType" type="hidden" value="1"/>
   <input type="hidden" id="sureActivityId">
   <input type="hidden" id="page" value="${paginator.page}">
   <div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck" page="${paginator.page}">确定</a>
  </div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
  </div>
   </div>
  
<script src="js/prize/prize.js"></script>
