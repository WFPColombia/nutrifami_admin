<?php
namespace Commodity\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;
use Zend\Db\Sql\Sql;


class KitsTable extends AbstractTableGateway
{
    protected $table = 'buss_kits';
    
    public function __construct()
    {
    	//$this->adapter = $adapter;
    	//$this->initialize();
    
    	$this->featureSet = new Feature\FeatureSet();
    	$this->featureSet->addFeature(new Feature\GlobalAdapterFeature());
    	$this->initialize();
    }
    
    
    public function getKits($options = Array()){
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
    
    
}

?>