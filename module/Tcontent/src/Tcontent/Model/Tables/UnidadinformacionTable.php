<?php
namespace Tcontent\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

class UnidadinformacionTable extends AbstractTableGateway
{
    protected $table = 'cap_unidadinformacion';
    
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
    	$resultSet = $this->select("uni_inf_id > 0");
    	return $resultSet->toArray();
    }
    
    
    public function getUnidad($id){
        $params = array('uni_inf_id' => $id);
        $resultSet = $this->select($params);
        if ($resultRow = $resultSet->toArray()){
        	return $resultRow[0];
        }else {
        	return false;
        }
    }
    
    public function getUnidades($options = Array(), $lid){
        $result = Array();
        $resultSet = $this->select(function (Select $select) use ($options, $lid) {
        	$select
                   ->join('cap_leccion_elemento', 'cap_leccion_elemento.uni_inf_id = cap_unidadinformacion.uni_inf_id', array('lec_id' => 'lec_id', 'lec_ele_orden' => 'lec_ele_orden'))
        	   ->join('cap_unidadinformacion_tipo', 'cap_unidadinformacion_tipo.uni_inf_tip_id = cap_unidadinformacion.uni_inf_tip_id', array('uni_inf_tip_nombre', 'uni_inf_tip_icono', 'uni_inf_tip_audio'))
                   ->where("1 = 1 AND (".$options['where'].") AND cap_unidadinformacion.uni_inf_activo = 1 AND cap_leccion_elemento.lec_id = ".$lid)
        	   ->order($options['order'])
        	   ->limit($options['limit']['length'])
        	   ->offset($options['limit']['start'])
                   ;
        	//Debug::dump($select->getSqlString()); die;
        });
        $result['data'] = $resultSet->toArray();
        
        $resultSet = $this->select(function (Select $select) use ($options, $lid) {
        	$select
                ->join('cap_leccion_elemento', 'cap_leccion_elemento.uni_inf_id = cap_unidadinformacion.uni_inf_id', 'lec_id')
        	->columns(array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')))
        	->where("1 = 1  AND (".$options['where'].") AND cap_unidadinformacion.uni_inf_activo = 1 AND cap_leccion_elemento.lec_id = ".$lid);
        });
        $count = $resultSet->toArray();
        $result['rows'] = $count[0]['num'];
        return $result;
    }
    
    public function updateUnidad($data){ 
        $succes = false;
        foreach ($data as $id => $d) { 
            if ($this->update($d, "uni_inf_id = $id")){
                $succes = $d;
            }else{
                $succes = false;
            }
        }
        return $succes;
    }
    
    public function updateByFieldsUnidad($data){
        $id = $data['uni_inf_id'];
        unset($data['uni_inf_id']);
        if ($this->update($data, "uni_inf_id = $id")){
            return true;
        }else{
            return false;
        }
    }
    
    
    public function insertUnidad($data){
        if ( isset($data['uni_inf_id']) ) {
            unset($data['uni_inf_id']);
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