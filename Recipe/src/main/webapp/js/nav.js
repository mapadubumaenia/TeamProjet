function initNavigation() {
    const isMobile = window.innerWidth <= 768;

    $('.menu-toggle').off('click').on('click', function () {
      $('.main-nav').slideToggle();
    });

    if (isMobile) {
      $('.dropdown > .nav-link').off('click').on('click', function (e) {
        e.preventDefault();
        const $dropdown = $(this).siblings('.dropdown-menu');

        $('.dropdown-menu').not($dropdown).slideUp();

        $dropdown.stop(true, true).slideToggle(200);
      });

      $('.main-nav').hide();

    } else {
      $('.dropdown > .nav-link').off('click');
      $('.dropdown-menu').removeAttr('style');

      $('.main-nav').show();
    }
  }

  $(document).ready(function () {
    initNavigation();

    let resizeTimer;
    $(window).on('resize', function () {
      clearTimeout(resizeTimer);
      resizeTimer = setTimeout(() => {
        initNavigation();
      }, 200);
    });
  });
