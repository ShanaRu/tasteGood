<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: Shana--%>
<%--  Date: 2020/7/11--%>
<%--  Time: 23:52--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>--%>
<%--<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>菜谱模块</title>--%>
<%--    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>--%>
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">--%>
<%--    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>--%>
<%--    <script type="text/javascript">--%>
<%--        layui.use('element', function(){--%>
<%--            var element = layui.element;--%>
<%--            var $=layui.jquery;--%>

<%--            //获取hash 来切换选项卡，假设当前地址的hash为lay-id对应的值--%>
<%--            var layid = location.hash.replace(/^#classificationMenu=/, '');--%>
<%--            // lay-filter="classificationMenu" 地址栏中参数的名称;--%>
<%--            // layid作为唯一的匹配索引，以用于外部的定位切换--%>
<%--            element.tabChange('classificationMenu', layid);--%>
<%--            //element.tabChange(filter, layid); 用于外部切换到指定的Tab项上，参数同上--%>
<%--            //http://a.com#classificationMenu=1，选项卡会自动切换到当前项--%>
<%--            element.on('tab(classificationMenu)', function(elem){--%>
<%--                //element.on(filter, callback); 用于元素的一些事件监听，以改变地址hash值--%>
<%--                console.log(elem);--%>
<%--                console.log(elem.index);--%>
<%--                location.hash = 'classificationMenu='+ $(this).attr('lay-id'); // 等同 +this.getAttribute('lay-id');--%>
<%--            });--%>

<%--        });--%>

<%--        function addCollection(menuId) {--%>
<%--            layui.use('layer', function() {--%>
<%--                var layer = layui.layer;--%>
<%--                $.ajax({--%>
<%--                    url:'${pageContext.request.contextPath}/collection/addCollection',--%>
<%--                    datatype:'text',--%>
<%--                    type:'post',--%>
<%--                    data:"menuId="+menuId,--%>
<%--                    success:function (data) {--%>
<%--                        if(data==="200"){--%>
<%--                            layer.msg('收藏成功', {icon: 1,offset:'220px'},);--%>
<%--                            window.setTimeout("window.location.reload();",1500);//延迟2秒跳转--%>
<%--                        }else if(data==="400"){--%>
<%--                            layer.msg('已经收藏过了', {icon: 5,offset:'220px'},);--%>
<%--                        }else {--%>
<%--                            layer.msg('收藏失败', {icon: 5,offset:'220px'},);--%>
<%--                        }--%>
<%--                    },--%>
<%--                    error:function () {--%>
<%--                        layer.msg('收藏失败', {icon: 5,offset:'220px'},);--%>
<%--                    }--%>
<%--                });--%>
<%--            });--%>
<%--        }--%>

<%--        function changePageSize() {--%>
<%--            //获取下拉框的值--%>
<%--            var pageSize = $("#changePageSize").val();--%>

<%--            //向服务器发送请求，改变每页显示条数--%>
<%--            location.href = "${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=1&size="--%>
<%--                + pageSize;--%>
<%--        }--%>
<%--    </script>--%>
<%--</head>--%>
<%--<body>--%>
<%--    <%@include file="navbar.jsp"%>--%>
<%--    <div style="margin:20px 100px 20px 100px;min-height: 500px" class="layui-row layui-col-space10">--%>
<%--        <div class="layui-tab" lay-filter="classificationMenu">--%>
<%--            <ul class="layui-tab-title">--%>
<%--                <li class="layui-this" lay-id="1">家常菜</li>--%>
<%--                <li lay-id="2">地方特色菜</li>--%>
<%--                <li lay-id="3">甜点/面食</li>--%>
<%--                <li lay-id="4">快餐</li>--%>
<%--                <li lay-id="5">中式</li>--%>
<%--                <li lay-id="5">西式</li>--%>
<%--                <li lay-id="5">日韩料理</li>--%>
<%--                <li lay-id="5">其他</li>--%>
<%--            </ul>--%>
<%--            <div class="layui-tab-content">--%>
<%--                <div class="layui-tab-item layui-show">--%>
<%--                    内容1--%>
<%--                    <c:forEach items="${pageInfo.list}" var="menu">--%>
<%--                        <div style="padding: 15px;margin-bottom: 20px" class="layui-col-md6">--%>
<%--                            <div class="layui-col-md6">--%>
<%--                                <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}" style="display: inline-block;line-height:0px;">--%>
<%--                                    <img src="${pageContext.request.contextPath}/${menu.menuCover}" style="width: 240px;height: 200px;vertical-align:bottom;">--%>
<%--                                </a>--%>
<%--                            </div>--%>
<%--                            <div class="layui-col-md6">--%>
<%--                                <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${menu.menuId}"><h1>${menu.menuName}</h1></a>--%>
<%--                                    &lt;%&ndash;                    <p>${userMenu.menuDetail}</p>&ndash;%&gt;--%>
<%--                                <c:forEach items="${menu.ingredients}" var="ingredient">--%>
<%--                                    &lt;%&ndash;                        ${ingredient.dosage}&ndash;%&gt;--%>
<%--                                    <span style="font-size: 14px">${ingredient.ingredient}</span>--%>
<%--                                </c:forEach>--%>
<%--                                <span>${menu.collection}收藏</span>--%>
<%--                                <button type="button" class="layui-btn" onclick="addCollection(${menu.menuId})">收藏</button>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>
<%--                    <div style="text-align: center" class="layui-col-md12">--%>
<%--                        &lt;%&ndash;首页&ndash;%&gt;--%>
<%--                        <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=1&size=${pageInfo.pageSize}">--%>
<%--                            <button class="layui-btn layui-btn-primary layui-btn-sm">首页</button>--%>
<%--                        </a>--%>
<%--                        &lt;%&ndash;上一页&ndash;%&gt;--%>
<%--                        <c:if test="${pageInfo.hasPreviousPage}">--%>
<%--                            <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">--%>
<%--                                <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-prev"></i></button>--%>
<%--                            </a>--%>
<%--                        </c:if>--%>
<%--                        &lt;%&ndash;中间页 pageInfo.navigatepageNums 所有页码的数组 pageInfo.pageNum 当前页数&ndash;%&gt;--%>
<%--                        <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">--%>
<%--                            <c:if test="${pageNum == pageInfo.pageNum}">--%>
<%--                                <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=${pageNum}&size=${pageInfo.pageSize}">--%>
<%--                                    <button class="layui-btn layui-btn-sm">${pageNum}</button>--%>
<%--                                </a>--%>
<%--                            </c:if>--%>
<%--                            <c:if test="${pageNum != pageInfo.pageNum}">--%>
<%--                                <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=${pageNum}&size=${pageInfo.pageSize}">--%>
<%--                                    <button class="layui-btn layui-btn-primary layui-btn-sm">${pageNum}</button>--%>
<%--                                </a>--%>
<%--                            </c:if>--%>
<%--                        </c:forEach>--%>
<%--                        &lt;%&ndash;下一页&ndash;%&gt;--%>
<%--                        <c:if test="${pageInfo.hasNextPage}">--%>
<%--                            <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">--%>
<%--                                <button class="layui-btn layui-btn-primary layui-btn-sm"><i class="layui-icon layui-icon-next"></i></button>--%>
<%--                            </a>--%>
<%--                        </c:if>--%>
<%--                        &lt;%&ndash;尾页&ndash;%&gt;--%>
<%--                        <a href="${pageContext.request.contextPath}/menu/searchClassification?classification=${classification}&page=${pageInfo.pages}&size=${pageInfo.pageSize}">--%>
<%--                            <button class="layui-btn layui-btn-primary layui-btn-sm">尾页</button>--%>
<%--                        </a>--%>
<%--                        <p style="display: inline-block;font-size: 12px;line-height: 30px">--%>
<%--                            每页--%>
<%--                            <select id="changePageSize" onchange="changePageSize()">--%>
<%--                                <option value="">请选择</option>--%>
<%--                                <option>6</option>--%>
<%--                                <option>10</option>--%>
<%--                                <option>14</option>--%>
<%--                            </select>--%>
<%--                            条--%>
<%--                        </p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="layui-tab-item">内容2</div>--%>
<%--                <div class="layui-tab-item">内容3</div>--%>
<%--                <div class="layui-tab-item">内容4</div>--%>
<%--                <div class="layui-tab-item">内容5</div>--%>
<%--                <div class="layui-tab-item">内容6</div>--%>
<%--                <div class="layui-tab-item">内容7</div>--%>
<%--                <div class="layui-tab-item">内容8</div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <%@include file="footer.jsp"%>--%>
<%--</body>--%>
<%--</html>--%>
