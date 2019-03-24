$(document).on('turbolinks:load', function() {  //出品ページに遷移後リロード
  $('.form-mask-image-new:first').removeClass('box-display-none-new') //最初のdropbox以外を非表示
   $(document).on('change', 'input[type="file"]', function(event) { //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
    $preview_new = $(this).parent(); //fileの親要素を$preview_newに代入
    previewfile(event,$preview_new) //プレビューを生成
    $(this).parent().addClass("box-display-none-new");
    $(this).parent().parent().parent().addClass("box-display-none-new"); //dropbox非表示
    $(this).parent().parent().parent().next('.form-mask-image-new').removeClass("box-display-none-new"); //次のdropbox表示
    $(this).parent().parent().parent().next('.form-mask-image-new').children().children().removeClass("box-display-none");
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
        if  (previewCount == 1){
          $('label').width(490);
        } else if (previewCount == 2){
          $('label').width(360);
        } else if (previewCount == 3){
          $('label').width(230);
        } else if (previewCount == 4){
          $('label').width(100);
        }
        var delete_btn = $('<div class="delete-button-new">').text('削除').on('click',function(){
          var c = $(this).parent().parent().prev().children().children().children("").clone();//fileクローンをcに代入
          c.val('');
          $(this).parent().parent().prev().children().children().children("").replaceWith(c);//１つ前のfileにクローンを置き換える
          c.remove()
          $(this).parent().parent().prev().addClass("box-display-none-new");
          $(this).parent().parent().prev().appendTo('.sell-form__dropbox-container');
          $(this).parent().parent().remove(); //削除ボタンを押したimage-box-1削除
          // $(".image-box-1-new:last").next(".form-mask-image-new").removeClass("box-display-none-new");
          // $(".image-box-1-new:last").next(".form-mask-image-new").children().children().removeClass("box-display-none-new");
          // var label = $(this).parent().parent().next('label').style;
          var label = document.querySelector("label");
          // var label = document.querySelector(this).parent().parent().next();
          var width = parseInt(label.style.width);
          label.style.width = (width + 130) + "px"; //dropboxのwidth+130
        });
        $('.replace').replaceWith(delete_btn); //replaceを置き換える
      };
    })(file);
    reader.readAsDataURL(file);
  }
})
