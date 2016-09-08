<?php
return array(
    'controllers' => array(
        'invokables' => array(
            'Tcontent\Controller\Modules' => 'Tcontent\Controller\ModulesController',
            'Tcontent\Controller\Lessons' => 'Tcontent\Controller\LessonsController',
            'Tcontent\Controller\Unidadinformacion' => 'Tcontent\Controller\UnidadinformacionController',
        ),
    ),
    
    'router' => array(
        'routes' => array(
            'modules' => array(
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
            'lessons' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/tcontent/lessons[/:action][/:id]',
                    'constraints' => array(
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id'     => '[0-9]+',
                    ),
                    'defaults' => array(
                        'controller' => 'Tcontent\Controller\Lessons',
                        'action'     => 'list',
                    ),
                ),
            ),
            'unidadinformacion' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/tcontent/unidadinformacion[/:action][/:id]',
                    'constraints' => array(
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id'     => '[0-9]+',
                    ),
                    'defaults' => array(
                        'controller' => 'Tcontent\Controller\Unidadinformacion',
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