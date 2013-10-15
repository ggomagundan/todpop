window.data = {}

ready = ->
  $(".noset").click ->
    if $(this).data('status') == 1
      location.href = '/admin/words'
    else
      location.href = '/admin/words?align=1'

  $(".word_img").click ->
    $("#word_remote_image_url").val($(this).data('url'))
  $("#more-image").click ->
    $('.loading').show();
    page =  parseInt($('#more-image').data('page'), 10)
    word = if $('#add_query').val() == '' then $('#more-image').data('word') else $('#add_query').val()

    if word != $('input[name=before_query]').val()
      $('input[name=before_query]').val(word)
      page = 1
    
    url = "/admin/words/"+word+"/get_img_url/"+page+".json"
    $.ajax url,
      type: 'GET'
      dataType: 'JSON'
      error: (jqXHR, textStatus, errorThrown) ->
        alert 'retry plz'
        $('.loading').hide()
      success: (json, textStatus, jqXHR) ->
        if json.data.url.length != 0
          for url_set in json.data.url
            $(".word_images").append("<img src='"+url_set.show+"' alt='pic' class='word_img' data-url='"+url_set.real_url+"' style='margin:10px;cursor:pointer;'/>")
          page += json.data.num
          $("#more-image").data('page',page)
        else
          alert('no result for search')
        $('.loading').hide()
        $(".word_img").click ->
          $("#word_remote_image_url").val($(this).data('url'))

  $("#more-image").trigger('click')
  $("#add_query").keyup (e) ->
    if e.which == 13
      $("#more-image").trigger('click')

$(document).ready(ready)
$(document).on('page:load', ready)
