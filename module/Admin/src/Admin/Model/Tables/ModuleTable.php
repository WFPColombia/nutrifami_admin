<?php
namespace Admin\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

class ModuleTable extends AbstractTableGateway
{
    protected $table = 'core_modules';
    
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
    	$resultSet = $this->select("COR_MOD_ID > 1");
    	return $resultSet->toArray();
    }
    
    
    public function getModule($id){
        $params = array('COR_MOD_ID' => $id);
        $resultSet = $this->select($params);
        if ($resultRow = $resultSet->toArray()){
        	return $resultRow[0];
        }else {
        	return false;
        }
    }
    
    public function getModules($pid = 1, $options = Array()){
        $result = Array();
        $resultSet = $this->select(function (Select $select) use ($pid, $options) {
        	$select
        	   ->where("COR_MOD_PID = ".$pid." AND (".$options['where'].") AND LUT_COD_STATUS = (SELECT LUT_COD_ID FROM lut_codes where LUT_COD_TYPE = 'STATUS' AND LUT_COD_ABBREVIATION = 'ACTIVE' LIMIT 1)")
        	   ->order($options['order'])
        	   ->limit($options['limit']['length'])
        	   ->offset($options['limit']['start']);
        	//Debug::dump($select->getSqlString()); die;
        });
        $result['data'] = $resultSet->toArray();
        
        $resultSet = $this->select(function (Select $select) use ($pid, $options) {
        	$select
        	->columns(array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')))
        	->where("COR_MOD_PID = ".$pid." AND (".$options['where'].") AND LUT_COD_STATUS = (SELECT LUT_COD_ID FROM lut_codes where LUT_COD_TYPE = 'STATUS' AND LUT_COD_ABBREVIATION = 'ACTIVE' LIMIT 1)");
        });
        $count = $resultSet->toArray();
        $result['rows'] = $count[0]['num'];
        return $result;
    }
    
    public function updateModule($data){ 
        $succes = false;
        foreach ($data as $id => $d) {
            if ($this->update($d, "COR_MOD_ID = $id")){
                $succes = $d;
            }else{
                $succes = false;
            }
        }
        return $succes;
    }
    
    public function updateByFieldsModule($data){
        $id = $data['COR_MOD_ID'];
        unset($data['COR_MOD_ID']);
        if ($this->update($data, "COR_MOD_ID = $id")){
            return true;
        }else{
            return false;
        }
    }
    
    
    public function insertModule($data){
        if ( isset($data['COR_MOD_ID']) ) {
            unset($data['COR_MOD_ID']);
        }
        return $this->insert($data);
    }
    
    
}

?>