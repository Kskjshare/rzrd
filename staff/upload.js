swfupload.onselect=function(marker,data)
{
    var key=data["key"];
    //data格式{key:'本次选择文件中的唯一标识',name:'文件名',size:'文件大小,单位字节',create:'文件创建日期时间',modify:'文件最后修改日期时间',data:'上传成功后返回的数据',state:'文件状态0，还没有上传，1、正在上传中，2、上传成功,此标识数据可以自定义'}
    switch(marker)
    {
        case "icourlswf":
            swfupload.photowrap[marker].html('<li id="swfuploaditem'+marker+key+'"><div class="swfuploadimg"><div><img src="'+(data["src"]||"/img/white.gif")+'" id="swfuploadimg'+marker+key+'" /></div></div><h2>等待上传<div></div></h2></li>');
            break;
    }
}
swfupload.onsucceed.callbak=function(marker,key,data)
{
    data=data.toJson();
    if(data["succeed"])
    {
        switch(marker)
        {
            case "icourlswf":
                $("#avatar").val(data["url"]);
                break;
        }
    }
}