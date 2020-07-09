<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/9
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        if(data==="200"){
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
    <div style="margin:20px 100px 20px 100px;min-height: 500px">
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
            <c:forEach items="${leaveMessages}" var="leaveMessage">
                <tr>
                    <td>${leaveMessage.leaveTime}</td>
                    <td><a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${leaveMessage.menuId}">${leaveMessage.menuName}</a></td>
                    <td>${leaveMessage.leaveWord}</td>
                    <td><button type="button" onclick="deleteLeave(${leaveMessage.leaveId})" class="layui-btn">删除留言</button></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
