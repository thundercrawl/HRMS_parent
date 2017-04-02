<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table
	class="table table-striped table-bordered bootstrap-datatable dataTable responsive"
	id="projectable">
	<thead>
		<tr>
			<th>姓名</th>
			<th>公司名称</th>
			<th>联系方式</th>
			<th>邮箱</th>
			<th>地址</th>
			<th>联系人类型</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
		<tbody>
			<c:forEach items="${paginator.list}" var="project">
				<tr>
					<td class="center">${project.contactName}</td>
					<td class="center">${project.companyName}</td>
					<td class="center">${project.contactPhone}</td>
					<td class="center">${project.contactEmail}</td>
					<td class="center">${project.contactAddress}</td>
					<td class="center">${project.typeMessage}</td>
					<td class="center">${project.statusMessage}</td>
					<td class="center"><a href="javaScript:void(0);"
						class="btn btn-info btn-xs edit updatePro"
						data-contactName='${project.contactName}'
						data-companyName="${project.companyName}"
						data-contactPhone="${project.contactPhone}"
						data-contactEmail="${project.contactEmail}"
						data-contactAddress="${project.contactAddress}"
						data-typeMessage="${project.typeMessage}"
						data-contactId="${project.contactId}"
						data-companyId="${project.companyId}"
						data-type="${project.type}"
						
						data-statusMessage="${project.statusMessage}"> <i
							class="fa fa-edit"></i>修改
					</a> <c:if test="${project.status==1}">
							<a href="javaScript:void(0);"
								class="btn btn-success btn-xs deleteUser"
								data-contactId="${project.contactId}"
								data-status="${project.status}"
								data-page="${paginator.page}">失效</a>
						</c:if> <c:if test="${project.status==2}">
							<a href="javaScript:void(0);"
								class="btn btn-danger btn-xs deleteUser"
								data-contactId="${project.contactId}"
								data-status="${project.status}"
								data-page="${paginator.page}">恢复</a>
						</c:if></td>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/secContact/showContact" name="url" />
	<jsp:param value="projectable" name="loadCmp" />
	<jsp:param value="formParam" name="formParam" />
</jsp:include>


<div id="addUserdialog" style="display: none;">
	<form action="" style="margin-right: 10px;">
		<table class="table2">
			<tr>
				<td>姓名</td>
				<td><input type="text" id="username" /><span id="unamespan"><img
						alt="" src="img/delete.png" style="width: 10px;"></span></td>
			</tr>
			<tr>
				<td>公司名称</td>
				<td><input type="text" id="search-text" autocomplete="off"/><span id="companyspan"><img
						alt="" src="img/delete.png" style="width: 10px;"></span>
						<input id="companyId" value="" type="hidden">
						<ul class="show-select"> </ul>
						</td>
						
			</tr>
			<tr>
				<td>地址</td>
				<td><input type="text" id="dress" /><span id="dressspan"><img
						alt="" src="img/delete.png" style="width: 10px;"></span></td>
			</tr>
			<tr>
				<td>联系方式</td>
				<td><input type="text" id="phone" /><span id="phonespan"><img
						alt="" src="img/delete.png" style="width: 10px;"></span></td>
			</tr>
			<tr>
				<td>邮箱</td>
				<td><input type="text" id="email" /><span id="emailspan"><img
						alt="" src="img/delete.png" style="width: 10px;"></span></td>
			</tr>

			<tr>
				<td>联系人类型</td>
				<td>
					<div class="dataTables_length" id="simpledatatable_length">
						<select name="simpledatatable_length"
							aria-controls="simpledatatable" class="input-sm" id="typess">
							<option value="1">账单联系人</option>
							<option value="2">合同联系人</option>
							<option value="3">活动联系人</option>
						</select>
					</div>
				</td>
			</tr>

		</table>
	</form>
	<input type="hidden" id="contactId"> 
	<input type="hidden" id="page" value="${paginator.page}">

	<div class="input-group col-md-3 colLee" style="display: inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="formcheck">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display: inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="return">取消</a>
	</div>


</div>
<div id="updateUserdialog" style="display: none;">
	<form action="">
		<table class="table2">
			<tr>
				<td>姓名</td>
				<td><input type="text" id="UserName" /> <span id="Unamespan"
					style="display: none"><img alt="" src="img/delete.png"
						style="width: 10px;"></span></td>
			</tr>

			<tr>
				<td>地址</td>
				<td><input type="text" id="Address" /> <span id="Addressspan"
					style="display: none"><img alt="" src="img/delete.png"
						style="width: 10px;"></span></td>
			</tr>

			<tr>
				<td>联系方式</td>
				<td><input type="text" id="Phone" /> <span id="Phonespan"
					style="display: none"><img alt="" src="img/delete.png"
						style="width: 10px;"></span></td>
			</tr>
			<tr>
				<td>邮箱</td>
				<td><input type="text" id="Email" /> <span id="Emailspan"
					style="display: none"><img alt="" src="img/delete.png"
						style="width: 10px;"></span></td>
			</tr>
		</table>
	</form>
	<input type="hidden" id="companyIds">
	<input type="hidden" id="contactIds" > 
	<input type="hidden" id="types" >
	<input type="hidden" id="pages" value="${paginator.page}"> 
	
	<div class="input-group col-md-3 colLee" style="display: inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="updateUser">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display: inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="returnUser">取消</a>
	</div>

</div>
<script src="js/contactManager/common_search.js"></script>
<script src="js/contactManager/contact.js"></script>