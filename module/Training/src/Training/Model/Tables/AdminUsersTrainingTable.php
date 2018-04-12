<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace Training\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

/**
 * Description of TrainingTable
 *
 * @author abel
 */
class AdminUsersTrainingTable extends AbstractTableGateway {
    
    protected $table = 'cap_admin_user_training';
    
    public function __construct()
    {
    	//$this->adapter = $adapter;
    	//$this->initialize();
    
    	$this->featureSet = new Feature\FeatureSet();
    	$this->featureSet->addFeature(new Feature\GlobalAdapterFeature());
    	$this->initialize();
    }
    
    public function fetchAll()
    {
    	$resultSet = $this->select();
    	return $resultSet->toArray();
    }
    
    
    public function getTrainingsIdString($idUser){
        $where = array('use_id' => $idUser);
        $resultSet = $this->select($where);
        $data = '0';
        if ($resultRow = $resultSet->toArray()){ 
            foreach ( $resultRow as $r ) {
                $data .= ', '.$r['cap_id'];
            }
            return $data;
        }else {
            return $data;
        }
    }
    
    public function saveAdminUser($data){
        if ( $this->delete("use_id = ".$data['use_id'], "cap_id = ".$data['cap_id']) ) {
            if ( $this->insert($data) ) {
                return true;
            }
        }else {
            if ( $this->insert($data) ) {
                return true;
            }
        }
        return false;   
    }
    
    public function deleteAdminUser($data){
        if ( $this->delete("use_id = ".$data['id']) ) {
                return true;
        }
        return false;   
    }
    
    
    
}
