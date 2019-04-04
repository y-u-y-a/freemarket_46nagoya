var secondHtml = `<div class="sell-upload-items second">
                    <ul class="pictures"></ul>
                  </div>`
  //出品ページに遷移後リロード
$(document).on('change', 'input[type="file"]', function(e) { //fileを選択時に発火
  e.preventDefault();
  $preview = $(this);
  previewFile(e,$preview);
});
function previewFile(e,$preview) {
  var file = e.target.files[0];
  var reader = new FileReader();
  if(file.type.indexOf("image") < 0){
    return false;
  }
  reader.onload = (function(file) {
    return function(e){

      for(i=0;i < 10; i++) {
        var htmlWhole = `<li class="sell-upload-item">
                            <figure class="sell-upload-figure landscape">
                              <img class="preview" style="vertical-align:middle" src="${e.target.result}" style={"width":100%}>
                            </figure>
                            <div class="sell-upload-button">
                              <a href="#" class="sell-upload-edit">編集</a>
                              <a href="#" id="sell-upload-delete${i}">削除</a>
                            </div>
                          </li>`
      }

      console.log(htmlWhole);
      var preView = $('.preview').length;
      if(preView <= 4){
        $('.pictures').append(htmlWhole);
      } else if (preView == 5) {
        $('.sell-upload-items').after(secondHtml);
        $('.second .pictures').append(htmlWhole);
      } else if (preView > 5) {
        $('.second .pictures').append(htmlWhole);
      }

      var previewCount = $('.preview').length;

      var currentId = document.getElementById("item_item_images_attributes_" + num + "_image");
      $(currentId).parent().parent().next().show();
      $(currentId).parent().parent().hide();
      num += 1;

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
        $(this).parent().parent().prev().children().children().replaceWith(c);
        c.remove();
        $(this).parent().parent().prev().addClass("box-display-none")
        $(this).parent().parent().prev().appendTo('.sell-dropbox-container');
      });
    };
  })(file);
  reader.readAsDataURL(file);
}
