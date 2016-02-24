<?php
namespace Application;

class Menu
{
	public static function getMenu(){
		/*$menu = array(
	        array(
	            'label' => 'Inicio',
	            'route' => 'home',
	        ),
	        array(
	            'label' => 'Album',
	            'route' => 'album',
	            'pages' => array(
	                array(
	                    'label' => 'Add',
	                    'route' => 'album',
	                    'action' => 'add',
	                ),
	                array(
	                    'label' => 'Edit',
	                    'route' => 'album',
	                    'action' => 'edit',
	                ),
	                array(
	                    'label' => 'Delete',
	                    'route' => 'album',
	                    'action' => 'delete',
	                ),
	            ),
	        ),
	    );*/	        
	    $modules = \Util\UserSession::getModulesTree();
	    $menu = Menu::renderMenu($modules);
	    return $menu;
	}
	
	
	/**
	 * 
	 * Recibe el array de modulos y genera el html para el menu.
	 * 
	 * @param array $modules
	 * @return string
	 */
	public static function renderMenu($modules){
	   $menu = '';
	   if ( count($modules) > 0 ) {
	       $menu .= '<ul id="jMenu">';
	       foreach ($modules as $module) {
	           $menu .= '<li>';
	           if ($module['url'] != ''){
	               $menu .= '<a href="'.$module['url'].'">'.$module['name'].'</a>';
	           }else {
	               $menu .= '<a>'.$module['name'].'</a>';
	           }
	           $menu .= Menu::renderMenu($module['children']);
	           $menu .= '</li>';
	       }
	       $menu .= '</ul>';
	   }
	   return $menu;
	}
}

?>