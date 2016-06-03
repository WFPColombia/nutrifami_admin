<?php
return array(
    'controllers' => array(
        'invokables' => array(
            'Tcontent\Controller\Modules' => 'Tcontent\Controller\ModulesController',
        ),
    ),
    
    'router' => array(
        'routes' => array(
            'album' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/tcontent/modules[/:action][/:id]',
                    'constraints' => array(
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id'     => '[0-9]+',
                    ),
                    'defaults' => array(
                        'controller' => 'Tcontent\Controller\Modules',
                        'action'     => 'list',
                    ),
                ),
            ),
        ),
    ),

    'view_manager' => array(
        'template_path_stack' => array(
            'tcontent' => __DIR__ . '/../view',
        ),
    ),
);