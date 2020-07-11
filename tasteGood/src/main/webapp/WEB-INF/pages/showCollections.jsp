<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/7
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>菜谱收藏</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
        function updateComplete(complete,menuId,userId) {
            var newComplete=complete+1;
            layui.use('layer', function() {
                var layer = layui.layer;
                $.ajax({
                    url:'${pageContext.request.contextPath}/collection/updateComplete',
                    datatype:'text',
                    type:'post',
                    data:{"complete":newComplete,"menuId":menuId,"userId":userId},
                    success:function (data) {
                        if(data==="200"){
                            layer.msg('打卡成功', {icon: 1,offset:'220px'},);
                            window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                        }else{
                            layer.msg('打卡失败', {icon: 5,offset:'220px'},);
                        }
                    },
                    error:function () {
                        layer.msg('打卡失败', {icon: 5,offset:'220px'},);
                    }
                });
            });
        }
        function deleteCollection(menuId,userId) {
            layui.use('layer', function() {
                var layer = layui.layer;
                $.ajax({
                    url:'${pageContext.request.contextPath}/collection/deleteCollection',
                    datatype:'text',
                    type:'post',
                    data:{"menuId":menuId,"userId":userId},
                    success:function (data) {
                        if(data==="200"){
                            layer.msg('删除成功', {icon: 1,offset:'220px'},);
                            window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                        }else{
                            layer.msg('删除失败', {icon: 5,offset:'220px'},);
                        }
                    },
                    error:function () {
                        layer.msg('删除失败', {icon: 5,offset:'220px'},);
                    }
                });
            });
        }

        function changePageSize() {
            //获取下拉框的值
            var pageSize = $("#changePageSize").val();

            //向服务器发送请求，改变每页显示条数
            location.href = "${pageContext.request.contextPath}/collection/showCollections?page=1&size="
                + pageSize;
        }
    </script>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 500px" class="layui-row layui-col-space10">
        <div class="layui-col-md12">
            <span class="layui-breadcrumb">
                <a href="${pageContext.request.contextPath}/userInfo/homePage">首页</a>
                <a href="${pageContext.request.contextPath}/collection/showCollections?page=1&size=6"><cite>菜谱收藏</cite></a>
            </span>
        </div>
        <c:forEach items="${pageInfo.list}" var="collection" varStatus="loop">
            <div style="padding: 15px;margin-bottom: 20px" class="layui-col-md6">
                <div class="layui-col-md6">
                    <c:forEach items="${collection.menu}" var="menu1" begin="${menu1[loop.count-1]}" end="${menu1[loop.count-1]}">
                        <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu1.menuId}" style="display: inline-block;line-height:0;">
                            <img src="${pageContext.request.contextPath}/${menu1.menuCover}" style="width: 240px;height: 200px;vertical-align:bottom;" alt="*">
                        </a>
                    </c:forEach>
                </div>
                <div class="layui-col-md6">
                    <c:forEach items="${collection.menu}" var="menu2" begin="${menu2[loop.count-1]}" end="${menu2[loop.count-1]}">
                        <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu2.menuId}"><h1>${menu2.menuName}</h1></a>
                        <c:forEach items="${menu2.ingredients}" var="ingredient">
                            <span style="font-size: 14px">${ingredient.ingredient}</span>
                        </c:forEach>
                        <p><i class="layui-icon layui-icon-star-fill"></i> ${menu2.collection}</p>
                    </c:forEach>
                    <div>
                        <span>完成次数 ${collection.complete} 次</span>
                        <button type="button" class="layui-btn" onclick="updateComplete(${collection.complete},${collection.menuId},${collection.userId})">完成打卡</button>
                    </div>
                    <button class="layui-btn" onclick="deleteCollection(${collection.menuId},${collection.userId})">删除</button>
                </div>
            </div>
        </c:forEach>
<%--        <c:forEach items="${menus}" var="menu" varStatus="loop">--%>
<%--            <div style="padding: 15px;margin-bottom: 20px" class="layui-col-md6">--%>
<%--                <div class="layui-col-md6">--%>
<%--                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}" style="display: inline-block;line-height:0px;">--%>
<%--                        <img src="${pageContext.request.contextPath}/${menu.menuCover}" style="width: 240px;height: 200px;vertical-align:bottom;">--%>
<%--                    </a>--%>
<%--                </div>--%>
<%--                <div class="layui-col-md6">--%>
<%--                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}"><h1>${menu.menuName}</h1></a>--%>
<%--                    <c:forEach items="${menu.ingredients}" var="ingredient">--%>
<%--                        <span style="font-size: 14px">${ingredient.ingredient}</span>--%>
<%--                    </c:forEach>--%>
<%--                    <p><i class="layui-icon layui-icon-star-fill"></i> ${menu.collection}</p>--%>
<%--                    <div>--%>
<%--                        <span>完成次数 ${pageInfo.list[loop.count-1].complete} 次</span>--%>
<%--                        <button type="button" class="layui-btn" onclick="updateComplete(${pageInfo.list[loop.count-1].complete},${pageInfo.list[loop.count-1].menuId},${pageInfo.list[loop.count-1].userId})">完成打卡</button>--%>
<%--                    </div>--%>
<%--                    <button class="layui-btn" onclick="deleteCollection(${pageInfo.list[loop.count-1].menuId},${pageInfo.list[loop.count-1].userId})">删除</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>
<%--        ${pageInfo.total}   ${pageInfo.pageNum}  ${pageInfo.pages}   ${pageInfo.pageSize}--%>
        <div style="text-align: center" class="layui-col-md12">
            <%--首页--%>
            <a href="${pageContext.request.contextPath}/collection/showCollections?page=1&size=${pageInfo.pageSize}">
                <button class="layui-btn layui-btn-primary layui-btn-sm">首页</button>
            </a>
            <%--上一页--%>
            <c:if test="${pageInfo.hasPreviousPage}">
                <a href="${pageContext.request.contextPath}/collection/showCollections?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-prev"></i></button>
                </a>
            </c:if>
            <%--中间页 pageInfo.navigatepageNums 所有页码的数组 pageInfo.pageNum 当前页数--%>
            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                <c:if test="${pageNum == pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/collection/showCollections?page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
                <c:if test="${pageNum != pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/collection/showCollections?page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-primary layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
            </c:forEach>
            <%--下一页--%>
            <c:if test="${pageInfo.hasNextPage}">
                <a href="${pageContext.request.contextPath}/collection/showCollections?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-next"></i></button>
                </a>
            </c:if>
            <%--尾页--%>
            <a href="${pageContext.request.contextPath}/collection/showCollections?page=${pageInfo.pages}&size=${pageInfo.pageSize}">
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
    <%@include file="footer.jsp"%>
</body>
</html>
