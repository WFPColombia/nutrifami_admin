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

use Tcontent\Model\Tables\UnidadinformacionTable;
use Tcontent\Model\Tables\LessonElementTable;
use Tcontent\Model\Tables\UnidadinformacionXOpcionTable;
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
class Unidadinformacion
{
    protected $unidadinformacionTable;
    protected $lessonElementTable;
    protected $unidadXOpcionTable;


    public function __construct()
    {
        $this->unidadinformacionTable = new UnidadinformacionTable();
        $this->lessonElementTable = new LessonElementTable();
        $this->unidadXOpcionTable = new UnidadinformacionXOpcionTable();
    }
    
    
    /**
     * 
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getAllUnidades(){
        return $this->unidadinformacionTable->fetchAll();
    }
    
    /**
     * 
     * @param number $pid
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getUnidades($options = Array(), $lid)
    {
        $unidades = $this->unidadinformacionTable->getUnidades($options, $lid);
        return $unidades;
    }
    
    
    public function updateUnidad(Array $data){
        return $this->unidadinformacionTable->updateUnidad($data);
    }    
    
    
    public function saveUnidad($data){ 
        $dataTable = array();
        if ( isset($data['tipo']) ) {
            $dataTable['uni_inf_tip_id'] = $data['tipo'];
            $dataTable['uni_inf_tip_alias'] = 'tipo'.$data['tipo'];
        }
        if ( isset($data['instruccion']) ) {
            $dataTable['uni_inf_instruccion'] = $data['instruccion'];
        }
        if ( isset($data['instruccion_audio']) ) {
            $dataTable['uni_inf_instruccion_audio'] = $data['instruccion_audio'];
        }     
        if ( isset($data['pregunta']) ) {
            $dataTable['uni_inf_titulo'] = $data['pregunta'];
        }   
        if ( isset($data['texto']) ) {
            $dataTable['uni_inf_texto'] = $data['texto'];
        }   
        if ( isset($data['audio']) ) {
            $dataTable['uni_inf_audio'] = $data['audio'];
        }      
        if ( isset($data['audio']) ) {
            $dataTable['uni_inf_media'] = $data['audio_texto'];
        }   
        if ( isset($data['imagen']) ) {
            $dataTable['uni_inf_imagen'] = $data['imagen'];
        }      
        $dataTable['uni_inf_activo'] = 1;
        if ( isset($data['id']) && $data['id']>0 ) {
            $dataTable['uni_inf_id'] = $data['id'];
            if ($this->unidadinformacionTable->updateByFieldsUnidad($dataTable)){
                return array("module_id" => $data['mid'], "lesson_id" => $data['lid'] );
            }
        }else { 
            if ( $new_unidad_id = $this->unidadinformacionTable->insertUnidad($dataTable) ){
                $elementLesson = array();
                $elementLesson['lec_id'] = $data['lid'];
                $elementLesson['uni_inf_id'] = $new_unidad_id;
                if ( $new_element_id = $this->lessonElementTable->insertElement($elementLesson) ) {
                    return array("element_id" => $new_element_id, "unidad_id" => $new_unidad_id, "lesson_id" => $data['lid'], "module_id" => $data['mid'] );
                }
            }
        }
    }
    
    
    
    public function deleteUnidad($dataOrigin){
        $data['uni_inf_activo'] = 0;
        $data['uni_inf_id'] = $dataOrigin['id'];
        return $this->unidadinformacionTable->updateByFieldsUnidad($data);
    }
    
    
    
    public function getUnidad ($id) 
    {
        return $this->unidadinformacionTable->getUnidad($id);
    }
    
    public function updateOpcion(Array $data){
        return $this->unidadXOpcionTable->updateOpcion($data);
    }
    
    
}

?>