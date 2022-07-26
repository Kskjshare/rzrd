
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta charset="utf-8" />
        <title>管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <style>
            #editor{font-size: 20px;}
        </style>
    </head>
    <body>

        <div id="editor">
            <a id="go"   style="display: none" href="/delegatexweb/bmweb.jsp" target="_blank"><span>自动点击</span></a>
            <p><br></p>
        </div>


        <%@include  file="/inc/js.html" %>
    </body>
</html>
<script>
    $(function(){
//       $("#go").click()
       $("#go span").click();
//       window.open = "/delegatexweb/bmweb.jsp"
//       alert("2")
    });
</script>

