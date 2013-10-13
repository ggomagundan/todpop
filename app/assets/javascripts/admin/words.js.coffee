window.data = {}

ready = ->
  $(".word_img").click ->
    $("#word_remote_image_url").val($(this).attr('src'))
  


  $("#more-image").click ->
    page =  parseInt($('#more-image').data('page'), 10)
    word = if $('#add_query').val() == '' then $('#more-image').data('word') else $('#add_query').val()

    if word != $('input[name=before_query]').val()
      $('input[name=before_query]').val(word)
      page = 1
    
    url = encodeURI("http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=eee21c9d5b1d8c48de656e8b15140d31&tags="+word+"&per_page=20&page="+page+"&format=json&nojsoncallback=1")

    $.ajax url,
      type: 'GET'
      dataType: 'JSON'
      error: (jqXHR, textStatus, errorThrown) ->
        alert 're try plz'
      success: (data, textStatus, jqXHR) ->
        if data.photos.photo.length != 0
          for json in data.photos.photo
            pic_url =  "http://farm"+json.farm+".staticflickr.com/"+json.server+"/"+json.id+"_"+json.secret+".jpg"
            $(".word_images").append("<img src='"+pic_url+"' alt='pic' class='word_img' style='width:200px;margin:10px;cursor:pointer;'/>")
          $("#more-image").data('page',++page)
        else
          alert('no result for search')

        $(".word_img").click ->
          $("#word_remote_image_url").val($(this).attr('src'))

  $("#more-image").trigger('click')

$(document).ready(ready)
$(document).on('page:load', ready)
