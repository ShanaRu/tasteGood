<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/6/25
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改菜谱</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
    <script type="text/javascript">
        // let beforeCount=0;
        $(document).ready(function () {
            // addDosage();
            // addDosage();
            // addStep();
            // addStep();
        });
        var num=1;//全局变量
        var judge=0;//判断是否进行num的第一次赋值
        console.log("num是"+num);
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
                        document.getElementById("menuCover").value = res.src;
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

        layui.use('form', function(){
            var form = layui.form;
            var $=layui.jquery;
            //监听提交
            // form.on('submit(formMenu)', function(data){
            //
            //     return false;
            // });
        });
        function addDosage()
        {
            var input1=document.createElement("input");
            input1.setAttribute("class","layui-input");
            input1.setAttribute("type","text");
            input1.setAttribute("required","required");
            input1.setAttribute("lay-verify","required");
            input1.setAttribute("name","ingredient");
            input1.setAttribute("placeholder","食材：请输入食材名");
            input1.setAttribute("autocomplete","off");
            input1.setAttribute("style","margin-bottom:5px;");
            document.getElementById("dosageBox1").appendChild(input1);

            var input2=document.createElement("input");
            input2.setAttribute("class","layui-input");
            input2.setAttribute("type","text");
            input2.setAttribute("required","required");
            input2.setAttribute("lay-verify","required");
            input2.setAttribute("name","dosage");
            input2.setAttribute("placeholder","用量：如一克");
            input2.setAttribute("autocomplete","off");
            input2.setAttribute("style","margin-bottom:5px;");
            // div2.appendChild(input2);
            document.getElementById("dosageBox2").appendChild(input2);

        }
        function delDosage(){
            var tr1=document.getElementById("dosageBox1");
            if(tr1.hasChildNodes()){//是否有子节点
                var node1=tr1.childNodes;//子节点数量
                console.log("节点1的数量"+node1.length);
                // for(var i=0;i<node1.length;i++){
                //     console.log(node1[i]);
                // }
                if(node1.length==1){
                    layer.msg('不可再删');
                }else{
                    var last1=tr1.lastChild;
                    tr1.removeChild(last1);
                }
            }

            var tr2=document.getElementById("dosageBox2");
            if(tr2.hasChildNodes()){//是否有子节点
                var node2=tr2.childNodes;//子节点数量
                console.log("节点1的数量"+node2.length);
                if(node2.length==1){
                    // layer.msg('不可再删');
                }else{
                    var last2=tr2.lastChild;
                    tr2.removeChild(last2);
                }
            }
        }

        function uploadPhoto(number) {
            var photo=document.getElementById("uploadStep"+number).value;
            var str=$("#uploadStep"+number).val();
            var arr=str.split('\\');//注split可以用字符或字符串分割
            var myPhoto=arr[arr.length-1];//这就是要取得的图片名称

            //预览效果
            var file = document.getElementById("uploadStep"+number).files[0];
            if (window.FileReader) {
                var reader = new FileReader();
                reader.readAsDataURL(file);
                //监听文件读取结束后事件
                reader.onloadend = function (e) {
                    //e.target.result就是最后的路径地址
                    $("#showStepChar"+number).attr("src",e.target.result);
                };
            }

            var formData = new FormData();
            formData.append("file", file);

            $.ajax({
                url:'${pageContext.request.contextPath}/images/upload',
                type: "post",
                data: formData,
                processData: false,//用于对data参数进行序列化处理 这里必须false
                contentType: false, //必须*
                dataType: "json",
                // async: false,//必须同步才可以先调用检验再进行表单提交
                success: function(data) {
                    //如果上传失败
                    if(data.code != 0){
                        return layer.msg('上传失败');
                    }
                    //上传成功
                    if(data.code == 0){
                        document.getElementById("stepChar"+number).value = data.src;
                        return layer.msg('上传成功');
                    }
                },
                error:function () {
                    layer.msg('上传失败');
                }
            })
        }

        function addStep() {
            if(judge==0){
                var tr1=document.getElementById("stepBox1");
                if(tr1.hasChildNodes()) {//是否有子节点
                    var node1=tr1.childNodes;//子节点数量
                    num=num+node1.length/2;
                }
                judge++;
            }
            var input3=document.createElement("textarea");
            input3.setAttribute("name","step");
            input3.setAttribute("placeholder","请输入步骤描述");
            input3.setAttribute("class","layui-textarea");
            input3.setAttribute("required","required");
            input3.setAttribute("lay-verify","required");
            input3.setAttribute("rows","7");
            input3.setAttribute("style","height: 162px");
            document.getElementById("stepBox1").appendChild(input3);

            var button=document.createElement("input");
            button.setAttribute("type","file");
            // button.setAttribute("class","layui-btn");
            button.setAttribute("style","margin-bottom:10px;margin-top:10px;");
            button.setAttribute("id","uploadStep"+num);
            button.setAttribute("onchange","uploadPhoto("+num+")");
            document.getElementById("stepBox1").appendChild(button);

            var input4=document.createElement("input");//隐藏标签
            input4.setAttribute("type","text");
            input4.setAttribute("id","stepChar"+num);
            input4.setAttribute("style","display: none;");
            document.getElementById("stepBox2").appendChild(input4);

            var img=document.createElement("img");
            img.setAttribute("style","width: 220px;height: 200px;margin-bottom:5px;");
            img.setAttribute("class","layui-upload-img");
            img.setAttribute("id","showStepChar"+num);
            document.getElementById("stepBox2").appendChild(img);

            num++;
        }
        function delStep() {
            var tr1=document.getElementById("stepBox1");
            if(judge==0){
                if(tr1.hasChildNodes()) {//是否有子节点
                    var node1=tr1.childNodes;//子节点数量
                    num=num+node1.length/2;
                }
                judge++;
            }
            if(tr1.hasChildNodes()){//是否有子节点
                var node1=tr1.childNodes;//子节点数量
                // console.log(node1.length);
                if(node1.length==2){
                    layer.msg('不可再删');
                }else{
                    var last1=tr1.lastChild;
                    tr1.removeChild(last1);
                    var last2=tr1.lastChild;
                    tr1.removeChild(last2);
                }
            }
            var tr3=document.getElementById("stepBox2");
            if(tr3.hasChildNodes()){//是否有子节点
                var node3=tr3.childNodes;//子节点数量
                if(node3.length==2){
                    // layer.msg('不可再删');
                }else{
                    var last3=tr3.lastChild;
                    tr3.removeChild(last3);
                    var last4=tr3.lastChild;
                    tr3.removeChild(last4);
                }
            }
            num--;
        }
        function commit() {
            var dosage1=document.getElementById("dosageBox1");
            var dosage2=document.getElementById("dosageBox2");
            var array1=new Array();
            for (let i=0;i<dosage1.childNodes.length;i++){
                var object1=new Object();
                if(dosage1.childNodes[i].value==""){
                    return false;
                }
                object1.ingredient=dosage1.childNodes[i].value;
                array1.push(object1);
            }
            for (let i=0;i<dosage2.childNodes.length;i++){
                if(dosage2.childNodes[i].value==""){
                    return false;
                }
                array1[i].dosage=dosage2.childNodes[i].value;
            }

            var step1=document.getElementById("stepBox1");
            var step2=document.getElementById("stepBox2");
            var array2=new Array();
            for(let i=0;i<step1.childNodes.length;i=i+2){
                var object2=new Object();
                if(i%2==0){//双数
                    if(step1.childNodes[i].value==""){
                        return false;
                    }
                    object2.step=step1.childNodes[i].value;
                    array2.push(object2);
                }

            }
            var count=0;
            for (let i=0;i<step2.childNodes.length;i++){
                if(i%2==0){//双数
                    array2[count].stepChar=step2.childNodes[i].value;
                    count++;
                }
            }
            var example=new Object();
            example.menuId=document.getElementById("menuId").value;
            example.userId=document.getElementById("userId").value;
            example.collection=document.getElementById("collection").value;
            if(document.getElementById("menuName").value==""){
                return false;
            }
            example.menuName=document.getElementById("menuName").value;
            example.menuCover=document.getElementById("menuCover").value;
            if(document.getElementById("menuDetail").value==""){
                return false;
            }
            example.menuDetail=document.getElementById("menuDetail").value;
            example.totalComplete=document.getElementById("totalComplete").value;
            var isAutoSend = document.getElementsByName('classification');
            for (var i = 0; i < isAutoSend.length; i++) {
                if (isAutoSend[i].checked == true) {
                    example.classification=isAutoSend[i].value;
                }
            }
            if(document.getElementById("tip").value==""){
                return false;
            }
            example.tip=document.getElementById("tip").value;
            example.uploadTime=new Date();
            example.ingredients=array1;
            example.steps=array2;
            layui.use('layer',function () {
                var layer=layui.layer;
                $.ajax({
                    url:"${pageContext.request.contextPath}/menu/updateMenu",
                    contentType:"application/json;charset=UTF-8",
                    data:JSON.stringify(example),
                    dataType:"json",
                    type: "post",
                    // async:false,
                    success:function (data) {
                        if(data=="200"){
                            <%--location.href = "${pageContext.request.contextPath}/userInfo/homePage";//跳转主页--%>
                            layer.msg('提交成功', {icon: 1,offset:'220px'},);
                            window.setTimeout("window.location='${pageContext.request.contextPath}/userInfo/homePage'",1500);
                        }else{
                            layer.msg('提交失败');
                        }
                    },
                    error:function (data) {
                        layer.msg('提交失败');
                    }
                });
            });
        }

    </script>

