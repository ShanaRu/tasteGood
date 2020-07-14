<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/21
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<%--    <script type="text/javascript">--%>
<%--        //一般直接写在一个js文件中--%>
<%--        layui.use(['layer', 'form'], function(){--%>
<%--            var layer = layui.layer,form = layui.form;--%>
<%--            layer.msg('Hello World');--%>
<%--        });--%>
<%--    </script>--%>
    <script type="text/javascript">
        layui.use('form', function(){
            var  form=layui.form;
            //自定义验证规则
            form.verify({
                username: [
                    /^[\S]{1,10}$/
                    ,'用户名必须1到10位，且不能出现空格'
                ],
                password: [
                    /^[\S]{6,12}$/
                    ,'密码必须6到12位，且不能出现空格'
                ]
            });
            //监听提交
            form.on('submit(registerForm)', function(data){
                $.ajax({
                    url:'${pageContext.request.contextPath}/userInfo/userSignIn',
                    data:data.field,
                    dataType:'text',
                    type:'post',
                    // async: false,
                    success:function (data) {
                        if (data == '1'){
                            location.href = "${pageContext.request.contextPath}/userInfo/homePage";//跳转主页
                        }else{
                            layer.msg('登录名或密码错误');
                        }
                    },
                    error:function () {
                        layer.msg('提交失败');
                    }
                })
                return false;
            });
        });
    </script>

    <style type="text/css">
        .center {
            width:400px;
            height:200px;
            position:absolute;
            background: #f3f3f3;
            left:50%;
            top:50%;
            margin: -150px 0 0 -200px;
            border: 1px solid #f3f3f3;
        }
    </style>
</head>
<body style="background-image:url('${pageContext.request.contextPath}/picture/background.png') ;">
    <div class="center">
        <form class="layui-form layui-form-pane" action="userInfo/userSignIn" method="post" style="margin-top: 30px;margin-left: 40px">
            <div class="layui-form-item">
                <label class="layui-form-label">用户昵称</label>
                <div class="layui-input-inline">
                    <input type="username" name="userName" required  lay-verify="username" placeholder="请输入用户昵称" autocomplete="off" class="layui-input">
                </div>
                <i class="layui-icon layui-icon-username" style="font-size: 30px; color: #1E9FFF;"></i>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">用户密码</label>
                <div class="layui-input-inline">
                    <input type="password" name="userPassword" required lay-verify="password" placeholder="请输入密码" autocomplete="off" class="layui-input" id="user_password">
                </div>
                <i class="layui-icon layui-icon-password" style="font-size: 30px; color: #1E9FFF;"></i>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="registerForm">登录</button>
                    <a href="userInfo/registerForm" class="layui-btn">注册</a>
                </div>
            </div>
        </form>
    </div>

</body>
</html>
