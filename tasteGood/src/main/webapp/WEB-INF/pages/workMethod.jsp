<%--
  Created by IntelliJ IDEA.
  User: Shana
  Date: 2020/7/14
  Time: 17:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<script type="text/javascript">
    function addCollection(menuId) {
        layui.use('layer', function() {
            var layer = layui.layer;
            $.ajax({
                url:'${pageContext.request.contextPath}/collection/addCollection',
                datatype:'text',
                type:'post',
                data:"menuId="+menuId,
                success:function (data) {
                    if(data=="200"){
                        layer.msg('收藏成功', {icon: 1,offset:'220px'},);
                        window.setTimeout("window.location.reload();",1500);//延迟2秒跳转
                    }else if(data=="400"){
                        layer.msg('已经收藏过了', {icon: 5,offset:'220px'},);
                    }else {
                        layer.msg('收藏失败', {icon: 5,offset:'220px'},);
                    }
                },
                error:function () {
                    layer.msg('收藏失败', {icon: 5,offset:'220px'},);
                }
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
                error:function () {
                    layer.msg('点赞失败', {icon: 5,offset:'220px'},);
                }
            });
        });
    }

    var workInfo={};//保存拿到的一个作品信息,全局变量
    function showWorkInfo(workId) {
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
                workInfo.menuName=jsondata.menuName;
                workInfo.workTime=jsondata.workTime;
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
                    '    <div style=\"margin:10px;min-height: 400px\" class=\"layui-row layui-col-space30\" id=\"info\">\n' +
                    '        <div class=\"layui-col-md7\">\n' +
                    '            <img id=\"showPic\" alt=\"error\" src=\"${pageContext.request.contextPath}/'+workInfo.workPhoto+'\" style=\"width:400px;height:370px;\">\n' +
                    '        </div>\n' +
                    '        <div class=\"layui-col-md5\">\n' +
                    '            <h4 id=\"showSummary\" style=\"margin-bottom:20px;font-size:16px;\">'+'# '+workInfo.workTime+' #'+'</h4>\n' +
                    '            <h4 id=\"showSummary\" style=\"margin-bottom:20px;font-size:16px;\">'+'上传了 # '+workInfo.menuName+' # 的作品'+'</h4>\n' +
                    '            <h4 id=\"showSummary\" style=\"margin-bottom:20px;font-size:16px;\">'+workInfo.summary+'</h4>\n' +
                    '        </div>\n' +
                    '    </div>'
            });
        });
    }
</script>
