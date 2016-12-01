<?php
return array(
    'controllers' => array(
        'invokables' => array(
            'Twayuu\Controller\Modules' => 'Twayuu\Controller\ModulesController',
            'Twayuu\Controller\Lessons' => 'Twayuu\Controller\LessonsController',
            'Twayuu\Controller\Unidadinformacion' => 'Twayuu\Controller\UnidadinformacionController',
            'Twayuu\Controller\Unidadopcion' => 'Twayuu\Controller\UnidadopcionController',
            'Twayuu\Controller\Tip' => 'Twayuu\Controller\TipController',
        ),
    ),
    
    'router' => array(
        'routes' => array(
            'twayuu' => array(
                'type'    => 'Literal',
                'options' => array(
                    // Change this to something specific to your module
                    'route'    => '/twayuu',
                    'defaults' => array(
                        // Change this value to reflect the namespace in which
                        // the controllers for your module are found
                        '__NAMESPACE__' => 'Twayuu\Controller',
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
            'Twayuu' => __DIR__ . '/../view',
        ),
    ),
);
