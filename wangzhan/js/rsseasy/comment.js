/// <reference path="jquery.min.js" />
/// <reference path="rsseasy.min.js" />
/// <reference path="rsseasy.app.js" />
/// <reference path="validated.v2.min.js" />
/// <reference path="rsseasy.popup.min.js" />
/// <reference path="rsseasy.rssapi.min.js" />

//评论模块
function RssComment(module, id) {
    return {
        "Module": module,
        "Wrap": $("#" + id),
        "List": RssApi.Comment.List(module),
        "onAppend": $.noop,
        "Append": RssApi.Comment.Append(module)
    }
}



$("[rsscomment]").click(function () {
    var t = $(this), module = t.attr("rsscomment");
    RssApi.Comment.Append(module).keyvalue(t.attrmap()).keyvalue("relationid", t.attr("relationid")).keymyid().setverify(function () {
        try {
            return ValidatedV3.setdict(this.params).isMatter("matter").isRelationId("relationid");
        }
        catch (ex) {
            RssCode.alert(ex);
            return false;
        }
    }).setType("json").post(function () {
        var back = RssComment[module];
        if (back) {
            back();
        }
        else {
            alert("提交成功！");
        }
    });
});

