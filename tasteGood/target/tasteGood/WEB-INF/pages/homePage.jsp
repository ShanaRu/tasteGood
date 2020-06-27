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
    </script>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 500px">
        <div class="layui-row layui-col-space30">
            <div class="layui-col-md2" style="min-height: 480px">
                <p>分类栏</p>
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
                    <div class="layui-col-md12" style="min-height: 160px">
                        内部列
                    </div>
                    <div class="layui-col-md12" style="min-height: 160px">
                        内部列
                    </div>
                </div>
            </div>
            <div class="layui-col-md3">
                <div class="layui-row">
                    <div class="layui-col-md12" style="min-height: 280px" >
                        <a href="${pageContext.request.contextPath}/menu/addMenu" class="layui-btn">写菜谱</a>
                    </div>
                    <div class="layui-col-md12" style="min-height: 160px">
                        内部列
                    </div>
                    <div class="layui-col-md12" style="min-height: 160px">
                        内部列
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--    底部--%>
    <%@include file="footer.jsp"%>
</body>
</html>
