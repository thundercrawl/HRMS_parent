<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="complaintAndSuggestions">
	<thead>
		<tr>
			<th>会员编号</th>
			<th>公司编号</th>
			<th>提交时间</th>
			<th>类型</th>
			<th>类型子类</th>
			<th>状态</th>
			<th>内容</th>
			<th>操作</th>
		</tr>
	</thead>
		<tbody>
	<c:if test="${!(empty paginator.list)}">
		   <c:forEach items="${paginator.list}" var="sug">
         <tr class="even" >
         	<td id="${sug.complainId}">${sug.userId}</td>
         	<td >${sug.companyId } </td>
         	<td class=" ">${sug.commitTime}</td>
         	<td class=" ">${sug.complainType}</td>
         	<td class=" ">${sug.complainTypeSub } </td>
         	<td id="a${sug.complainId}">${sug.status}</td>
          	<td class=" ">${sug.content}</td>
          	<td id ="c${sug.complainId}">
          	   <c:if test="${sug.status==1}">
          	   <a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro" name="${sug.complainId}" id="${sug.complainId}" value="未处理"  onclick="updateSuggestions(this.id);">未处理</a>
          	   </c:if>
          	   <c:if test="${sug.status==0}"><span style="color:black">已删除</span>
          	   </c:if>
          	   <c:if test="${sug.status==3}">已处理
          	   </c:if>
          	   <c:if test="${sug.status==2}">
          	   <a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro" name="${sug.complainId}" id="${sug.complainId}" value="处理中"  onclick="updateSuggestions2(this.id);">处理中</a>
          	   </c:if>
          	</td>
         </tr>
          </c:forEach>
		</c:if>
	</tbody>
</table>
<input type="text" hidden="true" value="userId=${userId}&companyId=${companyId }&complainType=${complainType}&complainTypeSub=${complainTypeSub }&submitTime=${submitTime}&status=${status}&endTime=${endTime}" id="huan">	
<input type="text" hidden="true" value="${page}" id="page">
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/complaintAndSuggestions/findSuggestions?userId=${userId}&companyId=${companyId }&complainType=${complainType}&complainTypeSub=${complainTypeSub }&submitTime=${submitTime}&status=${status}&endTime=${endTime}" name="url" />
	<jsp:param value="complaintAndSuggestions" name="loadCmp"/>
</jsp:include>
</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>

