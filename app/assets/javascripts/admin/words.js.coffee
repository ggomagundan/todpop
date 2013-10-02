$ ->
  $(".word_img").click ->
    alert '선택되었습니다'
    $("#word_remote_image_url").val($(this).attr('src'))

