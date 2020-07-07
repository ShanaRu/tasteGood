<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/27
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>个人菜谱</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script type="text/javascript">
        function deleteMenu(menuId) {
            layui.use('layer', function(){
                var layer = layui.layer;
                layer.confirm('确定要删除该菜谱吗？', {
                    btn: ['确定','取消'], //按钮
                    offset:'200px'
                }, function(){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/menu/deleteMenu",
                        data:"menuId="+menuId,
                        datatype:"text",
                        type:"post",
                        success:function (data) {
                            if(data=="200"){
                                layer.msg('删除成功', {icon: 1,offset:'220px'},);
                                <%--location.href = "${pageContext.request.contextPath}/menu/userMenu";--%>
                                <%--window.setTimeout("window.location='${pageContext.request.contextPath}/menu/userMenu'",2000);//延迟2秒跳转--%>
                                window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                            }else{
                                layer.msg('无法删除', {icon: 5,offset:'220px'},);
                            }
                        },
                        error:function (data) {
                            layer.msg('无法删除', {icon: 5,offset:'220px'},);
                        }
                    });
                    // layer.msg('删除成功', {icon: 1,offset:'220px'},);
                }, function(){
                    // layer.msg('删除成功', {icon: 5,offset:'220px'},);
                });

            });
        }

        function addCollection(menuId) {
            layui.use('layer', function() {
                var layer = layui.layer;
                $.ajax({
                    url:'${pageContext.request.contextPath}/collection/addCollection',
                    datatype:'text',
                    type:'post',
                    data:"menuId="+menuId,
                    success:function (data) {
                        if(data=="200"){
                            layer.msg('收藏成功', {icon: 1,offset:'220px'},);
                            window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                        }else if(data=="400"){
                            layer.msg('已经收藏过了', {icon: 5,offset:'220px'},);
                        }else {
                            layer.msg('收藏失败', {icon: 5,offset:'220px'},);
                        }
                    },
                    error:function (data) {
                        layer.msg('收藏失败', {icon: 5,offset:'220px'},);
                    }
                });
            });
        }
    </script>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 500px" class="layui-row layui-col-space10">
        <div>
            <span class="layui-breadcrumb">
                <a href="${pageContext.request.contextPath}/userInfo/homePage">首页</a>
                <a href="${pageContext.request.contextPath}/menu/userMenu"><cite>我的菜谱</cite></a>
            </span>
        </div>
        <c:forEach items="${userMenus}" var="userMenu">
            <div style="padding: 15px;margin-bottom: 20px" class="layui-col-md6">
                <div class="layui-col-md6">
                    <a href="${pageContext.request.contextPath}/menu/modifyMenu?menuId=${userMenu.menuId}" style="display: inline-block;line-height:0px;">
                        <img src="${pageContext.request.contextPath}/${userMenu.menuCover}" style="width: 240px;height: 200px;vertical-align:bottom;">
                    </a>
                </div>
                <div class="layui-col-md6">
                    <a href="${pageContext.request.contextPath}/menu/modifyMenu?menuId=${userMenu.menuId}"><h1>${userMenu.menuName}</h1></a>
<%--                    <p>${userMenu.menuDetail}</p>--%>
                    <c:forEach items="${userMenu.ingredients}" var="ingredient">
<%--                        ${ingredient.dosage}--%>
                        <span style="font-size: 14px">${ingredient.ingredient}</span>
                    </c:forEach>
                    <div>
                        <span>${userMenu.collection}收藏</span>
                        <button type="button" class="layui-btn" onclick="addCollection(${userMenu.menuId})">收藏</button>
                    </div>
                    <a href="${pageContext.request.contextPath}/menu/modifyMenu?menuId=${userMenu.menuId}" class="layui-btn">修改</a>
                    <button class="layui-btn" onclick="deleteMenu(${userMenu.menuId})">删除</button>
                </div>
            </div>

        </c:forEach>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
