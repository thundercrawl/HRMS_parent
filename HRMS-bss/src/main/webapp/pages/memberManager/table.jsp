<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable_meet">
	<thead>
		<tr>
			<th>会员ID</th>
			<th>名字</th>
			<th>电话</th>
			<th>注册时间</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
	</thead>
		<tbody>
       <input type="hidden" id="page" value="${paginator.page }">
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="os">
		<tr>
			<td class="center">${os.userId}</td>
			<td class="center">${os.userName}</td>
			<td class="center">${os.userPhone}</td>
			<td class="center">${os.createTime}</td>
			<td class="center status-${os.userId }">
			<c:if test="${os.userStatus!=-1}"> 可使用</c:if>
			<c:if test="${os.userStatus==-1}">  禁用</c:if>
			</td>
			<td >
			<c:if test="${os.userStatus==-1}">
			 <input type="button" id="prohibition" value="解禁" class="btn btn-primary prohibition-${os.userId }" onclick="prohibition(${os.userId},${os.userStatus })">
			</c:if>
			<c:if test="${os.userStatus!=-1}">
			  <input type="button" id="prohibition" value="禁用" class="btn btn-primary prohibition-${os.userId }""  onclick="prohibition(${os.userId},${os.userStatus })">
			</c:if>
			<c:if test="${!(empty os.nomalCompanyId)}">
		    <input type="button"  class="btn  btn-primary  memCompany" id="" comId="${os.nomalCompanyId}" 
		     onclick="memCompany('${os.userPhone}')" value="会员公司">
			</c:if>
			 <input type="button"  class="btn  btn-primary  joinAlert-${ os.userId}" id="" 
		     onclick="joinCompany('${os.userId}')" value="加入公司">
			
				<%-- 	<input type="button" id="sysout" class="btn btn-primary" value="删除" onclick="memberDel(${os.userId})"></td> --%>
			 <input type="button" value="修改" class="btn btn-primary modifymember" data-userID="${os.userId}" data-username="${os.userName}" data-userPhone="${os.userPhone}">
			  	<c:if test="${!(empty os.nomalCompanyId)}">
			  <input type="button" value="退出公司" class="btn btn-primary removemember" data-userID="${os.userId}" data-username="${os.userName}" data-userPhone="${os.userPhone}" data-companyid=${os.nomalCompanyId }>
			</c:if>
			<input type="button" value="重置密码" class="btn btn-primary resetPwd" data-userID="${os.userId}" data-username="${os.userName}" data-userPhone="${os.userPhone}" data-companyid=${os.nomalCompanyId }>
			</td>
			</tr>
		</c:forEach>
		</c:if>
	</tbody>
</table>
		<div id="joinPdialog" style="display: none;">
						<div >
								<label>选择公司</label>
								<div >
									<select class="form-control " name="companyId" id="companyId"></select>
								</div>
							</div>
                        <div>
						</div>

						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="joinSure">加入</a>
						</div>
						<div class="input-group col-md-3 colLee">
							<a type="button" class="btn btn-primary" id="joinQuit">取消</a>
						</div>
				</div>	
				 <div id="modify_member" style="display:none;">
  <form action="" style="margin-right: 10px;">
    <table>
      <tr>
         <td><input type="hidden" id="mod_userId" /></td>
      </tr>
      <tr>
         <td>名字</td>
         <td><div><input type="text" id="mod_username" maxlength="15"/><span id="spmod_username"  style="display: none;color: red;font-size: 18px">X</span></div></td>
      </tr>
<!--       <tr><td>电话</td> -->
<!--       <td>  -->
<!--       <input type="text" id="mod_userPhone" maxlength="11"><span id="spmod_userPhone"  style="display: none;color: red;font-size: 18px">X</span></td> -->
<!--       </tr> -->
    </table>
   </form>
   <div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="modify_sure">确定</a>
		</div>
		<div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary" id="modify_esc">取消</a>
		</div>
   
   
   
  </div>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/member/getMemberSearch" name="url"/>
	<jsp:param value="tid" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
<link href="css/walletItem.css" rel="stylesheet">
<script src="js/handlebars-v2.0.0.js"></script>
<script src="js/memberManager/table.js"></script>
<script id="companyoption" type="text/x-handlebars-template">
{{#each this}}
	<option value="{{companyId}}">{{companyName}}</option>
{{/each}}
</script>

