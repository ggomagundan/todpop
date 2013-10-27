$(document).ready ->
	$('.q_img_delete').unbind('click').click ->
		console.log("data-status : "+$(this).attr('data-status'))
		if $(this).attr('data-status') == '0'
			console.log('00000000')
			$(this).attr('data-status', '1')
			$('input[data-did='+$(this).attr('data-did')+']').val('1')
			$(this).html('DELETE (if click NOT DELETED)')
			$(this).css('font-weight','bold')
		else
			console.log('111111111')
			$(this).attr('data-status', '0')
			$('input[data-did='+$(this).data('did')+']').val('0')
			$(this).html('NOT DELETE (if click DELETED)')
			$(this).css('font-weight','normal')

	$("#cpx_advertisement_n_question").change ->
    $("#questions").html('')
    if $(this).val() == '0'
    	$("#questions").css('display','none')
    else
    	$("#questions").css('display','block')
	    for i in [1..$(this).val()]
	      $("#questions").append("
	          <div class='question'>
	          	<table class='table'>
	          		<tr>
	          			<th>q_no</th>
	          			<td>"+i+" <input type='hidden' name='q_no[]' value='"+i+"'/></td>
	          		</tr>
	          		<tr>
	          			<th>q_type</th>
	          			<td>
	          				<select name='q_type[]'>
	          					<option value='1'>NO IMAGE</option>
	          					<option value='2'>IMAGE</option>
	          					<option value='3'>NO IMAGE SINGLE</option>
	          					<option value='4'>IMAGE SINGLE</option>
	          				</select>
	          			</td>
	          		</tr>
	          		<tr>
	          			<th>q_text</th>
	          			<td><input type='text' name='q_text[]'/></td>
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
	          			<td><input type='text' name='a1[]'/></td>
	          		</tr>
	          		<tr>
	          			<th>a2</th>
	          			<td><input type='text' name='a2[]'/></td>
	          		</tr>
	          		<tr>
	          			<th>a3</th>
	          			<td><input type='text' name='a3[]'/></td>
	          		</tr>
	          		<tr>
	          			<th>a4</th>
	          			<td><input type='text' name='a4[]'/></td>
	          		</tr>
	          		<tr>
	          			<th>a5</th>
	          			<td><input type='text' name='a5[]'/></td>
	          		</tr>
	          	</table>
	          </div>
	      ")
