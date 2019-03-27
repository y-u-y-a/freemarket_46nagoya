$(document).on('turbolinks:load', function(){
  $("ul.main-category").hide();
  $("ul.child-category").hide();
  $("ul.grand-child-category").hide();
  $("ul.main-brand").hide();


  $(".lists-menu__brands").hover(function(e){
    e.preventDefault();
    $("ul:not(:animated)",this).show();
    },
    function(){
      $("ul",this).hide();
  })

  $(".lists-menu__categories").hover(function(e){
    e.preventDefault();
    $(".main-category:not(:animated)",this).show();
    },
    function(){
      $(".main-category",this).hide();
  })

  $(".main-category__list").hover(function(e){
    e.preventDefault();
    var val = (this.id);
    val = "ul#child_category_ul_" + val.replace(/[^0-9]/g, "");
    var val_not = val + ":not(:animated)";
    $(val_not,this).show();
    },
    function(){
      var val = (this.id);
      val = "ul#child_category_ul_" + val.replace(/[^0-9]/g, "");
      $(val,this).hide();
  })

  $(".child-category__list").hover(function(e){
    e.preventDefault();
    var val2 = (this.id);
    val2 = "ul#grand_child_category_ul_" + val2.replace(/[^0-9]/g, "");
    var val2_not = val2 + ":not(:animated)";
    $(val2_not,this).show();
    },
    function(){
      var val2 = (this.id);
      val2 = "ul#grand_child_category_ul_" + val2.replace(/[^0-9]/g, "");
      $(val2,this).hide();
  })
});
