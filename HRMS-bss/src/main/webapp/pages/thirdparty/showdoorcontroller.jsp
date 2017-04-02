<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">门禁控制器</a></li>
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
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">终端设备编号</span> <input type="text"
								class="form-control" placeholder="请输入终端设备编号" id="devicesysid"
								value="${devicesysid}">
						</div>
						<div class="input-group col-md-3"
							style="margin: 2px 0;display: inline-table;">
							<span class="input-group-addon">终端IP</span> <input type="text"
								class="form-control" placeholder="请输入终端IP" id="ip" value="${ip}">
						</div>
						
						
						<div class="input-group col-md-1 colLee" style="display:inline-block">
                    <a href="javaScript:void(0);" class="btn btn-primary"
						onclick="finddoorcontroller()" style="margin-left: 14px;">查询</a>
                    <span id="textspan" style=" position: absolute; right: -210px; top: 7px;color: red;display: none;">请输入合法的项目名称</span>
                  </div>
                  
                  <div class="input-group col-md-1 colLee" style="display:inline-block">
                     <a	href="javaScript:void(0);" class="btn btn-primary"
						id="adddoorcontroller" >添加门禁控制器</a>
                    <span id="textspan" style=" position: absolute; right: -210px; top: 7px;color: red;display: none;">请输入合法的项目名称</span>
                  </div>
						
					</form>
					
					<div id="cabinet_table" style="margin-top: 4px;">
						<jsp:include page="doorcontroller.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
