gene_question_box = (start, end) ->
  for i in [start...end]
    $("#questions").append("
      <div class='question'>
        <table class='table'>
          <tr>
            <th>q_no</th>
            <td>"+(i*1+1)+" <input type='hidden' name='q_no[]' value='"+(i*1+1)+"'/></td>
          </tr>
          <tr>
            <th>q_type</th>
            <td>
              <select name='q_type[]'>
                <option value='1'>NO IMAGE (CHOICE ANSWER)</option>
                <option value='2'>IMAGE (CHOICE ANSWER)</option>
                <option value='3'>NO IMAGE (SHORT ANSWER)</option>
                <option value='4'>IMAGE (SHORT ANSWER)</option>
              </select>
            </td>
          </tr>
          <tr>
            <th>q_text</th>
            <td><textarea name='q_text[]'></textarea></td>
          </tr>
          <tr>
            <th>q_image</th>
            <td><input type='file' name='q_image[]'/></td>
          </tr>
          <tr>
            <th>n_answer</th>
            <td>
              <select name='n_answer[]'>
                <option value='0'>0</option>
                <option value='1'>1</option>
                <option value='2'>2</option>
                <option value='3'>3</option>
                <option value='4'>4</option>
                <option value='5'>5</option>
              </select>
            </td>
          </tr>
          <tr>
            <th>a1</th>
            <td><textarea name='a1[]'></textarea></td>
          </tr>
          <tr>
            <th>a2</th>
            <td><textarea name='a2[]'></textarea></td>
          </tr>
          <tr>
            <th>a3</th>
            <td><textarea name='a3[]'></textarea></td>
          </tr>
          <tr>
            <th>a4</th>
            <td><textarea name='a4[]'></textarea></td>
          </tr>
          <tr>
            <th>a5</th>
            <td><textarea name='a5[]'></textarea></td>
          </tr>
        </table>
      </div>
    ")

$(document).ready ->
  $('.q_img_delete').unbind('click').click ->
    if $(this).attr('data-status') == '0'
      $(this).attr('data-status', '1')
      $('input[data-did='+$(this).attr('data-did')+']').val('1')
      $(this).html('DELETE (if click NOT DELETED)')
      $(this).css('font-weight','bold')
    else
      $(this).attr('data-status', '0')
      $('input[data-did='+$(this).data('did')+']').val('0')
      $(this).html('NOT DELETE (if click DELETED)')
      $(this).css('font-weight','normal')

  $("#cpx_advertisement_n_question").change -> 
    if $(this).val() == '0'
      $("#questions").html('')
      $("#questions").css('display','none')
    else
      $("#questions").css('display','block')
      if $("input[name=question_count]").val() == '0'
        $("#questions").append("
            <div class='question'>
              <table class='table'>
                <tr>
                  <th>q_no</th>
                  <td>0 (설문 설명)</td>
                </tr>
                <tr>
                  <th>q_type</th>
                  <td>
                    <select>
                      <option value='0' selected='selected'>CPS SPECIFICATION</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <th>q_text</th>
                  <td><textarea name='spec_text'/></textarea></td>
                </tr>
              </table>
            </div>
        ")
        gene_question_box(0, $(this).val()*1)
      else if $("input[name=question_count]").val()*1 < $(this).val()*1
        gene_question_box($("input[name=question_count]").val()*1, $(this).val()*1)
      else
        for i in [0...$("input[name=question_count]").val()*1-$(this).val()*1]
          $(".question").last().remove()

    $('input[name=question_count]').val($(this).val())
