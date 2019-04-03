$(document).on('turbolinks:load', function() {
  $('.mypage-nav li a').each(function(){
    var $href = $(this).attr('href');
    //urlがhrefと完全一致したら
    if(location.pathname == $href){
      $(this).addClass('active');
      $(this).css({'background':'#eee','font-weight':'bold'});
      $(this).children('.mypage-icon').css('color','black');
    }
  });
});
// urlに$hrefが含まれているか(location.href.match($href)