</head>
<body>
<%@include file="navbar.jsp"%>
<div style="margin:30px 100px 20px 100px;min-height: 500px">
    <div style="margin-bottom: 20px">
        <span class="layui-breadcrumb">
            <a href="${pageContext.request.contextPath}/userInfo/homePage">首页</a>
            <a href="${pageContext.request.contextPath}/menu/modifyMenu?menuId=${menu.menuId}"><cite>修改菜谱</cite></a>
        </span>
    </div>
    <div class="layui-row layui-col-space30">
        <div class="layui-col-md9" style="min-height: 480px">
            <div class="layui-form">
                <%--                <form class="layui-form">--%>
                <div class="layui-row layui-col-space10">
                    <div class="layui-col-md7">
                        <div class="layui-form-item">
                            <input type="text" name="menuId" style="display: none" id="menuId" value="${menu.menuId}"><%--隐藏标签--%>
                            <input type="text" name="userId" style="display: none" id="userId" value="${menu.userId}">
                            <input type="text" name="collection" style="display: none" id="collection" value="${menu.collection}">
                            <input type="text" name="totalComplete" style="display: none" id="totalComplete" value="${menu.totalComplete}">
                            <label class="layui-form-label">菜谱名称</label>
                            <div class="layui-input-block">
                                <textarea name="menuName" id="menuName" placeholder="请输入菜谱名称" class="layui-textarea" required  lay-verify="required">${menu.menuName}</textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">菜谱封面</label>
                            <div class="layui-input-block">
                                <input type="text" value="${menu.menuCover}"  id="menuCover" name="menuCover" style="display: none;"><!--隐藏标签-->
                                <button type="button" class="layui-btn" id="uploadPic">上传菜谱封面</button>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md5">
                        <div class="layui-form-item">
                            <img class="layui-upload-img " id="showPic" style="width: 250px;height: 240px;" src="${pageContext.request.contextPath}/${menu.menuCover}">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">菜谱分类</label>
                    <div class="layui-input-block">
                        <c:if test="${menu.classification=='家常菜'}">
                            <input type="radio" name="classification" value="家常菜" title="家常菜" checked>
                            <input type="radio" name="classification" value="地方特色菜" title="地方特色菜">
                            <input type="radio" name="classification" value="甜点/面食" title="甜点/面食">
                            <input type="radio" name="classification" value="快餐" title="快餐">
                            <input type="radio" name="classification" value="中式" title="中式">
                            <input type="radio" name="classification" value="西式" title="西式">
                            <input type="radio" name="classification" value="日韩料理" title="日韩料理">
                            <input type="radio" name="classification" value="其他" title="其他">
                        </c:if>
                        <c:if test="${menu.classification=='地方特色菜'}">
                            <input type="radio" name="classification" value="家常菜" title="家常菜">
                            <input type="radio" name="classification" value="地方特色菜" title="地方特色菜" checked>
                            <input type="radio" name="classification" value="甜点/面食" title="甜点/面食">
                            <input type="radio" name="classification" value="快餐" title="快餐">
                            <input type="radio" name="classification" value="中式" title="中式">
                            <input type="radio" name="classification" value="西式" title="西式">
                            <input type="radio" name="classification" value="日韩料理" title="日韩料理">
                            <input type="radio" name="classification" value="其他" title="其他">
                        </c:if>
                        <c:if test="${menu.classification=='甜点/面食 '}">
                            <input type="radio" name="classification" value="家常菜" title="家常菜">
                            <input type="radio" name="classification" value="地方特色菜" title="地方特色菜">
                            <input type="radio" name="classification" value="甜点/面食" title="甜点/面食" checked>
                            <input type="radio" name="classification" value="快餐" title="快餐">
                            <input type="radio" name="classification" value="中式" title="中式">
                            <input type="radio" name="classification" value="西式" title="西式">
                            <input type="radio" name="classification" value="日韩料理" title="日韩料理">
                            <input type="radio" name="classification" value="其他" title="其他">
                        </c:if>
                        <c:if test="${menu.classification=='快餐'}">
                            <input type="radio" name="classification" value="家常菜" title="家常菜">
                            <input type="radio" name="classification" value="地方特色菜" title="地方特色菜">
                            <input type="radio" name="classification" value="甜点/面食" title="甜点/面食">
                            <input type="radio" name="classification" value="快餐" title="快餐" checked>
                            <input type="radio" name="classification" value="中式" title="中式">
                            <input type="radio" name="classification" value="西式" title="西式">
                            <input type="radio" name="classification" value="日韩料理" title="日韩料理">
                            <input type="radio" name="classification" value="其他" title="其他">
                        </c:if>
                        <c:if test="${menu.classification=='中式'}">
                            <input type="radio" name="classification" value="家常菜" title="家常菜">
                            <input type="radio" name="classification" value="地方特色菜" title="地方特色菜">
                            <input type="radio" name="classification" value="甜点/面食" title="甜点/面食">
                            <input type="radio" name="classification" value="快餐" title="快餐">
                            <input type="radio" name="classification" value="中式" title="中式" checked>
                            <input type="radio" name="classification" value="西式" title="西式">
                            <input type="radio" name="classification" value="日韩料理" title="日韩料理">
                            <input type="radio" name="classification" value="其他" title="其他">
                        </c:if>
                        <c:if test="${menu.classification=='西式'}">
                            <input type="radio" name="classification" value="家常菜" title="家常菜">
                            <input type="radio" name="classification" value="地方特色菜" title="地方特色菜">
                            <input type="radio" name="classification" value="甜点/面食" title="甜点/面食">
                            <input type="radio" name="classification" value="快餐" title="快餐">
                            <input type="radio" name="classification" value="中式" title="中式">
                            <input type="radio" name="classification" value="西式" title="西式" checked>
                            <input type="radio" name="classification" value="日韩料理" title="日韩料理">
                            <input type="radio" name="classification" value="其他" title="其他">
                        </c:if>
                        <c:if test="${menu.classification=='日韩料理'}">
                            <input type="radio" name="classification" value="家常菜" title="家常菜">
                            <input type="radio" name="classification" value="地方特色菜" title="地方特色菜">
                            <input type="radio" name="classification" value="甜点/面食" title="甜点/面食">
                            <input type="radio" name="classification" value="快餐" title="快餐">
                            <input type="radio" name="classification" value="中式" title="中式">
                            <input type="radio" name="classification" value="西式" title="西式">
                            <input type="radio" name="classification" value="日韩料理" title="日韩料理" checked>
                            <input type="radio" name="classification" value="其他" title="其他">
                        </c:if>
                        <c:if test="${menu.classification=='其他'}">
                            <input type="radio" name="classification" value="家常菜" title="家常菜">
                            <input type="radio" name="classification" value="地方特色菜" title="地方特色菜">
                            <input type="radio" name="classification" value="甜点/面食" title="甜点/面食">
                            <input type="radio" name="classification" value="快餐" title="快餐">
                            <input type="radio" name="classification" value="中式" title="中式">
                            <input type="radio" name="classification" value="西式" title="西式">
                            <input type="radio" name="classification" value="日韩料理" title="日韩料理">
                            <input type="radio" name="classification" value="其他" title="其他" checked>
                        </c:if>
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">菜谱描述</label>
                    <div class="layui-input-block">
                        <textarea name="menuDetail" id="menuDetail" placeholder="请输入菜谱描述" class="layui-textarea" required lay-verify="required">${menu.menuDetail}</textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">用料</label>
                    <div class="layui-input-block">
                        <button type="button" class="layui-btn" value="添加用量" onclick="addDosage()">添加用量</button>
                        <button type="button" class="layui-btn" value="删除用量" onclick="delDosage()">删除用量</button><br>
                        <div class="layui-row layui-col-space10">
                            <div class="layui-col-md6" id="dosageBox1"><c:forEach items="${menu.ingredients}" var="i"><input class="layui-input" type="text" required lay-verif="required" name="ingredient" value="${i.ingredient}" placeholder="食材：请输入食材名" autocomplete="off" style="margin-bottom:5px;"></c:forEach></div>
                            <div class="layui-col-md6" id="dosageBox2"><c:forEach items="${menu.ingredients}" var="j"><input class="layui-input" type="text" required lay-verif="required" name="dosage" value="${j.dosage}" placeholder="用量：如一克" autocomplete="off" style="margin-bottom:5px;"></c:forEach></div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">步骤图</label>
                    <div class="layui-input-block">
                        <button type="button" class="layui-btn" value="添加步骤" onclick="addStep(num)">添加步骤</button>
                        <button type="button" class="layui-btn" value="删除步骤" onclick="delStep(num)">删除步骤</button>
                        <div class="layui-row layui-col-space10">
                            <div class="layui-col-md8" id="stepBox1"><c:forEach items="${menu.steps}" var="m" varStatus="status"><textarea name="step" placeholder="请输入步骤描述" class="layui-textarea" required lay-verify="required" rows="7" style="height: 162px">${m.step}</textarea><input type="file" id="uploadStep${status.count}" onchange="uploadPhoto(${status.count})" style="margin-bottom:10px;margin-top:10px;"></c:forEach></div>
                            <div class="layui-col-md4" id="stepBox2"><c:forEach items="${menu.steps}" var="n" varStatus="s"><input type="text" id="stepChar${s.count}" style="display: none;" value="${n.stepChar}"><img id="showStepChar${s.count}" src="${pageContext.request.contextPath}/${n.stepChar}" style="width: 220px;height: 200px;margin-bottom:5px;" class="layui-upload-img"></c:forEach></div>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">小提示</label>
                    <div class="layui-input-block">
                        <textarea name="tip" placeholder="请输入提示" id="tip" class="layui-textarea" required  lay-verify="required">${menu.tip}</textarea>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" onclick="commit()">保存</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
                <%--                </form>--%>
            </div>
        </div>
        <div class="layui-col-md3" style="min-height: 480px">
            <p style="text-align: center;color: #5FB878;">推荐菜谱</p>
            <c:forEach items="${recommends}" var="recommend">
                <div style="margin: 20px;text-align: center">
                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${recommend.menuId}" style="display: inline-block;line-height:0;">
                        <img src="${pageContext.request.contextPath}/${recommend.menuCover}" style="width: 180px;height: 150px;vertical-align:bottom;" alt="*">
                    </a>
                    <a href="${pageContext.request.contextPath}/menu/showMenu?menuId=${recommend.menuId}"><h5 style="margin-top: 10px">${recommend.menuName}</h5></a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<%--    底部--%>
<%@include file="footer.jsp"%>
</body>
</html>
