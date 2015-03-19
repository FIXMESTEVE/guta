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
            ->addJs("js/showFile.js")
            ->addJs("js/contextMenu.js")
            ->addJs("js/share.js");

        \Phalcon\Tag::setTitle('MyDropbox');

        $ds = DIRECTORY_SEPARATOR;  // '/'
        $storeFolder = 'uploadedFiles';   // the folder where we store all the files
        $user = $this->session->get('auth')['idUser'];
        $userPath = dirname( __FILE__ ) . $ds . '..' . $ds . '..' . $ds . '..' . $ds . $storeFolder . $ds . $user. $ds;

        $this->persistent->userPath = $userPath;
    }

    public function indexAction()
    {
    }

    public function uploadAction($directory = null)
    {
        $ds          = DIRECTORY_SEPARATOR;  // '/'

        $storeFolder = 'uploadedFiles';   // the folder where we store all the files
         
        $user = $this->session->get('auth')['idUser'];; //the user who signed in
       
        // Get the folder path  with userPath as the folder root for the user.
        $pos = strpos(urldecode($_SERVER['REQUEST_URI']),$directory);
        if($pos)
            $directory = urldecode(substr($_SERVER['REQUEST_URI'], $pos));  

        if (!empty($_FILES)) {
             
            $tempFile = $_FILES['file']['tmp_name'];
              
            $targetPath = dirname( __FILE__ ) . $ds . '..' . $ds . '..' . $ds . '..' . $ds . $storeFolder . $ds . $user. $ds . urldecode($directory) . $ds;
            
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
        $folder=".." . $ds . ".." . $ds . $storeFolder . $ds . $user;
        error_log(getcwd());
        if(file_exists(realpath($folder.$ds.$fileName)))
        {   
            chdir($folder);
            exec("svn rm \"".$fileName."\"");
            exec("svn commit -m \"removed file\"");
            exec("svn up --accept mine-full");
        }
        //Redirection to stay in folder view
        $names = explode('\\', $fileName);
        array_pop($names);
        $folderView = implode('\\', $names);
        $this->response->redirect("files/list/".$folderView);
        return;
    }

    public function downloadAction($fileName)
    {
        $fileName = str_replace('¤', '\\', $fileName);
        $ds = DIRECTORY_SEPARATOR;
        $storeFolder = "uploadedFiles"; //same as upload
        $user = $this->session->get('auth')['idUser'];; 
        //Force the download of a file
        $file=".." . $ds . ".." . $ds . $storeFolder . $ds . $user . $ds . $fileName;

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
                $size += $this->getFileSize(filesize($path . "/" . $file));
            }
        }

        return $size;
    }

    public function getFileSize($bytes, $decimals = 2) {
        $size = array('o','ko','Mo','Go','To');
        $factor = floor((strlen($bytes) - 1) / 3);
        return sprintf("%.{$decimals}f ", $bytes / pow(1024, $factor)) . @$size[$factor];
    }


    public function listAction($directory = null)
    {
        $directoryArray = array();
        $dirArray = array();
        $fileArray = array();

        //Searching for the shared files/directories
        $userId = $this->session->get('auth')['idUser'];
        $sharedfiles = Sharedfile::findByIdUser($userId);
        foreach ($sharedfiles as $sharedfile) {
            echo $sharedfile->path;
        }
        //$query = $this->modelsManager->createQuery("SELECT * FROM Sharedfile where id_user=:userId:");
        //$sharedfiles = $query->execute(array('userId' => $userId));

        // Get the folder path  with userPath as the folder root for the user.
        $pos = strpos(urldecode($_SERVER['REQUEST_URI']),$directory);
        if($pos)
            $directory = urldecode(substr($_SERVER['REQUEST_URI'], $pos));  
        
        $pathDirectory = urldecode($this->persistent->userPath . $directory);

        if(!is_dir($pathDirectory)) {
            $this->response->redirect("Files/list/");
        }

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
                    $size = $this->getFileSize(filesize($pathDirectory . "/" . $file));
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
        $this->view->shareInfo = null;

    }

    public function viewAction($directory = null) {
        
    }

    public function getFileAction($path){
        $this->view->disable();
        $response = new \Phalcon\Http\Response();

        $oldPath = $path;
        $ds = DIRECTORY_SEPARATOR;
        $olds = "/";

        $path = str_replace("{}", $ds, $path);
        $olpath = str_replace("{}", "/", $oldPath);

        $userID = $this->session->get('auth')['idUser']; //the user who signed in
        
        $targetPath = dirname( __FILE__ ) . $ds . '..' . $ds . '..' . $ds . '..' . $ds . "uploadedFiles" . $ds . $userID . $path;
        
        $onlinePath = "http://localhost/ped/guta/uploadedFiles/". $userID . $olpath;
        
        $image = getimagesize($onlinePath) ? true : false;
        $ext = pathinfo($targetPath, PATHINFO_EXTENSION);

        $data = file_get_contents($targetPath, FILE_USE_INCLUDE_PATH);

        if($ext == "html"){
            $data = str_replace("&", "&amp", $data);
            $data = str_replace("<", "&lt", $data);
            $data = str_replace(">", "&gt", $data);
        }else if($ext == "md"){
            $Parsedown = new Parsedown();
            $data = $Parsedown->text($data);
        }else if($ext == "php" || $ext == "doc" || $ext == "docx"){
            $data = "Fichiers non pris en chargent !" ;
        }else if($ext == "pdf"){
            $pdfPath = $onlinePath;
            $pdfPath = str_replace("/", "{}", $pdfPath);
            $data = '<a target="_blank" href="http://localhost/ped/guta/guta/files/viewPDF/' . $pdfPath . '" style="color: black;"> Visionner le fichier PDF </a>';
        }
        /*else if($ext == "png" || $ext == "jpg" || $ext == "jpeg" || $ext == "gif")
            $data = "<img style='width: 100%' src='" . $onlinePath . "' />";*/
        

        $data = "<pre>" . $data . "</pre>" ;

        if($image){
            $data = "<img style='width: 100%' src='" . $onlinePath . "' />";
        }

        $response->setContent(json_encode($data));

        /*  parser pour les fichiers md
            $Parsedown = new Parsedown();
            $Parsedown->text('Hello _Parsedown_!')
        */
        
        return $response;
    }

    public function viewPDFAction($path){
        // Enlève vue (menu...)
        $this->view->disable();

        $path = str_replace("{}", "/", $path);

        // Affiche le pdf
        $file = $path;
        $filename = 'toto.pdf';
        header('Content-type: application/pdf');
        header('Content-Disposition: inline; filename="' . $filename . '"');
        header('Content-Transfer-Encoding: binary');
        header('Accept-Ranges: bytes');
        @readfile($file);
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
        $email = $this->request->getPost("userMail");

        if($userShare = User::findFirstByemail($email)) {
            if($userId == $userShare->idUser) {
                $this->response->setJsonContent(array('message' => "Désolé, il n'est pas possible de partager avec soit-même..."));
                return $this->response;
            }

            $sharedPaths = $this->request->getPost("paths");
            if($sharedPaths) {  
                foreach ($sharedPaths as $path) {
                    if($sharedFile = Sharedfile::findFirstBypath($path)) {
                        if($sharedFile->id_user == $userShare->idUser) {
                            $this->response->setJsonContent(array('message' => 'Fichier(s)/Dossier(s) déjà partagé(s) avec cette utilisateur'));
                        } else {
                            $sharedFile = new Sharedfile();
                            $sharedFile->id_user = $userShare->idUser;
                            $sharedFile->path = $path;
                            $sharedFile->id_owner = $userId;
                        }
                    } else {
                        $sharedFile = new Sharedfile();
                        $sharedFile->id_user = $userShare->idUser;
                        $sharedFile->path = $path;
                        $sharedFile->id_owner = $userId;
                    }
                    if(!$sharedFile->save()) {
                        $this->response->setJsonContent(array('message' => 'Erreur lors du partage'));
                        return $this->response;
                    }
                }
                $this->response->setJsonContent(array('message' => 'Partage réussi !'));
            } else {
                $this->response->setJsonContent(array('message' => "Vous n'avez rien séléctionné !"));
            }
        } else {
            $this->response->setJsonContent(array('message' => 'Mail invalide'));
        }
        return $this->response;
    }
}
