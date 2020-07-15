<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/15
  Time: 20:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>管理菜谱</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script type="text/javascript">
        function changePageSize() {
            //获取下拉框的值
            var pageSize = $("#changePageSize").val();

            //向服务器发送请求，改变每页显示条数
            location.href = "${pageContext.request.contextPath}/manager/managerMenu?page=1&size="
                + pageSize;
        }

        function deleteMenu(menuId) {
            layui.use('layer', function(){
                var layer = layui.layer;
                layer.confirm('确定要删除该菜谱吗？', {
                    btn: ['确定','取消'], //按钮
                    offset:'200px'
                }, function(){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/menu/deleteMenu",
                        data:"menuId="+menuId,
                        datatype:"text",
                        type:"post",
                        success:function (data) {
                            if(data=="200"){
                                layer.msg('删除成功', {icon: 1,offset:'220px'},);
                                <%--location.href = "${pageContext.request.contextPath}/menu/userMenu";--%>
                                <%--window.setTimeout("window.location='${pageContext.request.contextPath}/menu/userMenu'",2000);//延迟2秒跳转--%>
                                window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                            }else{
                                layer.msg('无法删除', {icon: 5,offset:'220px'},);
                            }
                        },
                        error:function () {
                            layer.msg('无法删除', {icon: 5,offset:'220px'},);
                        }
                    });
                });
            });
        }

    </script>
</head>
<body>
    <%@include file="managerNavbar.jsp"%>
    <div style="margin:30px 100px 20px 100px;min-height: 500px">
        <table class="layui-table">
            <colgroup>
                <col width="20">
                <col width="200">
                <col width="150">
                <col width="450">
                <col width="200">
            </colgroup>
            <thead>
            <tr>
                <th>序号</th>
                <th>菜谱名称</th>
                <th>完成时间</th>
                <th>简介</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${pageInfo.list}" var="menu" varStatus="loop">
                <tr>
                    <td>${loop.index+1}</td>
                    <td>${menu.menuName}</td>
                    <td><fmt:formatDate value="${menu.uploadTime}" pattern="yyyy-MM-dd"/></td>
                    <td>${menu.menuDetail}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/manager/showMenuInfo?menuId=${menu.menuId}&pageNum=${pageInfo.pageNum}&pageSize=${pageInfo.pageSize}" class="layui-btn layui-btn-radius layui-btn-sm">基本信息</a>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-sm layui-btn-danger" onclick="deleteMenu(${menu.menuId})">删除</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div style="text-align: center;margin-top: 20px">
            <%--首页--%>
            <a href="${pageContext.request.contextPath}/manager/managerMenu?page=1&size=${pageInfo.pageSize}">
                <button class="layui-btn layui-btn-primary layui-btn-sm">首页</button>
            </a>
            <%--上一页--%>
            <c:if test="${pageInfo.hasPreviousPage}">
                <a href="${pageContext.request.contextPath}/manager/managerMenu?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-prev"></i></button>
                </a>
            </c:if>
            <%--中间页 pageInfo.navigatepageNums 所有页码的数组 pageInfo.pageNum 当前页数--%>
            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                <c:if test="${pageNum == pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/manager/managerMenu?page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
                <c:if test="${pageNum != pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/manager/managerMenu?page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-primary layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
            </c:forEach>
            <%--下一页--%>
            <c:if test="${pageInfo.hasNextPage}">
                <a href="${pageContext.request.contextPath}/manager/managerMenu?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-next"></i></button>
                </a>
            </c:if>
            <%--尾页--%>
            <a href="${pageContext.request.contextPath}/manager/managerMenu?page=${pageInfo.pages}&size=${pageInfo.pageSize}">
                <button class="layui-btn layui-btn-primary layui-btn-sm">尾页</button>
            </a>
            <p style="display: inline-block;font-size: 12px;line-height: 30px">
                &ensp;共${pageInfo.total}条&ensp;每页
                <select id="changePageSize" onchange="changePageSize()">
                    <option value="">请选择</option>
                    <option>10</option>
                    <option>20</option>
                    <option>30</option>
                </select>
                条
            </p>
        </div>
    </div>


</div>


</body>
</html>
