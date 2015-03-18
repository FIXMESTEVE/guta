<?php

use Phalcon\Mvc\Controller;

class FilesController extends Controller
{
    public function initialize()
    {
        $this->assets
            ->addCss("css/bootstrap.min.css")
            ->addCss("css/design.css")
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

    public function uploadAction($directory = null)
    {
        $ds          = DIRECTORY_SEPARATOR;  // '/'

        $storeFolder = 'uploadedFiles';   // the folder where we store all the files
         
        $user = $this->session->get('auth')['idUser']; //the user who signed in
       
        // Get the folder path  with userPath as the folder root for the user.
        $pos = strpos(urldecode($_SERVER['REQUEST_URI']),$directory);
        if($pos)
            $directory = urldecode(substr($_SERVER['REQUEST_URI'], $pos));  

        if (!empty($_FILES)) {
             
            $tempFile = $_FILES['file']['tmp_name'];
              
            $targetPath = dirname( __FILE__ ) . $ds . '..' . $ds . $storeFolder . $ds . $user. $ds . urldecode($directory) . $ds;
            
            $targetFile =  $targetPath. $_FILES['file']['name'];
         
            move_uploaded_file($tempFile,$targetFile);
            
            chdir($targetPath); 
            exec("svn add \"".$targetFile."\"");
            exec("svn commit -m \"uploaded file\"");
            exec("svn up --accept mine-full");
        }
    }

    public function deleteAction($fileName){
        $fileName = str_replace('¤', '\\', $fileName);
        $ds = DIRECTORY_SEPARATOR;
        $storeFolder = "uploadedFiles"; //same as upload
        $user = $this->session->get('auth')['idUser'];
        $folder=".." . $ds . "app" . $ds . $storeFolder . $ds . $user;
        error_log(getcwd());
        if(file_exists(realpath($folder.$ds.$fileName)))
        {   
            chdir($folder);
            exec("svn rm \"".$fileName."\"");
            exec("svn commit -m \"removed file\"");
            exec("svn up --accept mine-full");
        }
    }

    public function downloadAction($fileName)
    {
        $fileName = str_replace('¤', '\\', $fileName);
        $ds = DIRECTORY_SEPARATOR;
        $storeFolder = "uploadedFiles"; //same as upload
        $user = $this->session->get('auth')['idUser'];; 
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
            exit;
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
        $directoryArray = array();
        $dirArray = array();
        $fileArray = array();

        // Get the folder path  with userPath as the folder root for the user.
        $pos = strpos(urldecode($_SERVER['REQUEST_URI']),$directory);
        if($pos)
            $directory = urldecode(substr($_SERVER['REQUEST_URI'], $pos));  
        
        $pathDirectory = urldecode($this->persistent->userPath . $directory);
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
        error_log("currentDir ".$this->view->currentDir);
        

        $this->view->directories = $dirArray;
        $this->view->files = $fileArray;
    }

    public function viewAction($directory = null) {
        
    }


    /**
     * Creation of a new folder by the user.
     *
     * @param string $folderpath
     */
    public function createFolderAction($folderpath = null) {

        if ($this->request->isPost()) {

            // Get the name of the new folder.
            $foldername = urldecode($this->request->getPost("foldername"));
            if ($foldername == null) {
                echo '<div class="alert alert-danger" role="alert">';
                $this->flash->error("Le nom d'un dossier ne peut être vide.");
                echo "</div>";
                return $this->dispatcher->forward(array(
                    'controller' => 'files',
                    'action' => 'list'
                ));
            }
            // 
            if (file_exists($this->persistent->userPath . "/" . $folderpath . '/'.$foldername)) {
                echo '<div class="alert alert-danger" role="alert">';
                $this->flash->error("Ce nom existe déja.");
                echo "</div>";
                return $this->dispatcher->forward(array(
                    'controller' => 'files',
                    'action' => 'list'
                ));
            }

            // Get the path where the new folder will be created.
            $pos = strpos(urldecode($_SERVER['REQUEST_URI']),$folderpath);
            if($pos)
                $folderpath = urldecode(substr($_SERVER['REQUEST_URI'], $pos));

            // Check for forbidden characters in the folder name.
            if (preg_match('/[\/:?*<>"|]/', $foldername)) {
                $this->flash->error('Les caractères "/", "\", ":", "?", "*", "<", ">", """, "|" sont interdits.');
            } else {
                mkdir($this->persistent->userPath . "/" . $folderpath . "/" . $foldername);
                echo '<div class="alert alert-success" role="alert">';
                $this->flash->success("Le dossier ".$foldername." a été correctement créé");
                echo "</div>";
            }

            exec("svn add \"".$this->persistent->userPath . "/" . $folderpath . "/" . $foldername."\"");
            exec("svn up --accept mine-full");
            return $this->dispatcher->forward(array(
                'controller' => 'files',
                'action' => 'list'
            ));
        }
    }


    /**
     * Search a file or a folder.
     *
     * @param string $pattern
     */
    public function searchAction($pattern='*') {
        
        if ($this->request->isPost())
            $pattern = $this->request->getPost('pattern');

        // Pattern matching through the folders tree.
        $path = $this->persistent->userPath;
        $paths = array( $path );
        $results = array();
        while( count( $paths ) > 0 )
        {
            $path = array_shift( $paths );
            $paths = array_merge( $paths, glob( $path.'*', GLOB_MARK | GLOB_ONLYDIR | GLOB_NOSORT ) );
            $results = array_merge( $results, glob( $path."*$pattern*", GLOB_NOSORT ) );
        }

        if( count($results) == 0 ) 
        {
            $this->flash->error("Aucun résultat trouvé.");
        }

        // Set the variables for the view.
        $dirArray = array();
        $fileArray = array();
        foreach ( $results as $file )
        {
            $name = substr(strrchr($file, '\\'), 1);
            $localPath = explode($this->persistent->userPath, $file);
            $localPath = $localPath[1];
            
            if( is_dir($file) ){
                $size = $this->getDirSize($file);
                array_push($dirArray, array('name' => $name, 'size' => $size, 'path' => $localPath));
            } else {
                $size = filesize($file);
                $modifyDate = date ("d/m/Y H:i:s.", filemtime($file));
                array_push($fileArray, array('name' => $name, 'size' => $size, 'modifyDate' => $modifyDate, 'path' => $localPath));
            }
        }

        $this->view->files = $fileArray;
        $this->view->directories = $dirArray;
        
        
    }

    public function shareAction() {

        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(array(
                "controller" => "Files",
                "action" => "list"
            ));
        }

        $userId = $this->session->get('auth')['idUser'];
        $listEmail = $this->request->getPost("userMails");

        $usersShare = array();
        foreach ($listEmail as $email) {
            $userShare = User::findFirstByemail($email);
            $userShare.add($userShare);
        }
        
        $sharedPaths = $this->request->getPost("paths");

        foreach ($sharedPaths as $path) {
            if($sharedFile = Sharedfile::findFirstBypath($path)) {
                foreach ($usersShare as $userShare) {
                    $sharedFile->id_user.add($userShare->idUser);
                }
            } else {
                $sharedFile = new Sharedfile();
                $sharedFile->id_user = array();
                $sharedFile->id_user.add($userShare->idUser);
                $sharedFile->path = $path;
                $sharedFile->id_owner = $userId;
            }
            $sharedFile->save();
        }

        return $this->dispatcher->forward(array(
                "controller" => "Files",
                "action" => "list"
            ));
    }

}
