<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/2
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>作品模块</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 500px" class="layui-row layui-col-space10">
        <c:forEach items="${works}" var="work">
            <div class="layui-col-md4">
                <div><img src="${pageContext.request.contextPath}/${work.workPhoto}" style="height: 280px;width: 278px"></div>
                <div><h1>${work.menuName}</h1></div>
                <div><p style="width: 260px;margin:5px;text-overflow:ellipsis;overflow: hidden;">${work.summary}</p></div>
            </div>
        </c:forEach>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
