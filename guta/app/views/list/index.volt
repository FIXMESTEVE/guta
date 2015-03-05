
<?php echo $this->getContent() ?>

<div align="center">
    <h1>Your Files</h1>
</div>

<table class="table">
  	<tr>
  		<input type="file" value="Add File" />
  		<button></button>
  	</tr>
</table>

<table class="table">
{% for item in result %}
	<tr>
		<td><a href="/guta/list/view/{{ item }}">{{ item }}</a></td>
	</tr>
{% endfor %}
</table>