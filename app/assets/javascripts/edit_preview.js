$(document).on('turbolinks:load', function(e) {

  $('#sell-upload-delete').click(function(){
    $(this).parents(".sell-upload-item").remove();
  });

  var htmlWhole = `<li class="sell-upload-item">
                      <figure class="sell-upload-figure landscape">
                        <img class="preview" style="vertical-align:middle">
                      </figure>
                      <div class="sell-upload-button">
                        <a href="#" class="sell-upload-edit">編集</a>
                        <a href="#" id="sell-upload-delete">削除</a>
                      </div>
                    </li>`

  var secondHtml = `<div class="sell-upload-items second">
                      <ul class="pictures"></ul>
                    </div>`

  var prepreView = $('.preview').length;

  $('.box-display-none').hide();

  for(num=0;num < prepreView; num++) {
    var id = document.getElementById("item_item_images_attributes_" + num  + "_image");
    $(id).parent().parent().hide();
  }

  var currentId = document.getElementById("item_item_images_attributes_" + num + "_image");
  $(currentId).parent().parent().show();

  var previewCount = $('.preview').length;
  if (previewCount == 1 || previewCount == 6){
    $('.sell-upload-drop-box').width(491);
  } else if (previewCount == 2 || previewCount == 7){
    $('.sell-upload-drop-box').width(363);
  } else if (previewCount == 3 || previewCount == 8){
    $('.sell-upload-drop-box').width(234);
  } else if (previewCount == 4 || previewCount == 9){
    $('.sell-upload-drop-box').width(106);
  } else if (previewCount == 5){
    $('.sell-upload-drop-box').width(620);
  } else if (previewCount == 10){
    $('.sell-upload-drop-box').css('display','none');
  }
  //出品ページに遷移後リロード
  $(document).on('change', 'input[type="file"]', function(e) { //fileを選択時に発火
    e.preventDefault();
    $preview = $(this).parent();
    previewFile(e,$preview);
    $(this).parent().parent().addClass("box-display-none");
    $(this).parent().parent().next('.form-mask-image').removeClass("box-display-none");
    $(this).parent().parent().next('.form-mask-image').removeClass("box-display-none");
  });
  function previewFile(e,$preview) {
    var file = e.target.files[0];
    var reader = new FileReader();
    if(file.type.indexOf("image") < 0){
      return false;
    }
    reader.onload = (function(file) {
      return function(e){

        var prepreView = $('.preview').length;
        if(prepreView <= 4){
          $('.pictures').append(htmlWhole);
          $('.sell-upload-item:last').children().children('img').attr({
            src: e.target.result,
            width: "100%",
          });
        }
        else if (prepreView == 5) {
          $('.sell-upload-items').after(secondHtml);
          $('.second .pictures').append(htmlWhole);
          $('.second .pictures .sell-upload-item:last').children().children('img').attr({
            src: e.target.result,
            width: "100%",
          });
        } else if (prepreView > 5) {
          $('.second .pictures').append(htmlWhole);
          $('.second .pictures .sell-upload-item:last').children().children('img').attr({
            src: e.target.result,
            width: "100%",
          });
        }

        var previewCount = $('.preview').length;

        currentId = document.getElementById("item_item_images_attributes_" + num + "_image");
        $(currentId).parent().parent().next().show();
        $(currentId).parent().parent().hide();
        num += 1;
        console.log(currentId);

        if (previewCount == 1 || previewCount == 6){
          $('.sell-upload-drop-box').width(491);
        } else if (previewCount == 2 || previewCount == 7){
          $('.sell-upload-drop-box').width(363);
        } else if (previewCount == 3 || previewCount == 8){
          $('.sell-upload-drop-box').width(234);
        } else if (previewCount == 4 || previewCount == 9){
          $('.sell-upload-drop-box').width(106);
        } else if (previewCount == 5){
          $('.sell-upload-drop-box').width(620);
        } else if (previewCount == 10){
          $('.sell-upload-drop-box').css('display','none');
        }
        $('#sell-upload-delete').click(function(){
          var c = $(this).parent().parent().prev().children().children().clone();
          c.val('');
          console.log(this);
          $(this).parent().parent().prev().children().children().replaceWith(c);
          c.remove();
          $(this).parent().parent().prev().addClass("box-display-none")
          $(this).parent().parent().prev().appendTo('.sell-dropbox-container');
        });
      };
    })(file);
    reader.readAsDataURL(file);
  }
});
