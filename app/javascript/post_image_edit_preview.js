/*global $*/
$(document).on('turbolinks:load', function() {
  $(function () {
    function readURL(input) {
      if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          $('.post_img_edit_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
      }
    }

    $('.post_img_edit_field').change(function () {
      readURL(this);
    });
  });
});