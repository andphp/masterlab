<?php

namespace main\plugin\devinte;

use main\app\classes\UserAuth;
use main\app\model\PluginModel;
use main\app\model\user\UserModel;
use main\plugin\BasePluginCtrl;

/**
 *
 *   插件的入口类
 * @package main\plugin\devinte
 */
class Index extends BasePluginCtrl
{

    public $pluginInfo = [];

    public $dirName = '';

    public $pluginMethod = 'pageIndex';

    public function __construct()
    {
        parent::__construct();

        // 当前插件目录名
        $this->dirName = basename(pathinfo(__FILE__)['dirname']);

        // 当前插件的配置信息
        $pluginModel = new PluginModel();
        $this->pluginInfo = $pluginModel->getByName($this->dirName);

        $pluginMethod = isset($_GET['_target'][3])? $_GET['_target'][3] :'';
        if($pluginMethod=="/" || $pluginMethod=="\\" || $pluginMethod==''){
            $pluginMethod = "pageIndex";
        }
        if(method_exists($this,$pluginMethod)){
            $this->pluginMethod = $pluginMethod;
            $this->$pluginMethod();
        }
    }

    /**
     * 插件首页方法
     * @throws \Exception
     */
    public function pageIndex()
    {
        $data = [];
        $data['title'] = '插件首页';
        $data['nav_links_active'] = 'plugin';
        $data['current_user']  = UserModel::getInstance()->getByUid(UserAuth::getId());
        $this->phpRender('index.php', $data);
    }


}
