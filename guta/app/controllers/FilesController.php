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
            ->addJs("js/dropzone.js")
            ->addJs("js/contextMenu.js");
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

    public function downloadAction($fileName)
    {
        $ds = DIRECTORY_SEPARATOR;
        $storeFolder = "uploadedFiles"; //same as upload
        $user = "tomtom"; 
        //Force the download of a file
        $file=".." . $ds . "app" . $ds . $storeFolder . $ds . $user . $ds . $fileName;
        if(file_exists(realpath($file)))
        {
            header('Content-Description: File Transfer');
            header('Content-Type: application/octet-stream');
            header('Content-Disposition: attachment; filename='.basename($file));
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($file));
            readfile($file);
        }
        else
        {
            echo "File not found";
        }
    }

        public function listAction($directory)
    {
        $directoryArray = array();
        $dirArray = array();
        $fileArray = array();

        $files = scandir($directory);

        foreach ($files as $file) {            
            if($file != '.'){
                if (is_dir($directory . "/" . $file)) {
                    array_push($dirArray, $file);
                } else {
                    array_push($fileArray, $file);
                    //var_dump($fileArray);
                }
            }
        }

        sort($dirArray);
        sort($fileArray);

         $this->view->directories = $dirArray;
         $this->view->files = $fileArray;

    }
}
