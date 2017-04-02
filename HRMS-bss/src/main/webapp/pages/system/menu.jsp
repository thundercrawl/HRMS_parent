<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<ul class="breadcrumb">
		<li><a href="#">菜单设置</a></li>
	</ul>
</div>
<link href="css/style.css" rel="stylesheet">
<div class="row">
	<div class="box col-md-12">
		<div class="box-inner">
			<div class="box-header well" data-original-title="">
				<h2 style="margin-top:-12px">
					<i class="glyphicon glyphicon-shopping-cart"></i> 菜单设置
				</h2>
			</div>
			<div class="box-content">
				<input type="hidden" id="hiddenMenuJson" value="${menuJson}"/>
				<div  class="tree" >
					<div style="display:inline-block;min-height: 200px;">
					    <ul>
					        <li class="parent_li" id="topMenu">
					            <span title="Collapse this branch" class="menu" menu-type="top" id="top">办伴微信菜单</span>
					            <ul>
					            	<c:if test="${!(empty menu.button) }">
					            	<c:forEach items="${menu.button }" var="button" varStatus="buttonIndex">
					                <li class="parent_li">
					                	<span class="<c:if test="${(empty button.type)}">badge badge-success</c:if> menu" id="parentMenu_${buttonIndex.index }" <c:if test="${button.type eq 'view'}">menu-url="${button.url }"</c:if><c:if test="${button.type eq 'click'}">menu-key="${button.key }"</c:if> menu-type=<c:if test="${(empty button.sub_button) }">"${button.type }"</c:if><c:if test="${!(empty button.sub_button) }">"parent"</c:if>>${button.name }</span>
							            <ul>
						                	<c:if test="${!(empty button.sub_button) }">
							            	<c:forEach items="${button.sub_button }" var="subBtn" varStatus="subBtnIndex">
					                        <li>
						                        <span class="menu" menu-type="${subBtn.type }" id="subMenu_${buttonIndex.index }_${subBtnIndex.index }" <c:if test="${subBtn.type eq 'view'}">menu-url="${subBtn.url }"</c:if><c:if test="${subBtn.type eq 'click'}">menu-key="${subBtn.key }"</c:if>>${subBtn.name }</span>
					                        </li>
					                        </c:forEach>
						                    </c:if>
					                    </ul>
					                </li>
					                </c:forEach>
						            </c:if>
					            </ul>
					        </li>
					    </ul>
					</div>
					<div style="display:inline-block;position: absolute; margin-left:50px" id="menuConfig">
					</div>
				</div>
				
			</div>
		</div>
	</div>
	<!--/span-->

</div>
<div id="mask" class="ui-mask" style="display:none;">
</div>
<div id="delConfirm" style="display: none;z-index: 3">
	<div class="bid-btn center">
		<div class="btn btn-danger" style="margin:0 10px" id="removeMenu">确定</div>
		<div class="btn btn-de	fault" style="margin:0 10px" id="cancelRemove">取消</div>
	</div>
</div>
<!--/row-->
<script src="js/system/menu.js"></script>
