<?php

namespace User\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Debug\Debug;
use Zend\Db\Sql\Sql;
use Zend\Db\Sql\Expression;

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
    
    /**
     * 
     * Devuelve el usuario correspondiente al username 
     * y contraseña dadas
     * 
     * @param string $username
     * @param string $password
     * @return Ambigous <multitype:, ArrayObject, NULL, \ArrayObject, unknown>|boolean
     */
    public function getUser($username = '', $password = ''){
    	$params = array('COR_USR_NAME' => $username, 'COR_USR_PWD' => md5($password));
    	$resultSet = $this->select($params);
    	if ($resultRow = $resultSet->current()){
        	return $resultRow;
    	}else {
    		return false;
    	}
    }
    
    
    /**
     * 
     * Devuelve los modulos correspondientes a un usuario por sus roles
     * y por el padre del modulo correspondiente.
     * 
     * @param number $userId
     * @param number $parentId
     * @return unknown
     */
    public function getModulesByParent ($userId = 0, $parentId = 1) {
        $statusElement = \Util\LoockupValues::getStatus('ACTIVE');
        $oSql = new Sql( $this->getAdapter() );
        $oSelect = $oSql
        ->select()
        ->from( array("CRBU"=>"core_roles_by_user") )
        ->columns( array() )
        ->join( array("CR" => "core_roles"),
        		new Expression("CR.COR_ROL_ID = CRBU.COR_ROL_ID AND CR.LUT_COD_STATUS = ".$statusElement['LUT_COD_ID'])
        		, array()
        )
        ->join( array("CMBR" => "core_mod_by_rol_priv"), 
                      "CMBR.COR_ROL_ID = CR.COR_ROL_ID"
                      , array() 
        )
        ->join( array("CM" => "core_modules"), 
                      "CM.COR_MOD_ID = CMBR.COR_MOD_ID", 
                      array(
                          "id"=>"COR_MOD_ID",
                          "pid"=>"COR_MOD_PID",
                          "name"=>"COR_MOD_NAME",
                          "description"=>"COR_MOD_DESCRIPTION",
                          "url"=>"COR_MOD_URL",
                          "icon"=>"COR_MOD_ICON"
                       ) 
        )
        ->where("CRBU.COR_USR_ID = {$userId} AND CM.COR_MOD_PID = {$parentId}")
        ->quantifier('DISTINCT');
        //Debug::dump($oSelect->getSqlString()); die;
        $statement = $oSql->prepareStatementForSqlObject($oSelect);
        $oResultSet = $statement->execute();
        return $oResultSet;
    }
    
    
    public function getModulePrivileges ($userId = 0, $moduleId = 1) {
        $oSql = new Sql( $this->getAdapter() );
        $oSelect = $oSql
        ->select()
        ->from( array("CRBU"=>"core_roles_by_user") )
        ->columns( array() )
        ->join( array("CMBRP" => "core_mod_by_rol_priv"),
        		new Expression("CMBRP.COR_ROL_ID = CRBU.COR_ROL_ID AND CMBRP.COR_MRP_VALUE = 1"),
        		array('modId'=>'COR_MOD_ID')
        )
        ->join( array("LC" => "lut_codes"),
        		"LC.LUT_COD_ID = CMBRP.LUT_COD_PRIVILEGE",
        		array(
        		    'privilege'=>'LUT_COD_ABBREVIATION'
        		)
        )
        ->where("CRBU.COR_USR_ID = {$userId} AND CMBRP.COR_MOD_ID = {$moduleId}");
        $statement = $oSql->prepareStatementForSqlObject($oSelect);
        $oResultSet = $statement->execute();
        return $oResultSet;
    }
    

}
