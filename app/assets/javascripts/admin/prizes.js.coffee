window.data = {}
ready = ->
  $('.date').datepicker({format: 'yyyy-mm-dd'})

  
$(document).ready(ready)
$(document).on('page:load', ready)
  

