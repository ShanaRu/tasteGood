<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/2
  Time: 22:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改账户信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
        //注意：选项卡 依赖 element 模块，否则无法进行功能性操作
        layui.use('element', function(){
            var element = layui.element;
            element.on('tab(test)', function(data){
                // console.log(data);
            });

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
                            // demoText.html('<span style="color: #4cae4c;">上传成功</span>');
                            //将后台获取的图片地址传到前台存入隐藏控件中，随着表单一起提交
                            // console.log("图片地址："+res.src);
                            document.getElementById("userPhoto").value = res.src;
                            // console.log(document.getElementById("userPhoto").value);
                            return layer.msg('上传成功');
                        }
                    },
                    error: function(res, index, upload){
                        //演示失败状态，并实现重传
                        // var demoText = $('#picText');
                        // demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                        // demoText.find('.demo-reload').on('click', function(){
                        //     uploadInst.upload();
                        // });
                        return layer.msg('上传失败');
                    }
                });
            });

            layui.use('form',function () {
                var  form=layui.form;
                form.verify({
                    isExist:function(value){
                        let username=document.getElementById("user_name").value;
                        let name=document.getElementById("temp").value;
                        let message;
                        if(username!==name){//名称没有改才进行查重
                            $.ajax({
                                url:'${pageContext.request.contextPath}/userInfo/userNameIsExist',
                                type: "post",
                                data:"userName="+username,
                                async: false,//必须同步才可以先调用检验再进行表单提交
                                success: function(data) {
                                    message=data;
                                }
                            })
                            if(message==="1"){
                                return '用户昵称已存在';  //返回值必须在这里返回 只能返回字符串,不能返回true or false
                            }
                        }
                    },
                    isOld:function(value){
                        let oldPassword=document.getElementById("oldPassword").value;
                        console.log(oldPassword);
                        let tempPassword=document.getElementById("tempPassword").value;
                        console.log(tempPassword);
                        if(!/^[\S]{3,12}$/.test(value)){
                            return '密码必须3到12位，且不能出现空格';
                        }
                        if(oldPassword===tempPassword){
                            // layer.msg("匹配");
                        }else{
                            // layui.msg("与旧密码不匹配");
                            return '与旧密码不匹配';
                        }
                    },
                    isNew:function(value){
                        let newPassword=document.getElementById("newPassword").value;
                        console.log(newPassword);
                        let userPassword=document.getElementById("userPassword").value;
                        console.log(userPassword);
                        if(!/^[\S]{3,12}$/.test(value)){
                            return '密码必须3到12位，且不能出现空格';
                        }
                        if(newPassword===userPassword){
                            // layer.msg("匹配");
                        }else{
                            // layui.msg("两次输入不相同");
                            return '两次输入不相同';
                        }
                    },
                    password: [
                        /^[\S]{3,12}$/
                        ,'密码必须3到12位，且不能出现空格'
                    ]
                });
                //监听提交
                // form.on('submit(formDemo)', function(data){
                //     layer.msg(JSON.stringify(data.field));
                //     return true;
                // });

            });
        });
    </script>
</head>
<body>
    <%@include file="navbar.jsp"%>
        <div style="margin:20px 100px 20px 100px;min-height: 500px" class="layui-row layui-col-space10">
            <div class="layui-tab" lay-filter="test">
                <ul class="layui-tab-title">
                    <li class="layui-this">基本信息</li>
                    <li>修改密码</li>
                    <li>设置头像</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">

                        <form class="layui-form" action="${pageContext.request.contextPath}/userInfo/updateUserInfo" method="post" style="margin-top: 50px;width: 500px">
                            <div class="layui-form-item">
                                <label class="layui-form-label">用户昵称</label>
                                <div class="layui-input-block">
                                    <input type="text" name="userName" required  lay-verify="required|isExist" placeholder="请输入用户昵称" autocomplete="off"
                                           class="layui-input" id="user_name" value="${userInfo.userName}">
                                    <input style="display: none" value="${userInfo.userId}" name="userId">
                                    <input style="display:none;" id="temp" value="${userInfo.userName}"><%--用来保存拿到的userName--%>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">单选框</label>
                                <div class="layui-input-block">
                                    <c:if test="${userInfo.userSex eq 2}">
                                        <input type="radio" name="userSex" value="1" title="男">
                                        <input type="radio" name="userSex" value="2" title="女" checked>
                                    </c:if>
                                    <c:if test="${userInfo.userSex eq 1}">
                                        <input type="radio" name="userSex" value="1" title="男" checked>
                                        <input type="radio" name="userSex" value="2" title="女">
                                    </c:if>
                                </div>
                            </div>
                            <div class="layui-form-item layui-form-text">
                                <label class="layui-form-label">用户描述</label>
                                <div class="layui-input-block">
                                    <textarea name="userIntroduce" placeholder="请输入内容" class="layui-textarea" required lay-verify="required">${userInfo.userIntroduce}</textarea>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit lay-filter="formDemo">保存</button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="layui-tab-item">
                        <form class="layui-form" action="${pageContext.request.contextPath}/userInfo/updateUserPassword" style="margin-top: 50px;width: 500px;" method="post">
                            <div class="layui-form-item">
                                <label class="layui-form-label">旧密码</label>
                                <div class="layui-input-block">
                                    <input type="text" name="oldPassword" required  lay-verify="require|isOld" placeholder="请输入旧密码" autocomplete="off"
                                           class="layui-input" id="oldPassword">
                                    <input style="display:none;" id="tempPassword" value="${userInfo.userPassword}"><%--用来保存拿到的userPassword--%>
                                    <input style="display: none" value="${userInfo.userId}" name="userId">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">新密码</label>
                                <div class="layui-input-block">
                                    <input type="text" required  lay-verify="required|Password" placeholder="请输入新密码" autocomplete="off"
                                           class="layui-input" id="newPassword">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">确认新密码</label>
                                <div class="layui-input-block">
                                    <input type="text" name="userPassword" required  lay-verify="isNew|required" placeholder="请再次输入确认新密码" autocomplete="off"
                                           class="layui-input" id="userPassword">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit lay-filter="password">保存</button>
                                </div>
                            </div>
                        </form>


                    </div>
                    <div class="layui-tab-item">

                        <form class="layui-form" action="${pageContext.request.contextPath}/userInfo/updateUserPhoto" style="margin-top: 50px;width: 500px;" method="post">
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <input type="text" value=""  id="userPhoto" name="userPhoto" style="display: none;"><!--隐藏标签-->
<%--                                    <label class="layui-form-label" style="width: 200px;text-align: center">预览图一：</label>--%>
                                    <input style="display: none" value="${userInfo.userId}" name="userId"><!--隐藏标签-->
                                    <div class="layui-upload">
                                        <div class="layui-upload-list">
                                            <div class="layui-col-md7">
                                                <img class="layui-upload-img" id="showPic" style="width: 200px;height: 200px" src="${pageContext.request.contextPath}/${userInfo.userPhoto}" alt="*">
                                            </div>
                                            <div class="layui-col-md5">
                                                <button type="button" class="layui-btn" id="uploadPic">上传图片</button>
                                            </div>
<%--                                            <p id="picText"></p>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit lay-filter="photo">更新</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    <%@include file="footer.jsp"%>
</body>
</html>
