
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>??</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link href="/css/reset.css" rel="stylesheet" type="text/css" />
        <link href="/css/layout.css" rel="stylesheet" type="text/css" />
        <script src="/js/jquery.min.js"></script>
        <style>

        </style>
    </head>
    <body>
        <p style="padding: 20px;"></p>
        <script type="text/javascript">
            function getvalue (name){
                var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
                var r =window.location.search.substr(1).match(reg);
                if (r!==null) {
                    return r[2];
                }
                return "";
            }
            let text = getvalue("text");
//            alert(decodeURI(text));
            $('p').text(decodeURI(text))
        </script>
    </body>
</html>
