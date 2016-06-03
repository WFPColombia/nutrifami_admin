<?php
namespace Tcontent\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

class ModuleTable extends AbstractTableGateway
{
    protected $table = 'cap_modulo';
    
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
    	$resultSet = $this->select("mod_id > 0");
    	return $resultSet->toArray();
    }
    
    
    public function getModule($id){
        $params = array('mod_id' => $id);
        $resultSet = $this->select($params);
        if ($resultRow = $resultSet->toArray()){
        	return $resultRow[0];
        }else {
        	return false;
        }
    }
    
    public function getModules($options = Array()){
        $result = Array();
        $resultSet = $this->select(function (Select $select) use ($options) {
        	$select
        	   ->where("1 = 1 AND (".$options['where'].") AND mod_activo = 1")
        	   ->order($options['order'])
        	   ->limit($options['limit']['length'])
        	   ->offset($options['limit']['start']);
        	//Debug::dump($select->getSqlString()); die;
        });
        $result['data'] = $resultSet->toArray();
        
        $resultSet = $this->select(function (Select $select) use ($options) {
        	$select
        	->columns(array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')))
        	->where("1 = 1  AND (".$options['where'].") AND mod_activo = 1");
        });
        $count = $resultSet->toArray();
        $result['rows'] = $count[0]['num'];
        return $result;
    }
    
    public function updateModule($data){ 
        $succes = false;
        foreach ($data as $id => $d) {
            if ($this->update($d, "mod_id = $id")){
                $succes = $d;
            }else{
                $succes = false;
            }
        }
        return $succes;
    }
    
    public function updateByFieldsModule($data){
        $id = $data['mod_id'];
        unset($data['mod_id']);
        if ($this->update($data, "mod_id = $id")){
            return true;
        }else{
            return false;
        }
    }
    
    
    public function insertModule($data){
        if ( isset($data['mod_id']) ) {
            unset($data['mod_id']);
        }
        return $this->insert($data);
    }
    
    
}

?>