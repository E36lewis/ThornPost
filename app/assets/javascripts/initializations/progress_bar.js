var ProgressBar = {
  init: function() {
    // Hook into Turbolinks event
    $(document).on('turbolinks:fetch', function() {
      $('[data-behavior="progress-bar"]').addClass('active');
    });

    $(document).on('turbolinks:load', function() {
      $('[data-behavior="progress-bar"]').removeClass('active');
    });
  }
};

$(document).ready(ProgressBar.init);
$(document).on('page:load', ProgressBar.init);
