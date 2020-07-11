<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/7
  Time: 21:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>菜谱分类</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script type="text/javascript">
        function addCollection(menuId) {
            layui.use('layer', function() {
                var layer = layui.layer;
                $.ajax({
                    url:'${pageContext.request.contextPath}/collection/addCollection',
                    datatype:'text',
                    type:'post',
                    data:"menuId="+menuId,
                    success:function (data) {
                        if(data==="200"){
                            layer.msg('收藏成功', {icon: 1,offset:'220px'},);
                            window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                        }else if(data==="400"){
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
            location.href = "${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=1&size="
                + pageSize;
        }
    </script>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 500px" class="layui-row layui-col-space10">
        <div class="layui-col-md6">
            <span class="layui-breadcrumb">
                <a href="${pageContext.request.contextPath}/userInfo/homePage">首页</a>
                <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=1&size=6"><cite>${classification}</cite></a>
            </span>
        </div>
        <div class="layui-col-md6">
            <button type="button" class="layui-btn-primary layui-btn-sm"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=家常菜&page=1&size=6">家常菜</a></button>
            <button type="button" class="layui-btn-primary layui-btn-sm"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=地方特色菜&page=1&size=6">地方特色菜</a></button>
            <button type="button" class="layui-btn-primary layui-btn-sm"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=甜点/面食&page=1&size=6">甜点/面食</a></button>
            <button type="button" class="layui-btn-primary layui-btn-sm"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=快餐&page=1&size=6">快餐</a></button>
            <button type="button" class="layui-btn-primary layui-btn-sm"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=中式&page=1&size=6">中式</a></button>
            <button type="button" class="layui-btn-primary layui-btn-sm"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=西式&page=1&size=6">西式</a></button>
            <button type="button" class="layui-btn-primary layui-btn-sm"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=日韩料理&page=1&size=6">日韩料理</a></button>
            <button type="button" class="layui-btn-primary layui-btn-sm"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=其他&page=1&size=6">其他</a></button>
        </div>
<%--        <div class="layui-col-md1"><a style="text-align: center"><button type="button" class="layui-btn-primary layui-btn-sm">家常菜</button></a></div>--%>
<%--        <div class="layui-col-md1"><a style="text-align: center"><button type="button" class="layui-btn-primary layui-btn-sm">地方特色</button></a></div>--%>
<%--        <div class="layui-col-md1"><a style="text-align: center"><button type="button" class="layui-btn-primary layui-btn-sm">甜点/面食</button></a></div>--%>
<%--        <div class="layui-col-md1"><a style="text-align: center"><button type="button" class="layui-btn-primary layui-btn-sm">中式</button></a></div>--%>
<%--        <div class="layui-col-md1"><a style="text-align: center"><button type="button" class="layui-btn-primary layui-btn-sm">西式</button></a></div>--%>
<%--        <div class="layui-col-md1"><a style="text-align: center"><button type="button" class="layui-btn-primary layui-btn-sm">日韩料理</button></a></div>--%>
<%--        <div class="layui-col-md1"><a style="text-align: center"><button type="button" class="layui-btn-primary layui-btn-sm">其他</button></a></div>--%>
        <c:forEach items="${pageInfo.list}" var="menu">
            <div style="padding: 15px;margin-bottom: 20px" class="layui-col-md6">
                <div class="layui-col-md6">
                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}" style="display: inline-block;line-height:0;">
                        <img src="${pageContext.request.contextPath}/${menu.menuCover}" style="width: 240px;height: 200px;vertical-align:bottom;" alt="*">
                    </a>
                </div>
                <div class="layui-col-md6">
                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}"><h1>${menu.menuName}</h1></a>
                        <%--                    <p>${userMenu.menuDetail}</p>--%>
                    <c:forEach items="${menu.ingredients}" var="ingredient">
                        <%--                        ${ingredient.dosage}--%>
                        <span style="font-size: 14px">${ingredient.ingredient}</span>
                    </c:forEach>
                    <span>${menu.collection}收藏</span>
                    <button type="button" class="layui-btn" onclick="addCollection(${menu.menuId})">收藏</button>
                </div>
            </div>
        </c:forEach>
        <div style="text-align: center" class="layui-col-md12">
            <%--首页--%>
            <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=1&size=${pageInfo.pageSize}">
                <button class="layui-btn layui-btn-primary layui-btn-sm">首页</button>
            </a>
            <%--上一页--%>
            <c:if test="${pageInfo.hasPreviousPage}">
                <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-prev"></i></button>
                </a>
            </c:if>
            <%--中间页 pageInfo.navigatepageNums 所有页码的数组 pageInfo.pageNum 当前页数--%>
            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                <c:if test="${pageNum == pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
                <c:if test="${pageNum != pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-primary layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
            </c:forEach>
            <%--下一页--%>
            <c:if test="${pageInfo.hasNextPage}">
                <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-next"></i></button>
                </a>
            </c:if>
            <%--尾页--%>
            <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=${pageInfo.pages}&size=${pageInfo.pageSize}">
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
