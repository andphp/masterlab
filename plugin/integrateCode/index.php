<?php

namespace main\plugin\integrateCode;

use main\app\classes\PermissionLogic;
use main\app\classes\RewriteUrl;
use main\app\classes\UserAuth;
use main\app\model\PluginModel;
use main\app\model\user\UserModel;
use main\plugin\BasePluginCtrl;
use main\plugin\integrates\model\IntegratesRepoModel;

/**
 *
 *   插件的入口类
 * @package main\plugin\integrateCode
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

        $pluginMethod = isset($_GET['_target'][3]) ? $_GET['_target'][3] : '';
        if ($pluginMethod == "/" || $pluginMethod == "\\" || $pluginMethod == '') {
            $pluginMethod = "pageIndex";
        }
        if (method_exists($this, $pluginMethod)) {
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
        $data['integrates_nav_links_active'] = 'code';
        $data = RewriteUrl::setProjectData($data);
        // 权限判断
        if (!empty($data['project_id'])) {
            if (!$this->isAdmin && !PermissionLogic::checkUserHaveProjectItem(UserAuth::getId(), $data['project_id'])) {
                $this->warn('提 示', '您没有权限访问该项目,请联系管理员申请加入该项目');
                die;
            }
        }

        $branch = ['branchNow'=>'','branch'=>[]];
        if (isset($_GET['repo'])) {
            $data['repo'] = $_GET['repo'];
            $branch = $this->gitBranchByRepoID($_GET['repo']);
        }

        $data['repos'] = (new IntegratesRepoModel())->getRows('id,name',['project_id'=>$data['project_id']]);

        $data = array_merge($data,$branch);

        $this->twigRender('index.twig', $data);
    }

    public function fetchAll()
    {
        $where = array();
        if (isset($_GET['repo'])) {
            $where = ['id' => $_GET['repo']];
        }
        $dir = null;
        $branch = null;
        if (isset($_GET['branch'])) {
            $branch = $_GET['branch'];
        }
        if (isset($_GET['dir'])) {
            $dir = $_GET['dir'];
        }
        $file = null;
        if (isset($_GET['file'])) {
            $file = $_GET['file'];
        }
        $repo = (new IntegratesRepoModel())->getRow('id,name,path,scm,client', $where);
        if (!empty($repo)) {
            $data['repo'] = $repo;
        }
        // 切换分支
        if($branch){
            $branchTrue = git_checkout($repo['path'],$branch);
//            var_dump($branchTrue);
        }
        $ret = array();
        $rootPath = $dir?explode('/',$dir):[];
        $repo['path'] = $dir?$repo['path'].$dir:$repo['path'];
        $path = (is_dir($repo['path']))?$repo['path']:null;
//        var_dump(is_dir($repo['path']));exit;
        if(strtolower($repo['scm']) == 'git' && $path){
            $cmd = "cd " . $path . "&& git ls-tree -l HEAD";
            $shell = shell_exec($cmd);
            $shellData = array_filter(preg_split('/\n/', $shell));
            $keys = [
                'auth',
                'kind',
                'revision',
                'size',
                'name'
            ];
//            var_dump($shellData);exit;

            foreach ($shellData as $item) {
                $str1 = preg_replace("/\s(?=\s)/", "\\1", $item);
                $str2 = str_replace("\t", " ", $str1);
                //去除字符串左右两边的空格
                $str3 = trim($str2);
                //将字符串以空格为界分隔
                $retArr = explode(" ", $str3);
                $fileInfo = array_combine($keys, $retArr);

                $fileInfo['kind'] = ($fileInfo['kind'] == 'tree')?'dir':'file';
                $fileInfo['size'] = ($fileInfo['size'] > 0)?$fileInfo['size'].' B':$fileInfo['size'];
                $fileInfo['dir'] = $dir; //增加rootPath

                $log = git_log($path,$fileInfo['name']);

                $ret[] = array_merge($fileInfo,$log);
            }
            $last_names = array_column($ret,'kind');
            array_multisort($last_names,SORT_ASC,$ret);
        }

        $rootPath = array_filter($rootPath);
        $rootPath2 = array();
        foreach ($rootPath as $key => $item ){

            $path = '';
            for($start=1;$start<$key;$start++){
                $path = $path=='/'? $path . $rootPath[$start]:$path .'/'. $rootPath[$start];
            }
            $rootPath2[] = ['name'=>$item,'path'=>$path];
        }


        $data['rootPath'] = $rootPath2;
        $data['infos'] = $ret;
        $this->ajaxSuccess('', $data);
    }

    public function branchSelect()
    {
        $where = array();
        if (isset($_GET['repo'])) {
            $where = ['id' => $_GET['repo']];
        }
        $repo = (new IntegratesRepoModel())->getRow('id,name,path,scm,client', $where);
        $path = (is_dir($repo['path']))?$repo['path']:null;
        $data = ['branchNow'=>'','branch'=>[]];
        if(strtolower($repo['scm']) == 'git' && $path){
            $data = git_branch($path);
        }
        $this->ajaxSuccess('', $data);
    }

    protected function gitBranchByRepoID($repoID)
    {
        $repo = (new IntegratesRepoModel())->getRow('id,name,path,scm,client', ['id' => $repoID]);
        if(!$repo){
            return [];
        }
        $path = (is_dir($repo['path']))?$repo['path']:null;
        $data = ['branchNow'=>'','branch'=>[]];
        if(strtolower($repo['scm']) == 'git' && $path){
            $data = git_branch($path);
        }
        return $data;
    }

    public function branchFetch()
    {
        $where = array();
        if (isset($_GET['repo'])) {
            $where = ['id' => $_GET['repo']];
        }
        $repo = (new IntegratesRepoModel())->getRow('id,name,path,scm,client', $where);
        $path = (is_dir($repo['path']))?$repo['path']:null;
        $data = [];
        if(strtolower($repo['scm']) == 'git' && $path){
            git_pull_all($path);
        }
        $this->ajaxSuccess('', []);
    }
}
