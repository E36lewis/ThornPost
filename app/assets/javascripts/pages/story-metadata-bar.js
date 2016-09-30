var StoryMetadataBar = {
  init: function() {
    if (!$('[data-page="story-metadata-bar"]').length > 0) {
      return;
    }

    var lastScrollTop = 0;
    var $metadataBar = $('[data-behavior="animated-metadata"]');
    $(window).scroll(function(event) {
      var st = $(this).scrollTop();

      if (st > lastScrollTop) {
        // downscroll event
        $metadataBar.removeClass('is-inView');
        $metadataBar.addClass('is-hidden');
      } else {
        // upscroll event
        $metadataBar.removeClass('is-hidden');
        $metadataBar.addClass('is-inView');
      }
      lastScrollTop = st;
    });
  }
};

$(document).ready( StoryMetadataBar.init );
$(document).on( 'page:load', StoryMetadataBar.init );
