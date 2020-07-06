<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/1
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户作品</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
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
        function deleteWork(workId) {
            layui.use('layer', function(){
                var layer = layui.layer;
                layer.confirm('确定要删除该作品吗？', {
                    btn: ['确定','取消'], //按钮
                    offset:'200px'
                }, function(){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/work/deleteWork",
                        data:"workId="+workId,
                        datatype:"text",
                        type:"post",
                        success:function (data) {
                            if(data=="200"){
                                layer.msg('删除成功', {icon: 1,offset:'220px'},);
                                <%--location.href = "${pageContext.request.contextPath}/menu/userMenu";--%>
                                <%--window.setTimeout("window.location='${pageContext.request.contextPath}/work/userWorks'",2000);//延迟2秒跳转--%>
                                window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                            }else{
                                layer.msg('无法删除', {icon: 5,offset:'220px'},);
                            }
                        },
                        error:function (data) {
                            layer.msg('无法删除', {icon: 5,offset:'220px'},);
                        }
                    });
                    // layer.msg('删除成功', {icon: 1,offset:'220px'},);
                }, function(){
                    // layer.msg('删除成功', {icon: 5,offset:'220px'},);
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
        <div style="margin:20px 100px 20px 100px;min-height: 500px" class="layui-row layui-col-space10">
<%--            <input type="text" name="summary" style="display: none" id="showSummary">&lt;%&ndash;隐藏标签&ndash;%&gt;--%>
<%--            <input type="text" name="workPhoto" style="display: none" id="showPic">&lt;%&ndash;隐藏标签&ndash;%&gt;--%>
            <c:forEach items="${userWorks}" var="works">
                <div style="padding: 15px;margin-bottom: 20px" class="layui-col-md6">
                    <div class="layui-col-md6">
<%--                        <a href="" style="display: inline-block;line-height:0px;">--%>
<%--                            <img src="" style="width: 240px;height: 200px;vertical-align:bottom;">--%>
<%--                        </a>--%>
                            <button style="display: inline-block;line-height:0px;cursor: pointer;border: none" onclick="showWorkInfo(${works.workId})">
                                <img src="${pageContext.request.contextPath}/${works.workPhoto}" style="width: 240px;height: 200px;vertical-align:bottom;">
                            </button>
                    </div>
                    <div class="layui-col-md6">
                        <button class="layui-btn layui-btn-primary" style="border: none" onclick="showWorkInfo(${works.workId})"><h1>${works.menuName}</h1></button>
                        <p><i class="layui-icon">&#xe68f;</i> ${works.likes}</p>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="addLikes(${works.workId})">
                            <i class="layui-icon">&#xe6c6;</i> 赞
                        </button>
                        <a href="${pageContext.request.contextPath}/work/modifyWork?workId=${works.workId}" class="layui-btn">修改</a>
                        <button class="layui-btn" onclick="deleteWork(${works.workId})">删除</button>
                    </div>
                </div>
            </c:forEach>
        </div>
<%--    <div style="margin:10px;min-height: 400px" class="layui-row layui-col-space10" id="info" style="display: none">--%>
<%--        <div class="layui-col-md8">--%>
<%--            <img id="showPic" alt="error" src="${pageContext.request.contextPath}/">--%>
<%--        </div>--%>
<%--        <div class="layui-col-md4">--%>
<%--            <p id="showSummary"></p>--%>
<%--        </div>--%>
<%--    </div>--%>
    <%@include file="footer.jsp"%>

</body>
</html>
