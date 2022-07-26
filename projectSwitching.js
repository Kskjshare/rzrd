/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//登录页面图片
//如果要切换环江还是汝州，只用改下面一行就行，当然注意看是否有该图片，没有就修改了，有的还没来得及添加图片
let flag = 2;//用来标志是否是环江的还是汝州的还是其他，1环江，2汝州，3.。。。



var loginImgSrc = "LoginPage/images/logo_old.png";//没有名字的，登陆页面的图片
var lianluozhanSrc = "img/header.png";//初始的，联络站的图片

if(flag === 1){
    //环江的
    loginImgSrc = "LoginPage/images/huanjianglogo.png";//图片暂时没加------------------
    var lianluozhanSrc = "img/header.png";//联络站的图片，还没加--------------------
}else if(flag === 2){
    //汝州的
    loginImgSrc = "LoginPage/images/logo.png";
    var lianluozhanSrc = "img/header.png";//联络站的图片，汝州的
}else{
    //其他另加
//    loginImgSrc = "LoginPage/images/logo.png";
//    var lianluozhanSrc = "img/header.png";//联络站的图片，汝州的
}