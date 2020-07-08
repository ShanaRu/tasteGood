<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/23
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        var workInfo=new Object();//保存拿到的一个作品信息,全局变量
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
                        if(data=="200"){
                            layer.msg('点赞成功', {icon: 1,offset:'220px'},);
                            window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                        }else{
                            layer.msg('点赞失败', {icon: 5,offset:'220px'},);
                        }
                    },
                    error:function (data) {
                        layer.msg('点赞失败', {icon: 5,offset:'220px'},);
                    }
                });
            });
        }
    </script>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 500px">
        <div class="layui-row layui-col-space30">
            <div class="layui-col-md2" style="min-height: 480px;">
                <div style="text-align: center;margin-top: 10px;margin-bottom: 10px"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=家常菜"><h2>家常菜</h2></a></div>
                <div style="text-align: center;margin-top: 10px;margin-bottom: 10px"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=地方特色菜"><h2>地方特色菜</h2></a></div>
                <div style="text-align: center;margin-top: 10px;margin-bottom: 10px"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=甜点/面食"><h2>甜点/面食</h2></a></div>
                <div style="text-align: center;margin-top: 10px;margin-bottom: 10px"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=快餐"><h2>快餐</h2></a></div>
                <div style="text-align: center;margin-top: 10px;margin-bottom: 10px"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=中式"><h2>中式</h2></a></div>
                <div style="text-align: center;margin-top: 10px;margin-bottom: 10px"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=西式"><h2>西式</h2></a></div>
                <div style="text-align: center;margin-top: 10px;margin-bottom: 10px"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=日韩料理"><h2>日韩料理</h2></a></div>
                <div style="text-align: center;margin-top: 10px;margin-bottom: 10px"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=其他"><h2>其他</h2></a></div>
            </div>
            <div class="layui-col-md7">
                <div class="layui-row">
                    <div class="layui-col-md12" style="min-height: 160px" >
                        <div class="layui-carousel" id="test1">
                            <div carousel-item>
                                <div>条目1</div>
                                <div>条目2</div>
                                <div>条目3</div>
                                <div>条目4</div>
                                <div>条目5</div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12" style="min-height: 160px;margin-top: 20px;margin-left: 10px">
                        <a href="${pageContext.request.contextPath}/work/showWorks" style="font-size: 14px;color: #5FB878">最佳作品</a>
                        <div class="layui-row layui-col-space10">
                            <c:forEach items="${works}" var="work" end="3">
                                <div class="layui-col-md3">
                                    <button style="display: inline-block;line-height:0px;cursor: pointer;border: none" onclick="showWorkInfo(${work.workId})">
                                        <img src="${pageContext.request.contextPath}/${work.workPhoto}" style="width: 130px;height: 100px;vertical-align:bottom;">
                                    </button>
                                    <button class="layui-btn layui-btn-primary layui-btn-xs" style="border: none" onclick="showWorkInfo(${work.workId})">${work.menuName}</button>
                                    <button type="button" class="layui-btn layui-btn-radius layui-btn-danger layui-btn-xs" onclick="addLikes(${work.workId})">
                                        <i class="layui-icon">&#xe6c6;</i> ${work.likes}赞
                                    </button>
                                </div>
<%--                                ${work.menuName}--%>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="layui-col-md12" style="min-height: 160px">
                        内部列
                    </div>
                </div>
            </div>
            <div class="layui-col-md3">
                <div class="layui-row">
                    <div class="layui-col-md12" style="min-height: 280px" >
                        <img src="${pageContext.request.contextPath}/${userInfo.userPhoto}" style="width: 50px;height: 50px">
                        <p><a href="">${userInfo.userName}</a></p>
                        <p><a href="${pageContext.request.contextPath}/work/userWorks">${totalWork}作品</a></p>
                        <p><a href="${pageContext.request.contextPath}/collection/showCollections">${totalCollection}收藏</a></p>
                        <p><a href="${pageContext.request.contextPath}/menu/userMenu">${totalMenu}菜谱</a></p>
                        <a href="${pageContext.request.contextPath}/menu/addMenu" class="layui-btn">写菜谱</a>
                    </div>
                    <div class="layui-col-md12" style="min-height: 320px">
                        <a href=""><h3>流行菜谱</h3></a>
                        <c:forEach items="${menus}" var="menu" varStatus="loop">
                            <div>
                                <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}" style="font-size: 20px">${menu.menuName}</a>
                                    ${collections[loop.count-1].complete}<i class="layui-icon layui-icon-star"></i>
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
