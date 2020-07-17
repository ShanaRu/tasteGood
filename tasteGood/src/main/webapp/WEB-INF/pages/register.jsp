<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/21
  Time: 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
        layui.use('upload', function(){
            var $ = layui.jquery
                ,upload = layui.upload;

            //普通图片上传
            var uploadInst = upload.render({
                elem: '#uploadPic'
                ,url: '${pageContext.request.contextPath}/images/upload'
                ,accept: 'images'
                ,size: '1024*5'
                ,before: function(obj){
                    //预读本地文件示例
                    obj.preview(function(index, file, result){
                        $('#showPic').attr('src', result);
                    });
                }
                ,done: function(res, index, upload){
                    //如果上传失败
                    if(res.code != 0){
                        return layer.msg('上传失败');
                    }
                    //上传成功
                    if(res.code == 0){
                        document.getElementById("userPhoto").value = res.src;
                        return layer.msg('上传成功');
                    }
                },
                error: function(res, index, upload){
                    return layer.msg('上传失败');
                }
            });
        });
        layui.use('form', function(){
            var  form=layui.form;
            //自定义验证规则
            form.verify({
                isExist:function(value){
                    let username=document.getElementById("user_name").value;
                    let demo;
                    $.ajax({
                        url:'${pageContext.request.contextPath}/userInfo/userNameIsExist',
                        type: "post",
                        data:"userName="+username,
                        async: false,//必须同步才可以先调用检验再进行表单提交
                        success: function(data) {
                            demo=data;
                        }
                    })
                    if(demo=="1"){
                        return '用户昵称已存在';  //返回值必须在这里返回 只能返回字符串,不能返回true or false
                    }
                },
                password: [
                    /^[\S]{6,12}$/
                    ,'密码必须6到12位，且不能出现空格'
                ],
                // checkUserName:function () {
                //    ^.{3,6}$
                // }
                checkUserName: [
                    /^.{1,10}$/
                    ,'昵称必须1到10位，且不能出现空格'
                ],
                checkIntroduce:[
                    /^.{1,140}$/
                    ,'用户描述不可超过140长度'
                ],
            });
            //监听提交
            // form.on('submit(formDemo)', function(data){
            //     return true;
            // });
        });
    </script>

    <style type="text/css">
        .center {
            width:400px;
            height:550px;
            position:absolute;
            background: #f3f3f3;
            left:50%;
            top:50%;
            margin: -275px 0 0 -200px;
            border: 1px solid #f3f3f3;
        }
    </style>

</head>
<body style="background-image:url('${pageContext.request.contextPath}/picture/background.png') ;">
    <div class="center">
        <form class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/userInfo/saveUseInfo" method="post" style="margin: 30px">
            <div class="layui-form-item">
                <label class="layui-form-label">用户昵称</label>
                <div class="layui-input-block">
                        <input type="text" name="userName" required  lay-verify="required|isExist|checkUserName" placeholder="请输入用户昵称" autocomplete="off"
                                class="layui-input" id="user_name">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密码</label>
                <div class="layui-input-block">
                    <input type="password" name="userPassword" required lay-verify="password" placeholder="请输入用户密码" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" pane>
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="userSex" value="1" title="男">
                    <input type="radio" name="userSex" value="2" title="女" checked>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <input type="text" value="picture/logocooker.png"  id="userPhoto" name="userPhoto" style="display: none;"><!--隐藏标签-->
                    <div class="layui-upload">
                        <div class="layui-upload-list">
                            <button type="button" class="layui-btn" id="uploadPic">上传头像</button>
                            <img class="layui-upload-img" id="showPic" style="width: 100px;height: 100px;margin-left: 30px;">
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">用户描述</label>
                <div class="layui-input-block">
                    <textarea name="userIntroduce" placeholder="请输入内容" class="layui-textarea" required lay-verify="required|checkIntroduce" lay-verify="required"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit>注册</button>
                    <a href="${pageContext.request.contextPath}/" class="layui-btn layui-btn-primary">返回</a>
                </div>
            </div>
        </form>
    </div>

</body>
</html>
