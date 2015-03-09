<?php

use Phalcon\Mvc\Controller;

class FilesController extends Controller
{
    public function initialize()
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

        \Phalcon\Tag::setTitle('MyDropbox');

        $ds = DIRECTORY_SEPARATOR;  // '/'
        $storeFolder = 'uploadedFiles';   // the folder where we store all the files
        $user = $this->session->get('auth')['idUser'];
        $userPath = dirname( __FILE__ ) . $ds . '..' . $ds . $storeFolder . $ds . $user. $ds;

        $this->persistent->userPath = $userPath;
    }

    public function indexAction()
    {
    }

    public function uploadAction()
    {
        $ds          = DIRECTORY_SEPARATOR;  // '/'
    
        $user = $this->session->get('auth')['idUser'];

        $storeFolder = 'uploadedFiles';   // the folder where we store all the files
        
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

    public function getDirSize($path)
    {
        $size = 0;

        $files = scandir($path);

        foreach ($files as $file) {
            if(is_dir($path . "/" . $file)) {
                $newPath = $path . "/" . $file;
                if($file != ".." && $file != ".")
                    $size += $this->getDirSize($newPath);
            } else {
                $size += filesize($path . "/" . $file);
            }
        }

        return $size;
    }

    public function listAction($directory = null)
    {

        $directory = substr($_SERVER['REQUEST_URI'], 22);

        $directoryArray = array();
        $dirArray = array();
        $fileArray = array();

        $pathDirectory = $this->persistent->userPath . $directory;

        $files = scandir($pathDirectory);

        $directory = rtrim(ltrim($directory, '/'), '/');

        foreach ($files as $file) {            
            if($file != '.'){
                if (is_dir($pathDirectory . "/" . $file)) {
                    if(!(strlen($directory) == 0 && $file == "..")) {
                        if($file != ".." && $file != ".")
                            $size = $this->getDirSize($pathDirectory . "/" . $file);
                        else
                            $size = null;
                        array_push($dirArray, array('name' => $file, 'size' => $size));
                    }
                } else {
                    $size = filesize($pathDirectory . "/" . $file);
                    $modifyDate = date ("d/m/Y H:i:s.", filemtime($pathDirectory . "/" . $file));
                    array_push($fileArray, array('name' => $file, 'size' => $size, 'modifyDate' => $modifyDate));
                }
            }
        }

        sort($dirArray);
        sort($fileArray);

        if($directory != null)
            $directory = "/" . $directory;
        $this->view->currentDir = $directory;
        $this->view->directories = $dirArray;
        $this->view->files = $fileArray;
    }

    public function viewAction($directory = null) {
        
    }
}
