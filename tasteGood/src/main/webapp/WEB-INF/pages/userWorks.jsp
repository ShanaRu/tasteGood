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
        var id;
        var workSummary;
        var photo;
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
                    // console.log(document.getElementById("showPic").src);
                    // var path=document.getElementById("showPic").src;
                    // document.getElementById("showPic").src=path+workInfo.workPhoto;
                    // document.getElementById("showSummary").innerText=workInfo.summary;
                    // console.log(document.getElementById("showSummary").innerText);
                    // console.log(document.getElementById("showPic").src);
                    // console.log(workInfo);

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
                    skin: 'layui-layer-rim', //加上边框
                    area: ['800px', '500px'], //宽高
                    content:
                        '    <div style=\"margin:10px;min-height: 400px\" class=\"layui-row layui-col-space10\" id=\"info\">\n' +
                        '        <div class=\"layui-col-md8\">\n' +
                        '            <img id=\"showPic\" alt=\"error\" src=\"${pageContext.request.contextPath}/'+workInfo.workPhoto+'\">\n' +
                        '        </div>\n' +
                        '        <div class=\"layui-col-md4\">\n' +
                        '            <p id=\"showSummary\">'+workInfo.summary+'</p>\n' +
                        '        </div>\n' +
                        '    </div>'
                    <%--success: function(layero, index){--%>
                    <%--    // console.log(layero, index);--%>
                    <%--    document.getElementById("showPic").src=${pageContext.request.contextPath}+'/'+workInfo.workPhoto;--%>
                    <%--    document.getElementById("showSummary").innerText=workInfo.summary;--%>
                    <%--}--%>
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
                            <button style="display: inline-block;line-height:0px;" onclick="showWorkInfo(${works.workId})">
                                <img src="${pageContext.request.contextPath}/${works.workPhoto}" style="width: 240px;height: 200px;vertical-align:bottom;">
                            </button>
                    </div>
                    <div class="layui-col-md6">
                        <a href=""><h1>${works.menuName}</h1></a>
                        <p>${works.likes}点赞</p>
                        <a href="${pageContext.request.contextPath}/work/modifyWork?workId=${works.workId}" class="layui-btn">修改</a>
                        <a href="" class="layui-btn">删除</a>
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
