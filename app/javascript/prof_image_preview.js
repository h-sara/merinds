/*global $*/
$(document).on('turbolinks:load', function() {
  $(function () {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('.prof_img_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }

    $('.prof_img_field').change(function () {
      readURL(this);
    });
  });
});