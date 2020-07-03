<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/1
  Time: 22:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改作品</title>
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
                        console.log("图片地址："+res.src);
                        document.getElementById("workPhoto").value = res.src;
                        console.log(document.getElementById("workPhoto").value);
                        return layer.msg('上传成功');
                    }
                },
                error: function(res, index, upload){
                    return layer.msg('上传失败');
                }
            });
        });
    </script>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 500px">
        <div class="layui-row layui-col-space30">
            <div class="layui-col-md9">
                <form class="layui-form" method="post" action="${pageContext.request.contextPath}/work/updateWork">
                    <input type="text" name="menuId" value="${work.menuId}" style="display: none">
                    <input type="text" name="menuName" value="${work.menuName}" style="display: none">
                    <input type="text" name="workId" value="${work.workId}" style="display: none">
                    <input type="text" name="userId" value="${work.userId}" style="display: none">
                    <div class="layui-form-item">
                        <label class="layui-form-label">作品照片</label>
                        <div class="layui-input-block">
                            <input type="text" value="${work.workPhoto}"  id="workPhoto" name="workPhoto" style="display: none;"><!--隐藏标签-->
                            <button type="button" class="layui-btn" id="uploadPic">上传作品照片</button>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <img class="layui-upload-img " id="showPic" style="width: 660px;height: 400px;" src="${pageContext.request.contextPath}/${work.workPhoto}">
                        </div>
                    </div>
                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">心得描述</label>
                        <div class="layui-input-block">
                            <textarea name="summary" id="summary" placeholder="请输入心得总结" class="layui-textarea" required lay-verify="required">${work.summary}</textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn">保存</button>
                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="layui-col-md3">
                <p>展示</p>
            </div>
        </div>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
