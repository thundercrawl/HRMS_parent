<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScript:void(0);">敏感词管理</a></li>
	</ul>
</div>
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="min-height: 320px;">
				<div>
					<form action="">
						<div class="input-group col-md-6" style="margin:2px 0;display: inline-table;">
							<span class="input-group-addon">敏感关键词</span> <input type="text"
								class="form-control" placeholder="敏感关键词" id="findInput"
								name="findInput">

						</div>
						<div class="input-group col-md-1 colLee" style="display:inline-block">
							<a href="javaScript:void(0);" class="btn btn-primary" id="findScolation">查询</a>
						</div>
						<div class="input-group col-md-1 colLee" style="display:inline-block">
							<a href="javaScript:void(0);" class="btn btn-primary"	id="addScolation">添加</a> 
						</div>
						<div class="input-group col-md-1 colLee" style="display:inline-block;margin-right:23px;">
							<a href="javaScript:void(0);" class="btn btn-primary" id="addScolations">批量添加</a>
						</div>
						<div class="input-group col-md-1 colLee" style="display:inline-block">
							<a href="javaScript:void(0);" class="btn btn-danger" id="deleteScolation">删除</a>
						</div>				
						
						<div style="float: right;">
							<span id="textspan"	style="margin-top: -43px; margin-left: 6px; color: red; display: none;">请输入合法的敏感关键词</span>						
						</div>

					</form>
					<input type="hidden" id="formParam" value="" />
					<div id="colationtable" style="margin-top: 8px;">
						<jsp:include page="showColation.jsp"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<div id="deleteDialog" style="display: none">
	<p style="text-align: center; margin-top: 23px;">您还没有选择要删除的敏感词！</p>
	<div class="input-group col-md-12 text-center colLee"
		style="display: inline-block;">
		<a href="javaScript:void(0);" class="btn btn-primary" id="deletecheck">确定</a>
	</div>
</div>
<div id="confirmDialog" style="display: none">
	<p style="text-align: center; margin-top: 23px;">您确定要删除选中的敏感词？</p>
	<a href="javaScript:void(0);" class="btn btn-primary shiny btn-xs"
		id="confirmDelBtn" style="margin-left: 125px; margin-top: 13px;">确定</a>
	<a href="javaScript:void(0);" class="btn btn-primary shiny btn-xs"
		id="cancelDelBtn" style="margin-left: 125px; margin-top: 13px;">取消</a>
</div>
<div id="addScenes" style="display: none">
	<form action="filter/forum/addScene" id="addform"
		enctype="multipart/form-data" method="post">
		<table>
			<tr>
				<td>选择上传的文件</td>
				<td><input type="file" id="file" name='file'
					style="width: 262px; height: 37px; opacity: 0; z-index: 999; position: absolute; left: 22%; top: 11px;">
					<input id='scenetxt' name="scenetxt" value="选择文件(如:敏感词.txt)">&nbsp;<span
					style="display: none;" id="imgspans"><img alt=""
						src="img/delete.png" style="height: 20px;"></span></td>
			</tr>
		</table>
	</form>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="surecheck">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="backcheck">取消</a>
	</div>
	 
</div>
<div id="addSdialog" style="display: none;">
	<form>
		<table>
			<tr>
				<td>敏感词名称</td>
				<td><input type="text" id="sceneName">&nbsp;<span
					style="display: none;" id="imgspan"><img alt=""
						src="img/delete.png" style="height: 20px;"></span></td>
			</tr>
		</table>
	</form>
	<input type="hidden" id="sceneid"> <input type="hidden"
		id="page" value="${paginator.page}">
		<div class="input-group col-md-3 colLee">
		 <a href="javaScript:void(0);" class="btn btn-primary" id="formcheck">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		<a href="javaScript:void(0);" class="btn btn-primary" id="return">取消</a>
	</div>
		
		  
</div>
<!--/row-->
<script src="js/forum/colation.js"></script>