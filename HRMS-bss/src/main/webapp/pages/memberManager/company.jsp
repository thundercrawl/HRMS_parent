<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="javaScipt:void(0);">客户关系管理/公司管理</a></li>
	</ul>
</div>
<div class="row" id="memSchi">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-content"
				style="overflow-x: scroll; min-height: 320px;">
				
					<div id="addComMembers" style="display: none;">
						<form class="user-form user-form1 user-info" id="userIdPic"
						method="post" action="" style="margin-right: 40px;" enctype="multipart/form-data">
						<div>
						<input type="hidden" id="comIdsss"> </div>
						<div>
							<label for="userName">名字<font style='color:red'>*</font>：</label> 
							<input type="text" id="addUserName111" /> <span id="namespan" style="display: none;color: red;"  >姓名为字母和汉字,长度15</span>
						</div>
						<div>
							<label for="userPw">密码<font style='color:red'>*</font>：</label> <input type="text" id="userPw111" />
							<span id="passwordspan" style="display: none;color: red;">密码为6-18位字母数字或特殊符号</span>
						</div>
						<div>
							<label for="userPhone">手机<font style='color:red'>*</font>：</label> <input type="text"
								id="addUserPhone111" /> <span id="phonespan" style="display: none;color: red;">请输入正确格式的手机号码</span>
						</div>
						<div>
							<label for="userMail">邮箱<font style='color:red'>*</font>：</label> <input type="text"
								id="userMail111" />
						</div>
						<!-- <div>
							<label for="userMail">个人图片：</label> 
							<input type="file" id="comfile" name='file' value="请选择图片上传"> 
							<input id='commemberImg' name="memberImg" type = "text" value="请选择图片上传">
						</div> -->
					</form>
					

						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="memCreMemSure">确定</a>
						</div>
						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="memCreMemQuit">取消</a>
						</div>
				</div>
				
				<div id="transfer-alert2" style="display: none;">
					<form class="user-form user-form1 user-info" id="companyId1"
						method="post" action="" style="margin-left: 25px;" enctype="multipart/form-data">
						<div>
							<label for="companyName">公司名称<font style='color:red'>*</font>：</label> <input type="text"
								id="companyNameAdd" /> <span id="namespan"></span>
						</div>
						<div>
							<label for="companyAddress">公司地址：</label> <input type="text"
								id="companyAddressAdd" />
						</div>
						<div>
							<label for="companyEmail">公司邮箱<font style='color:red'>*</font>：</label> <input type="text"
								id="companyEmailAdd" />
						</div>
						<div>
							<label for="companyPhone">公司电话：</label> <input type="text"
								id="companyPhoneAdd" /> <span id="phonespan"></span>
						</div>
						<div>
							<label for="companyBusiness">公司业务：</label> <input type="text"
								id="companyBusinessAdd" />
						</div>
						<div>
							<label for="companyIntroduction">公司介绍：</label> <input type="text"
								id="companyIntroductionAdd" />
						</div>
						<div>
							<label for="createerPhone">创建者电话<font style='color:red'>*</font>：</label> <input type="text"
								id="createerPhoneAdd" /><span id="createerPhoneSpan"></span>
						</div>
						<div>
							<label for="companyImg">公司头像：</label> <input type="file"
								id="file" name='file'> <input id='companyImg'
								name="companyImg" value="请选择图片上传" style="margin-left: -68px;">
						</div>
					</form>
						<div class="input-group col-md-3 colLee"
							style="margin: 2px 0; display: inline-block;">
							<a type="button" class="btn btn-primary" id="comCreSure">确定</a>
						</div>
						<div class="input-group col-md-3 colLee"
							style="margin: 2px 0; display: inline-block;">
							<a type="button" class="btn btn-primary shiny" id="comCreQuit">取消</a>
						</div>
				</div>
				<div id="transfer-alert3" style="display: none;"></div>
				<div id="import-alert" style="display: none;">
					<p align="center">请选择需要上传的文件</p>
					<form id="excel_form" name="form1" method="post"
						action="" enctype="multipart/form-data">
						<table border="0" align="center">
							<tr>
								<td>上传文件：</td>
								<td><input name="file" type="file" size="20" id="excelfile"></td>
							</tr>
							<tr>
								<td><input type="submit" name="submit" class="btn btn-primary" value="提交" id="excelsure">
									<input type="reset" name="reset" class="btn btn-primary" value="重置"></td>
							</tr>
						</table>
					</form>
				</div>
				<div>
					<div id="projectable_meet" style="margin-top: 4px;">
						<div>
							<form id="forid">
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">公司ID</span> <input type="text"
										class="form-control" placeholder="ID" id="companyId"
										name="companyId">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">公司名称</span> <input type="text"
										class="form-control" placeholder="公司名称" id="companyName"
										name="companyName">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">公司地址</span> <input type="text"
										class="form-control" placeholder="公司地址" id="companyAddress"
										name="companyAddress">
								</div>
								<div class="input-group col-md-3"
									style="margin: 2px 0; display: inline-table;">
									<span class="input-group-addon">成员手机号码</span> <input
										type="text" class="form-control" placeholder="成员手机号码"
										id="userPhone" name="userPhone" value="${userPhone }">
								</div>
								<div class="input-group col-md-1 colLee">
									<a href="javaScript:void(0);" class="btn btn-primary"
										id="forComSearch">查询</a>
								</div>
								<div class="input-group col-md-1 colLee" style="margin-right: 23px;">
									<a class="btn btn-primary" class="btn btn-primary" id="companyCreate">创建公司</a>
								</div>
								
								<div class="input-group col-md-1 colLee" style="margin-right: 23px;">
									<a href="javaScript:void(0);" class="btn btn-primary"
										id="exportComSearch">导出结果</a>
								</div>

                                <div class="input-group col-md-1 colLee" >
									<a href="javaScript:void(0);" class="btn btn-primary"
										id="importComSearch">批量导入</a>
								</div>

							</form>
							<div id="exportCom"></div>
							<input type="hidden" value="" id="companySearchCondition">
							<div id="tid" style="margin-top: 8px;">
								<jsp:include page="comtable.jsp"></jsp:include>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/span-->
