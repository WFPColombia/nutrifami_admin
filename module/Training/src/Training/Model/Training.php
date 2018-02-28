<?php
/**********************************************************
 * CLIENTE: PMA Colombia
* ========================================================
*
* @copyright PMA Colombia 2018
* @updated 
* @version 1
* @author {Abel Oswaldo Moreno Acevedo} <{moreno.abel@gmail.com}>
**********************************************************/
namespace Training\Model;

use Training\Model\Tables\TrainingTable;
use Training\Model\Tables\AdminUsersTrainingTable;
/**********************************************************
* MODELO Training
* =======================================================
*
* ATRIBUTOS
* $moduleTable   // Tabla modulos
*
*
* METODOS
* __construct();
*
**********************************************************/
class Training {
    
    protected $trainingTable;
    protected $adminUsersTrainingTable;


    public function __construct()
    {
        $this->trainingTable = new TrainingTable();
        $this->adminUsersTrainingTable = new AdminUsersTrainingTable();
    }
    
    public function getAllTrainings(){
        return $this->trainingTable->fetchAll();
    }
    
    public function getTrainings($options = Array())
    {   
        $ids = $this->adminUsersTrainingTable->getTrainingsIdString(\Util\UserSession::getId());
        //print_r($ids); die;
        $trainings = $this->trainingTable->getTrainings($ids, $options);
        return $trainings;
    }
    
    public function getTraining ($id) 
    {
        return $this->trainingTable->getTraining($id);
    }
    
    public function getAdminUsers($options = Array(), $cid = 0)
    {   
        $users = $this->trainingTable->getAdminUsers($options, $cid);
        return $users;
    }
    
}
