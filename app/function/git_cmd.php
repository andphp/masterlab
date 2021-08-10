<?php


if (!function_exists('git_branch')) {
    function git_branch($path){
        $path = is_dir($path)?$path:null;
        if(!$path){
            return ['branchNow'=>'','branch'=>[]];
        }
        $cmd = "cd " . $path . "&& git branch";
        $shell = shell_exec($cmd);
        $shellData = array_filter(preg_split('/\n/', $shell));
        $branchNow = '';
        $branch = array();
        foreach ($shellData as $item) {
            $str1 = preg_replace("/\s(?=\s)/", "\\1", $item);
            $str2 = trim($str1);
            $arr1 = explode(' ',$str2);
            if(count($arr1)>1){
                $branchNow = $arr1[1];
                $branch[]['name'] = $arr1[1];
            }else{
                $branch[]['name'] = $arr1[0];
            }
        }
        return ['branchNow'=>$branchNow,'branch'=>$branch];
    }
}
if (!function_exists('git_checkout')) {
    function git_checkout($path,$branch){
        $path = is_dir($path)?$path:null;
        if(!$path){
            return false;
        }
        $cmd = "cd " . $path . "&& git checkout ".$branch. "&& git branch";
        $shell = shell_exec($cmd);
        $shellData = array_filter(preg_split('/\n/', $shell));
        foreach ($shellData as $item) {
            $str1 = preg_replace("/\s(?=\s)/", "\\1", $item);
            $str2 = trim($str1);
            $arr1 = explode(' ',$str2);
            if(count($arr1)>1 && $arr1[1] == $branch){
                return true;
            }
        }
        return false;
    }
}
if (!function_exists('git_pull_all')) {
    function git_pull_all($path){
        $path = is_dir($path)?$path:null;
        if(!$path){
            return false;
        }

        $cmd = "cd " . $path;
        $fetchCmd = $cmd.' && git fetch --all';
        shell_exec($fetchCmd);

        $shell = shell_exec($cmd.'&& git branch -r');
        $shellData = array_filter(preg_split('/\n/', $shell));

        foreach ($shellData as $key => $item) {
            $str1 = preg_replace("/\s(?=\s)/", "\\1", $item);
            $item = trim($str1);
            $arr1 = explode('->',$item);
            if(count($arr1)>1){
                unset($shellData[$key]);
                continue;
            }
            $remote = explode('/',$item);
            $shellCmd = $cmd.'&& git branch --track '.$remote[1].' '.$item;
            shell_exec($shellCmd);
        }
        $pullCmd = $cmd.' && git pull --all';
        shell_exec($pullCmd);

        return true;
    }
}

if (!function_exists('git_log')) {
    function git_log($path,$filename)
    {
        $cmd = "cd " . $path . '&&git log -1 '.$filename;
        $shell = shell_exec($cmd);
        $shellData = array_filter(preg_split('/\n/', $shell));
        $account = '';
        $date = '';
        $commit = '';
        foreach ($shellData as $key => $item) {
            $str1 = preg_replace("/\s(?=\s)/", "\\1", $item);

            $str2 = trim($str1);
            $arr1 = explode(' ',$str2);
            if($arr1[0] == 'Author:'){
                $account = substr($str2,7);
                continue;
            }
            if($arr1[0] == 'Date:'){
                $date = date('Y-m-d H:i:s', strtotime(substr($str2,6)));
                continue;
            }
            if($key !== 0){
                $commit .= $str1;
            }
        }
        return [
            'account' => $account,
            'date' => $date,
            'comment' => $commit,
        ];
    }
}