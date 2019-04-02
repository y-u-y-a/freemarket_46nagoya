$(document).on('turbolinks:load', function() {
  var path = location.pathname;
  if(path == "/users/sign_up"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "http://localhost:3000/to_signup";
    });
  }
  if(path == "/users"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "http://localhost:3000/to_signup";
    });
  }
  if(path == "/signup/profile"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "http://localhost:3000/to_signup";
    });
  }
  if(path == "/signup/address"){
    history.pushState(null, null, null);
    $(window).on("popstate", function (event) {
      location.href = "http://localhost:3000/to_signup";
    });
  }
  if(path == "/signup/credit"){
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
