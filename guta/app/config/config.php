<?php 
	$config = new \Phalcon\Config(array(
		"database" => array(
			"host" => "localhost",
			"username" => "root",
			"password" => "",
			"dbname" => "guta"),
		"application" => array(
			"controllersDir" => "../app/controllers/",
			"modelsDir" => "../app/models/",
			"viewsDir" => "../app/views/",
			"libraryDir" => "../app/library",
			"baseUri" => "/ped/guta/guta/",
			"cacheDir" => "../app/cache/",
			"pluginDir" => "../app/plugin")
	));