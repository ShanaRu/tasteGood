<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/25
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
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

        layui.use('form', function(){
            var form = layui.form;
            //监听提交
            form.on('submit(formDemo)', function(){
                // layer.msg(JSON.stringify(data.field));
                // console.log(data.field);
                return false;
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
                <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/userInfo/homePage" class="myCss">首页</a></li>
                <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/menu/searchClassification?classification=家常菜&page=1&size=8" class="myCss" >菜谱</a></li>
                <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/work/showWorks?page=1&size=8" class="myCss">作品</a></li>
                <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/userInfo/kitchen?userId=<%=session.getAttribute("userId")%>" class="myCss" >我的厨房</a></li>
                <li class="layui-nav-item">
                    <form action="${pageContext.request.contextPath}/menu/searchMenu" method="post" class="layui-form">
                        <div class="layui-form-item" style="margin: 8px 0 7px 30px">
                            <div class="layui-inline">
                                <div class="layui-input-inline">
                                    <input style="display: none" name="page" value="1">
                                    <input style="display: none" name="size" value="8">
                                    <input type="text" name="searchMenuName" placeholder="请输入菜谱名称" autocomplete="off" class="layui-input">
                                </div>
                                <div class="layui-input-inline">
                                    <button class="layui-btn layui-btn-primary" lay-sumbit lay-filter="formDemo" style="padding-left: 8px;padding-right: 8px"><i class="layui-icon layui-icon-search"></i>搜索菜谱</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </li>
            </ul>
            <ul class="layui-nav layui-layout-right layui-bg-green" style="padding-right: 5%">
                <li class="layui-nav-item">
                    <a href="">
                        <img src="http://t.cn/RCzsdCq" class="layui-nav-img" alt="*">
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="${pageContext.request.contextPath}/userInfo/modifyUserInfo" >个人信息</a></dd>
                        <dd><a href="${pageContext.request.contextPath}/leaveMessage/showLeaveMessage?page=1&size=6" >我的留言</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/userInfo/exit">退出</a></li>
            </ul>
        </div>
    </div>
