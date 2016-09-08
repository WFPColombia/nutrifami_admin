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


    public function __construct()
    {
        $this->unidadinformacionTable = new UnidadinformacionTable();
        $this->lessonElementTable = new LessonElementTable();
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
        if ( isset($data['titulo']) ) {
            $dataTable['lec_titulo'] = $data['titulo'];
        }
        if ( isset($data['descripcion']) ) {
            $dataTable['lec_descripcion'] = $data['descripcion'];
        }
        if ( isset($data['imagen']) ) {
            $dataTable['lec_imagen'] = $data['imagen'];
        }     
        if ( isset($data['icono']) ) {
            $dataTable['lec_icono'] = $data['icono'];
        }   
        if ( isset($data['audio']) ) {
            $dataTable['lec_audio'] = $data['audio'];
        }   
        if ( isset($data['mensaje_final']) ) {
            $dataTable['lec_mensaje'] = $data['mensaje_final'];
        }   
        if ( isset($data['audio_final']) ) {
            $dataTable['lec_audio_final'] = $data['audio_final'];
        }      
        $dataTable['lec_activo'] = 1;
        if ( isset($data['id']) && $data['id']>0 ) {
            $dataTable['lec_id'] = $data['id'];
            if ($this->lessonTable->updateByFieldsLesson($dataTable)){
                return array("module_id" => $data['mid'] );
            }
        }else { 
            if ( $new_lesson_id = $this->lessonTable->insertLesson($dataTable) ){
                $elementModule = array();
                $elementModule['mod_id'] = $data['mid'];
                $elementModule['lec_id'] = $new_lesson_id;
                if ( $new_element_id = $this->moduleElementTable->insertElement($elementModule) ) {
                    return array("element_id" => $new_element_id, "lesson_id" => $new_lesson_id, "module_id" => $data['mid'] );
                }
            }
        }
    }
    
    
    
    public function deleteLesson($data){
        /* Pendiente hasta tener admin de opciones */
    }
    
    
    
    public function getUnidad ($id) 
    {
        return $this->unidadinformacionTable->getUnidad($id);
    }
    
    
}

?>