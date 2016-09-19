<?php
namespace Tcontent\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

class UnidadinformacionOpcionTable extends AbstractTableGateway
{
    protected $table = 'cap_unidadinformacion_opcion';
    
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
    	$resultSet = $this->select("uni_inf_opc_id > 0");
    	return $resultSet->toArray();
    }
    
    
    public function getOpcion($id){
        $resultSet = $this->select(function (Select $select) use ($id) {
        	$select
                   ->join('cap_unidadinformacion_x_opcion', 'cap_unidadinformacion_x_opcion.uni_inf_opc_id = cap_unidadinformacion_opcion.uni_inf_opc_id', array('uni_inf_id' => 'uni_inf_id', 'uni_inf_x_opc_orden' => 'uni_inf_x_opc_orden', 'uni_inf_x_opc_correcta' => 'uni_inf_x_opc_correcta', 'uni_inf_opc_feedback' => 'uni_inf_opc_feedback', 'uni_inf_opc_feedback_audio' => 'uni_inf_opc_feedback_audio'))
        	   ->where("1 = 1 AND cap_unidadinformacion_opcion.uni_inf_opc_id = $id")
                   ;
        	//Debug::dump($select->getSqlString()); die;
        });
        if ($resultRow = $resultSet->toArray()){
        	return $resultRow[0];
        }else {
        	return false;
        }
    }
    
    public function getOpciones($options = Array(), $uid){
        $result = Array();
        $resultSet = $this->select(function (Select $select) use ($options, $uid) {
        	$select
                   ->join('cap_unidadinformacion_x_opcion', 'cap_unidadinformacion_x_opcion.uni_inf_opc_id = cap_unidadinformacion_opcion.uni_inf_opc_id', array('uni_inf_id' => 'uni_inf_id', 'uni_inf_x_opc_orden' => 'uni_inf_x_opc_orden', 'uni_inf_x_opc_correcta' => 'uni_inf_x_opc_correcta', 'uni_inf_opc_feedback' => 'uni_inf_opc_feedback', 'uni_inf_opc_feedback_audio' => 'uni_inf_opc_feedback_audio'))
        	   ->where("1 = 1 AND (".$options['where'].") AND cap_unidadinformacion_x_opcion.uni_inf_x_opc_visible = 1 AND cap_unidadinformacion_x_opcion.uni_inf_id = ".$uid)
        	   ->order($options['order'])
        	   ->limit($options['limit']['length'])
        	   ->offset($options['limit']['start'])
                   ;
        	//Debug::dump($select->getSqlString()); die;
        });
        $result['data'] = $resultSet->toArray();
        
        $resultSet = $this->select(function (Select $select) use ($options, $uid) {
        	$select
                ->join('cap_unidadinformacion_x_opcion', 'cap_unidadinformacion_x_opcion.uni_inf_opc_id = cap_unidadinformacion_opcion.uni_inf_opc_id', array('uni_inf_id' => 'uni_inf_id', 'uni_inf_x_opc_orden' => 'uni_inf_x_opc_orden', 'uni_inf_x_opc_correcta' => 'uni_inf_x_opc_correcta', 'uni_inf_opc_feedback' => 'uni_inf_opc_feedback', 'uni_inf_opc_feedback_audio' => 'uni_inf_opc_feedback_audio'))
        	->columns(array('num' => new \Zend\Db\Sql\Expression('COUNT(*)')))
        	->where("1 = 1 AND (".$options['where'].") AND cap_unidadinformacion_x_opcion.uni_inf_x_opc_visible = 1 AND cap_unidadinformacion_x_opcion.uni_inf_id = ".$uid);
        });
        $count = $resultSet->toArray();
        $result['rows'] = $count[0]['num'];
        return $result;
    }
    
    public function updateOpcion($data){ 
        $succes = false;
        foreach ($data as $id => $d) { 
            if ($this->update($d, "uni_inf_opc_id = $id")){
                $succes = $d;
            }else{
                $succes = false;
            }
        }
        return $succes;
    }
    
    public function updateByFieldsOpcion($data){
        $id = $data['uni_inf_opc_id'];
        unset($data['uni_inf_opc_id']);
        if ($this->update($data, "uni_inf_opc_id = $id")){
            return true;
        }else{
            return false;
        }
    }
    
    
    public function insertOpcion($data){
        if ( isset($data['uni_inf_opc_id']) ) {
            unset($data['uni_inf_opc_id']);
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