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
                        var demoText = $('#picText');
                        demoText.html('<span style="color: #4cae4c;">上传成功</span>');
                        //将后台获取的图片地址传到前台存入隐藏控件中，随着表单一起提交
                        console.log("图片地址："+res.src);
                        document.getElementById("userPhoto").value = res.src;
                        console.log(document.getElementById("userPhoto").value);
                        return layer.msg('上传成功');
                    }
                },
                error: function(res, index, upload){
                    //演示失败状态，并实现重传
                    var demoText = $('#picText');
                    demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                    demoText.find('.demo-reload').on('click', function(){
                        uploadInst.upload();
                    });
                    return layer.msg('上传失败');
                }
            });
        });
        layui.use('form', function(){
            var  form=layui.form;
            var check =false;
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
                            // if(data=="0"){
                            //     check=true;
                            // }else if(data=="1") {
                            //     check=false;
                            // }
                        }
                    })
                    if(demo==="1"){
                        return '用户昵称已存在';  //返回值必须在这里返回 只能返回字符串,不能返回true or false
                    }
                },
                password: [
                    /^[\S]{6,12}$/
                    ,'密码必须6到12位，且不能出现空格'
                ]
            });
            //监听提交
            form.on('submit(formDemo)', function(data){
                // if(check===true){
                //     return true;
                // }else{
                //     return false;
                // }
                return true;
            });
        });
    </script>

</head>
<body style="padding: 20px;">
    <div style="width: 600px;height: 700px">
        <form class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/userInfo/saveUseInfo" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">用户昵称</label>
                <div class="layui-input-block">
                        <input type="text" name="userName" required  lay-verify="required|isExist" placeholder="请输入用户昵称" autocomplete="off"
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
                <label class="layui-form-label">单选框</label>
                <div class="layui-input-block">
                    <input type="radio" name="userSex" value="1" title="男">
                    <input type="radio" name="userSex" value="2" title="女" checked>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <input type="text" value=""  id="userPhoto" name="userPhoto" style="display: none;"><!--隐藏标签-->
                    <label class="layui-form-label" style="width: 200px;text-align: center">预览图一：</label>
                    <div class="layui-upload">
                        <div class="layui-upload-list">
                            <img class="layui-upload-img" id="showPic">
                            <p id="picText"></p>
                        </div>
                        <button type="button" class="layui-btn" id="uploadPic">上传图片</button>
                    </div>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">用户描述</label>
                <div class="layui-input-block">
                    <textarea name="userIntroduce" placeholder="请输入内容" class="layui-textarea" required lay-verify="required" lay-verify="required"></textarea>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>

</body>
</html>
