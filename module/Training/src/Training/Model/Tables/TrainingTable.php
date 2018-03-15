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
    
    
    public function getTrainings($ids, $options = Array()){
        $result = Array();
        $resultSet = $this->select(function (Select $select) use ($ids, $options) {
        	$select->columns(array('*'))
                   ->join('cap_status', 'cap_status.sta_id = cap_capacitacion.cap_status', array('status' => 'sta_nombre'))
                   ->join('cap_idioma', 'cap_idioma.idi_id = cap_capacitacion.cap_idioma', array('idioma' => 'idi_nombre', 'idioma_sigla' => 'idi_abreviatura'))
        	   ->where("cap_capacitacion.cap_id IN (".$ids.") AND cap_capacitacion.cap_activo = 1 AND (".$options['where'].")")
        	   ->order($options['order'])
        	   ->limit($options['limit']['length'])
        	   ->offset($options['limit']['start']);
        	//Debug::dump($select->getSqlString()); die;
        });
        $result['data'] = $resultSet->toArray();
        
        $resultSet = $this->select(function (Select $select) use ($ids, $options) {
        	$select
        	->columns(array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')))
        	->where("cap_id IN (".$ids.") AND cap_activo = 1 AND (".$options['where'].")");
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
    
    
    public function getAdminUsers($options = Array(), $cid){
        $result = Array();
        $resultSet = $this->select(function (Select $select) use ($options, $cid) {
        	$select
                   ->join('cap_admin_user_training'
                           , 'cap_admin_user_training.cap_id = cap_capacitacion.cap_id'
                           , array()
                          )
                   ->join('core_users'
                           , 'core_users.COR_USR_ID = cap_admin_user_training.use_id'
                           , array(
                               'id' => 'COR_USR_ID'
                               , 'username' => 'COR_USR_NAME'
                               , 'name' => new Expression("concat(COR_USR_NAME,' ',COR_USR_LAST_NAME)")
                            )
                          )
                   ->join('cap_admin_profile'
                           , 'cap_admin_profile.pro_id = cap_admin_user_training.pro_id'
                           , array(
                               'role' => 'pro_description'
                               , 'role_name' => 'pro_name'
                               , 'role_id' => 'pro_id'
                            )
                          )
                   
        	   ->where("1 = 1 AND (".$options['where'].") AND cap_capacitacion.cap_id = ".$cid)
        	   ->order($options['order'])
        	   ->limit($options['limit']['length'])
        	   ->offset($options['limit']['start'])
                   ;
        	//Debug::dump($select->getSqlString()); die;
        });
        $result['data'] = $resultSet->toArray();
        
        $resultSet = $this->select(function (Select $select) use ($options, $cid) {
        	$select
                ->join('cap_admin_user_training'
                           , 'cap_admin_user_training.cap_id = cap_capacitacion.cap_id'
                           , array()
                          )
                   ->join('core_users'
                           , 'core_users.COR_USR_ID = cap_admin_user_training.use_id'
                           , array()
                          )
                   ->join('cap_admin_profile'
                           , 'cap_admin_profile.pro_id = cap_admin_user_training.pro_id'
                           , array()
                          )
                   ->columns(array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')))
        	   ->where("1 = 1 AND (".$options['where'].") AND cap_capacitacion.cap_id = ".$cid);
        });
        $count = $resultSet->toArray();
        $result['rows'] = $count[0]['num'];
        return $result;
    }
    

    
    
    
}
