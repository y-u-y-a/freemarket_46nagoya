$(document).on('turbolinks:load', function() {
  var path = location.pathname;
  if(path == "/users/sign_up"){
    $(".member-page").addClass("active");
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "http://localhost:3000/to_signup";
    });
  }
  if(path == "/users"){
    $(".phone-page").addClass("active");
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "http://localhost:3000/to_signup";
    });
  }
  if(path == "/signup/profile"){
    $(".address-page").addClass("active");
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "http://localhost:3000/to_signup";
    });
  }
  if(path == "/signup/address"){
    $(".credit-page").addClass("active");
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "http://localhost:3000/to_signup";
    });
  }
  if(path == "/signup/credit"){
    $(".comp-page").addClass("active");
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "http://localhost:3000/to_signup";
    });
  }
  if(path == "/to_signup"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "http://localhost:3000";
    });
  }
});
