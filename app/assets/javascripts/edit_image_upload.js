$(function() {
  $(document).on('turbolinks:load', function() {  //出品ページに遷移後リロード
    $('.sell-upload-drop-box:first').removeClass('box-display-none') //css display:none
     $(document).on('change', 'input[type="file"]', function(event) { //fileを選択時に発火
      var
      $preview = $(this).parent();
      previewFile(event,$preview);
      $(this).addClass("box-display-none");
      // $(this).parent().parent().parent().addClass("box-display-none");
      // $(this).parent().parent().parent().next('.form-mask-image').removeClass("box-display-none");
      // $(this).parent().parent().parent().next('.form-mask-image').children().children().removeClass("box-display-none");
    })
    function previewFile(e,$preview) {
      var file = e.target.files[0],
          reader = new FileReader();
      if(file.type.indexOf("image") < 0){
        return false;
      }
      reader.onload = (function(file) {
        return function(e){
          var html_whole = `<li class="sell-upload-item">
                              <figure class="sell-upload-figure landscape">
                                <img>
                              </figure>
                              <div class="sell-upload-button">
                                <a href="#" class="sell-upload-edit">編集</a>
                                <a href="#" id="image-delete-button">削除</a>
                              </div>
                            </li>`

          // $preview.append(html_whole).attr({
          //   src: e.target.result,
          //   width: "100%",
          //   class: "add-picture",
          //   margin: "auto",
          //   title: file.name
          // })
          $preview.parent().parent().after(html_whole)
          $preview.parent().parent().next().children().children('img').attr({
            src: e.target.result,
            width: "100%",
            class: "add-picture",
            margin: "auto",
            title: file.name
          })
          var delete_btn = $('<div class="delete-button">').text('削除').on('click',function(){
            var c = $(this).parent().parent().prev().children().children().children("").clone();
            c.val('');
            $(this).parent().parent().prev().children().children().children("").replaceWith(c);
            c.remove()
            $(this).parent().parent().prev().addClass("box-display-none")

            $(this).parent().parent().prev().appendTo('.sell-content__image-upload-box--sell-dropbox-container');
            $(this).parent().parent().remove()

            $(".image-box-1:last").next(".form-mask-image").removeClass("box-display-none");

            $(".image-box-1:last").next(".form-mask-image").children().children().removeClass("box-display-none");
          });
          $('.replace').replaceWith(delete_btn)
        };
      })(file);
      reader.readAsDataURL(file);
    }
  })
})
