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


class CommoditiesTable extends AbstractTableGateway
{
    protected $table = 'buss_commodities';
    
    public function __construct()
    {
    	//$this->adapter = $adapter;
    	//$this->initialize();
    
    	$this->featureSet = new Feature\FeatureSet();
    	$this->featureSet->addFeature(new Feature\GlobalAdapterFeature());
    	$this->initialize();
    }
    
    
    public function getCommoditiesByKit($kid, $options = Array()){
    	$result = Array();
    	$oSql = new Sql($this->getAdapter());
    	$oSelect = $oSql
    	->select()
    	    ->from( array("BCK"=>"buss_com_by_kit") )
        	->columns( array('BUS_KIT_ID', 'BUS_COM_KIT_QUANTITY') )
        	->join( array("BC" => "buss_commodities"),
        			"BC.BUS_COM_ID = BCK.BUS_COM_ID",
        			array('BUS_COM_ID', 'BUS_COM_NAME', 'BUS_COM_DESCRIPTION', 'LUT_COD_COM_TYPE')
        	)
        	->join( array("BCA" => "buss_commodity_attribute"),
        			"BCA.BUS_COM_ID = BC.BUS_COM_ID ",
        			array(
        		          'UNIT' => new Expression("(SELECT lut_codes.LUT_COD_NAME FROM lut_codes WHERE lut_codes.LUT_COD_ID = BCA.LUT_COD_UNIT)")
        			    , 'CURRENCY' => new Expression("(SELECT lut_codes.LUT_COD_NAME FROM lut_codes WHERE lut_codes.LUT_COD_ID = BCA.LUT_COD_CURRENCY)")  
        	            , 'BUS_COM_ATT_PRICE' 
        			    , 'BUS_COM_ATT_WEIGHT'
        	        )
        	)
    		->where("BCK.BUS_KIT_ID = {$kid} AND (".$options['where'].") AND LUT_COD_STATUS = (SELECT LUT_COD_ID FROM lut_codes where LUT_COD_TYPE = 'STATUS' AND LUT_COD_ABBREVIATION = 'ACTIVE' LIMIT 1)")
    		->order($options['order'])
    		->limit($options['limit']['length'])
    		->offset($options['limit']['start']);
    	$statement = $oSql->prepareStatementForSqlObject($oSelect);
    	$oResultSet = $statement->execute();
    	$resultSet = Array();
    	foreach ($oResultSet as $k=>$oR) {
    	    $resultSet[] = $oR;
    	}    	
    	$result['data'] = $resultSet;
        
    	$oSelect = $oSql
    	->select()
    	    ->from( array("BCK"=>"buss_com_by_kit") )
    		->columns( array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')) )
    		->join( array("BC" => "buss_commodities"),
    				"BC.BUS_COM_ID = BCK.BUS_COM_ID",
    				array()
    		)
    		->join( array("BCA" => "buss_commodity_attribute"),
    				"BCA.BUS_COM_ID = BC.BUS_COM_ID ",
    				array()
    		)
    		->where("BCK.BUS_KIT_ID = {$kid} AND (".$options['where'].") AND LUT_COD_STATUS = (SELECT LUT_COD_ID FROM lut_codes where LUT_COD_TYPE = 'STATUS' AND LUT_COD_ABBREVIATION = 'ACTIVE' LIMIT 1)");
    	$statement = $oSql->prepareStatementForSqlObject($oSelect);
    	$oResultSet = $statement->execute();
    	
    	
    	$countTemp = $oResultSet;
    	$count = Array();
    	foreach ($countTemp as $k=>$c){
    	    $count[] = $c;
    	}
    	$result['rows'] = $count[0]['num'];
    	return $result;
    }
    
    /*
     
     public function getCommoditiesByKit($kid, $options = Array()){
    	$result = Array();
    	$oSql = new Sql($this->getAdapter());
    	$oSelect = $oSql
    	->select()
    	    ->from( array("A" => new Expression("SELECT 
                    BCK.BUS_KIT_ID
                  , BCK.BUS_COM_KIT_QUANTITY 
                  , BC.BUS_COM_ID
                  , BC.BUS_COM_NAME
                  , BC.BUS_COM_DESCRIPTION
                  , BC.LUT_COD_COM_TYPE 
                  , (SELECT lut_codes.LUT_COD_NAME FROM lut_codes WHERE lut_codes.LUT_COD_ID = BCA.LUT_COD_UNIT) AS UNIT 
                  , (SELECT lut_codes.LUT_COD_NAME FROM lut_codes WHERE lut_codes.LUT_COD_ID = BCA.LUT_COD_CURRENCY) AS CURRENCY 
                  , BCA.BUS_COM_ATT_PRICE 
                  , BCA.BUS_COM_ATT_WEIGHT
                FROM 
                  buss_com_by_kit AS BCK 
                INNER JOIN 
                  buss_commodities AS BC
                  ON BC.BUS_COM_ID = BCK.BUS_COM_ID
                INNER JOIN 
                  buss_commodity_attribute AS BCA 
                  ON BCA.BUS_COM_ID = BC.BUS_COM_ID ")) )
        	->columns( array('BUS_KIT_ID', 'BUS_COM_KIT_QUANTITY', 'BUS_COM_ID', 'BUS_COM_NAME', 'BUS_COM_DESCRIPTION', 'LUT_COD_COM_TYPE', 'UNIT', 'CURRENCY', 'BUS_COM_ATT_PRICE', 'BUS_COM_ATT_WEIGHT') )
    		->where("BCK.BUS_KIT_ID = {$kid} AND (".$options['where'].") AND LUT_COD_STATUS = (SELECT LUT_COD_ID FROM lut_codes where LUT_COD_TYPE = 'STATUS' AND LUT_COD_ABBREVIATION = 'ACTIVE' LIMIT 1)")
    		->order($options['order'])
    		->limit($options['limit']['length'])
    		->offset($options['limit']['start']);
    	$statement = $oSql->prepareStatementForSqlObject($oSelect);
    	$oResultSet = $statement->execute();
    	$resultSet = Array();
    	foreach ($oResultSet as $k=>$oR) {
    	    $resultSet[] = $oR;
    	}    	
    	$result['data'] = $resultSet;
        
    	$oSelect = $oSql
    	->select()
    	    ->from( array("A" => new Expression("SELECT 
                    BCK.BUS_KIT_ID
                  , BCK.BUS_COM_KIT_QUANTITY 
                  , BC.BUS_COM_ID
                  , BC.BUS_COM_NAME
                  , BC.BUS_COM_DESCRIPTION
                  , BC.LUT_COD_COM_TYPE 
                  , (SELECT lut_codes.LUT_COD_NAME FROM lut_codes WHERE lut_codes.LUT_COD_ID = BCA.LUT_COD_UNIT) AS UNIT 
                  , (SELECT lut_codes.LUT_COD_NAME FROM lut_codes WHERE lut_codes.LUT_COD_ID = BCA.LUT_COD_CURRENCY) AS CURRENCY 
                  , BCA.BUS_COM_ATT_PRICE 
                  , BCA.BUS_COM_ATT_WEIGHT
                FROM 
                  buss_com_by_kit AS BCK 
                INNER JOIN 
                  buss_commodities AS BC
                  ON BC.BUS_COM_ID = BCK.BUS_COM_ID
                INNER JOIN 
                  buss_commodity_attribute AS BCA 
                  ON BCA.BUS_COM_ID = BC.BUS_COM_ID ")) )
    		->columns( array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')) )
    		->where("BCK.BUS_KIT_ID = {$kid} AND (".$options['where'].") AND LUT_COD_STATUS = (SELECT LUT_COD_ID FROM lut_codes where LUT_COD_TYPE = 'STATUS' AND LUT_COD_ABBREVIATION = 'ACTIVE' LIMIT 1)");
    	$statement = $oSql->prepareStatementForSqlObject($oSelect);
    	$oResultSet = $statement->execute();
    	
    	
    	$countTemp = $oResultSet;
    	$count = Array();
    	foreach ($countTemp as $k=>$c){
    	    $count[] = $c;
    	}
    	$result['rows'] = $count[0]['num'];
    	return $result;
    }
     
     
     */
    
    
}

?>