<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="persontable">
	<thead>
		<tr>
			<th>人员姓名</th>
            <th>抽奖时间</th>
            <th>是否中奖</th>
            <th>是否配送</th>
            <th>配送人员</th>
            <th>配送时间</th>
            <th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="activity">
		<tr>
			<td class="center">${activity.userName}</td>
			<td class="center">${activity.prizeTime}</td>
			<c:if test="${activity.prizeStatus=='中奖'}"><td class="center">中奖</td></c:if>
			<c:if test="${activity.prizeStatus=='未中奖'}"><td class="center">未中</td></c:if>
			<c:if test="${activity.sendStatus=='已配送'}"><td class="center">已配送</td></c:if>
			<c:if test="${activity.sendStatus=='未配送'}"><td class="center">未配送</td></c:if>
			<td class="center">${activity.adminName}</td>
			<td class="center">${activity.sendTime}</td>
			<td class="center">
			<c:if test="${activity.sendStatus=='未配送'}">
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs sureDelivery"
			data-prizeRecordId="${activity.prizeRecordId}" data-activityId="${activity.activityId}">
			<i class="fa fa-edit"></i>确认配送</a>
			</c:if>
			<c:if test="${activity.sendStatus=='已配送'}">
			已配送
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
   <input id="activityId" type="hidden" value="${activityId}"/>
   <input type="hidden" id="sureActivityId">
   <input type="hidden" id="page" value="${paginator.page}">
   <a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck" style="margin-left: 104px;" page="${paginator.page}">确定</a>
   <a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
  </div>
  <div>
  	<button id="backPage">返回 </button>
  </div>
  <script src="js/prize/prizeActivity.js"></script>
  
