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


    public function __construct()
    {
        $this->trainingTable = new TrainingTable();
    }
    
    public function getAllTrainings(){
        return $this->trainingTable->fetchAll();
    }
    
    public function getTrainings($options = Array())
    {
        $trainings = $this->trainingTable->getTrainings($options);
        return $trainings;
    }
    
    public function getTraining ($id) 
    {
        return $this->trainingTable->getTraining($id);
    }
    
}
