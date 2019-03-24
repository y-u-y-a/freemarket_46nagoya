$(document).on('turbolinks:load', function(){
  var width = $('.sell-upload-items').width();
  if (width <= 120){
    $('.sell-upload-drop-box').css('width','491')
  } else if (width >= 100 && width <= 250) {
    $('.sell-upload-drop-box').css('width','363');
  } else if (width >= 250 && width <= 380){
    $('.sell-upload-drop-box').css('width','234');
  } else if (width >= 490 && width < 620) {
    $('.sell-upload-drop-box').css('width','106');
  } else if (width >= 620){
    $('.sell-upload-drop-box').css('width','100%');
  }

  // $(".hidden").submit(function(){
  //   var width = $('.sell-upload-items').width();
  //   if (width <= 120){
  //     $('.sell-upload-drop-box').css('width','491')
  //   } else if (width >= 100 && width <= 250) {
  //     $('.sell-upload-drop-box').css('width','363');
  //   } else if (width >= 250 && width <= 380){
  //     $('.sell-upload-drop-box').css('width','234');
  //   } else if (width >= 490 && width < 620) {
  //     $('.sell-upload-drop-box').css('width','106');
  //   } else if (width >= 620){
  //     $('.sell-upload-drop-box').css('width','100%');
  //   }
  // });
});
