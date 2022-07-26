<%-- 
    Document   : c
    Created on : 2018-6-13, 10:46:49
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>  
        <title>Upload a file please</title>  
    </head>  
    <body>  
        <h1>Please upload a file</h1>  
        <form id="abc" enctype="multipart/form-data" method="post">  
            <input type="file" name="file"/>  
            <input id="submit" type="submit"/>  
        </form>  
        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="js/lvzhi/jquery.form.js" type="text/javascript"></script>
        <script>
            $("#submit").click(function () {
                var ppp = "0"
                $("#abc").ajaxSubmit({
                    url: "/widget/upload.jsp?",
                    type: "post",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        alert("111")
                        console.log(data)
                        ppp = "1"
                    }});
                if (ppp == "1") {
                    return false;
                }
            })


        </script>
    </body>
</html>
