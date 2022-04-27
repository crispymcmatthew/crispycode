(function ( $ ) {
  //Check on scroll
  var web_window = $(window);
  var animation_elements = $.find(".animation-element");
  var stickyNavTop = $('.main--navigation--container').offset().top;

  function check_if_in_view() {
   var window_height = web_window.height();
   var window_top_position = web_window.scrollTop();
   var window_bottom_position = (window_top_position + window_height);

   $.each(animation_elements, function(){
     var element = $(this);
     var element_height = $(element).outerHeight();
     var element_top_position = $(element).offset().top;
     var element_bottom_position = (element_top_position + element_height);
     if (element_top_position <= window_bottom_position){
       element.addClass('in-view');
     }
     else {
       // element.removeClass('in-view');
     }
   })
  }
  //Sticky Navigation
  var stickyNav = function(){
    var scrollTop = $(window).scrollTop();

    if (scrollTop > stickyNavTop) {
        $('.main--navigation--container').addClass('sticky');
    } else {
        $('.main--navigation--container').removeClass('sticky');
    }
  };

  $(window).on("scroll resize", function(){
    check_if_in_view();
    stickyNav();
    var thisWidth = $(".same--width").width();
    $(".same--width").height(thisWidth);
  });
  $(window).trigger('scroll');
  $(window).on("load", function(){
    $("body").css("opacity","1");
  })

  $(".icon--play").mouseenter(function(){
    $(".video--container").addClass("hover");
  });
  $(".icon--play").mouseleave(function(){
    $(".video--container").removeClass("hover");
  });

  var thisWidth = $(".same--width").width();
  $(".same--width").height(thisWidth);

  $(".icon--play").each(function () {
    var thisTarget = $(this).attr("data-target");
    var videoSrc = $(thisTarget).find("iframe").attr("src");

    $(thisTarget).on("show.bs.modal", function () { // on opening the modal
      $(thisTarget).find("iframe").attr("src", videoSrc + "?autoplay=1");
    });

    $(thisTarget).on("hidden.bs.modal", function () { // on closing the modal
      // stop the video
      $(thisTarget).find("iframe").attr("src", null);
    });
  });

  if($(".opera--carousel.owl-carousel").length > 0){
    $(".opera--carousel.owl-carousel").owlCarousel({
      items: 3,
      nav: false,
    });
  }
}( jQuery ));

  var is_chrome = !!window.chrome && !is_opera;
  var is_explorer= typeof document !== 'undefined' && !!document.documentMode && !isEdge;
  var is_firefox = typeof window.InstallTrigger !== 'undefined';
  var is_safari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);
  if ( /^((?!chrome|android).)*safari/i.test(navigator.userAgent)) {
    alert('Its Safari');
  }
  var is_opera = !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
