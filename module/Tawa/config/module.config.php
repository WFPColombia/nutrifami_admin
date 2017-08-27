<?php
return array(
    'controllers' => array(
        'invokables' => array(
            'Tawa\Controller\Modules' => 'Tawa\Controller\ModulesController',
            'Tawa\Controller\Lessons' => 'Tawa\Controller\LessonsController',
            'Tawa\Controller\Unidadinformacion' => 'Tawa\Controller\UnidadinformacionController',
            'Tawa\Controller\Unidadopcion' => 'Tawa\Controller\UnidadopcionController',
            'Tawa\Controller\Tip' => 'Tawa\Controller\TipController',
        ),
    ),
    
    'router' => array(
        'routes' => array(
            'twayuu' => array(
                'type'    => 'Literal',
                'options' => array(
                    // Change this to something specific to your module
                    'route'    => '/tawa',
                    'defaults' => array(
                        // Change this value to reflect the namespace in which
                        // the controllers for your module are found
                        '__NAMESPACE__' => 'Tawa\Controller',
                        'controller'    => 'Modules',
                        'action'        => 'list',
                    ),
                ),
                'may_terminate' => true,
                'child_routes' => array(
                    // This route is a sane default when developing a module;
                    // as you solidify the routes for your module, however,
                    // you may want to remove it and replace it with more
                    // specific routes.
                    'default' => array(
                        'type'    => 'Segment',
                        'options' => array(
                            'route'    => '/[:controller[/:action]]',
                            'constraints' => array(
                                'controller' => '[a-zA-Z][a-zA-Z0-9_-]*',
                                'action'     => '[a-zA-Z][a-zA-Z0-9_-]*',
                            ),
                            'defaults' => array(
                            ),
                        ),
                    ),
                ),
            ),
        ),
    ),
    'view_manager' => array(
        'template_path_stack' => array(
            'Tawa' => __DIR__ . '/../view',
        ),
    ),
);
