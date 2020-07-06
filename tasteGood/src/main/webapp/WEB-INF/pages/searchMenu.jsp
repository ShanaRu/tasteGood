<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/6
  Time: 20:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>
<body>
<%@include file="navbar.jsp"%>
<div style="margin:20px 100px 20px 100px;min-height: 500px" class="layui-row layui-col-space10">
    <c:forEach items="${menus}" var="menu">
        <div style="padding: 15px;margin-bottom: 20px" class="layui-col-md6">
            <div class="layui-col-md6">
                <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}" style="display: inline-block;line-height:0px;">
                    <img src="${pageContext.request.contextPath}/${menu.menuCover}" style="width: 240px;height: 200px;vertical-align:bottom;">
                </a>
            </div>
            <div class="layui-col-md6">
                <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}"><h1>${menu.menuName}</h1></a>
                    <%--                    <p>${userMenu.menuDetail}</p>--%>
                <c:forEach items="${menu.ingredients}" var="ingredient">
                    <%--                        ${ingredient.dosage}--%>
                    <span style="font-size: 14px">${ingredient.ingredient}</span>
                </c:forEach>
                <p>${menu.collection}收藏</p>

            </div>
        </div>
    </c:forEach>
</div>
<%@include file="footer.jsp"%>
</body>
</html>
