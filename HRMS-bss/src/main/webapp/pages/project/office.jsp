<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<table class="table table-striped table-bordered bootstrap-datatable dataTable responsive" id="projectable">
	<thead>
		<tr>
			<th>所属项目</th>
			<th>办公室名称</th>
			<th>门牌号</th>
            <th>所属楼层</th>
            <th>区域信息</th>            
            <th>办公室大小（人数）</th>
            <th>办公室面积（m²）</th>
            <th>简要描述</th>            
            <th>操作</th>            
		</tr>
	</thead>
	<tbody>
	<c:if test="${!(empty paginator.list)}">
		<c:forEach items="${paginator.list}" var="project">
		<tr><td class="center">${project.projectName}</td>
			<td class="center">${project.officename}</td>
			<td class="center">${project.homeNum}</td>
			<td class="center">${project.flood}</td>
			<td class="center">${project.areainfo}</td>
			<td class="center">${project.content}</td>
			<td class="center">${project.officearea}</td>
			<td class="center">${project.desc}</td>
			<td>
			  <a href="javaScript:void(0);" class="btn btn-info btn-xs edit updateOff"
			  data-rankId="${project.rankId}"
		     data-rankDescribe="${project.rankDescribe}"
			data-projectname="${project.officename}" data-proname="${project.homeNum}" data-flood="${project.flood}" 
			data-area="${project.areainfo}" data-bname="${project.content}" data-address="${project.desc}"
			data-officeid="${project.officeid}" officearea="${project.officearea}" 
			projectid="${project.projectid}"
			projectname="${project.projectName}"><i class="fa fa-edit"></i>修改</a>
			<a href="javaScript:void(0);" class="btn btn-danger btn-xs delete deleteOff" officeid="${project.officeid}" projectid="${project.projectid}" data-page="${paginator.page}">删除</a>
			<c:if test="${project.lockstatus==1}"> 
			    <input type="button" class="btn btn-info  btn-xs" value="锁定" id="lock-${project.officeid}" onclick="lock(${project.officeid},${project.lockstatus})">
			</c:if>
			<c:if test="${project.lockstatus==0}">
                <input type="button" class="btn btn-info  btn-xs" value="解锁" id="lock-${project.officeid}" onclick="lock(${project.officeid},${project.lockstatus})">
             </c:if>
             </td>
			</td>
		</tr>
		</c:forEach>
	</c:if>
	</tbody>
</table>
<jsp:include page="../common/paginator.jsp">
	<jsp:param value="filter/project/showoffice" name="url"/>
	<jsp:param value="projectable" name="loadCmp"/>
	<jsp:param value="formParam" name="formParam"/>
</jsp:include>
  <div id="addOdialog" style="display:none;">
    <table class="table2">
      <tr>
         <td>办公室名称</td>
         <td><input type="text" id="officename"/><span id="offimg"><img alt="" src="img/delete.png" style="width: 20px;"></span></td>
      </tr>
      <tr>
         <td>门牌号</td>
         <td><input type="text" id="homeNum"/><span id="meetimg"><img alt="" src="img/delete.png" style="width: 20px;"></span></td>
      </tr>
      <tr>
         <td>办公室等级</td>
         <td style="position:relative">
         	<input id="rank_select2" style="height: 30px;width: 100%;" readonly="true"/><span id="rankimg"><img alt="" style="width: 20px;" src="img/delete.png"></span>
         	<input id="rank_id2" type="hidden"/>
		    <ul class="rank_select_url select_ul" id="rank_select_url2"></ul>
         </td>
      </tr>
      <tr>
         <td>所属项目</td>
         <td style="position:relative">
         	<input id="select" style="height: 30px;width: 100%;"  readOnly="true"/><span id="proimg"><img alt="" src="img/delete.png" style="width: 20px;"></span>
         	<input id="projectid" type="hidden"/>
		    <ul class="select_ul" id="select_ul"></ul>
         </td>
      </tr>
      <tr>
         <td>所属楼层</td>
         <td style="position:relative">
         	<input id="flood" style="height: 30px;width: 100%;"  readOnly="true"/><span id="floodimg"><img alt="" src="img/delete.png" style="width: 20px;"></span>
		    <ul class="select_ul" id="flood_ul"></ul>
         </td>
      </tr>
      <tr>
         <td>区域信息</td>
         <td><input type="text" id="areainfo"/><span id="spceimg"><img alt="" src="img/delete.png" style="width: 20px;"></span></td>
      </tr>
      <tr>
         <td>办公室人数</td>
         <td><input type="text" id="space"/><span id="contentimg"><img alt="" src="img/delete.png" style="width: 20px;"></span></td>
      </tr>
      <tr>
         <td>办公室面积</td>
         <td><input type="text" id="officeArea"/><span id="areaimg"><img alt="" src="img/delete.png" style="width: 20px;"></span></td>
      </tr>
       <tr>
         <td>简要描述</td>
         <td><input type="text" id="describ"/><span id="descimg"><img alt="" src="img/delete.png" style="width: 20px;"></span></td>
      </tr>
      </table>
   <center>
   <input type="hidden" id="officeid">
   <div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary shiny" id="formcheck" page="${paginator.page}">确定</a>
	</div>
	<div class="input-group col-md-3 colLee" style="display:inline-block;">
		 <a href="javaScript:void(0);" class="btn btn-primary shiny" id="return">取消</a>
	</div>
  </center>
</div>
<div id="officePic" style="display: none">
<form id="Officeform" enctype="multipart/form-data" method="post">
   <table>
       <tr>
        <td>办公室图片</td>
        <td>
		  <input type="file" id="files" name='imgFile' style="width:270px;height:37px;opacity: 0;z-index:999;position: absolute;left: 22%;top:12px;" >
		  <input id='projectimg' name="projectimg" value="请选择图片上传">
		</td>
      </tr>
    </table>
   </form>
   <div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary shiny" id="formPic">确定</a>
		</div>
		<div class="input-group col-md-3 colLee">
			<a href="javaScript:void(0);" class="btn btn-primary shiny" id="returnpic">取消</a>
		</div>
    
   
</div>
<script src="js/project/office.js"></script>

