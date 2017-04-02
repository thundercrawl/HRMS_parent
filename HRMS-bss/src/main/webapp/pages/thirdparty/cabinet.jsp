<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table
	class="table table-striped table-hover table-bordered dataTable no-footer"
	aria-describedby="editabledatatable_info">
	<thead>
		<tr role="row">
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" >全选
				 <input type="checkbox" onclick="checkAll(this)">
			</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1">大储物柜编号</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" >储物柜名称</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" >所属项目</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" >所属楼层</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1">区域信息</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1" >规格</th>
			<th class="sorting" tabindex="0" aria-controls="editabledatatable"
				rowspan="1" colspan="1">操作</th>
		</tr>
	</thead>
	<c:if test="${!(empty paginator.list)}">
		<tbody>
			<c:forEach items="${paginator.list}" var="c">
				<tr class="even">
					<td class=" " style="text-align: center;"><input
						type="checkbox" name="promotions" value="${c.cabinetId}">
					</td>
					<td class=" ">${c.code}</td>
					<td class=" ">${c.cabinetName}</td>
					<td class=" ">${c.projectName}</td>
					<td class=" ">${c.floor}</td>
					<td class=" ">${c.areaInfo}</td>
					<td class=" ">${c.cabinetCount}</td>
					<td style="white-space: nowrap;"><a href="javaScript:void(0);"
						class="btn btn-info btn-xs "
						onclick="editcabinet(${c.cabinetId},'${c.cabinetName}',${c.projectId},'${c.projectName}',${c.floor},'${c.areaInfo}',${c.status},'${c.statusname}',${c.rank},'${c.rankname}',${c.cabinetCount},'${c.code}')">
							<i class="fa fa-edit"></i>修改
					</a> <a href="javaScript:void(0);" class="btn btn-info btn-xs "
						onclick="showcabinetdetail(${c.cabinetId},'${c.code}','${c.cabinetName}')"> <i
							class="fa fa-edit"></i>查看与操作
					</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</c:if>
</table>
<input value="${paginator.page}" style="display: none;" id="curpage">
<input
	value="code=${code}&cabinetname=${cabinetname}&projectname=${projectname}&cabinetstatus=${cabinetstatus}"
	style="display: none;" id="url">
<jsp:include page="../common/paginator.jsp">
	<jsp:param
		value="filter/thirdparty/cabinet/showcabinet?code=${code}&cabinetname=${cabinetname}&projectname=${projectname}&cabinetstatus=${cabinetstatus}&cabinetName=${cabinetName}&code=${code}"
		name="url" />
	<jsp:param value="cabinet_table" name="loadCmp" />
</jsp:include>
<div id="alert" style="display: none;">
	<form action="" style="margin-right: 15px;">
		<table>
			<tr>
				<td>储物柜名称</td>
				<td><input type="text" id="addcabinetname"> <input
					type="text" id="addcabinetid" hidden="true"></td>
			</tr>
			<tr>
				<td>储物柜编号</td>
				<td><input type="text" id="codeNum"></td>
			</tr>
			<tr>
				<td>所属项目名称</td>
				<td><select id="addprojectid">
						<option value="" style="display: none;">请选择项目</option>
						<c:forEach items="${projectlist}" var="p">
							<option value="${p.projectid}">${p.projectname}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>所属楼层</td>
				<td><input type="text" id="addfloor"></td>
			</tr>
			<tr>
				<td>区域信息</td>
				<td><input type="text" id="addareainfo"></td>
			</tr>
			<tr>
				<td>状态</td>
				<td><select id="addstatus">
						<option value="1">已使用</option>
						<option value="2">未使用</option>
				</select></td>
			</tr>
			<tr>
				<td>等级</td>
				<td><select id="addcabinetlevel">
						<c:forEach items="${enumlist}" var="e">
							<option value="${e.typeNum}">${e.typeValue}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>数量</td>
				<td><input type="text" id="addcount"></td>
			</tr>

		</table>
	</form>
	
		<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" onclick="surecabinets()">确定</a> 
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		  <a href="javaScript:void(0);"	class="btn btn-primary" onclick="cancle();">取消</a>
	</div>
	<div class="input-group col-md-12">
		 <span id="addspan" style="color: red"></span>
	</div>
	
</div>
<div id="alertedit" style="display: none;">
	<form action="" style="margin-right: 16px;">
		<table>
			<tr>
				<td>储物柜名称</td>
				<td><input type="text" id="editcabinetname"> <input
					type="text" id="editcabinetid" hidden="true"></td>
			</tr>
			<tr>
				<td>储物柜编号</td>
				<td><input type="text" id="editcode"> </td>
			</tr>
			<tr>
				<td>所属项目名称</td>
				<td><select id="editprojectid">
						<option value="" id="showprojectid" style="display: none;"></option>
						<c:forEach items="${projectlist}" var="p">
							<option value="${p.projectid}">${p.projectname}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>所属楼层</td>
				<td><input type="text" id="editfloor"></td>
			</tr>
			<tr>
				<td>区域信息</td>
				<td><input type="text" id="editareainfo"></td>
			</tr>
			<tr>
				<td>状态</td>
				<td><select id="editstatus">
						<option value="" id="showstatus" style="display: none;"></option>
						<option value="1">已使用</option>
						<option value="2">未使用</option>
				</select></td>
			</tr>
			<tr>
				<td>等级</td>
				<td><select id="editcabinetlevel">
						<option value="" id="showcabinetlevel" style="display: none;"></option>
						<c:forEach items="${enumlist}" var="e">
							<option value="${e.typeNum}">${e.typeValue}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>数量</td>
				<td><input type="text" id="editcount"></td>
			</tr>

		</table>
	</form>
	
		<div class="input-group col-md-3 colLee" style="display:inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" onclick="sureeditcabinets()">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary" onclick="cancleedit();">取消</a>
	</div>
	<div class="input-group col-md-12">
		 <span id="editspan" style="color: red"></span>
	</div>
	 
</div>
<script src="js/thirdparty/cabinet.js"></script>