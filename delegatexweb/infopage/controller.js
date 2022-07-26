
function ck_liudbcilclick() {

    $('tbody tr').dblclick(function () {

        popuplayer.display("/delegatexweb/infopage/butview.jsp?id=" + $(this).attr('idd') + "&TB_iframe=true", '查看', {width: 830, height: 350});
    })

}