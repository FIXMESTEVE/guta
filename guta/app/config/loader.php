<?php

$loader = new \Phalcon\Loader();

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerClasses(
    array(
        "Some"         => "library/Parsedown.php",
    )
);
$loader->registerDirs(
    array(
        $config->application->controllersDir,
        $config->application->libraryDir,
        $config->application->modelsDir
    )
)->register();
