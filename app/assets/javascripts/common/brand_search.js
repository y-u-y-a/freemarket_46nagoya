$(document).on('turbolinks:load', function(){
  $(".brand_field").hide();
  var path = location.pathname;
  if(path == "/users/sign_up"){
    document.getElementById( "brand_search" ).value = "";
  }
  function appendBrand(brand) {
    var html = `<li class="brand_list" id="${brand.id}">${brand.name}</li>`;
    return html;
  }
  $("#brand_search").on("keyup", function() {
    var input = $("#brand_search").val();

    $.ajax({
      type: 'GET',
      url: '/items/new',
      data: { keyword: input },
      dataType: 'json'
    })

    .done(function(brands) {
      var html = "";
      brands.forEach(function(brand) {
        if (input.length === 0) {
          $("#brand_result li").remove();
        } else {
        html += appendBrand(brand);
        }
      });

      $("#brand_result").html(html);
    })
    .fail(function() {
      console.log('検索に失敗しました');
    });
  });

  $(".brand_field").on('click', ".brand_list",function() {
    // var id   = (this.id);
    var name = $(this).text();
    document.getElementById( "brand_search" ).value = name;
    $("#brand_result li").remove();
  });
});
