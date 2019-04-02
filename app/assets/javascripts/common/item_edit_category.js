$(document).on('turbolinks:load', function(){
  var path = location.pathname;
  // プルダウンのoption内容をコピー
  var cate2 = $("#category2-select option").clone();
  var cate3 = $("#category3-select option").clone();
  var val1 = $("#category1-select").val();
  $("#category2-select option[class != "+val1+"]").remove();
  var val2 = $("#category2-select").val();
  $("#category3-select option[class != "+val2+"]").remove();

  if(path.match(/item_search_result/)){
    document.getElementById("category1-select").options[0].selected = true;
    $("#category2-select").prepend('<option value="" selected="selected">---</option>');
    $("#category3-select").prepend('<option value="" selected="selected">---</option>');
  } else {
    $("#category2-select").prepend('<option value="">---</option>');
    $("#category3-select").prepend('<option value="">---</option>');
  }

  // 1→2連動
  $("#category1-select").change(function () {
    var val1 = $("#category1-select").val();

    // $("#category2-select").removeAttr("disabled");
    if (val1 == "") {
      $("#category2").hide();
      $("#category3").hide();
    } else {
      $("#category2").show();
    }

    // 一旦、category2のoptionを削除
    $("#category2-select option").remove();

    // (コピーしていた)元のcategory2を表示
    $(cate2).appendTo("#category2-select");

    // 選択値以外のクラスのoptionを削除
    $("#category2-select option[class != "+val1+"]").remove();

    // 「▼選択」optionを先頭に表示
    $("#category2-select").prepend('<option value="" selected="selected">---</option>');

    // lv3Pulldown disabled処理
    // $("#category3-select").attr("disabled", "disabled");
    $("#category3-select").show();
    $("#category3-select option").remove();
    $("#category3-select").prepend('<option value="" selected="selected">---</option>');
  });

  // 2→3連動
  $("#category2-select").change(function () {
    var val2 = $("#category2-select").val();

    if (val2 == "") {
      $("#category3").hide();
    } else {
      $("#category3").show();
    }

    // 一旦、lv3Pulldownのoptionを削除
    $("#category3-select option").remove();

    // (コピーしていた)元のlv3Pulldownを表示
    $(cate3).appendTo("#category3-select");

    // 選択値以外のクラスのoptionを削除
    $("#category3-select option[class != "+val2+"]").remove();

    // 「▼選択」optionを先頭に表示
    $("#category3-select").prepend('<option value="" selected="selected">---</option>');
  });
});
