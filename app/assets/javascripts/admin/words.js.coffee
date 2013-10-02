$ ->
  $(".word_img").click ->
    $("#word_remote_image_url").val($(this).attr('src'))

