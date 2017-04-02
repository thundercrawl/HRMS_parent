<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
		<ul class="breadcrumb">
			<li><a href="javaScipt:void(0);">客户关系管理/虚拟会员管理</a></li>
		</ul>
	</div>
<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content" style="overflow-x: scroll;min-height: 320px;">
			<div id="transfer-alert" style="display:none;">
				<table>
			<tr>
			<td>虚拟会员名字：</td>
			<td><input type="text" id="virmemberName"></td>
			</tr>
			<tr>
			<td>虚拟会员密码：</td>
			<td><input type="text" id="virmemberPsw"></td>
			</tr>
			<tr>
			<td>虚拟会员电话：</td>
			<td><input type="text" id="virmemberPhone"></td>
			</tr>
			<tr>
			<td>虚拟会员邮箱：</td>
			<td><input type="text" id="virmemberMail"></td>
			</tr>
			</table>
			<div class="input-group col-md-3 colLee">
		<a type="button" class="btn btn-primary"  id="virMemCreSure">确定</a>
	</div>
	<div class="input-group col-md-3 colLee">
		<a type="button" class="btn btn-primary"  id="virMemCreQuit">取消</a>
	</div>		
				
				
		</div>	
				<div>
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
						<form id="forid">
						 <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">虚拟会员ID</span>
                    <input type="text" class="form-control" placeholder="ID" id="virMemId" name="virMemId">
                  </div>
                   <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">会员名字</span>
                    <input type="text" class="form-control" placeholder="名字" id="userName" name="userName">
                  </div>
						 <div class="input-group col-md-3" style="margin: 2px 0;display: inline-table;">
                    <span class="input-group-addon">手机号</span>
                    <input type="text" class="form-control" placeholder="手机号" id="userPhone" name="userPhone">
                  </div>
                  <div class="input-group col-md-1 colLee">
		<a class="btn btn-primary" id="forVirMemSearch">查询</a>
	</div>
	
                  <div class="input-group col-md-1 colLee">
		  <a type="button" class="btn btn-primary" id="memberCreate">创建虚拟会员</a>
	</div>
                  
                
</form>
<input type="hidden" value="" id="virmemberSearchCondition">
<div id="tid">
<jsp:include page="virTable.jsp"></jsp:include>
</div>
</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<script src="js/virtualMember/virMem.js"></script>
<script src="js/pagination.js"></script>

