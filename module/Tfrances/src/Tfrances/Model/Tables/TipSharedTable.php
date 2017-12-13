<?php
namespace Tfrances\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

class TipSharedTable extends AbstractTableGateway
{
    protected $table = 'tip_shared';
    
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
    	$resultSet = $this->select("sha_id > 0");
    	return $resultSet->toArray();
    }
    
    
    public function insertShared($data){
        if ( isset($data['sha_id']) ) {
            unset($data['sha_id']);
        }
        return $this->insert($data);
    }
    
    
}

?>