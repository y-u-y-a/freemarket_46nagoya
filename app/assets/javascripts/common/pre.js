$(document).on('turbolinks:load', function() {
  var previewCount = $('.preview').length;
  var secondHtml = `<div class="sell-upload-items second">
                      <ul class="pictures"></ul>
                    </div>`

  if (previewCount == 1 || previewCount == 6){
    $('.sell-upload-drop-box').width(491);
  } else if (previewCount == 2 || previewCount == 7){
    $('.sell-upload-drop-box').width(363);
  } else if (previewCount == 3 || previewCount == 8){
    $('.sell-upload-drop-box').width(234);
  } else if (previewCount == 4 || previewCount == 9){
    $('.sell-upload-drop-box').width(106);
  } else if (previewCount == 0 || previewCount == 5){
    $('.sell-upload-drop-box').width(620);
  } else if (previewCount == 10){
    $('.sell-upload-drop-box').hide();
  }

  for(num=0;num < previewCount; num++) {
    var id = document.getElementById("item_item_images_attributes_" + num  + "_image");
    $(id).remove();
  }

  //プレビューが６枚以上の時secondHtmlを追加し、イメージを移動させとく
  if (previewCount >= 6) {
    $('.sell-upload-items').after(secondHtml);
    for(i=5;i < 10; i++) {
      var image = document.getElementById("pre" + i)
      $('.second .pictures').append(image);
    }
  }

  $('.box-display-none').hide();

  for(num=0;num < previewCount; num++) {
    var id = document.getElementById("item_item_images_attributes_" + num  + "_image");
    $(id).remove();
  }

  var currentId = document.getElementById("item_item_images_attributes_" + num + "_image");
  $(currentId).parent().parent().show();
});
