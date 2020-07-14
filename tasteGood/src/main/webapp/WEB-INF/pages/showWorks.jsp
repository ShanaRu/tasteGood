<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/2
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>作品模块</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
        function changePageSize() {
            //获取下拉框的值
            var pageSize = $("#changePageSize").val();

            //向服务器发送请求，改变每页显示条数
            location.href = "${pageContext.request.contextPath}/work/showWorks?page=1&size="
                + pageSize;
        }
    </script>
    <%@include file="workMethod.jsp"%>
</head>
<body>
    <%@include file="navbar.jsp"%>
    <div style="margin:20px 100px 20px 100px;min-height: 500px" class="layui-row layui-col-space10">
        <div class="layui-col-md12" style="margin-bottom: 20px">
            <span class="layui-breadcrumb">
                <a href="${pageContext.request.contextPath}/userInfo/homePage">首页</a>
                <a href="${pageContext.request.contextPath}/work/showWorks?page=1&size=8"><cite>作品区</cite></a>
            </span>
        </div>
        <c:forEach items="${pageInfo.list}" var="work">
            <div class="layui-col-md3" style="margin-bottom: 20px">
                <div style="width: 210px;text-align: center;border: 1px solid #f3f3f3">
                    <button class="layui-btn layui-btn-primary" style="border: none" onclick="showWorkInfo(${work.workId})">${work.menuName}</button>
                    <button style="display: inline-block;line-height:0;cursor: pointer;border: none" onclick="showWorkInfo(${work.workId})">
                        <img src="${pageContext.request.contextPath}/${work.workPhoto}" style="width: 210px;height: 170px;vertical-align:bottom;" alt="*">
                    </button>
                    <p style="width: 190px;margin:15px;overflow: hidden;text-overflow:ellipsis;white-space: nowrap;">${work.summary}</p>
                    <p style="margin: 15px">${work.likes} 赞 |
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-danger layui-btn-xs" onclick="addLikes(${work.workId})">
                            <i class="layui-icon">&#xe6c6;</i> 赞
                        </button>
                    </p>
                </div>
            </div>
        </c:forEach>
        <div style="text-align: center" class="layui-col-md12">
            <%--首页--%>
            <a href="${pageContext.request.contextPath}/work/showWorks?page=1&size=${pageInfo.pageSize}">
                <button class="layui-btn layui-btn-primary layui-btn-sm">首页</button>
            </a>
            <%--上一页--%>
            <c:if test="${pageInfo.hasPreviousPage}">
                <a href="${pageContext.request.contextPath}/work/showWorks?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-prev"></i></button>
                </a>
            </c:if>
            <%--中间页 pageInfo.navigatepageNums 所有页码的数组 pageInfo.pageNum 当前页数--%>
            <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                <c:if test="${pageNum == pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/work/showWorks?page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
                <c:if test="${pageNum != pageInfo.pageNum}">
                    <a href="${pageContext.request.contextPath}/work/showWorks?page=${pageNum}&size=${pageInfo.pageSize}">
                        <button class="layui-btn layui-btn-primary layui-btn-sm">${pageNum}</button>
                    </a>
                </c:if>
            </c:forEach>
            <%--下一页--%>
            <c:if test="${pageInfo.hasNextPage}">
                <a href="${pageContext.request.contextPath}/work/showWorks?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">
                    <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-next"></i></button>
                </a>
            </c:if>
            <%--尾页--%>
            <a href="${pageContext.request.contextPath}/work/showWorks?page=${pageInfo.pages}&size=${pageInfo.pageSize}">
                <button class="layui-btn layui-btn-primary layui-btn-sm">尾页</button>
            </a>
            <p style="display: inline-block;font-size: 12px;line-height: 30px">
                每页
                <select id="changePageSize" onchange="changePageSize()">
                    <option value="">请选择</option>
                    <option>8</option>
                    <option>12</option>
                    <option>16</option>
                </select>
                条
            </p>
        </div>
    </div>
    <%@include file="footer.jsp"%>
</body>
</html>
