<?php
namespace Tcontent\Model\Tables;

use Zend\Db\TableGateway\AbstractTableGateway;
use Zend\Db\TableGateway\Feature;
use Zend\Db\Adapter\Adapter;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\Sql\Select;
use Zend\Debug\Debug;
use Zend\Db\Sql\Expression;

class UnidadinformacionXOpcionTable extends AbstractTableGateway
{
    protected $table = 'cap_unidadinformacion_x_opcion';
    
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
    
    public function updateOpcion($data){ 
        /*$oid = $data['uni_inf_opc_id'];
        unset($data['uni_inf_opc_id']);
        $uid = $data['uni_inf_id'];
        unset($data['uni_inf_id']);
        $where = array("uni_inf_opc_id"=>$oid, "uni_inf_id"=>$uid);
        if ($this->update($data, $where)){
            return true;
        }else{
            return false;
        }*/
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
    
    
}

?>