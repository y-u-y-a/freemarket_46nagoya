$(document).on('turbolinks:load', function(){
  $(".pc-header-nav__user-icon").hover(function(e){
    e.preventDefault();
    var mypageBox = $(".header-mypage-box:not(:animated)");
    mypageBox.show();
    mypageBox.hover(function(){
      mypageBox.show();
    }, function(){
      mypageBox.hide();
    });
  }, function(){
    $(".header-mypage-box").hide();
  });
});
