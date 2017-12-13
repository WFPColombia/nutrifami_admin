<?php
return array(
    'controllers' => array(
        'invokables' => array(
            'Tfrances\Controller\Modules' => 'Tfrances\Controller\ModulesController',
            'Tfrances\Controller\Lessons' => 'Tfrances\Controller\LessonsController',
            'Tfrances\Controller\Unidadinformacion' => 'Tfrances\Controller\UnidadinformacionController',
            'Tfrances\Controller\Unidadopcion' => 'Tfrances\Controller\UnidadopcionController',
            'Tfrances\Controller\Tip' => 'Tfrances\Controller\TipController',
        ),
    ),
    
    'router' => array(
        'routes' => array(
            'modules' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/tfrances/modules[/:action][/:id]',
                    'constraints' => array(
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id'     => '[0-9]+',
                    ),
                    'defaults' => array(
                        'controller' => 'Tfrances\Controller\Modules',
                        'action'     => 'list',
                    ),
                ),
            ),
            'lessons' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/tfrances/lessons[/:action][/:id]',
                    'constraints' => array(
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id'     => '[0-9]+',
                    ),
                    'defaults' => array(
                        'controller' => 'Tfrances\Controller\Lessons',
                        'action'     => 'list',
                    ),
                ),
            ),
            'unidadinformacion' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/tfrances/unidadinformacion[/:action][/:id]',
                    'constraints' => array(
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id'     => '[0-9]+',
                    ),
                    'defaults' => array(
                        'controller' => 'Tfrances\Controller\Unidadinformacion',
                        'action'     => 'list',
                    ),
                ),
            ),
            'unidadopcion' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/tfrances/unidadopcion[/:action][/:id]',
                    'constraints' => array(
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id'     => '[0-9]+',
                    ),
                    'defaults' => array(
                        'controller' => 'Tfrances\Controller\Unidadopcion',
                        'action'     => 'list',
                    ),
                ),
            ),
            'tip' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/tfrances/tip[/:action][/:id]',
                    'constraints' => array(
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id'     => '[0-9]+',
                    ),
                    'defaults' => array(
                        'controller' => 'Tfrances\Controller\Tip',
                        'action'     => 'list',
                    ),
                ),
            ),
        ),
    ),

    'view_manager' => array(
        'template_path_stack' => array(
            'tfrances' => __DIR__ . '/../view',
        ),
    ),
);