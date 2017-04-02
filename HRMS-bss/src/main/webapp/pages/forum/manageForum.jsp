<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table class="table table-striped table-hover table-bordered dataTable no-footer"  aria-describedby="editabledatatable_info">
     <thead>
         <tr role="row">
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 243px;">
       	 全选
       	 <input type="checkbox" onclick="checkAll(this)">
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 243px;">
       	 标题 
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 243px;">	
                 帖子类型</th>
                 <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 243px;">	
                 发帖用户</th>
          <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 171px;">
                            发帖时间
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 100px;">
       	 是否为水贴
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 100px;">
       	公司名称
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 100px;">
       	 喜欢数
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 100px;">
       	 收藏数
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 100px;">
       	 回复数
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 171px;">
                          帖子状态
         </th>
         <th class="sorting" tabindex="0" aria-controls="editabledatatable" rowspan="1" colspan="1" style="width: 171px;">
          操作
         </th>
         </tr>
         </thead>
       <c:if test="${!(empty paginator.list)}">
       <tbody>
         <c:forEach items="${paginator.list}" var="c">
         <tr class="even">
          	<td class=" "style="text-align: center;">
          	<input type="checkbox" name="promotions" value="${c.forumId}">
          	</td>
         	<td class=" ">${c.title} </td>
         	<td class=" ">${c.forumTypeName}</td>
         	<td class=" ">${c.nickname}</td>
         	<td class=" ">${c.postTime}</td>
         	<td class=" ">${c.cannotDelName}</td>
         	<td class=" ">${c.companyName}</td>
          	<td class=" ">${c.likeCount}</td>
          	<td class=" ">${c.collectCount}</td>
          	<td class=" ">${c.replyCount}</td>
          	<td class=" ">${c.delSignName}</td>
          	<td>
          	 <%--   <c:if test="${c.status==1}">
          	     <a href="javaScript:void(0)" class="btn btn-xs delete" id="sures${c.contractid}" style="color: gray;"><i class="fa fa-trash-o"></i>已确认</a>
          	   </c:if> --%>
          	    <c:if test="${c.status==1}">
          	     <c:if test="${c.isTop==1}">
          	               	   	<a href="javaScript:void(0)" class="btn btn-danger btn-xs is_topforum" orderid="${c.forumId}" page="${paginator.page}"><i class="fa fa-trash-o"></i>置顶</a>
          	     </c:if>
          	     <c:if test="${c.isTop==0}">
          	               	   	<a href="javaScript:void(0)" class="btn btn-danger btn-xs not_topforum" orderid="${c.forumId}" page="${paginator.page}"><i class="fa fa-trash-o"></i>取消置顶</a>
          	     </c:if>
          	     </c:if>
          	     <c:if test="${c.status==1}">
          	       <c:if test="${c.isforum==1}">
          	        	<a href="javaScript:void(0)" class="btn btn-danger btn-xs modify_forum" orderid="${c.forumId}" page="${paginator.page}"><i class="fa fa-trash-o"></i>修改</a>
          	       </c:if>
          	               	  
          	     </c:if>
          	       <c:if test="${c.status==1}">
          	               	   	<a href="javaScript:void(0)" class="btn btn-danger btn-xs delete_forum" orderid="${c.forumId}" page="${paginator.page}"><i class="fa fa-trash-o"></i>删除</a>
          	     </c:if>
          	     
          	  <c:if test="${c.status==1}">
          	  	<c:if test="${c.cannotDel==1}">
          	  		<a href="javaScript:void(0)" class="btn btn-danger btn-xs change_forum" orderid="${c.forumId}" page="${paginator.page}" cannotdel="${c.cannotDel}"><i class="fa fa-trash-o"></i>置为水贴</a>
          	  	</c:if>
          	  	<c:if test="${c.cannotDel==0}">
          	  		<a href="javaScript:void(0)" class="btn btn-danger btn-xs cancel_change_forum" orderid="${c.forumId}" page="${paginator.page}" cannotdel="${c.cannotDel}"><i class="fa fa-trash-o"></i>取消水贴</a>
          	  	</c:if>
          	  <%-- 	<c:if test="${c.typevalue=='合同'}">
          	    	<a href="javaScript:void(0)" class="btn btn-danger btn-xs sure" orderid="${c.contractid}" page="${paginator.page}"><i class="fa fa-trash-o"></i>确认合同</a>
          	    </c:if> --%>
          	    </c:if>
          	       <c:if test="${c.status==1}">
          	               	   	<a href="javaScript:void(0)" class="btn btn-danger btn-xs forum_detail" orderid="${c.forumId}" page="${paginator.page}"><i class="fa fa-trash-o"></i>帖子详情</a>
          	     </c:if>
          	 <%--  <c:if test="${c.statusname==4}">
          	  	<c:if test="${c.typevalue=='意向书'}">
          	  		<a href="javaScript:void(0)" class="btn btn-xs delete" id="sures${c.contractid}" style="color: gray;"><i class="fa fa-trash-o"></i>已生成合同</a>
          	  	</c:if>
          	  	<c:if test="${c.typevalue=='合同'}">
          	    	<a href="javaScript:void(0)" class="btn btn-danger btn-xs surePay" orderid="${c.contractid}" page="${paginator.page}"><i class="fa fa-trash-o"></i>确认付款</a>
          	    </c:if>
          	  </c:if> --%>
          	</td>
         </tr></c:forEach>
           </tbody></c:if>
         </table>
         <input type="text" hidden="true" value="forumtitle=${forumtitle}&username=${username}&companyname=${companyname}&fromtime=${fromtime}&totime=${totime}&status=${status}&type=${type}" id="huan">
         <input type="text" hidden="true" value="${page}" id="page">
           <jsp:include page="../common/paginator.jsp">
				<jsp:param value="filter/forum/findForum?forumtitle=${forumtitle}&username=${username}&companyname=${companyname}&fromtime=${fromtime}&totime=${totime}&status=${status}&type=${type}" name="url" />
				<jsp:param value="fourm_table" name="loadCmp"/> 
		   </jsp:include>
		  
	<script src="js/forum/showManageForum.js"></script>    	   
