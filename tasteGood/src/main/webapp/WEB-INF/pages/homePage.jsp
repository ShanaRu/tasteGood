<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/23
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>主页</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script type="text/javascript">
        layui.use('carousel', function(){
            var carousel = layui.carousel;
            //建造实例
            carousel.render({
                elem: '#test1'
                ,width: '100%' //设置容器宽度
                ,arrow: 'always' //始终显示箭头
                //,anim: 'updown' //切换动画方式
            });
        });
    </script>
    <%@include file="workMethod.jsp"%>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:30px 100px 20px 100px;min-height: 500px">
        <div class="layui-row layui-col-space30">
            <div class="layui-col-md2" style="min-height: 480px;">
                <ul>
                    <li style="margin: 15px">
                        <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=家常菜&page=1&size=8" style="font-size: 18px;line-height: 35px">
                            <img src="${pageContext.request.contextPath}/picture/logo1.png" style="width: 35px;height: 35px">&ensp;家常菜
                        </a>
                    </li>
                    <li style="margin: 15px 0px 15px 15px">
                        <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=地方特色菜&page=1&size=8" style="font-size: 18px;line-height: 35px">
                            <img src="${pageContext.request.contextPath}/picture/logo2.png" style="width: 35px;height: 35px">&ensp;地方特色菜
                        </a>
                    </li>
                    <li style="margin: 15px">
                        <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=甜点/面食&page=1&size=8" style="font-size: 18px;line-height: 35px">
                            <img src="${pageContext.request.contextPath}/picture/logo3.png" style="width: 35px;height: 35px">&ensp;甜点/面食
                        </a>
                    </li>
                    <li style="margin: 15px">
                        <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=快餐&page=1&size=8" style="font-size: 18px;line-height: 35px">
                            <img src="${pageContext.request.contextPath}/picture/logo4.png" style="width: 35px;height: 35px">&ensp;快餐
                        </a>
                    </li>
                    <li style="margin: 15px">
                        <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=中式&page=1&size=8" style="font-size: 18px;line-height: 35px">
                            <img src="${pageContext.request.contextPath}/picture/logo5.png" style="width: 35px;height: 35px">&ensp;中式
                        </a>
                    </li>
                    <li style="margin: 15px">
                        <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=西式&page=1&size=8" style="font-size: 18px;line-height: 35px">
                            <img src="${pageContext.request.contextPath}/picture/logo6.png" style="width: 35px;height: 35px">&ensp;西式
                        </a>
                    </li>
                    <li style="margin: 15px">
                        <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=日韩料理&page=1&size=8" style="font-size: 18px;line-height: 35px">
                            <img src="${pageContext.request.contextPath}/picture/logo7.png" style="width: 35px;height: 35px">&ensp;日韩料理
                        </a>
                    </li>
                    <li style="margin: 15px">
                        <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=其他&page=1&size=8" style="font-size: 18px;line-height: 35px">
                            <img src="${pageContext.request.contextPath}/picture/logo8.png" style="width: 35px;height: 35px">&ensp;其他
                        </a>
                    </li>
                </ul>
            </div>
            <div class="layui-col-md7">
                <div class="layui-row">
                    <div class="layui-col-md12" style="min-height: 160px" >
                        <div class="layui-carousel" id="test1">
                            <div carousel-item>
                                <div>
                                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${carousel[0].menuId}">
                                        <img src="${pageContext.request.contextPath}/${carousel[0].menuCover}" style="width: 100%;height: 280px"></a>
                                </div>
                                <div>
                                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${carousel[1].menuId}">
                                    <img src="${pageContext.request.contextPath}/${carousel[1].menuCover}" style="width: 100%;height: 280px"></a>
                                </div>
                                <div>
                                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${carousel[2].menuId}">
                                    <img src="${pageContext.request.contextPath}/${carousel[2].menuCover}" style="width: 100%;height: 280px"></a>
                                </div>
                                <div>
                                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${carousel[3].menuId}">
                                    <img src="${pageContext.request.contextPath}/${carousel[3].menuCover}" style="width: 100%;height: 280px"></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12" style="min-height: 160px;margin-left: 10px">
                        <div style="margin-top: 20px;margin-bottom: 10px">
                            <a href="${pageContext.request.contextPath}/work/showWorks?page=1&size=8" style="font-size: 18px;color: #5FB878;">最佳作品</a>
                        </div>
                        <div class="layui-row layui-col-space10">
                            <c:forEach items="${works}" var="work" end="3">
                                <div class="layui-col-md3">
                                    <button style="display: inline-block;line-height:0;cursor: pointer;border: none" onclick="showWorkInfo(${work.workId})">
                                        <img src="${pageContext.request.contextPath}/${work.workPhoto}" style="width: 130px;height: 100px;vertical-align:bottom;" alt="*">
                                    </button>
                                    <div style="text-align: center;margin-top: 5px">
                                        <button class="layui-btn layui-btn-primary layui-btn-xs" style="border: none;" onclick="showWorkInfo(${work.workId})">
                                            <p style="overflow: hidden;text-overflow:ellipsis;white-space: nowrap;width: 120px;font-size: 14px">${work.menuName}</p>
                                        </button>
                                    </div>
                                    <div style="text-align: center;margin-top: 5px">
                                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger layui-btn-xs" onclick="addLikes(${work.workId})">
                                            <i class="layui-icon">&#xe6c6;</i> ${work.likes}赞
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="layui-col-md12" style="min-height: 160px;margin-left: 10px">
                        <div style="margin-top: 20px;margin-bottom: 10px">
                            <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=家常菜&page=1&size=8" style="font-size: 18px;color: #5FB878;">今日推荐</a>
                        </div>
                        <div class="layui-row layui-col-space10">
                            <c:forEach items="${recommends}" var="recommend">
                                <div class="layui-col-md3">
                                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${recommend.menuId}" style="display: inline-block;line-height:0;">
                                        <img src="${pageContext.request.contextPath}/${recommend.menuCover}" style="width: 130px;height: 100px;vertical-align:bottom;" alt="*">
                                    </a>
                                    <p style="margin-top: 5px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;">${recommend.totalComplete} 做过 | <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${recommend.menuId}">${recommend.menuName}</a></p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-col-md3">
                <div class="layui-row">
                    <div class="layui-col-md12" style="min-height: 280px" >
                        <div style="text-align: center">
                            <a href="${pageContext.request.contextPath}/userInfo/kitchen?userId=${userInfo.userId}" style="display: inline-block;line-height:0;">
                                <img src="${pageContext.request.contextPath}/${userInfo.userPhoto}" style="width: 100px;height: 100px;border-radius: 50%" alt="*">
                            </a>
                        </div>
                        <div style="text-align: center;margin-top: 15px">
                                <a href="${pageContext.request.contextPath}/userInfo/kitchen?userId=${userInfo.userId}" style="font-size: 20px;">${userInfo.userName}</a>
                        </div>
                        <p style="text-align: center;margin-top: 15px;font-size: 16px">
                            <a href="${pageContext.request.contextPath}/menu/userMenu?userId=${userInfo.userId}&page=1&size=6">${totalMenu}菜谱</a>&ensp;
                            <a href="${pageContext.request.contextPath}/work/userWorks?userId=${userInfo.userId}&page=1&size=6">${totalWork}作品</a>&ensp;
                            <a href="${pageContext.request.contextPath}/collection/showCollections?userId=${userInfo.userId}&page=1&size=6">${totalCollection}收藏</a>
                        </p>
                        <div style="text-align: center;margin-top: 30px;">
                            <a href="${pageContext.request.contextPath}/menu/addMenu" class="layui-btn">写菜谱</a>
                        </div>
                    </div>
                    <div class="layui-col-md12" style="min-height: 320px">
                        <div style="margin-top: 20px;margin-bottom: 10px">
                            <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=家常菜&page=1&size=8" style="font-size: 18px;color: #5FB878;">流行菜谱</a>
                        </div>
                        <c:forEach items="${menus}" var="menu" varStatus="loop" end="7">
                            <div style="margin-top: 15px;">
                                <p style="overflow: hidden;text-overflow:ellipsis;white-space: nowrap;width: 200px;display: inline-block;font-size: 16px">
                                    ${loop.index+1}&ensp;
                                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}" style="font-size:16px;">
                                        ${menu.menuName}
                                    </a>
                                </p>
                                <span style="font-size: 16px">&ensp;${menu.totalComplete} <i class="layui-icon layui-icon-ok"></i></span>
<%--                                <fmt:formatDate value="${date3}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>--%>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--    底部--%>
    <%@include file="footer.jsp"%>
</body>
</html>
