<?php

use Phalcon\Mvc\Controller;

class FilesController extends Controller
{
    public function initialize()
    {
        \Phalcon\Tag::setTitle('MyDropbox');
    }

    public function indexAction()
    {
       $this->assets
            ->addCss("css/bootstrap.min.css")
            ->addCss("css/styles.css")
            ->addCss("css/dropzone.css");

        $this->assets
            ->addJs("js/jquery-1.11.2.min.js")
            ->addJS("js/bootstrap.min.js")
            ->addJs("js/dropzone.js");
    }

    public function uploadAction()
    {
        $ds          = DIRECTORY_SEPARATOR;  // '/'
 
        $storeFolder = 'uploadedFiles';   // the folder where we store all the files
         
        $user = 'tomtom'; //the user who signed in (tomtom currently used as a placeholder)

        if (!empty($_FILES)) {
             
            $tempFile = $_FILES['file']['tmp_name'];
              
            $targetPath = dirname( __FILE__ ) . $ds . '..' . $ds . $storeFolder . $ds . $user. $ds;
             
            $targetFile =  $targetPath. $_FILES['file']['name'];
         
            move_uploaded_file($tempFile,$targetFile);
             
        }
    }
}
