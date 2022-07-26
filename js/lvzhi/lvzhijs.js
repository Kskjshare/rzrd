



$("input[name='all']").change(function () {
    if ($(this).is(":checked")) {
        $("input[name='id']").each(function () {
            $(this).prop("checked", true)
        })
        $("input[name='myid']").each(function () {
            $(this).prop("checked", true)
        })
    } else {
        $("input[name='id']").each(function () {
            $(this).prop("checked", false)
        })
        $("input[name='myid']").each(function () {
            $(this).prop("checked", false)
        })
    }
})

$("#footerpagesize").change(function () {
    var re = $('input[name="resume"]').val() ? $('input[name="resume"]').val() : "";
    var cn = $('input[name="consultation"]').val() ? $('input[name="consultation"]').val() : "";
    var iw = $('input[name="lwstate"]').val() ? $('input[name="lwstate"]').val() : "";
    var is = $('input[name="iscs"]').val() ? $('input[name="iscs"]').val() : "";
    var en = $('input[name="examination"]').val() ? $('input[name="examination"]').val() : "";
    var ie = $('input[name="isdbtshenhe"]').val() ? $('input[name="isdbtshenhe"]').val() : "";
    var ic = $('input[name="isxzsc"]').val() ? $('input[name="isxzsc"]').val() : "";
    var dt = $('input[name="draft"]').val() ? $('input[name="draft"]').val() : "";
//    if (!(ic == undefined || ic == "")) {
//        if (dt == "2") {
//            location.href = "?curpage1&pagesize=" + $(this).val() + "&lwstate=" + iw + "&draft=" + dt;
//        } else {
    location.href = "?curpage1&pagesize=" + $(this).val() + "&lwstate=" + iw + "&iscs=" + is + "&examination=" + en + "&isdbtshenhe=" + ie + "&isxzsc=" + ic + "&draft=" + dt+ "&resume=" + re+ "&consultation=" + cn;
//        }
//    } else {
//        location.href = "?curpage1&pagesize=" + $(this).val() + "&lwstate=" + iw + "&iscs=" + is + "&examination=" + en + "&isdbtshenhe=" + ie + "&draft=" + dt;
//    }
})
function checksel() {
    $(".checksel input").change(function () {
        $(this).parents(".checksel").find("p").html("");
        $(this).parents(".checksel").find("input[type='checkbox']").each(function () {
            if ($(this).is(":checked")) {
                $(this).parents(".checksel").find("p").append("<span  sesid=" + $(this).attr("sesid") + " >" + $(this).siblings("span").text() + "</span>,");
            }
        })
    })
}

function checkse2() {
    $(".checksel input").change(function () {
        $(this).parents(".checksel").find("p").html("");
        $(this).parents(".checksel").find("input[type='checkbox']").each(function () {
            if ($(this).is(":checked")) {
                $(this).parents(".checksel").find("p").append("<span  sesid=" + $(this).attr("sesid") + " >" + $(this).siblings("span").text() + "</span>,");
            }
        })
    })
}

$(".checksel>p").click(function (e) {
    if (!($(".in").val() == 1)) {
        e.stopPropagation();
    }
    $(this).parent().find("ul").toggle();
})
$(".checksel>ul").click(function (e) {
    e.stopPropagation();
})