$(document).on('turbolinks:load', function() {
  $(".input-default").on('keyup', function(e){
    e.preventDefault();
    var count = $(this).val();
    if (300 <= count && count <= 9999999){
      var commission = Math.floor(count * 0.1); //販売手数料
      var profits = (count - commission);
      $(".commission").text( "¥" + commission.toLocaleString());
      $(".profits").text( "¥" + profits.toLocaleString());
    } else {
      $(".commission").text("ー");
      $(".profits").text("ー");
    }
  });
});
