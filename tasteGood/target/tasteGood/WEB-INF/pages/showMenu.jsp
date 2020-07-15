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
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <%@include file="workMethod.jsp"%>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:30px 100px 20px 100px;min-height: 500px">
        <div style="margin-bottom: 20px">
            <span class="layui-breadcrumb">
                <a href="${pageContext.request.contextPath}/userInfo/homePage">首页</a>
                <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}"><cite>${menu.menuName}(${menu.classification})</cite></a>
            </span>
        </div>
        <div class="layui-row layui-col-space30">
            <div class="layui-col-md8">
                <div style="margin-left: 50px;width: 640px">
                    <h2 style="font-size: 25px;margin-bottom: 20px">${menu.menuName}</h2>
                    <img src="${pageContext.request.contextPath}/${menu.menuCover}" style="width: 640px;height: 420px;" alt="*">
                    <p style="margin: 20px 0 20px 0;font-size: 16px">${menu.menuDetail}</p>
                    <div style="margin: 20px 0 20px 0;">
                        <a style="font-size: 16px" href="${pageContext.request.contextPath}/userInfo/kitchen?userId=${menuUser.userId}">
                            <img src="${pageContext.request.contextPath}/${menuUser.userPhoto}" style="width: 60px;height: 60px;vertical-align:bottom;border-radius:50%;" alt="*">
                            <p style="line-height: 60px;display: inline-block">&nbsp;${menuUser.userName}</p>
                        </a>
                        <div style="display: inline-block;float: right;">
                            <p style="display:block;font-size: 16px;line-height: 60px">${menu.totalComplete}&ensp;次打卡&ensp;|&ensp;${menu.collection}&ensp;收藏&ensp;
                                <button type="button" class="layui-btn layui-btn-danger" onclick="addCollection(${menu.menuId})">收藏</button>
                            </p>
                        </div>
                    </div>
                    <div style="margin: 20px 0 20px 0;">
                        <h3 style="margin-bottom: 20px">材料</h3>
                        <table class="layui-table">
                            <colgroup>
                                <col width="320">
                                <col width="320">
                            </colgroup>
                            <thead>
                            <tr>
                                <th style="font-size: 16px">食材</th>
                                <th style="font-size: 16px">用量</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${menu.ingredients}" var="ingredient">
                                <tr>
                                    <td style="font-size: 16px">${ingredient.ingredient}</td>
                                    <td style="font-size: 16px">${ingredient.dosage}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div style="margin: 20px 0 20px 0;">
                        <h3 style="margin-bottom: 20px">步骤</h3>
                        <table class="layui-table">
                            <colgroup>
                                <col width="20">
                                <col width="300">
                                <col width="320">
                            </colgroup>
                            <thead>
                            <tr>
                                <th style="font-size: 16px">顺序</th>
                                <th style="font-size: 16px">食材</th>
                                <th style="font-size: 16px">用量</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${menu.steps}" var="s" varStatus="loop">
                                <tr>
                                    <td style="font-size: 16px">${loop.index+1}</td>
                                    <td style="font-size: 16px">${s.step}</td>
                                    <td style="font-size: 16px"><img src="${pageContext.request.contextPath}/${s.stepChar}" style="width: 250px;height: 200px;max-width: 250px" alt="*"></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <p style="margin: 20px 0 40px 0;font-size: 16px"><i class="layui-icon layui-icon-note">&ensp;小提示&ensp;</i>&ensp;${menu.tip}</p>
                    <div>
                        <form class="layui-form" action="${pageContext.request.contextPath}/leaveMessage/addLeaveMessage" method="post">
                            <div class="layui-form-item layui-form-text">
                                <label class="layui-form-label">留言区</label>
                                <div class="layui-input-block">
                                    <textarea placeholder="请输入留言" class="layui-textarea" name="leaveWord" required lay-verify="required"></textarea>
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
                        <c:forEach items="${leaveMessages}" var="leaveMessage" varStatus="loop">
                            <div class="layui-row layui-col-space10">
                                <div class="layui-col-md2" style="text-align: center;margin-bottom: 10px;">
                                    <a href="${pageContext.request.contextPath}/userInfo/kitchen?userId=${userInfos[loop.count-1].userId}">
                                        <img src="${pageContext.request.contextPath}/${userInfos[loop.count-1].userPhoto}" alt="*" style="width: 60px;height: 60px;border-radius:50%;">
                                        <p style="margin-top: 5px;">${userInfos[loop.count-1].userName}</p>
                                    </a>
                                </div>
                                <div class="layui-col-md10" style="margin-bottom: 10px;">
                                    <p style="margin-bottom: 10px;">#&ensp;<fmt:formatDate value="${leaveMessage.leaveTime}" pattern="yyyy-MM-dd"/>&ensp;#发表</p>
                                    <p>${leaveMessage.leaveWord}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="layui-col-md4" style="min-height: 480px">
                <div style="margin: 20px 0 20px 0;text-align: center">
                    <a href="${pageContext.request.contextPath}/work/addWork?menuId=${menu.menuId}&menuName=${menu.menuName}" class="layui-btn layui-btn-danger">
                        <h4>上传你的作品#&ensp;${menu.menuName}&ensp;#</h4>
                    </a>
                </div>
                <c:if test="${menuWork != null}">
                    <p style="text-align: center;font-size: 18px"><i class="layui-icon layui-icon-praise"></i>&ensp;大家参照这个菜谱做出的作品</p>
                    <c:forEach items="${menuWork}" var="work">
                        <div style="margin: 20px;text-align: center">
                            <button style="display: inline-block;line-height:0;cursor: pointer;border: none" onclick="showWorkInfo(${work.workId})">
                                <img src="${pageContext.request.contextPath}/${work.workPhoto}" style="width: 210px;height: 180px;vertical-align:bottom;" alt="*">
                            </button>
                            <h5 style="margin-top: 10px">${work.menuName}</h5>
                            <p style="text-align: center;margin-top: 5px">
                                    ${work.likes} 赞 |
                                <button type="button" class="layui-btn layui-btn-radius layui-btn-danger layui-btn-xs" onclick="addLikes(${work.workId})">
                                    <i class="layui-icon">&#xe6c6;</i> 赞
                                </button>
                            </p>
                        </div>
                    </c:forEach>
                </c:if>
                <p style="text-align: center;font-size: 18px"><i class="layui-icon layui-icon-tabs"></i>&ensp;推荐菜谱</p>
                <c:forEach items="${menus}" var="recommend">
                    <div style="margin: 20px;text-align: center">
                        <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${recommend.menuId}" style="display: inline-block;line-height:0;">
                            <img src="${pageContext.request.contextPath}/${recommend.menuCover}" style="width: 210px;height: 180px;vertical-align:bottom;" alt="*">
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
