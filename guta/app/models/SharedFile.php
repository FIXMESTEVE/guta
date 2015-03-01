<?php

class SharedFile extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $idShared_File;

    /**
     *
     * @var integer
     */
    public $id_user;

    /**
     *
     * @var integer
     */
    public $id_owner;

    /**
     *
     * @var string
     */
    public $path;

    /**
     * Independent Column Mapping.
     */
    public function columnMap()
    {
        return array(
            'idShared_File' => 'idShared_File', 
            'id_user' => 'id_user', 
            'id_owner' => 'id_owner', 
            'path' => 'path'
        );
    }

}
