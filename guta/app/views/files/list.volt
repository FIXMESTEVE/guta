{{ content() }}


<table class="table table-hover" style="width:80%" data-sortable>
	<thead>
		<tr>
			<th>Nom</th>
		</tr>
	</thead>
	<tbody>
		
			{% for dir in directories %}
				<tr><td>{{ link_to("files/list" ~ currentDir ~ "/" ~ dir, dir) }}</td></tr>
			{% endfor %}
			{% for file in files %}
				<tr><td>{{ link_to("files/view" ~ currentDir  ~ "/" ~ file, file) }}</a></td></tr>
			{% endfor %}

		
	</tbody>
</table>
