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
                        if(data=="200"){
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
                layer.confirm('确定要删除该收藏吗？', {
                    btn: ['确定','取消'], //按钮
                    offset:'200px'
                }, function(){
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
                    // layer.msg('删除成功', {icon: 1,offset:'220px'},);
                }, function(){
                    // layer.msg('删除成功', {icon: 5,offset:'220px'},);
                });
            });
        }

        function changePageSize() {
            //获取下拉框的值
            var pageSize = $("#changePageSize").val();

            //向服务器发送请求，改变每页显示条数
            location.href = "${pageContext.request.contextPath}/collection/showCollections?userId=${userInfo.userId}&page=1&size="
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
                <c:forEach items="${pageInfo.list}" var="collection" varStatus="loop">
                    <div class="layui-col-md4">
                        <div style="width: 240px;text-align: center;border: 1px solid #f3f3f3">
                            <c:forEach items="${collection.menu}" var="menu1" begin="${menu1[loop.count-1]}" end="${menu1[loop.count-1]}">
                                <h3 style="margin: 15px"><a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu1.menuId}">${menu1.menuName}</a></h3>
                            </c:forEach>
                            <c:forEach items="${collection.menu}" var="menu2" begin="${menu2[loop.count-1]}" end="${menu2[loop.count-1]}">
                                <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu2.menuId}" style="display: inline-block;line-height:0;">
                                    <img src="${pageContext.request.contextPath}/${menu2.menuCover}" style="width: 240px;height: 180px;vertical-align:bottom;" alt="*">
                                </a>
                            </c:forEach>
                            <c:forEach items="${collection.menu}" var="menu3" begin="${menu3[loop.count-1]}" end="${menu3[loop.count-1]}">
                                <p style="width: 220px;margin:15px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;">
                                    <c:forEach items="${menu3.ingredients}" var="ingredient">
                                        ${ingredient.ingredient}、

                                    </c:forEach>
                                </p>
                            </c:forEach>
                            <c:forEach items="${collection.menu}" var="menu4" begin="${menu4[loop.count-1]}" end="${menu4[loop.count-1]}">
                                <p style="margin: 15px">${menu4.totalComplete} 做过 ${menu4.collection} 收藏</p>
                            </c:forEach>
                            <div style="margin: 15px">
                                <span>已完成 ${collection.complete} 次</span>
                                <button type="button" class="layui-btn layui-btn-primary layui-btn-xs layui-btn-radius" onclick="updateComplete(${collection.complete},${collection.menuId},${collection.userId})">完成打卡</button>
                                <button class="layui-btn layui-btn-primary layui-btn-xs layui-btn-radius" onclick="deleteCollection(${collection.menuId},${collection.userId})">删除</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <div style="text-align: center" class="layui-col-md12">
                    <%--首页--%>
                    <a href="${pageContext.request.contextPath}/collection/showCollections?userId=${userInfo.userId}&page=1&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-primary layui-btn-sm">首页</button>
                    </a>
                    <%--上一页--%>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <a href="${pageContext.request.contextPath}/collection/showCollections?userId=${userInfo.userId}&page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">
                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-prev"></i></button>
                        </a>
                    </c:if>
                    <%--中间页 pageInfo.navigatepageNums 所有页码的数组 pageInfo.pageNum 当前页数--%>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                        <c:if test="${pageNum == pageInfo.pageNum}">
                            <a href="${pageContext.request.contextPath}/collection/showCollections?userId=${userInfo.userId}&page=${pageNum}&size=${pageInfo.pageSize}">
                                <button class="layui-btn layui-btn-sm">${pageNum}</button>
                            </a>
                        </c:if>
                        <c:if test="${pageNum != pageInfo.pageNum}">
                            <a href="${pageContext.request.contextPath}/collection/showCollections?userId=${userInfo.userId}&page=${pageNum}&size=${pageInfo.pageSize}">
                                <button class="layui-btn layui-btn-primary layui-btn-sm">${pageNum}</button>
                            </a>
                        </c:if>
                    </c:forEach>
                    <%--下一页--%>
                    <c:if test="${pageInfo.hasNextPage}">
                        <a href="${pageContext.request.contextPath}/collection/showCollections?userId=${userInfo.userId}&page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">
                            <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-next"></i></button>
                        </a>
                    </c:if>
                    <%--尾页--%>
                    <a href="${pageContext.request.contextPath}/collection/showCollections?userId=${userInfo.userId}&page=${pageInfo.pages}&size=${pageInfo.pageSize}">
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
<%--        <div class="layui-col-md12">--%>
<%--            <span class="layui-breadcrumb">--%>
<%--                <a href="${pageContext.request.contextPath}/userInfo/homePage">首页</a>--%>
<%--                <a href="${pageContext.request.contextPath}/collection/showCollections?page=1&size=6"><cite>菜谱收藏</cite></a>--%>
<%--            </span>--%>
<%--        </div>--%>
<%--        <c:forEach items="${pageInfo.list}" var="collection" varStatus="loop">--%>
<%--            <div style="padding: 15px;margin-bottom: 20px" class="layui-col-md6">--%>
<%--                <div class="layui-col-md6">--%>
<%--                    <c:forEach items="${collection.menu}" var="menu1" begin="${menu1[loop.count-1]}" end="${menu1[loop.count-1]}">--%>
<%--                        <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu1.menuId}" style="display: inline-block;line-height:0;">--%>
<%--                            <img src="${pageContext.request.contextPath}/${menu1.menuCover}" style="width: 240px;height: 200px;vertical-align:bottom;" alt="*">--%>
<%--                        </a>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>
<%--                <div class="layui-col-md6">--%>
<%--                    <c:forEach items="${collection.menu}" var="menu2" begin="${menu2[loop.count-1]}" end="${menu2[loop.count-1]}">--%>
<%--                        <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu2.menuId}"><h1>${menu2.menuName}</h1></a>--%>
<%--                        <c:forEach items="${menu2.ingredients}" var="ingredient">--%>
<%--                            <span style="font-size: 14px">${ingredient.ingredient}</span>--%>
<%--                        </c:forEach>--%>
<%--                        <p><i class="layui-icon layui-icon-star-fill"></i> ${menu2.collection}</p>--%>
<%--                    </c:forEach>--%>
<%--                    <div>--%>
<%--                        <span>完成次数 ${collection.complete} 次</span>--%>
<%--                        <button type="button" class="layui-btn" onclick="updateComplete(${collection.complete},${collection.menuId},${collection.userId})">完成打卡</button>--%>
<%--                    </div>--%>
<%--                    <button class="layui-btn" onclick="deleteCollection(${collection.menuId},${collection.userId})">删除</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>
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

    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
