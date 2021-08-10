<?php

namespace main\plugin\integrates;

use main\app\classes\PermissionLogic;
use main\app\classes\RewriteUrl;
use main\app\classes\UserAuth;
use main\app\ctrl\BaseCtrl;
use main\app\model\PluginModel;
use main\app\model\user\UserModel;
use main\plugin\BasePluginCtrl;
use main\plugin\integrates\model\IntegratesRepoModel;

/**
 *
 *   插件的入口类
 * @package main\plugin\integrates
 */
class Index extends BasePluginCtrl
{

    public $pluginInfo = [];

    public $dirName = '';

    public $pluginMethod = 'pageIndex';

    public $integrates = [
        'code',
        'review',
        'build',
        'command',
    ];

    public function __construct()
    {
        parent::__construct();

        // 当前插件目录名
        $this->dirName = basename(pathinfo(__FILE__)['dirname']);

        // 当前插件的配置信息
        $pluginModel = new PluginModel();
        $this->pluginInfo = $pluginModel->getByName($this->dirName);

        $pluginMethod = isset($_GET['_target'][3])? $_GET['_target'][3] :'';
        $pluginMethod = isset($_GET['_target'][3]) && in_array($_GET['_target'][3],$this->integrates)? $_GET['_target'][3]."_".$_GET['_target'][4] :$pluginMethod;
        $pluginMethod = isset($_GET['_target'][4]) && in_array($_GET['_target'][4],$this->integrates)? $_GET['_target'][4] :$pluginMethod;
        if($pluginMethod=="/" || $pluginMethod=="\\" || $pluginMethod==''){
            $pluginMethod = "pageIndex";
        }

//        var_dump($pluginMethod);
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
        $data['title'] = '开发集成';
        $data['sub_nav_active'] = 'plugin';
        $data['plugin_name'] = $this->dirName;
        $data['nav_links_active'] = 'integrates';
        $data = RewriteUrl::setProjectData($data);
        // 权限判断
        if (!empty($data['project_id'])) {
            if (!$this->isAdmin && !PermissionLogic::checkUserHaveProjectItem(UserAuth::getId(), $data['project_id'])) {
                $this->warn('提 示', '您没有权限访问该项目,请联系管理员申请加入该项目');
                die;
            }
        }

        $this->twigRender('index.twig', $data);
    }

    /**
     * 获取所有数据
     * @throws \Exception
     */
    public function fetchAll()
    {
        $model = new IntegratesRepoModel();
        if (isset($_GET['project_id'])) {
            $integrates = $model->getAllItem(['project_id'=>$_GET['project_id'],'deleted'=>0]);
        }else{
            $integrates = $model->getAllItem();
        }
        $data = [];
        $data['integrates'] = $integrates;
        $this->ajaxSuccess('', $data);
    }

    /**
     * 获取单条数据
     * @param $id
     * @throws \Exception
     */
    public function get()
    {
        $id = null;
        if (isset($_GET['_target'][4])) {
            $id = (int)$_GET['_target'][4];
        }
        if (isset($_GET['id'])) {
            $id = (int)$_GET['id'];
        }
        if (!$id) {
            $this->ajaxFailed('参数错误', 'id不能为空');
        }
        $model = new IntegratesRepoModel();
        $integrateOne = $model->getById($id);

        $this->ajaxSuccess('操作成功', (object)$integrateOne);
    }

