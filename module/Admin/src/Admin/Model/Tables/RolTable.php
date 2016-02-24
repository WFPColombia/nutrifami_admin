<?php
namespace Admin\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;
use Zend\Db\Sql\Sql;

class RolTable extends AbstractTableGateway
{
    protected $table = 'core_roles';
    
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
    
    
    public function getRoles($options = Array()){
        $result = Array();
        $resultSet = $this->select(function (Select $select) use ($options) {
        	$select
        	   ->where("(".$options['where'].") AND LUT_COD_STATUS = (SELECT LUT_COD_ID FROM lut_codes where LUT_COD_TYPE = 'STATUS' AND LUT_COD_ABBREVIATION = 'ACTIVE' LIMIT 1)")
        	   ->order($options['order'])
        	   ->limit($options['limit']['length'])
        	   ->offset($options['limit']['start']);
        	//Debug::dump($select->getSqlString()); die;
        });
        $result['data'] = $resultSet->toArray();
        
        $resultSet = $this->select(function (Select $select) use ($options) {
        	$select
        	->columns(array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')))
        	->where("LUT_COD_STATUS = (SELECT LUT_COD_ID FROM lut_codes where LUT_COD_TYPE = 'STATUS' AND LUT_COD_ABBREVIATION = 'ACTIVE' LIMIT 1)");
        });
        $count = $resultSet->toArray();
        $result['rows'] = $count[0]['num'];
        return $result;
    }
    

    
    public function updateRol($data){ 
        $succes = false;
        foreach ($data as $id => $d) {
            if ($this->update($d, "COR_ROL_ID = $id")){
                $succes = $d;
            }else{
                $succes = false;
            }
        }
        return $succes;
    }
    
    public function updateByFieldsRol($data){
        $id = $data['COR_ROL_ID'];
        unset($data['COR_ROL_ID']);
        if ($this->update($data, "COR_ROL_ID = $id")){
            return true;
        }else{
            return false;
        }
    }
    
    
    public function insertRol($data){
    	if ( isset($data['COR_ROL_ID']) ) {
    		unset($data['COR_ROL_ID']);
    	}
    	return $this->insert($data);
    }
    
    
    public function getRol($id){
    	$params = array('COR_ROL_ID' => $id);
    	$resultSet = $this->select($params);
    	if ($resultRow = $resultSet->toArray()){
    		return $resultRow[0];
    	}else {
    		return false;
    	}
    }
    
    
    
    public function getPrivilegesByRol( $id ){        
        $oSql = new Sql($this->getAdapter());
        $oSelect = $oSql
            ->select()
            ->from( array("CMBRP"=>"core_mod_by_rol_priv") )
        	->columns( array('COR_MOD_ID', 'COR_ROL_ID') )
        	->join( array("PRIVILEGES" => "lut_codes"),
        			new Expression("PRIVILEGES.LUT_COD_ID = CMBRP.LUT_COD_PRIVILEGE AND PRIVILEGES.LUT_COD_TYPE = 'PRIVILEGES' AND PRIVILEGES.LUT_COD_ABBREVIATION !=  'PRIVILEGES'"),
        			array('LUT_COD_ID', 'LUT_COD_NAME', 'LUT_COD_ABBREVIATION')
        	)
        	->where("CMBRP.COR_ROL_ID = {$id}");
            $statement = $oSql->prepareStatementForSqlObject($oSelect);
            $oResultSet = $statement->execute();
        return $oResultSet;
    }
    
    
    
}

?>