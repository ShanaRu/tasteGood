<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/27
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 500px">
        <div class="layui-row layui-col-space30">
            <div class="layui-col-md9">
                <h1>${menu.menuName}</h1>
                <img src="${pageContext.request.contextPath}/${menu.menuCover}" style="width: 470px;height: 500px;">
                <p>${menu.collection}收藏</p>
                <p>${menu.menuDetail}</p>
                <c:forEach items="${menu.ingredients}" var="ingredient">
                    <div class="layui-col-md6">
                        ${ingredient.ingredient}
                    </div>
                    <div class="layui-col-md6">
                        ${ingredient.dosage}
                    </div>
                </c:forEach>
                <c:forEach items="${menu.step}" var="step">
                    <div class="layui-col-md6">
                            ${step.step}
                    </div>
                    <div class="layui-col-md6">
                        <img src="${pageContext.request.contextPath}/${step.stepChar}" style="width: 200px;height: 200px;">
                    </div>
                </c:forEach>
                <p>${menu.tip}</p>
            </div>
            <div class="layui-col-md3" style="min-height: 480px">
                <p>展示</p>
            </div>
        </div>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
