<?php
return array(
    'controllers' => array(
        'invokables' => array(
            'Training\Controller\Index' => 'Training\Controller\IndexController',
            'Training\Controller\Content' => 'Training\Controller\ContentController',
        ),
    ),
    
    'router' => array(
        'routes' => array(
            'training' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/training',
                    'defaults' => array(
                        '__NAMESPACE__' => 'Training\Controller',
                        'controller'    => 'Index',
                        'action'        => 'index',
                    ),
                ),
            ),
            'trainings' => array(
                'type'    => 'segment',
                'options' => array(
                    'route'    => '/training/content[/:action][/:id]',
                    'constraints' => array(
                        'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
                        'id'     => '[0-9]+',
                    ),
                    'defaults' => array(
                        'controller' => 'Training\Controller\Content',
                        'action'     => 'list',
                    ),
                ),
            )
        ),
    ),

    'view_manager' => array(
        'template_path_stack' => array(
            'training' => __DIR__ . '/../view',
        ),
    ),
);