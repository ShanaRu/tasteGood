<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/27
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
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
                        error:function () {
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
                    error:function () {
                        layer.msg('收藏失败', {icon: 5,offset:'220px'},);
                    }
                });
            });
        }

        function changePageSize() {
            //获取下拉框的值
            var pageSize = $("#changePageSize").val();

            //向服务器发送请求，改变每页显示条数
            location.href = "${pageContext.request.contextPath}/menu/userMenu?userId=${userInfo.userId}page=1&size="
                + pageSize;
        }

        function addFollow(userId,follow) {
            layui.use('layer', function() {
                var layer = layui.layer;
                $.ajax({
                    url:'${pageContext.request.contextPath}/userInfo/addFollow',
                    datatype:'text',
                    type:'post',
                    data:{"userId":userId,"follow":follow},
                    success:function (data) {
                        if(data=="200"){
                            layer.msg('关注成功', {icon: 1,offset:'220px'},);
                            window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                        }else if(data=="400"){
                            layer.msg('已经关注过了', {icon: 5,offset:'220px'},);
                        }else {
                            layer.msg('关注失败', {icon: 5,offset:'220px'},);
                        }
                    },
                    error:function () {
                        layer.msg('关注失败', {icon: 5,offset:'220px'},);
                    }
                });
            });
        }
    </script>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 500px" class="layui-row layui-col-space30">
        <div class="layui-col-md2">
            <div style="text-align: center">
                <a href="${pageContext.request.contextPath}/userInfo/kitchen?userId=${userInfo.userId}" style="display: inline-block;line-height:0;">
                    <img src="${pageContext.request.contextPath}/${userInfo.userPhoto}" style="width: 100px;height: 100px;vertical-align:bottom;border-radius:50%;" alt="*">
                </a>
            </div>
            <div style="padding: 15px"><a href="${pageContext.request.contextPath}/userInfo/kitchen?userId=${userInfo.userId}"><h3 style="text-align: center">${userInfo.userName}</h3></a></div>
            <c:if test="${myUserId eq userInfo.userId}">
                <div style="text-align: center;padding: 15px">
                    <a href="${pageContext.request.contextPath}/userInfo/modifyUserInfo" class="layui-btn layui-btn-primary">修改个人信息</a>
                </div>
            </c:if>
            <c:if test="${myUserId ne userInfo.userId}">
                <div style="text-align: center;padding: 15px">
                    <button class="layui-btn layui-btn-danger" onclick="addFollow(${myUserId},${userInfo.userId})">关注</button>
                </div>
            </c:if>
            <p style="text-align: center;padding: 15px;"><a href="${pageContext.request.contextPath}/userInfo/showFollow?userId=${userInfo.userId}&page=1&size=16" class="layui-btn layui-btn-primary">关注 ${follow}</a></p>
            <p style="text-align: center;padding: 15px;"><a href="${pageContext.request.contextPath}/userInfo/showFollowed?userId=${userInfo.userId}&page=1&size=16" class="layui-btn layui-btn-primary">被关注 ${followed}</a></p>
            <ul>
                <li style="text-align: center;padding: 15px;font-size: 20px">
                    <a href="${pageContext.request.contextPath}/menu/userMenu?userId=${userInfo.userId}&page=1&size=6" class="layui-btn layui-btn-primary">菜谱</a>
                </li>
                <li style="text-align: center;padding: 15px;font-size: 20px">
                    <a href="${pageContext.request.contextPath}/work/userWorks?userId=${userInfo.userId}&page=1&size=6" class="layui-btn layui-btn-primary">作品</a>
                </li>
                <li style="text-align: center;padding: 15px;font-size: 20px">
                    <a href="${pageContext.request.contextPath}/collection/showCollections?userId=${userInfo.userId}&page=1&size=6" class="layui-btn layui-btn-primary">收藏</a>
                </li>
            </ul>
        </div>
        <div class="layui-col-md10">
            <div class="layui-row layui-col-space30">
                    <c:forEach items="${pageInfo.list}" var="userMenu">
                        <div class="layui-col-md4">
                            <div style="width: 240px;text-align: center;border: 1px solid #f3f3f3">
                                <h3 style="margin: 15px"><a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${userMenu.menuId}">${userMenu.menuName}</a></h3>
                                <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${userMenu.menuId}" style="display: inline-block;line-height:0;">
                                    <img src="${pageContext.request.contextPath}/${userMenu.menuCover}" style="width: 240px;height: 190px;vertical-align:bottom;" alt="*">
                                </a>
                                <p style="width: 220px;margin:15px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;">
                                    <c:forEach items="${userMenu.ingredients}" var="ingredient">
                                        ${ingredient.ingredient}、
                                    </c:forEach>
                                </p>
                                <p style="margin: 15px">${userMenu.totalComplete} 做过 ${userMenu.collection} 收藏 | <a href="${pageContext.request.contextPath}/userInfo/kitchen?userId=${userInfo.userId}">${userInfo.userName}</a></p>
                                <p style="margin: 15px">
                                    <c:if test="${userInfo.userId eq myUserId}">
                                        <a href="${pageContext.request.contextPath}/menu/modifyMenu?menuId=${userMenu.menuId}">
                                            <button class="layui-btn layui-btn-primary layui-btn-xs layui-btn-radius">修改</button>
                                        </a>
                                        <button class="layui-btn layui-btn-primary layui-btn-xs layui-btn-radius" onclick="deleteMenu(${userMenu.menuId})">删除</button>
                                    </c:if>
                                </p>
                            </div>
                        </div>
                    </c:forEach>
            </div>
            <div style="text-align: center" class="layui-col-md12">
                <%--首页--%>
                <a href="${pageContext.request.contextPath}/menu/userMenu?userId=${userInfo.userId}&page=1&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm">首页</button>
                </a>
                <%--上一页--%>
                <c:if test="${pageInfo.hasPreviousPage}">
                    <a href="${pageContext.request.contextPath}/menu/userMenu?userId=${userInfo.userId}&page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-prev"></i></button>
                    </a>
                </c:if>
                <%--中间页 pageInfo.navigatepageNums 所有页码的数组 pageInfo.pageNum 当前页数--%>
                <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                    <c:if test="${pageNum == pageInfo.pageNum}">
                        <a href="${pageContext.request.contextPath}/menu/userMenu?userId=${userInfo.userId}&page=${pageNum}&size=${pageInfo.pageSize}">
                            <button class="layui-btn layui-btn-sm">${pageNum}</button>
                        </a>
                    </c:if>
                    <c:if test="${pageNum != pageInfo.pageNum}">
                        <a href="${pageContext.request.contextPath}/menu/userMenu?userId=${userInfo.userId}&page=${pageNum}&size=${pageInfo.pageSize}">
                            <button class="layui-btn layui-btn-primary layui-btn-sm">${pageNum}</button>
                        </a>
                    </c:if>
                </c:forEach>
                <%--下一页--%>
                <c:if test="${pageInfo.hasNextPage}">
                    <a href="${pageContext.request.contextPath}/menu/userMenu?userId=${userInfo.userId}&page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-next"></i></button>
                    </a>
                </c:if>
                <%--尾页--%>
                <a href="${pageContext.request.contextPath}/menu/userMenu?userId=${userInfo.userId}&page=${pageInfo.pages}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm">尾页</button>
                </a>
                <p style="display: inline-block;font-size: 12px;line-height: 30px">
                    每页
                    <select id="changePageSize" onchange="changePageSize()">
                        <option value="">请选择</option>
                        <option>6</option>
                        <option>10</option>
                        <option>14</option>
                    </select>
                    条
                </p>
            </div>
        </div>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
