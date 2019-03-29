$(document).on('turbolinks:load', function() {
  //お知らせをクリックしたらお知らせ用のview出現
  $('#mypage-tab-notification').click(function(){
    $('#mypage-tab-todo').parent().parent().removeClass('active');
    $(this).parent().parent().addClass('active');
  });
  //やる事リストをクリックしたらやる事用のview出現
  $('#mypage-tab-todo').click(function(){
    $('#mypage-tab-notification').parent().parent().removeClass('active');
    $(this).parent().parent().addClass('active');
  });

  //購入した商品をクリックしたら購入用のviewが出現
  $('#mypage-tab-transaction-now').click(function(){
    $('#mypage-tab-transaction-old').parent().parent().removeClass('active');
    $(this).parent().parent().addClass('active');
    $('#tab-transaction-now').parent().removeClass('tab-hidden');
    $('#tab-transaction-old').parent().addClass('tab-hidden');
  });
  //過去の取引をクリックしたら過去用のviewが出現
  $('#mypage-tab-transaction-old').click(function(){
    $('#mypage-tab-transaction-now').parent().parent().removeClass('active');
    $(this).parent().parent().addClass('active');
    $('#tab-transaction-old').parent().removeClass('tab-hidden');
    $('#tab-transaction-now').parent().addClass('tab-hidden');
  });
});
