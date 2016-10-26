<?php
/**********************************************************
 * CLIENTE: PMA Colombia
* ========================================================
*
* @copyright PMA Colombia 2016
* @updated 
* @version 1
* @author {Abel Oswaldo Moreno Acevedo} <{moreno.abel@gmail.com}>
**********************************************************/
namespace Tcontent\Model;

use Tcontent\Model\Tables\UnidadinformacionXOpcionTable;
use Tcontent\Model\Tables\UnidadinformacionOpcionTable;
use Doctrine\Common\Util\Debug;
/**********************************************************
* MODELO Module
* =======================================================
*
* ATRIBUTOS
* $moduleTable   // Tabla modulos
*
*
* METODOS
* __construct();
*
**********************************************************/
class UnidadinformacionOpcion
{
    protected $opcionTable;
    protected $unidadXOpcionTable;


    public function __construct()
    {
        $this->opcionTable = new UnidadinformacionOpcionTable();
        $this->unidadXOpcionTable = new UnidadinformacionXOpcionTable();
    }
    
    
    /**
     * 
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getAllOpciones(){
        return $this->opcionTable->fetchAll();
    }
    
    /**
     * 
     * @param number $pid
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getOpciones($options = Array(), $uid)
    {
        $opciones = $this->opcionTable->getOpciones($options, $uid);
        return $opciones;
    }
    
    
    public function updateOpcion(Array $data){
        return $this->opcionTable->updateOpcion($data);
    }    
    
    
    public function saveOpcion($dataOpcion, $dataXUnidad){ 
        $dataTableOpcion = array();
        $dataTableUnidad = array();
        if ( isset($dataOpcion['texto']) ) {
            $dataTableOpcion['uni_inf_opc_texto'] = $dataOpcion['texto'];
        }
        if ( isset($dataOpcion['audio']) ) {
            $dataTableOpcion['uni_inf_opc_audio'] = $dataOpcion['audio'];
        }
        if ( isset($dataOpcion['imagen']) ) {
            $dataTableOpcion['uni_inf_opc_media'] = $dataOpcion['imagen'];
        }
        
        if ( isset($dataOpcion['id']) && $dataOpcion['id']>0 ) {
            $dataTableOpcion['uni_inf_opc_id'] = $dataOpcion['id'];
            if ($this->opcionTable->updateByFieldsOpcion($dataTableOpcion)){
                $dataTableUnidad['uni_inf_x_opc_correcta'] = $dataXUnidad['correcta'];
                $dataTableUnidad['uni_inf_opc_feedback'] = $dataXUnidad['feedback'];
                $dataTableUnidad['uni_inf_opc_feedback_audio'] = $dataXUnidad['feedback_audio'];
                $dataTableUnidad['uni_inf_x_opc_visible'] = 1;
                $dataTableUnidad['uni_inf_id'] = $dataXUnidad['uid'];
                $dataTableUnidad['uni_inf_opc_id'] = $dataOpcion['id'];
                if ( $this->unidadXOpcionTable->updateByFieldsOpcion($dataTableUnidad) ) {
                    array("opcion_id" => $dataOpcion['mid'], "nivel" => "Elemento");
                }
                return array("opcion_id" => $dataOpcion['mid']);
            }else {
                $dataTableUnidad['uni_inf_x_opc_correcta'] = $dataXUnidad['correcta'];
                $dataTableUnidad['uni_inf_opc_feedback'] = $dataXUnidad['feedback'];
                $dataTableUnidad['uni_inf_opc_feedback_audio'] = $dataXUnidad['feedback_audio'];
                $dataTableUnidad['uni_inf_x_opc_visible'] = 1;
                $dataTableUnidad['uni_inf_id'] = $dataXUnidad['uid'];
                $dataTableUnidad['uni_inf_opc_id'] = $dataOpcion['id'];
                if ( $this->unidadXOpcionTable->updateByFieldsOpcion($dataTableUnidad) ) {
                    array("opcion_id" => $dataOpcion['mid'], "nivel" => "Elemento");
                }
            }
        }else { 
            if ( $new_opcion_id = $this->opcionTable->insertOpcion($dataTableOpcion) ){
                $dataTableUnidad['uni_inf_x_opc_correcta'] = $dataXUnidad['correcta'];
                $dataTableUnidad['uni_inf_opc_feedback'] = $dataXUnidad['feedback'];
                $dataTableUnidad['uni_inf_opc_feedback_audio'] = $dataXUnidad['feedback_audio'];
                $dataTableUnidad['uni_inf_x_opc_visible'] = 1;
                $dataTableUnidad['uni_inf_id'] = $dataXUnidad['uid'];
                $dataTableUnidad['uni_inf_opc_id'] = $new_opcion_id;
                if ( $new_element_id = $this->unidadXOpcionTable->insertElement($dataTableUnidad) ) {
                    return array("opcion_id" => $new_opcion_id);
                }
            }
        }
        
        return $dataTableUnidad;
    }
    
    
    
    public function deleteOpcion($dataOrigin){
        $data = array("uni_inf_id"=>$dataOrigin['uid'], "uni_inf_opc_id"=>$dataOrigin['oid'], "uni_inf_x_opc_visible"=>0);
        if ( $this->unidadXOpcionTable->updateByFieldsOpcion($data) ) {
            array("opcion_id" => $data['uni_inf_opc_id']);
        }else {
            array();
        }
    }
    
    
    
    public function getOpcion ($id) 
    {
        return $this->opcionTable->getOpcion($id);
    }
    
    
}

?>