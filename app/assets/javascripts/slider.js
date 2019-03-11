$(function(){
  var mySwiper = new Swiper('.swiper-container', {
    preventClicks: false,
    preventClicksPropagation: false,
    loop: true,
    pagination: {
      el: '.swiper-pagination',
      type: 'bullets',
      clickable: true,
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev'
    },
    autoplay: {
      delay: 3000,
      stopOnLastSlide: false,
      disableOnInteraction: true,
      reverseDirection: false
    },
  });
  $('.swiper-pagination-bullet').hover( function() {
    $(this).click();
  })
});

