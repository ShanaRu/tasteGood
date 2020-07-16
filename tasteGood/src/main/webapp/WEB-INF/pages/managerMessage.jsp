<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/15
  Time: 22:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理留言</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script type="text/javascript">
        function changePageSize() {
            //获取下拉框的值
            var pageSize = $("#changePageSize").val();

            //向服务器发送请求，改变每页显示条数
            location.href = "${pageContext.request.contextPath}/manager/managerMessage?page=1&size="
                + pageSize;
        }

        function deleteLeave(leaveId) {
            console.log(123);
            layui.use('layer', function() {
                var layer = layui.layer;
                $.ajax({
                    url:'${pageContext.request.contextPath}/leaveMessage/deleteLeaveMessage',
                    datatype:'text',
                    type:'post',
                    data:"leaveId="+leaveId,
                    success:function (data) {
                        if(data=="200"){
                            layer.msg('删除成功', {icon: 1,offset:'220px'},);
                            window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                        }else {
                            layer.msg('删除失败', {icon: 5,offset:'220px'},);
                        }
                    },
                    error:function () {
                        layer.msg('删除失败', {icon: 5,offset:'220px'},);
                    }
                });
            });
        }
    </script>
</head>
<body>
<%--    <ul class="layui-nav layui-bg-green" style="text-align: center;font-size: 18px">--%>
<%--        <li class="layui-nav-item" style="width: 150px">--%>
<%--            <a href="${pageContext.request.contextPath}/manager/managerMenu?page=1&size=10">菜谱</a>--%>
<%--        </li>--%>
<%--        <li class="layui-nav-item" style="width: 150px">--%>
<%--            <a href="${pageContext.request.contextPath}/manager/managerWork?page=1&size=10">作品</a>--%>
<%--        </li>--%>
<%--        <li class="layui-nav-item layui-this" style="width: 150px">--%>
<%--            <a href="${pageContext.request.contextPath}/manager/managerMessage?page=1&size=10">留言</a>--%>
<%--        </li>--%>
<%--        <li class="layui-nav-item" style="width: 150px">--%>
<%--            <a href="${pageContext.request.contextPath}/userInfo/exit">退出</a>--%>
<%--        </li>--%>
<%--    </ul>--%>
<%@include file="managerNavbar.jsp"%>
    <div style="margin:30px 100px 20px 100px;min-height: 500px">
        <table class="layui-table">
            <colgroup>
                <col width="200">
                <col width="200">
                <col width="500">
            </colgroup>
            <thead>
            <tr>
                <th>留言时间</th>
                <th>留言所在菜谱名称</th>
                <th>留言内容</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageInfo.list}" var="leaveMessage">
                <tr>
                    <td><fmt:formatDate value="${leaveMessage.leaveTime}" pattern="yyyy-MM-dd"/></td>
                    <td>${leaveMessage.menuName}</td>
                    <td>${leaveMessage.leaveWord}</td>
                    <td><button type="button" onclick="deleteLeave(${leaveMessage.leaveId})" class="layui-btn">删除留言</button></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div style="text-align: center;margin-top: 20px">
            <%--首页--%>
            <a href="${pageContext.request.contextPath}/manager/managerMessage?page=1&size=${pageInfo.pageSize}">
                <button class="layui-btn layui-btn-primary layui-btn-sm">首页</button>
            </a>
            <%--上一页--%>
            <c:if test="${pageInfo.hasPreviousPage}">
                <a href="${pageContext.request.contextPath}/manager/managerMessage?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-prev"></i></button>
                </a>
            </c:if>
            <%--中间页 pageInfo.navigatepageNums 所有页码的数组 pageInfo.pageNum 当前页数--%>
            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                <c:if test="${pageNum == pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/manager/managerMessage?page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
                <c:if test="${pageNum != pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/manager/managerMessage?page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-primary layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
            </c:forEach>
            <%--下一页--%>
            <c:if test="${pageInfo.hasNextPage}">
                <a href="${pageContext.request.contextPath}/manager/managerMessage?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-next"></i></button>
                </a>
            </c:if>
            <%--尾页--%>
            <a href="${pageContext.request.contextPath}/manager/managerMessage?page=${pageInfo.pages}&size=${pageInfo.pageSize}">
                <button class="layui-btn layui-btn-primary layui-btn-sm">尾页</button>
            </a>
            <p style="display: inline-block;font-size: 12px;line-height: 30px">
                &ensp;共${pageInfo.total}条&ensp;每页
                <select id="changePageSize" onchange="changePageSize()">
                    <option value="">请选择</option>
                    <option>10</option>
                    <option>20</option>
                    <option>30</option>
                </select>
                条
            </p>
        </div>
    </div>
<%@include file="footer.jsp"%>
</body>
</html>
