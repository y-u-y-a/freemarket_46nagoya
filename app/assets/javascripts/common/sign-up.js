$(document).on('turbolinks:load', function() {
  var path = location.pathname;

  if(path == "/users/sign_up"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "https://www.freemarket46nagoya.com/to_signup";
    });
  }
  if(path == "/users"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "https://www.freemarket46nagoya.com/to_signup";
    });
  }
  if(path == "/signup/profile"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "https://www.freemarket46nagoya.com/to_signup";
    });
  }
  if(path == "/signup/address"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "https://www.freemarket46nagoya.com/to_signup";
    });
  }
  if(path == "/signup/credit"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "https://www.freemarket46nagoya.com/to_signup";
    });
  }
  if(path == "/to_signup"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "https://www.freemarket46nagoya.com";
    });
  }
  if(path.match(/great/)){
    $(".mypage-tab-container__tabs .good").addClass('active');
  } else if(path.match(/good/)) {
    $(".mypage-tab-container__tabs .normal").addClass('active');
  } else if(path.match(/poor/)){
    $(".mypage-tab-container__tabs .bad").addClass('active');
  } else {
    $(".mypage-tab-container__tabs .all").addClass('active');
  }

});
