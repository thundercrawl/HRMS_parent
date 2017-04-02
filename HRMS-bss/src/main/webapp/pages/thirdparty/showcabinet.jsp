<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">储物柜</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<form action="">
						<div class="input-group col-md-3" style="display: inline-table;">
							<span class="input-group-addon">储物柜编号</span> <input type="text"
								class="form-control" placeholder="请输入储物柜编号" id="cabinetid"
								value="${cabinetid}">
						</div>
						<div class="input-group col-md-3" style="display: inline-table;">
							<span class="input-group-addon">储物柜名称</span> <input type="text"
								class="form-control" value="${cabinetname}"
								placeholder="请输入储物柜名称" id="cabinetname">
						</div>
						<div class="input-group col-md-3" style="display: inline-table;">
							<span class="input-group-addon">所属项目</span> <select name="unit"
								id="projectname" class="form-control" type="select">
								<c:if test="${projectname==null||projectname==''}">
									<option value="">全部</option>
									<c:forEach items="${projectlist}" var="p">
										<option value="${p.projectid}">${p.projectname}</option>
									</c:forEach>
								</c:if>
								<c:if test="${projectname!=null&&projectname!=''}">
									<c:forEach items="${projectlist}" var="p">
										<c:if test="${p.projectid==projectname}">
											<option value="${p.projectid}">${p.projectname}</option>
										</c:if>
									</c:forEach>
									<c:forEach items="${projectlist}" var="p">
										<c:if test="${p.projectid!=projectname}">
											<option value="${p.projectid}">${p.projectname}</option>
										</c:if>
									</c:forEach>
									<option value="">全部</option>
								</c:if>
							</select>
						</div>
						<div style="display: inline-table;" class="input-group col-md-3">
							<span class="input-group-addon">储物柜状态</span> <select name="unit"
								id="cabinetstatus" class="form-control" type="select">
								<c:if
									test="${cabinetstatus==3||cabinetstatus==null||cabinetstatus==''}">
									<option value="3">全部</option>
									<option value="1">使用</option>
									<option value="2">未使用</option>
								</c:if>
								<c:if test="${cabinetstatus==1}">
									<option value="1">使用</option>
									<option value="3">全部</option>
									<option value="2">未使用</option>
								</c:if>
								<c:if test="${cabinetstatus==2}">
									<option value="2">未使用</option>
									<option value="1">使用</option>
									<option value="3">全部</option>
								</c:if>
							</select>
						</div>
						<div class="input-group col-md-1 colLee" style="display: inline-block;">
							<a href="javaScript:void(0);" class="btn btn-primary"
								onclick="findcabinets()">查询</a>
						</div>
						<div class="input-group col-md-1 colLee" style="display: inline-block;">
							<a href="javaScript:void(0);" class="btn btn-primary"
								onclick="deletecabinets()">删除</a>
						</div>
						<div class="input-group col-md-2 colLee" style="display: inline-block;">
							<a href="javaScript:void(0);" class="btn btn-primary"
								id="addcabinets">添加储物柜</a>
						</div>



					</form>
					<div id="cabinet_table" style="margin-top: 4px;">
						<jsp:include page="cabinet.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
