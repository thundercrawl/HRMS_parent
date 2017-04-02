<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">门信息</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<form action="">
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">门牌号码</span> <input type="text"
								class="form-control" placeholder="请输入门牌号码" id="doornumber"
								value="${doornumber}">
						</div>
						<%-- <div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">门禁控制器</span> <select name="unit"
								id="devicesysid" class="form-control" type="select">
								<c:if test="${devicesysid==null||devicesysid==''}">
									<option value="">全部</option>
									<c:forEach items="${doorcontrollerlist}" var="p">
										<option value="${p.deviceSysId}">${p.stationName}</option>
									</c:forEach>
								</c:if>
								<c:if test="${devicesysid!=null&&devicesysid!=''}">
									<c:forEach items="${doorcontrollerlist}" var="p">
										<c:if test="${p.deviceSysId==devicesysid}">
											<option value="${p.deviceSysId}">${p.stationName}</option>
										</c:if>
									</c:forEach>
									<c:forEach items="${doorcontrollerlist}" var="p">
										<c:if test="${p.deviceSysId!=devicesysid}">
											<option value="${p.deviceSysId}">${p.stationName}</option>
										</c:if>
									</c:forEach>
									<option value="">全部</option>
								</c:if>
							</select>
						</div> --%>
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">所属项目</span> <select name="unit"
								id="projectid" class="form-control" type="select">
								<c:if test="${projectid==null||projectid==''}">
									<option value="">全部</option>
									<c:forEach items="${projectlist}" var="p">
										<option value="${p.projectid}">${p.projectname}</option>
									</c:forEach>
								</c:if>
								<c:if test="${projectid!=null&&projectid!=''}">
									<c:forEach items="${projectlist}" var="p">
										<c:if test="${p.projectid==projectid}">
											<option value="${p.projectid}">${p.projectname}</option>
										</c:if>
									</c:forEach>
									<c:forEach items="${projectlist}" var="p">
										<c:if test="${p.projectid!=projectid}">
											<option value="${p.projectid}">${p.projectname}</option>
										</c:if>
									</c:forEach>
									<option value="">全部</option>
								</c:if>
							</select>
						</div>
						
						<div class="input-group col-md-1 colLee" style="display:inline-block">
                     <a href="javaScript:void(0);" class="btn btn-primary"
						onclick="finddoor()" >查询</a>
                  </div>
                  <div class="input-group col-md-1 colLee" style="display:inline-block">
                      <a
						href="javaScript:void(0);" class="btn btn-primary" id="adddoor"
						>添加门信息</a>
                    </div>
						
					</form>
					
					<div id="cabinet_table" style="margin-top: 8px;">
						<jsp:include page="door.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
