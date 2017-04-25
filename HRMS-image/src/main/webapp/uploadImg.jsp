<%@ page language="java" import="java.util.*" 
 contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="form1" method="post" enctype="multipart/form-data" action="filter/image/upload?relId=1&relType=1">
        <input type="file" name="imgFile" style="width:160px;" />
        <input type="submit" name="Submit" value="添加" />
    </form>
    <img id='imgsrc' src='http://localhost:8080/filter/image/tofindPic?imgName=201704241759146103_120_120'></img>
</body>
</html>