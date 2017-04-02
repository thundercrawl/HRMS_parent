<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:if test="${fn:indexOf(param.url, '?') != -1 }" >
	<c:set var="linkChar" value="&"/>
</c:if>
<c:if test="${fn:indexOf(param.url, '?') == -1 }" >
	<c:set var="linkChar" value="?"/>
</c:if>
<input type="hidden" id="loadCmp" value="${param.loadCmp }"/>
<input type="hidden" id="formParamName" value="${param.formParam }"/>
<c:if test="${!(empty paginator.totalPage) && paginator.totalPage >= 1 }">
<div class="row center">
	<ul class="pagination" style="margin: 0;">
		<li <c:if test="${paginator.page <=1 }">class="disabled"</c:if>><a data-href="${param.url }${linkChar }page=0">首页</a></li>
		<li <c:if test="${paginator.page <=1 }">class="disabled"</c:if>><a data-href="${param.url }${linkChar }page=${paginator.page-2 }">上页</a></li>
		<c:choose>
		<c:when test="${paginator.page <= 3 }">
		<li <c:if test="${paginator.page == 1 }">class="active"</c:if>><a data-href="${param.url }${linkChar }page=0">1</a></li>
		<c:if test="${paginator.totalPage >= 2 }"><li <c:if test="${paginator.page == 2 }">class="active"</c:if>><a data-href="${param.url }${linkChar }page=1">2</a></li></c:if>
		<c:if test="${paginator.totalPage >= 3 }"><li <c:if test="${paginator.page == 3 }">class="active"</c:if>><a data-href="${param.url }${linkChar }page=2">3</a></li></c:if>
		<c:if test="${paginator.totalPage >= 4 }"><li><a data-href="${param.url }${linkChar }page=3">4</a></li></c:if>
		<c:if test="${paginator.totalPage >= 5 }"><li><a data-href="${param.url }${linkChar }page=4">5</a></li></c:if>
		</c:when>
		<c:when test="${paginator.page >= paginator.totalPage-2 }">
		<c:if test="${paginator.totalPage >= 5 }"><li><a data-href="${param.url }${linkChar }page=${paginator.totalPage-5 }">${paginator.totalPage-4 }</a></li></c:if>
		<c:if test="${paginator.totalPage >= 4 }"><li><a data-href="${param.url }${linkChar }page=${paginator.totalPage-4 }">${paginator.totalPage-3 }</a></li></c:if>
		<c:if test="${paginator.totalPage >= 3 }"><li <c:if test="${paginator.page == paginator.totalPage-2 }">class="active"</c:if>><a data-href="${param.url }${linkChar }page=${paginator.totalPage-3 }">${paginator.totalPage-2 }</a></li></c:if>
		<c:if test="${paginator.totalPage >= 2 }"><li <c:if test="${paginator.page == paginator.totalPage-1 }">class="active"</c:if>><a data-href="${param.url }${linkChar }page=${paginator.totalPage-2 }">${paginator.totalPage-1 }</a></li></c:if>
		<li <c:if test="${paginator.page == paginator.totalPage }">class="active"</c:if>><a data-href="${param.url }${linkChar }page=${paginator.totalPage-1 }">${paginator.totalPage }</a></li>
		</c:when>
		<c:otherwise>
		<li><a data-href="${param.url }${linkChar }page=${paginator.page - 3 }">${paginator.page - 2 }</a></li>
		<li><a data-href="${param.url }${linkChar }page=${paginator.page - 2 }">${paginator.page - 1 }</a></li>
		<li class="active"><a data-href="${param.url }${linkChar }page=${paginator.page -1 }">${paginator.page }</a></li>
		<li><a data-href="${param.url }${linkChar }page=${paginator.page }">${paginator.page + 1 }</a></li>
		<li><a data-href="${param.url }${linkChar }page=${paginator.page + 1 }">${paginator.page + 2 }</a></li>
		</c:otherwise>
		</c:choose>
		<li <c:if test="${paginator.page >= paginator.totalPage }">class="disabled"</c:if>><a data-href="${param.url }${linkChar }page=${paginator.page }">下页</a></li>
		<li <c:if test="${paginator.page >= paginator.totalPage }">class="disabled"</c:if>><a data-href="${param.url }${linkChar }page=${paginator.totalPage-1 }">尾页</a></li>
	</ul>
</div>
</c:if>