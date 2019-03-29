$(document).on('turbolinks:load', function() {
  $('.todo-lists').css('display','none');
  //お知らせをクリックしたらお知らせ用のview出現
  $('#mypage-tab-notification').click(function(){
    $('#mypage-tab-todo').parent().parent().removeClass('active');
    $(this).parent().parent().addClass('active');
    $('.notification-lists').css('display','');
    $('.todo-lists').css('display','none');
  });
  //やる事リストをクリックしたらやる事用のview出現
  $('#mypage-tab-todo').click(function(){
    $('#mypage-tab-notification').parent().parent().removeClass('active');
    $(this).parent().parent().addClass('active');
    $('.todo-lists').css('display','');
    $('.notification-lists').css('display','none');
  });

  //購入した商品をクリックしたら購入用のviewが出現
  $('#mypage-tab-transaction-now').on('click',function(){
    $('#mypage-tab-transaction-old').parent().parent().removeClass('active');
    $(this).parent().parent().addClass('active');
    $('#tab-transaction-now').removeClass('tab-hidden');
    $('#tab-transaction-old').addClass('tab-hidden');
  });
  //過去の取引をクリックしたら過去用のviewが出現
  $('#mypage-tab-transaction-old').on('click',function(){
    $('#mypage-tab-transaction-now').parent().parent().removeClass('active');
    $(this).parent().parent().addClass('active');
    $('#tab-transaction-old').removeClass('tab-hidden');
    $('#tab-transaction-now').addClass('tab-hidden');
  });


});
