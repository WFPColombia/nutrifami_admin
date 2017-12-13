<?php
namespace Tfrances\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

class LessonTipsTable extends AbstractTableGateway
{
    protected $table = 'tip_leccion_tips';
    
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
    
    
    public function insertElement($data){ 
        if ( $this->insert($data) ) {
            $id = $this->lastInsertValue;
            return $id;
        }else {
            return false;
        }
    }
    
    public function updateTip($data){ 
        $succes = false;
        foreach ($data as $id => $d) {
            if ($this->update($d, "tip_id = $id")){
                $succes = $d;
            }else{
                $succes = false;
            }
        }
        return $succes;
    }
    
    
}

?>