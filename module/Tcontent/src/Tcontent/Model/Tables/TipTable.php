<?php
namespace Tcontent\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

class TipTable extends AbstractTableGateway
{
    protected $table = 'tip_tips';
    
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
    	$resultSet = $this->select("tip_id > 0");
    	return $resultSet->toArray();
    }
    
    
    public function getTip($id){
        $params = array('tip_id' => $id);
        $resultSet = $this->select($params);
        if ($resultRow = $resultSet->toArray()){
        	return $resultRow[0];
        }else {
        	return false;
        }
    }
    
    public function getTips($options = Array(), $lid){
        $result = Array();
        $resultSet = $this->select(function (Select $select) use ($options, $lid) {
        	$select
                   ->join('tip_leccion_tips', 'tip_leccion_tips.tip_id = tip_tips.tip_id', Array())
        	   ->where("1 = 1 AND (".$options['where'].") AND tip_tips.tip_activo = 1 AND tip_leccion_tips.lec_id = ".$lid)
        	   ->order($options['order'])
        	   ->limit($options['limit']['length'])
        	   ->offset($options['limit']['start'])
                   ;
        	//Debug::dump($select->getSqlString()); die;
        });
        $result['data'] = $resultSet->toArray();
        
        $resultSet = $this->select(function (Select $select) use ($options, $lid) {
        	$select
                ->join('tip_leccion_tips', 'tip_leccion_tips.tip_id = tip_tips.tip_id', 'lec_id')
        	->columns(array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')))
        	->where("1 = 1  AND (".$options['where'].") AND tip_tips.tip_activo = 1 AND tip_leccion_tips.lec_id = ".$lid);
        });
        $count = $resultSet->toArray();
        $result['rows'] = $count[0]['num'];
        return $result;
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
    
    public function updateByFieldsTip($data){
        $id = $data['tip_id'];
        unset($data['tip_id']);
        if ($this->update($data, "tip_id = $id")){
            return true;
        }else{
            return false;
        }
    }
    
    
    public function insertTip($data){
        if ( isset($data['tip_id']) ) {
            unset($data['tip_id']);
        }
        if ( $this->insert($data) ) {
            $id = $this->lastInsertValue;
            return $id;
        }else {
            return false;
        }
    }
    
    
}

?>