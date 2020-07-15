<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/16
  Time: 1:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<ul class="layui-nav layui-bg-green" style="text-align: center;">
    <li class="layui-nav-item" style="width: 150px;" >
        <a href="${pageContext.request.contextPath}/manager/managerMenu?page=1&size=10" style="font-size: 18px">菜谱</a>
    </li>
    <li class="layui-nav-item" style="width: 150px;">
        <a href="${pageContext.request.contextPath}/manager/managerWork?page=1&size=10" style="font-size: 18px">作品</a>
    </li>
    <li class="layui-nav-item" style="width: 150px;">
        <a href="${pageContext.request.contextPath}/manager/managerMessage?page=1&size=10" style="font-size: 18px">留言</a>
    </li>
    <li class="layui-nav-item" style="width: 150px;">
        <a href="${pageContext.request.contextPath}/userInfo/exit" style="font-size: 18px">退出</a>
    </li>
</ul>
