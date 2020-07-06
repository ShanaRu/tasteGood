<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/2
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>作品模块</title>
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
        <c:forEach items="${works}" var="work">
            <div class="layui-col-md4">
                <div>
<%--                    <img src="${pageContext.request.contextPath}/${work.workPhoto}" style="height: 280px;width: 278px">--%>
                    <button style="display: inline-block;line-height:0px;cursor: pointer;border: none" onclick="showWorkInfo(${work.workId})">
                        <img src="${pageContext.request.contextPath}/${work.workPhoto}" style="width: 280px;height: 278px;vertical-align:bottom;">
                    </button>
                </div>
                <div style="margin-top: 15px">
<%--                    <h1>${work.menuName}</h1>--%>
                    <button class="layui-btn layui-btn-primary" style="border: none" onclick="showWorkInfo(${work.workId})"><h1>${work.menuName}</h1></button>
                    <button type="button" class="layui-btn layui-btn-radius layui-btn-danger" onclick="addLikes(${work.workId})">
                        <i class="layui-icon">&#xe6c6;</i> 赞
                    </button>
                </div>
                <div><p style="width: 260px;margin:5px;text-overflow:ellipsis;overflow: hidden;">${work.summary}</p></div>
                <div><i class="layui-icon">&#xe68f;</i> ${work.likes}</div>
            </div>
        </c:forEach>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
