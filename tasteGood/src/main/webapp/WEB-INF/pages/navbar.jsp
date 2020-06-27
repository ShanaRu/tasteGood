<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/25
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <script type="text/javascript">
        window.onload=function(){
            $(document).ready(function () {
                $("span.layui-nav-bar").remove();
                $(".layui-nav-item a").unbind();
            })
        };
        layui.use('element', function(){
            var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
            //监听导航点击
            element.on('nav(demo)', function(elem){
                //console.log(elem)
                layer.msg(elem.text());
            });
        });
    </script>
    <style type="text/css">
        .myCss{
            font-size: 16px;
        }
    </style>

    <div class="layui-layout layui-layout-admin">
        <div class="layui-header layui-bg-green">
            <div class="layui-logo layui-bg-green" style="padding-left: 1%"><a href="${pageContext.request.contextPath}/userInfo/homePage" style="font-size: 27px;color: #ffe152">味食荟</a></div>
            <!-- 头部区域（可配合layui已有的水平导航） -->
            <ul class="layui-nav layui-layout-left layui-bg-green">
                <li class="layui-nav-item layui-this"><a href="${pageContext.request.contextPath}/userInfo/homePage" class="myCss">首页</a></li>
                <li class="layui-nav-item"><a href="" class="myCss" >菜谱</a></li>
                <li class="layui-nav-item"><a href="" class="myCss" >菜单系列</a></li>
                <li class="layui-nav-item"><a href="" class="myCss">作品</a></li>
                <li class="layui-nav-item">
                    <form action="" method="post" class="layui-form">
                        <label class="layui-form-label myCss" style="">搜索</label>
                        <div class="layui-input-block">
                            <input type="text" name="searchMenuName" placeholder="请输入菜谱名称" autocomplete="off" class="layui-input myCss">
                        </div>
                    </form>
                </li>
            </ul>
<%--            <ul class="layui-nav layui-layout-right layui-bg-green" style="padding-right: 5%;height: 60px">--%>
<%--                <li class="layui-nav-item">--%>
<%--                    <a href="" ><img src="//t.cn/RCzsdCq" class="layui-nav-img" alt="*" target="useriframe"></a>--%>
<%--                    <dl class="layui-nav-child">--%>
<%--                        <dd><a href="javascript:;" >我的主页</a></dd>--%>
<%--                        <dd><a href="javascript:;" >个人信息</a></dd>--%>
<%--                        <dd><a href="javascript:;" >我的菜谱</a></dd>--%>
<%--                        <dd><a href="javascript:;" >我的收藏</a></dd>--%>
<%--                        <dd><a href="javascript:;" >退出</a></dd>--%>
<%--                    </dl>--%>
<%--                </li>--%>
<%--            </ul>--%>
            <ul class="layui-nav layui-layout-right layui-bg-green" style="padding-right: 5%">
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" >我的主页</a></dd>
                        <dd><a href="javascript:;" >个人信息</a></dd>
                        <dd><a href="${pageContext.request.contextPath}/menu/userMenu" >我的菜谱</a></dd>
                        <dd><a href="javascript:;" >我的收藏</a></dd>
<%--                        <dd><a href="javascript:;" >退出</a></dd>--%>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/">退出</a></li>
            </ul>
        </div>
    </div>
