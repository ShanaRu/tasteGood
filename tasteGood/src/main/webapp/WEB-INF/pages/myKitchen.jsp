<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/12
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的厨房</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script type="text/javascript">
        var workInfo={};//保存拿到的一个作品信息,全局变量
        function showWorkInfo(workId) {
            // id=workId;
            // // workInfo=works;
            // workSummary=summary;
            // photo=workPhoto;
            $.ajax({
                url:'${pageContext.request.contextPath}/work/getWork',
                data:"workId="+workId,
                dataType:'text',
                type:'post',
                async: false,
                success:function (data) {
                    // alert(data);
                    var jsondata=$.parseJSON(data);
                    workInfo.summary=jsondata.summary;
                    workInfo.workPhoto=jsondata.workPhoto;
                },
                error:function () {
                    layer.msg('获取失败');
                }
            });
            // layer.msg('hello');
            layui.use('layer', function(){
                var layer = layui.layer;
                //页面层
                layer.open({
                    type: 1,
                    title:'作品信息',
                    offset: '30px',
                    shadeClose:true,//点击遮罩可关闭弹窗
                    // skin: 'layui-layer-rim', //加上边框
                    skin:'layui-layer-molv',
                    area: ['800px', '500px'], //宽高
                    content:
                        '    <div style=\"margin:10px;min-height: 400px\" class=\"layui-row layui-col-space10\" id=\"info\">\n' +
                        '        <div class=\"layui-col-md8\">\n' +
                        '            <img id=\"showPic\" alt=\"error\" src=\"${pageContext.request.contextPath}/'+workInfo.workPhoto+'\" style=\"width:400px;height:370px;\">\n' +
                        '        </div>\n' +
                        '        <div class=\"layui-col-md4\">\n' +
                        '            <p id=\"showSummary\">'+workInfo.summary+'</p>\n' +
                        '        </div>\n' +
                        '    </div>'
                });
            });
        }

        function addLikes(workId) {
            layui.use('layer', function() {
                var layer = layui.layer;
                $.ajax({
                    url:'${pageContext.request.contextPath}/work/addLikes',
                    datatype:'text',
                    type:'post',
                    data:'workId='+workId,
                    success:function (data) {
                        if(data==="200"){
                            layer.msg('点赞成功', {icon: 1,offset:'220px'},);
                            window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                        }else{
                            layer.msg('点赞失败', {icon: 5,offset:'220px'},);
                        }
                    },
                    error:function () {
                        layer.msg('点赞失败', {icon: 5,offset:'220px'},);
                    }
                });
            });
        }

        function changePageSize() {
            //获取下拉框的值
            var pageSize = $("#changePageSize").val();

            //向服务器发送请求，改变每页显示条数
            location.href = "${pageContext.request.contextPath}/work/showWorks?page=1&size="
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
                        if(data==="200"){
                            layer.msg('关注成功', {icon: 1,offset:'220px'},);
                            window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                        }else if(data==="400"){
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
                <div style="text-align: center">
                    <a href="${pageContext.request.contextPath}/userInfo/modifyUserInfo" class="layui-btn layui-btn-primary">修改个人信息</a>
                </div>
            </c:if>
            <c:if test="${myUserId ne userInfo.userId}">
                <div style="text-align: center">
                    <button class="layui-btn layui-btn-danger" onclick="addFollow(${myUserId},${userInfo.userId})">关注</button>
                </div>
            </c:if>
            <p style="text-align: center">关注 ${follow} | 被关注 ${followed}</p>
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
            <div style="padding: 10px">
                <c:if test="${userInfo.userSex eq 1}">
                    性别 <i class="layui-icon layui-icon-female"></i>
                </c:if>
                <c:if test="${userInfo.userSex eq 2}">
                    性别 <i class="layui-icon layui-icon-male"></i>
                </c:if>
            </div>
            <div style="padding: 20px">
                简介 ${userInfo.userIntroduce}
            </div>
            <div class="layui-row layui-col-space30">
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>
                        <p style="">${userInfo.userName}的菜谱 <a href="${pageContext.request.contextPath}/menu/userMenu?userId=${userInfo.userId}&page=1&size=6" style="color: #dd3915">(查看全部菜谱)</a></p>
                    </legend>
                </fieldset>
                <c:if test="${totalMenu eq 0}">
                    <p>还没有菜谱~</p>
                </c:if>
                <c:if test="${totalMenu != 0}">
                    <c:forEach items="${userMenus}" begin="0" end="2" var="userMenu">
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
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
            <div class="layui-row layui-col-space30">
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>
                        <p style="">${userInfo.userName}的作品 <a href="${pageContext.request.contextPath}/work/userWorks?userId=${userInfo.userId}&page=1&size=6" style="color: #dd3915">(查看全部作品)</a></p>
                    </legend>
                </fieldset>
                <c:if test="${totalWork eq 0}">
                    <p>还没有作品~</p>
                </c:if>
                <c:if test="${totalWork != 0}">
                    <c:forEach items="${works}" begin="0" end="2" var="work">
                        <div class="layui-col-md4">
                            <div style="width: 240px;text-align: center;border: 1px solid #f3f3f3">
                                <button class="layui-btn layui-btn-primary" style="border: none" onclick="showWorkInfo(${work.workId})">${work.menuName}</button>
                                <button style="display: inline-block;line-height:0;cursor: pointer;border: none" onclick="showWorkInfo(${work.workId})">
                                    <img src="${pageContext.request.contextPath}/${work.workPhoto}" style="width: 240px;height: 190px;vertical-align:bottom;" alt="*">
                                </button>
                                <p style="width: 220px;margin:15px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;">${work.summary}</p>
                                <p style="margin: 15px">${work.likes} 赞 | <a href="${pageContext.request.contextPath}/userInfo/kitchen?userId=${userInfo.userId}">${userInfo.userName}</a></p>
                                <button type="button" class="layui-btn layui-btn-radius layui-btn-danger layui-btn-xs" onclick="addLikes(${work.workId})" style="margin-bottom: 15px">
                                    <i class="layui-icon">&#xe6c6;</i> 赞
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
            <div class="layui-row layui-col-space30">
                <fieldset class="layui-elem-field layui-field-title">
                    <legend>
                        <p style="">${userInfo.userName}的收藏 <a href="${pageContext.request.contextPath}/collection/showCollections?userId=${userInfo.userId}&page=1&size=6" style="color: #dd3915">(查看全部收藏)</a></p>
                    </legend>
                </fieldset>
                <c:if test="${totalCollection eq 0}">
                    <p>还没有菜谱~</p>
                </c:if>
                <c:if test="${totalCollection != 0}">
                    <c:forEach items="${collections}" begin="0" end="2" var="collection" varStatus="loop">
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
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>
    <%@include file="footer.jsp"%>

</body>
</html>
