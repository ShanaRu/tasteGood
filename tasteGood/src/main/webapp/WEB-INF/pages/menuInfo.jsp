<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/16
  Time: 1:29
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
    <%@include file="managerNavbar.jsp"%>
    <div style="margin:30px 100px 20px 100px;min-height: 500px">
        <i class="layui-icon layui-icon-return"></i><a href="${pageContext.request.contextPath}/manager/managerMenu?page=${pageNum}&size=${pageSize}" style="font-size: 16px;">返回</a>
        <div style="margin-left: 50px;width: 640px;margin-top: 20px">
            <h2 style="font-size: 25px;margin-bottom: 20px">${menu.menuName}</h2>
            <img src="${pageContext.request.contextPath}/${menu.menuCover}" style="width: 640px;height: 420px;" alt="*">
            <p style="margin: 20px 0 20px 0;font-size: 16px">${menu.menuDetail}</p>
            <p style="display:block;font-size: 16px;line-height: 60px">${menu.totalComplete}&ensp;次打卡&ensp;|&ensp;${menu.collection}&ensp;收藏&ensp;</p>
            <div style="margin: 20px 0 20px 0;">
                <h3 style="margin-bottom: 20px">材料</h3>
                <table class="layui-table">
                    <colgroup>
                        <col width="320">
                        <col width="320">
                    </colgroup>
                    <thead>
                    <tr>
                        <th style="font-size: 16px">食材</th>
                        <th style="font-size: 16px">用量</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${menu.ingredients}" var="ingredient">
                        <tr>
                            <td style="font-size: 16px">${ingredient.ingredient}</td>
                            <td style="font-size: 16px">${ingredient.dosage}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <div style="margin: 20px 0 20px 0;">
                <h3 style="margin-bottom: 20px">步骤</h3>
                <table class="layui-table">
                    <colgroup>
                        <col width="20">
                        <col width="300">
                        <col width="320">
                    </colgroup>
                    <thead>
                    <tr>
                        <th style="font-size: 16px">顺序</th>
                        <th style="font-size: 16px">食材</th>
                        <th style="font-size: 16px">用量</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${menu.steps}" var="s" varStatus="loop">
                        <tr>
                            <td style="font-size: 16px">${loop.index+1}</td>
                            <td style="font-size: 16px">${s.step}</td>
                            <td style="font-size: 16px"><img src="${pageContext.request.contextPath}/${s.stepChar}" style="width: 250px;height: 200px;max-width: 250px" alt="*"></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <p style="margin: 20px 0 40px 0;font-size: 16px"><i class="layui-icon layui-icon-note">&ensp;小提示&ensp;</i>&ensp;${menu.tip}</p>
        </div>
    </div>
</body>
</html>
