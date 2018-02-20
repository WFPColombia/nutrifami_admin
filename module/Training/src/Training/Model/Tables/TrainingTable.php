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
class TrainingTable extends AbstractTableGateway {
    
    protected $table = 'cap_capacitacion';
    
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
    
    
    public function getTrainings($options = Array()){
        $result = Array();
        $resultSet = $this->select(function (Select $select) use ($options) {
        	$select
        	   ->where("cap_activo = 1 AND (".$options['where'].")")
        	   ->order($options['order'])
        	   ->limit($options['limit']['length'])
        	   ->offset($options['limit']['start']);
        	//Debug::dump($select->getSqlString()); die;
        });
        $result['data'] = $resultSet->toArray();
        
        $resultSet = $this->select(function (Select $select) use ($options) {
        	$select
        	->columns(array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')))
        	->where("cap_activo = 1 AND (".$options['where'].")");
        });
        $count = $resultSet->toArray();
        $result['rows'] = $count[0]['num'];
        return $result;
    }
    
    
    public function getTraining($id){
        $params = array('cap_id' => $id);
        $resultSet = $this->select($params);
        if ($resultRow = $resultSet->toArray()){
        	return $resultRow[0];
        }else {
        	return false;
        }
    }
    
    
    
}
