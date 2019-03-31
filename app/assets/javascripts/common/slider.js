$(document).on('turbolinks:load', function() {
  $(function(){
    var mySwiper = new Swiper('.swiper-container', {
      preventClicks: false,
      preventClicksPropagation: false,
      loop: true,
      speed: 700,
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
        delay: 3500,
        stopOnLastSlide: false,
        disableOnInteraction: false,
        reverseDirection: false
      },
    });
    $('.swiper-pagination-bullet').hover( function() {
      $(this).click();
    })
  });
});
