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

use Tcontent\Model\Tables\TipTable;
use Tcontent\Model\Tables\LessonTipsTable;
use Tcontent\Model\Tables\TipSharedTable;
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
class Tips
{
    protected $tipTable;
    protected $lessonTipsTable;
    protected $tipsSharedTable;


    public function __construct()
    {
        $this->tipTable = new TipTable();
        $this->lessonTipsTable = new LessonTipsTable;
        $this->tipsSharedTable = new TipSharedTable;
    }
    
    
    /**
     * 
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getAllTips(){
        return $this->tipTable->fetchAll();
    }
    
    /**
     * 
     * @param number $pid
     * @return Ambigous <multitype:, multitype:NULL multitype: Ambigous <\ArrayObject, unknown> >
     */
    public function getTips($options = Array(), $lid)
    {
        $tips = $this->tipTable->getTips($options, $lid);
        return $tips;
    }
    
    
    public function updateTip(Array $data){
        return $this->tipTable->updateTip($data);
    }    
    
    
    public function saveTip($data){ 
        $dataTable = array();
        if ( isset($data['texto']) ) {
            $dataTable['tip_texto'] = $data['texto'];
        }
        if ( isset($data['descripcion']) ) {
            $dataTable['tip_descripcion'] = $data['descripcion'];
        }
        if ( isset($data['tags']) ) {
            $dataTable['tip_tags'] = $data['tags'];
        }     
        $dataTable['tip_activo'] = 1;
        if ( isset($data['id']) && $data['id']>0 ) {
            $dataTable['tip_id'] = $data['id'];
            if ($this->tipTable->updateByFieldsTip($dataTable)){
                return array("module_id" => $data['mid'], "lesson_id" => $data['lid'] );
            }
        }else { 
            if ( $new_tip_id = $this->tipTable->insertTip($dataTable) ){
                $tipLesson = array();
                $tipLesson['lec_id'] = $data['lid'];
                $tipLesson['tip_id'] = $new_tip_id;
                if ( $new_element_id = $this->lessonTipsTable->insertElement($tipLesson) ) {
                    return array("element_id" => $new_element_id, "unidad_id" => $new_unidad_id, "lesson_id" => $data['lid'], "module_id" => $data['mid'] );
                }
            }
        }
    }
    
    
    
    public function deleteTip($dataOrigin){
        $data['tip_activo'] = 0;
        $data['tip_id'] = $dataOrigin['id'];
        return $this->tipTable->updateByFieldsTip($data);
    }
    
    
    
    public function getTip ($id) 
    {
        return $this->tipTable->getTip($id);
    }
    
    
    
    
}

?>