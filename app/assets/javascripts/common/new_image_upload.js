$(document).on('turbolinks:load', function() {  //出品ページに遷移後リロード
  var path = location.pathname;
  if(path == "/items/new"){
    console.log("出品");
    $('.form-mask-image-new:first').removeClass('box-display-none-new') //最初のdropbox以外を非表示
     $(document).on('change', 'input[type="file"]', function(event) { //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
      $preview_new = $(this).parent(); //fileの親要素を$preview_newに代入
      previewfile(event,$preview_new) //プレビューを生成
      $(this).parent().parent().parent().addClass("box-display-none-new"); //dropbox非表示
      $(this).parent().parent().parent().next('.form-mask-image-new').removeClass("box-display-none-new"); //次のdropbox表示
    })
    function previewfile(e,$preview_new) {
      var file = e.target.files[0],
          reader = new FileReader();
      if(file.type.indexOf("image") < 0){ //image以外はfalse
        return false;
      }
      reader.onload = (function(file) {
        return function(e){
          var html_whole_new = `<div class="image-box-1-new" style="display:inline-block">
                                  <div class="image-box-2-new">
                                    <img class="img">
                                  </div>
                                  <div class="edit-delete-button-new">
                                    <div class="edit-button-new">編集</div>
                                    <div class="replace"></div>
                                  </div>
                                </div>`
          $preview_new.parent().parent().after(html_whole_new)
          $preview_new.parent().parent().next().children().children('img').attr({
            src: e.target.result,
            width: "100%",
            height: "100%",
            class: "preview"
          })
          var previewCount = $('.preview').length; //previewの数によってdropboxのwidthを変更
          if  (previewCount == 1 || previewCount == 6){
            $('.form-mask-image-new').width(490);
          } else if (previewCount == 2 || previewCount == 7){
            $('.form-mask-image-new').width(360);
          } else if (previewCount == 3 || previewCount == 8){
            $('.form-mask-image-new').width(230);
          } else if (previewCount == 4 || previewCount == 9){
            $('.form-mask-image-new').width(100);
          } else if (previewCount == 5){
            $('.form-mask-image-new').width(620);
          } else if (previewCount == 10){
            $('.form-mask-image-new').addClass('box-display-none-new');
          }
          var delete_btn = $('<div class="delete-button-new">').text('削除').on('click',function(){
            var c = $(this).parent().parent().prev().children().children().children("").clone();//fileクローンをcに代入
            c.val('');
            $(this).parent().parent().prev().children().children().children("").replaceWith(c);//１つ前のfileにクローンを置き換える
            c.remove() //クローンを削除
            $(this).parent().parent().prev().appendTo('.sell-form__dropbox-container');
            $(this).parent().parent().remove(); //削除ボタンを押したimage-box-1削除
            $(".image-box-1-new:last").next(".form-mask-image-new").removeClass("box-display-none-new");//完全に消えたdropboxを復活させる
            var deleteCount = $('.preview').length; //previewの数によってdropboxのwidthを変更
            if (deleteCount == 0 || deleteCount == 5){
              $('.form-mask-image-new').width(618);
            } else if (deleteCount == 1 || deleteCount == 6){
              $('.form-mask-image-new').width(490);
            } else if (deleteCount == 2 || deleteCount == 7){
              $('.form-mask-image-new').width(360);
            } else if (deleteCount == 3 || deleteCount == 8){
              $('.form-mask-image-new').width(230);
            } else if (deleteCount == 4 || deleteCount == 9){
              $('.form-mask-image-new').width(100);
            }
          });
          $('.replace').replaceWith(delete_btn); //replaceをdeleteボタンに置き換える
        };
      })(file);
      reader.readAsDataURL(file);
    }
  }
})
