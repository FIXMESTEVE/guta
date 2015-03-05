{{ content() }}


<table class="table table-hover" style="width:80%" data-sortable>
	<thead>
		<tr>
			<th>Nom</th>
		</tr>
	</thead>
	<tbody>
		
			{% for dir in directories %}
				<tr><td>{{ dir }}</td></tr>
			{% endfor %}
			{% for file in files %}
				<tr><td>{{ file }}</td></tr>
			{% endfor %}

		
	</tbody>
</table>
