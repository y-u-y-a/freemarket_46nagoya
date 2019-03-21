$(document).on('turbolinks:load', function(){
  $("ul.main-category").hide();
  $("ul.main-brand").hide();

  $(".lists-menu__brands").hover(function(e){
    e.preventDefault();
    $("ul:not(:animated)",this).show()
    },
    function(){
      $("ul",this).hide();
  })

  $(".lists-menu__categories").hover(function(e){
    e.preventDefault();
    $("ul:not(:animated)",this).show()
    },
    function(){
      $("ul",this).hide();
  })
});
