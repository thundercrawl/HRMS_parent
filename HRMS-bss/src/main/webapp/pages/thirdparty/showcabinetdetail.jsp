<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">储物柜详情</a></li>
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
							<span class="input-group-addon">小储物柜编号</span> <input type="text"
								class="form-control" placeholder="请输入储物柜编号" id="cabinetdetailid"
								value="${cabinetdetailid}">
						</div>
						<div style="margin: 2px 0; display: inline-table;"
							class="input-group col-md-3">
							<span class="input-group-addon">小储物柜状态</span> <select name="unit"
								id="status" class="form-control" type="select">
								<c:if test="${status==3||status==null||status==''}">
									<option value="3">全部</option>
									<option value="1">未使用</option>
									<option value="2">已使用</option>
								</c:if>
								<c:if test="${status==1}">
									<option value="1">未使用</option>
									<option value="3">全部</option>
									<option value="2">已使用</option>
								</c:if>
								<c:if test="${status==2}">
									<option value="2">已使用</option>
									<option value="1">未使用</option>
									<option value="3">全部</option>
								</c:if>
							</select>
						</div>
						<div class="input-group col-md-1 colLee" style="display:inline-block;">
                   			 <a href="javaScript:void(0);" class="btn btn-primary" onclick="findcabinetsdetail('${code }','${cabinetName }')">查询</a>
                   		</div>
                   		<div class="input-group col-md-1 colLee" style="display:inline-block;">
                   			<a	href="javaScript:void(0);" class="btn btn-primary" onclick="deletecabinetsdetail('${code }','${cabinetName }')">删除</a>
                   		</div>
                   		<div class="input-group col-md-1 colLee" style="display:inline-block; margin-right:3%">
                   			 <a href="javaScript:void(0);" class="btn btn-primary" id="addcabinetsdetail">添加储物柜</a>
                   		</div>
                   		<div class="input-group col-md-1 colLee" style="display:inline-block;">
                   			 <a href="javaScript:void(0);" class="btn btn-primary" onclick="returncabinetdetail()">大储物柜</a>
                   		</div>
						
						 
						

					</form>
					<div id="cabinet_table" style="margin-top: 8px;">
						<jsp:include page="cabinetdetail.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
