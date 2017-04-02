<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>姓名</th>
			<th>登录名</th>
            <th>性别</th>
            <th>年龄</th>
            <th>联系方式</th>
            <th>邮箱</th>
            <th>身份证号</th>
            <th>所属组织</th>
            <th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
	<tbody>
		<c:forEach items="${paginator.list}" var="project">
		<tr>
			<td class="center">${project.username}</td>
			<td class="center">${project.userLname}</td>
			<td class="center">${project.gender}</td>
			<td class="center">${project.age}</td>
			<td class="center">${project.phone}</td>
			<td class="center">${project.email}</td>
			<td class="center">${project.idNum}</td>
			<td class="center">${project.orgname}</td>
			<td class="center">
			  <a href="javaScript:void(0);" class="btn btn-info btn-xs edit updatePro"
			     data-username="${project.username}" data-gender="${project.gender}" data-age="${project.age}" 
			     data-phone="${project.phone}" data-email="${project.email}" data-idNum="${project.idNum}"
			     userLname="${project.userLname}" data-userid="${project.userid}" password="${project.password}"><i class="fa fa-edit"></i>修改</a>
			  <c:if test="${project.status==-1}">
			    <a href="javaScript:void(0);" class="btn btn-success btn-xs deleteUser" data-userid="${project.userid}" data-page="${paginator.page}" status="1">解锁</a>
			  </c:if>
			  <c:if test="${project.status==1}">
			    <a href="javaScript:void(0);" class="btn btn-danger btn-xs deleteUser" data-userid="${project.userid}" data-page="${paginator.page}" status="-1">锁定</a>
			  </c:if>
			  <c:if test="${project.status==1}">
			   <a href="javaScript:void(0);" class="btn btn-danger btn-xs repassword" data-userid="${project.userid}">重置密码</a>
			  </c:if>
			  <c:if test="${project.type==1}">
			   <a href="javaScript:void(0);" class="btn btn-info btn-xs adduserorg" data-userid="${project.userid}" data-orgid="${project.orgid}">修改组织</a>
			  </c:if>
			  <c:if test="${project.type==2}">
			   <a href="javaScript:void(0);" class="btn btn-info btn-xs adduserorg" data-userid="${project.userid}" data-orgid="0">添加组织</a>
			  </c:if>
			</td>
		  </tr>
		</c:forEach>
	</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/bssuser/showuser" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
  <div id="addUserdialog" style="display:none;">
  <form action="" style="margin-right: 10px;">
    <table class="table2">
      <tr>
         <td>姓名</td>
         <td><input type="text" id="username"/><span id="uname"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>登录名</td>
         <td><input type="text" id="userLname"/><span id="Lname"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>密码</td>
         <td><input type="text" id="password" placeholder="密码必须大于6位"/><span id="psw"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>性别</td>
         <td>
          <div class="dataTables_length" id="simpledatatable_length">
         <select name="simpledatatable_length" aria-controls="simpledatatable" class="input-sm" id="gender">
             <option value="男">男</option>
             <option value="女">女</option>
         </select>
         </div>
         </td>
      </tr>
      <tr>
         <td>年龄</td>
         <td><input type="text" id="age"/><span id="agespan"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>联系方式</td>
         <td><input type="text" id="phone"/><span id="phonespan"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>邮箱</td>
         <td><input type="text" id="email"/><span id="emailspan"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>身份证号</td>
         <td><input type="text" id="idNum"/><span id="idNumspan"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
    </table>
   </form>
   <input type="hidden" id="userid">
   <input type="hidden" id="page" value="${paginator.page}">
   
   <div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="return">取消</a>
	</div>
   
   
  </div>
  <div id="updateUserdialog" style="display:none;">
  <form action="">
    <table class="table2">
      <tr>
         <td>姓名</td>
         <td><input type="text" id="UserName"/> <span id="suname" style="display: none"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>登录名</td>
         <td><input type="text" id="UserLname"/> <span id="sLname" style="display: none"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>性别</td>
         <td>
          <div class="dataTables_length" id="simpledatatable_length">
         <select name="simpledatatable_length" aria-controls="simpledatatable" class="input-sm" id="Gender">
             <option value="男">男</option>
             <option value="女">女</option>
         </select>
         </div>
         </td>
      </tr>
      <tr>
         <td>年龄</td>
         <td><input type="text" id="Age"/> <span id="sagespan" style="display: none"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>联系方式</td>
         <td><input type="text" id="Phone"/> <span id="sphonespan" style="display: none"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>邮箱</td>
         <td><input type="text" id="Email"/> <span id="semailspan" style="display: none"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
      <tr>
         <td>身份证号</td>
         <td><input type="text" id="IdNum"/> <span id="sidNumspan" style="display: none"><img alt="" src="img/delete.png" style="width: 10px;"></span></td>
      </tr>
    </table>
   </form>
   <input type="hidden" id="Userid">
   <input type="hidden" id="pages" value="${paginator.page}">
   <input type="hidden" id="Password">
   <div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary"  id="updateUser">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="returnUser">取消</a>
	</div>
   
  
  </div>
  
<div id="orgdialog" style="display: none">
  <table id="userorgtable">
  </table>
  <input type="hidden" id="olderorgid">
  <input type="hidden" id="userorgid">
  <div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="updateUserorg">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="returnUserorg">取消</a>
	</div>
   
   
</div>

