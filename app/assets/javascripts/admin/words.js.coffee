$ ->
  $(".word_img").click ->
    $("#word_remote_image_url").val($(this).attr('src'))

  $("#more-image").click ->
    page =  parseInt($('#more-image').data('page'), 10)+1
    $("#more-image").data('page',page)
    url = "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=eee21c9d5b1d8c48de656e8b15140d31&tags=run&per_page=20&page="+(page-1)+"&format=json&nojsoncallback=1"
    $.ajax url,
      type: 'GET'
      dataType: 'JSON'
      error: (jqXHR, textStatus, errorThrown) ->
        alert 're try plz'
      success: (data, textStatus, jqXHR) ->
        
        for json in data.photos.photo
          pic_url =  "http://farm"+json.farm+".staticflickr.com/"+json.server+"/"+json.id+"_"+json.secret+".jpg"
          $(".word_images").append("<img src='"+pic_url+"' alt='pic' class='word_img' />")

        $("#more-image").data('page',page)

        $(".word_img").click ->
          $("#word_remote_image_url").val($(this).attr('src'))
