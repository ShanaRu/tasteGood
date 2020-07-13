<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/27
  Time: 17:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
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
    </script>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:30px 100px 20px 100px;min-height: 500px">
        <div style="margin-bottom: 20px">
            <span class="layui-breadcrumb">
                <a href="${pageContext.request.contextPath}/userInfo/homePage">首页</a>
                <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}"><cite>${menu.menuName}</cite></a>
            </span>
        </div>
        <div class="layui-row layui-col-space30">
            <div class="layui-col-md8">
                <h2 style="font-size: 25px;">${menu.menuName}</h2>
                <div style="margin: 20px;">
                    ${menu.collection}&ensp;收藏&ensp;<button type="button" class="layui-btn" onclick="addCollection(${menu.menuId})">收藏</button>
                    <a href="${pageContext.request.contextPath}/work/addWork?menuId=${menu.menuId}&menuName=${menu.menuName}" class="layui-btn layui-btn-danger">上传你的作品${menu.menuName}</a>
                </div>
                <img src="${pageContext.request.contextPath}/${menu.menuCover}" style="width: 500px;height: 300px;" alt="*">

<%--                <p>${menu.collection}收藏</p>--%>
                <p>${menu.classification}</p>
                <p>${menu.menuDetail}</p>
                <c:forEach items="${menu.ingredients}" var="ingredient">
                    <div class="layui-col-md6">
                        ${ingredient.ingredient}
                    </div>
                    <div class="layui-col-md6">
                        ${ingredient.dosage}
                    </div>
                </c:forEach>
                <c:forEach items="${menu.steps}" var="s">
                    <div class="layui-col-md6">
                            ${s.step}
                    </div>
                    <div class="layui-col-md6">
                        <img src="${pageContext.request.contextPath}/${s.stepChar}" style="width: 200px;height: 200px;" alt="*">
                    </div>
                </c:forEach>
                <p>${menu.tip}</p>
                <div style="text-align: center">
<%--    <a href="${pageContext.request.contextPath}/work/addWork" class="layui-btn">上传你的作品${menu.menuName}</a>--%>

                </div>
                <div >
                    <form class="layui-form" action="${pageContext.request.contextPath}/leaveMessage/addLeaveMessage" method="post">
                        <div class="layui-form-item layui-form-text">
                            <label class="layui-form-label">留言区</label>
                            <div class="layui-input-block">
                                <textarea placeholder="请输入留言" class="layui-textarea" name="leaveWord"></textarea>
                                <input style="display: none" value="${menu.menuId}" name="menuId">
                                <input style="display: none" value="${menu.menuName}" name="menuName">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn">立即提交</button>
                            </div>
                        </div>
                    </form>
                </div>
                <c:forEach items="${leaveMessages}" var="leaveMessage" varStatus="loop">
                    <div style="margin: 5px" class="layui-row layui-col-space30">
                        <div class="layui-col-md2" style="text-align: center">
                            <img src="${pageContext.request.contextPath}/${userInfos[loop.count-1].userPhoto}" alt="*" style="width: 50px;height: 50px;border-radius:50%;">
                        </div>
                        <div class="layui-col-md10">
                            <p>${userInfos[loop.count-1].userName}</p>
                            <p>${leaveMessage.leaveWord}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="layui-col-md4" style="min-height: 480px">
                <p style="text-align: center">推荐菜谱</p>
                <c:forEach items="${menus}" var="recommend">
                    <div style="margin: 20px;text-align: center">
                        <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${recommend.menuId}" style="display: inline-block;line-height:0;">
                            <img src="${pageContext.request.contextPath}/${recommend.menuCover}" style="width: 180px;height: 150px;vertical-align:bottom;" alt="*">
                        </a>
                        <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${recommend.menuId}"><h5 style="margin-top: 10px">${recommend.menuName}</h5></a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
