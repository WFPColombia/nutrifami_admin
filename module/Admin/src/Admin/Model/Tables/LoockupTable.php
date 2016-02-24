<?php
namespace Admin\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

class LoockupTable extends AbstractTableGateway
{
    protected $table = 'lut_codes';
    
    public function __construct()
    {
    	//$this->adapter = $adapter;
    	//$this->initialize();
    
    	$this->featureSet = new Feature\FeatureSet();
    	$this->featureSet->addFeature(new Feature\GlobalAdapterFeature());
    	$this->initialize();
    }
    
    
    public function fetchAll ()
    {
    	$resultSet = $this->select();
    	return $resultSet->toArray();
    }
    
    
    public function getElement ($type = "", $abbreviation = "" ) {
        $params = array('LUT_COD_TYPE' => $type, 'LUT_COD_ABBREVIATION' => $abbreviation);
        $resultSet = $this->select($params);
        if ($resultRow = $resultSet->current()){
        	return $resultRow;
        }else {
        	return false;
        }
    }
    
    
    public function getList ($type = "", $getParent = true){
        if (!$getParent) {
            $where = "LUT_COD_TYPE = '{$type}' AND LUT_COD_ABBREVIATION !=  '{$type}'";
        }else {
            $where = "LUT_COD_TYPE = '{$type}'";
        } 
        $resultSet = $this->select(function (Select $select) use ($where) {
        	$select
        	->where($where);
        });
        return $resultSet->toArray();
    }
    
}

?>