<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">消息推送</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
							<form id="query_ems_params">
								<div>
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">推送编号</span> 
										<input type="text" class="form-control" placeholder="推送编号" id="ems_id" name="emsId">
									</div>
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">消息内容</span> 
										<input type="text" class="form-control" placeholder="消息内容" id="msg_content" name="msgContent">
									</div>
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">推送时间</span> 
										<input type="text" class="form-control reDatetimepicker" id="create_time" name="createTime">
									</div>
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">消息类型 </span> 
										<select class="form-control" name="emsType" id="ems_type">
										<option value=""></option>
										<option value="1">系统消息</option>
										<option value="2">社区消息</option>
										<option value="3">其他消息</option>
										</select>
									</div>
									<div class="input-group col-md-3"
										style="margin: 2px 0; display: inline-table;">
										<span class="input-group-addon">推送范围 </span> <select
											class="form-control" name="sendType" id="send_type">
											<option value=""></option>
											<option value="3">按个人推送</option>
											<option value="2">按公司推送</option>
											<option value="1">全量推送</option>
										</select>
									</div>
									<div class="input-group col-md-1 colLee" style="display: inline-table;">
										<a class="btn btn-primary"
											id="query_ems_info" style="border-radius: 4px;">查询
										</a>
									</div>
								</div>
							</form>
					
					<input type="hidden" value="" id="query_emsparams">
					<div id="ems_page_info" style="margin-top: 8px;">
						<jsp:include page="emsPageI.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<!--/row-->
<script src="js/pagination.js"></script>
<script src="js/ems/emsPage.js"></script>