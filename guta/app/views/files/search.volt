{{ content() }}

<h1 class="text-center">Recherche</h1>

{{ form('files/search', 'method': 'post', "class": "col-lg-12", "style": "width:340px;margin:0 auto;") }}
	
	
    <div class="form-group input-group ">
        {{ text_field("pattern", 'class': 'form-control', "id": "inputUsername","placeholder":"Recherche") }}
        <span class="input-group-btn">
        	{{ submit_button('Go!', "class":"btn btn-default") }}
      	</span>
    </div>


    
{{ end_form() }}
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
					<td><span class="glyphicon glyphicon-folder-open"> {{ link_to("files/list" ~ "/" ~ dir['path'], dir['name']) }}</span></td>
					<td>{% if dir['size'] != null %} {{ dir['size'] }} ko {% endif %}</td>
					<td></td>
				</tr>
			{% endfor %}
			{% for file in files %}
				<tr class="downloadable">
					<td><span class="glyphicon glyphicon-file"> {{ link_to("files/view" ~ file['path'], file['name']) }}</span></td>
					<td>{% if file['size'] != null %} {{ file['size'] }} ko {% endif %}</td>
					<td>{{ file['modifyDate'] }}</td>
				</tr>
			{% endfor %}
		
	</tbody>
</table>
