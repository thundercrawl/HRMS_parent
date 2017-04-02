<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">蓝牙授权解除</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				<div>
					<form action="" id="forid">
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">会员手机号</span> <input type="text"
								class="form-control" placeholder="请输入会员手机号" id="userPhone"
							>
						</div>
						<div class="input-group col-md-6 colLee">
							<a href="javaScript:void(0);" class="btn btn-primary"
								id="unUserRelieve" onclick="unUserRelieve(2)"
								style="margin-left: 14px;">解除授权</a>
						</div>
                         <br><br>
						<!-- <div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">公司名称</span> <input type="text"
								class="form-control" placeholder="请输入公司名全称" id="companyName"
								>
						</div> -->
						<div class="input-group col-md-3"
							style="margin: 2px 0; display: inline-table;">
							<span class="input-group-addon">公司名称</span>
							<input type="text" class="form-control input-md" id="search-text" class="companyName"
								autocomplete="off" placeholder="请输入公司名称并选择已有公司">
								<input type="hidden" id="companyId">
								<input type="hidden" id="companyName">
							<ul class="show-select" style="width:184px;left:73px">
							</ul>
						</div>

						<div class="input-group col-md-1 colLee">
							<a  class="btn btn-primary" onclick="uncomRelieve();"
								style="margin-left: 14px;">解除授权</a>
						</div>

					</form>
					<input type="hidden" value="" id="bluetoothCondition">
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<!-- <div id="selectcompany" style="display: none;">
	<div>
		<label>选择公司</label>
		<div>
			<select class="form-control " id="seletcompany"></select>
		</div>
	</div>
	<div></div>
	<div class="input-group col-md-3 colLee">
		<a type="button" class="btn btn-primary" id="querycompanycheck">解除授权</a>
		
	</div>
	<div class="input-group col-md-3 colLee">
		<a type="button" class="btn btn-primary" id="esccompanycheck">取消</a>
	</div>
</div> -->
<script src="js/jquery/jquery.js"></script>
<script src="js/thirdparty/bluetoothrelive.js"></script>
<script src="js/readCard/common_search.js"></script>
<script src="js/handlebars-v2.0.0.js"></script>
   <script id="comselect" type="text/x-handlebars-template">
{{#each this}}
	<option value="{{companyId}}">{{companyName}}</option>
{{/each}}
</script>