</div>
<script id="template" type="text/x-handlebars-template">
   {{#each this}}
			<table>
			<tr><input type="hidden" id="comId" value="{{companyId}}">
			<td>公司名字：</td>
			<td><input type="text" id="comName" value="{{companyName}}"></td>
           <td><span id="namespan"></span></td>
			</tr>
            <tr>
			<td>昵称：</td>
			<td><input type="text" id="nickname" value="{{nickname}}"></td>
			</tr>
			<tr>
			<td>地址：</td>
			<td><input type="text" id="comAddress" value="{{companyAddress}}"></td>
			</tr>
			<tr>
			<td>邮箱：</td>
			<td><input type="text" id="comEmail" value="{{companyEmail}}"></td>
			</tr>
			<tr>
			<td>联系方式：</td>
			<td><input type="text" id="comPhone" value="{{companyPhone}}"></td>
            <td><span id="phonespan"></span></td>
			</tr>
			<tr>
			<td>公司业务：</td>
			<td><input type="text" id="comBusiness" value="{{companyBusiness}}"></td>
			</tr>
			<tr>
			<td>公司介绍：</td>
			<td><input type="text" id="comIntroduction" value="{{companyIntroduction}}"></td>
			</tr>
			</table>
				<button type="button" class="btn btn-primary shiny" onclick="comChangeSure()">确定</button>
				<button type="button" class="btn btn-primary shiny" onclick="comChangeQuit()">取消</button>
				
   {{/each}}
</script>
<script src="js/jquery/jquery.form.js"></script>
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/virtualMember/company.js"></script>
<script src="js/virtualMember/createComMem.js"></script>
<script src="js/pagination.js"></script>