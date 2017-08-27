<?php
namespace Tcontent\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

class LessonTable extends AbstractTableGateway
{
    protected $table = 'cap_leccion';
    
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
    	$resultSet = $this->select("lec_id > 0");
    	return $resultSet->toArray();
    }
    
    
    public function getLesson($id){
        $params = array('lec_id' => $id);
        $resultSet = $this->select($params);
        if ($resultRow = $resultSet->toArray()){
        	return $resultRow[0];
        }else {
        	return false;
        }
    }
    
    public function getLessons($options = Array(), $mid){
        $result = Array();
        $resultSet = $this->select(function (Select $select) use ($options, $mid) {
        	$select
                   ->join('cap_modulo_elemento', 'cap_modulo_elemento.lec_id = cap_leccion.lec_id', array('mod_id' => 'mod_id', 'mod_ele_orden' => 'mod_ele_orden'))
        	   ->where("1 = 1 AND (".$options['where'].") AND lec_activo = 1 AND cap_modulo_elemento.mod_id = ".$mid)
        	   ->order($options['order'])
        	   ->limit($options['limit']['length'])
        	   ->offset($options['limit']['start'])
                   ;
        	//Debug::dump($select->getSqlString()); die;
        });
        $result['data'] = $resultSet->toArray();
        
        $resultSet = $this->select(function (Select $select) use ($options, $mid) {
        	$select
                ->join('cap_modulo_elemento', 'cap_modulo_elemento.lec_id = cap_leccion.lec_id', 'mod_id')
        	->columns(array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')))
        	->where("1 = 1  AND (".$options['where'].") AND lec_activo = 1 AND cap_modulo_elemento.mod_id = ".$mid);
        });
        $count = $resultSet->toArray();
        $result['rows'] = $count[0]['num'];
        return $result;
    }
    
    public function updateLesson($data){ 
        $succes = false;
        foreach ($data as $id => $d) {
            if ($this->update($d, "lec_id = $id")){
                $succes = $d;
            }else{
                $succes = false;
            }
        }
        return $succes;
    }
    
    public function updateByFieldsLesson($data){
        $id = $data['lec_id'];
        unset($data['lec_id']);
        if ($this->update($data, "lec_id = $id")){
            return true;
        }else{
            return false;
        }
    }
    
    
    public function insertLesson($data){
        if ( isset($data['lec_id']) ) {
            unset($data['lec_id']);
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