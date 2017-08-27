<?php

namespace User\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Debug\Debug;

class UserTable extends AbstractTableGateway
{
    protected $table = 'core_users';

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
    
    public function getUser($username = '', $password = ''){
    	$params = array('COR_USR_NAME' => $username, 'COR_USR_PWD' => md5($password));
    	$resultSet = $this->select($params);
    	if ($resultRow = $resultSet->current()){
        	return $resultRow;
    	}else {
    		return false;
    	}
    }

}
