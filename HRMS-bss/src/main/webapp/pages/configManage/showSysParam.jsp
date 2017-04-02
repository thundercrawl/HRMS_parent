<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div>
	<ul class="breadcrumb">
		<li><a href="javascript:volid(0);" style="text-decoration:none;">系统管理/参数管理/系统参数配置</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
	<div>
		
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
				<div>
				<form id="queryForm">
						<div class="input-group col-md-3" style="margin:2px 0;display: inline-table;" >
							<span class="input-group-addon">参数名称</span>
							<input type="text" class="form-control" placeholder="参数名称" id="paramName" name="paramName"
							 value="${ paramName}"  >
						</div>
						<div class="input-group col-md-3" style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">参数码</span>
							<input type="text" class="form-control" placeholder="参数码" id="paramId" name="paramId" 
							value="${ paramId}" >
						</div>
						<div class="input-group col-md-1 colLee" style="display:inline-block;">
							 <a class="btn btn-primary" id="queryBtn">查询</a>
						</div>
						<div class="input-group col-md-1 colLee" style="display:inline-block;">
							<a class="btn btn-primary " id="addParam">新增</a>
						</div>
						</form>
					</div> 
					
					 <input type="hidden" value="" id="companySearchCondition">
                  <div id="tid">
					<div id="projectable" style="margin-top: 8px;">
						<jsp:include page="sysParamConfig.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
