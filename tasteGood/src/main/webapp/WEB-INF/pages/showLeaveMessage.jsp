<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/9
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>查看留言</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script>
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
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 520px">
        <div class="layui-col-md12">
            <span class="layui-breadcrumb">
                <a href="${pageContext.request.contextPath}/userInfo/homePage">首页</a>
                <a href="${pageContext.request.contextPath}/leaveMessage/showLeaveMessage?page=1&size=6"><cite>我的留言</cite></a>
            </span>
        </div>
        <div class="layui-col-md12">
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
                        <td><a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${leaveMessage.menuId}">${leaveMessage.menuName}(点击查看详情)</a></td>
                        <td>${leaveMessage.leaveWord}</td>
                        <td><button type="button" onclick="deleteLeave(${leaveMessage.leaveId})" class="layui-btn">删除留言</button></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div style="text-align: center" class="layui-col-md12">
            <%--首页--%>
            <a href="${pageContext.request.contextPath}/leaveMessage/showLeaveMessage?page=1&size=${pageInfo.pageSize}">
                <button class="layui-btn layui-btn-primary layui-btn-sm">首页</button>
            </a>
            <%--上一页--%>
            <c:if test="${pageInfo.hasPreviousPage}">
                <a href="${pageContext.request.contextPath}/leaveMessage/showLeaveMessage?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-prev"></i></button>
                </a>
            </c:if>
            <%--中间页 pageInfo.navigatepageNums 所有页码的数组 pageInfo.pageNum 当前页数--%>
            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                <c:if test="${pageNum == pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/leaveMessage/showLeaveMessage?page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
                <c:if test="${pageNum != pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/leaveMessage/showLeaveMessage?page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-primary layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
            </c:forEach>
            <%--下一页--%>
            <c:if test="${pageInfo.hasNextPage}">
                <a href="${pageContext.request.contextPath}/leaveMessage/showLeaveMessage?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-next"></i></button>
                </a>
            </c:if>
            <%--尾页--%>
            <a href="${pageContext.request.contextPath}/leaveMessage/showLeaveMessage?page=${pageInfo.pages}&size=${pageInfo.pageSize}">
                <button class="layui-btn layui-btn-primary layui-btn-sm">尾页</button>
            </a>
        </div>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
