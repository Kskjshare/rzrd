<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>管理系统</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link href="css/resetold.css" rel="stylesheet" type="text/css" />
    <link href="css/login.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        if(self!=top)
        {
            top.location=self.location;
        }
    </script>
</head>
<body>
    <script src="js/jquery.js"></script>
    <script src="js/rsseasy.min.js"></script>
    <script type="text/javascript">
        Cookie.RemoveAll();
        location.href="login.jsp";
    </script>

</body>
</html>
