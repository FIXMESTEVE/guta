{{ content() }}

<h1 class="text-center">Mes fichiers</h1>

<table class="table table-hover" style="width:80%" data-sortable>
	<thead>
		<tr>
			<th>Nom</th>
			<th>Taille</th>
			<th>Modification</th>
		</tr>
	</thead>
	<tbody>
		
			{% for dir in directories %}
				<tr>
					<td><span class="glyphicon glyphicon-folder-open"> {{ link_to("files/list" ~ currentDir ~ "/" ~ dir['name'], dir['name']) }}</span></td>
					<td>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</td>
					<td></td>
				</tr>
			{% endfor %}
			{% for file in files %}
				<tr class="downloadable">
					<td><span class="glyphicon glyphicon-file"> {{ link_to("files/view" ~ currentDir  ~ "/" ~ file['name'], file['name']) }}</span></td>
					<td>{% if file['size'] != null %} {{ file['size'] }} ko {% endif %}</td>
					<td>{{ file['modifyDate'] }}</td>
				</tr>
			{% endfor %}
		
	</tbody>
</table>