    /**
     * 创建插件
     * @throws \Exception
     */
    public function add()
    {
        if (empty($_POST)) {
            $this->ajaxFailed('错误', '没有提交表单数据');
        }
        $_POST['name'] = trimStr($_POST['name']);
        if (isset($_POST['name']) && empty($_POST['name'])) {
            $errorMsg['name'] = '名称不能为空';
        }
        if (isset($_POST['scm']) && empty($_POST['scm'])) {
            $errorMsg['scm'] = '类型不能为空';
        }
        if (isset($_POST['path']) && empty($_POST['path'])) {
            $errorMsg['path'] = '地址不能为空';
        }
        if (isset($_POST['project_id']) && empty($_POST['project_id'])) {
            $errorMsg['project_id'] = '项目ID不能为空';
        }

//        $pattern="#(http|https)://(.*\.)?.*\..*#i";
//        if(!preg_match($pattern,$_POST['url'])){
//            $errorMsg['url'] = 'url格式不正确';
//        }

        $model = new IntegratesRepoModel();
        if (isset($model->getByName($_POST['name'])['id'])  && !empty($_POST['name'])) {
            $errorMsg['name'] = '名称已经被使用';
        }

        if (!empty($errorMsg)) {
            $this->ajaxFailed('参数错误', $errorMsg, BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }
        $name = trimStr($_POST['name']);
        $info = [];
        $info['name'] = $name;
        $info['scm'] = $_POST['scm'];
        $info['path'] = $_POST['path'];

        if (isset($_POST['desc'])) {
            $info['desc'] = $_POST['desc'];
        }
        if (isset($_POST['encoding'])) {
            $info['encoding'] = $_POST['encoding'];
        }
        if (isset($_POST['client'])) {
            $info['client'] = $_POST['client'];
        }
        if (isset($_POST['project_id'])) {
            $info['project_id'] = $_POST['project_id'];
        }

        list($ret, $msg) = $model->insert($info);
        if ($ret) {
            $this->ajaxSuccess('提示', '操作成功');
        } else {
            $this->ajaxFailed('服务器错误:', $msg);
        }
    }



    /**
     * 更新插件数据
     * @param $id
     * @param $params
     * @throws \Exception
     */
    public function update()
    {
        $id = null;
        if (isset($_POST['id'])) {
            $id = (int)$_POST['id'];
        }
        if (!$id) {
            $this->ajaxFailed('参数错误', 'id不能为空');
        }
        $errorMsg = [];

        $_POST['name'] = trimStr($_POST['name']);
        if (isset($_POST['name']) && empty($_POST['name'])) {
            $errorMsg['name'] = '名称不能为空';
        }
        if (isset($_POST['scm']) && empty($_POST['scm'])) {
            $errorMsg['scm'] = '类型不能为空';
        }
        if (isset($_POST['path']) && empty($_POST['path'])) {
            $errorMsg['path'] = '地址不能为空';
        }
        if (isset($_POST['project_id']) && empty($_POST['project_id'])) {
            $errorMsg['project_id'] = '项目ID不能为空';
        }

        if (!empty($errorMsg)) {
            $this->ajaxFailed('参数错误', $errorMsg, BaseCtrl::AJAX_FAILED_TYPE_FORM_ERROR);
        }


        $id = (int)$id;
        $model = new IntegratesRepoModel();
        $row = $model->getById($id);
        if (!isset($row['id'])) {
            $this->ajaxFailed('参数错误,数据不存在');
        }
        unset($row);
        $name = trimStr($_POST['name']);
        $info = [];
        $info['name'] = $name;
        $info['scm'] = $_POST['scm'];
        $info['path'] = $_POST['path'];

        if (isset($_POST['desc'])) {
            $info['desc'] = $_POST['desc'];
        }
        if (isset($_POST['encoding'])) {
            $info['encoding'] = $_POST['encoding'];
        }
        if (isset($_POST['client'])) {
            $info['client'] = $_POST['client'];
        }
        if (isset($_POST['project_id'])) {
            $info['project_id'] = $_POST['project_id'];
        }

        if (!empty($info)) {
            $model->updateById($id, $info);
        }
        $this->ajaxSuccess('操作成功');
    }

    /**
     * 删除插件，包括插件目录,谨慎操作
     * @param $id
     * @throws \Exception
     */
    public function delete()
    {
        $id = null;
        if (isset($_POST['id'])) {
            $id = (int)$_POST['id'];
        }
        if (!$id) {
            $this->ajaxFailed('参数错误', 'id不能为空');
        }
        $model = new IntegratesRepoModel();
        $model->deleteById($id);

        $this->ajaxSuccess("提示",'操作成功');

    }


}
