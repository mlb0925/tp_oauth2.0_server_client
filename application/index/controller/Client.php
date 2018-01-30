<?php
namespace app\index\controller;

use think\Controller;

class Client extends Controller
{
    const GET_AUTH_CODE_URL = "http://www.c.com/public/index.php/Index/Server/authorize";
    const GET_ACCESS_TOKEN_URL = "http://www.c.com/public/index.php/Index/Server/token";
    const GET_RESOURCE_URL = "http://www.c.com/public/index.php/Index/Server/resource";
    const APP_ID = "testclient";	//应用的APPKEY
    const APP_SECRET = "testpass";//应用密钥
    const REDIRECT_URI = 'http://www.c.com/public/index.php/Index/Client/login';//成功授权后的回调地址
    public static function getAuthorizeUrl($app_param=array()){
        $params = array(
            'response_type'=>'code',
            'client_id'=>isset($app_param['appid'])?$app_param['appid']:SELF::APP_ID,
            'redirect_uri'=>isset($app_param['redirect_uri'])?$app_param['redirect_uri']:SELF::REDIRECT_URI,
            'state'=>$app_param['state'],
        );
        $authorze_url = SELF::GET_AUTH_CODE_URL.'?'.http_build_query($params);
        return $authorze_url;
    }
    public static function getToken($app_param=array()){
        $params = array(
            'grant_type'=>'authorization_code',
            'client_id'=>isset($app_param['appid'])?$app_param['appid']:SELF::APP_ID,
            'redirect_uri'=>isset($app_param['redirect_uri'])?$app_param['redirect_uri']:SELF::REDIRECT_URI,
            'client_secret'=>isset($app_param['app_secret'])?$app_param['app_secret']:SELF::APP_SECRET,
            'code'=>$app_param['code'],
        );
        $response = self::post(SELF::GET_ACCESS_TOKEN_URL,$params);
        return $response;

    }
    public static function getApiData($app_param=array()){

        $params = array(
            'access_token'=>$app_param['access_token'],
        );
        $openid_url = SELF::GET_RESOURCE_URL.'?'.http_build_query($params);
        //   echo $openid_url;
        $str  = file_get_contents($openid_url);
        $data = json_decode($str,true);
        return $data;

    }
    public function login(){
        $code = isset($_REQUEST["code"])?$_REQUEST["code"]:'';
        if(empty($code))
        {
            //state参数用于防止CSRF攻击，成功授权后回调时会原样带回
            session('state', md5(uniqid(rand(), TRUE)));
            $data['state'] =  session('state');
            $authorze_url = $this->getAuthorizeUrl($data);
            header('Location:'.$authorze_url);
        }
        if(isset($_REQUEST['state']) && ($_REQUEST['state'] == session('state')))
        {
            //Step2：通过Authorization Code获取Access Token
            $data = array(
                'code'=>$code,
            );

            if(!empty($_SESSION['token']) && $_SESSION['token_expire_at']>time()){
                $token =  $_SESSION['token'];

            }else{
                $token =  $this->getToken($data);

            }
            //Step3：使用Access Token来获取用户的OpenID
            if(!empty($token['access_token']))
            {
                $_SESSION['token'] = $token;
                $_SESSION['token_expire_at'] = time()+$token['expires_in'];
                $user_info =  $this->getApiData($token);
                var_dump($user_info);
            }else{
                exit('token error...');
            }
        }else{
            exit("csrf...");
        }
    }
    /***
     * @param $url
     * @param array $header_options
     * @return mixed
     */
    static function get($url,array $header_options = array())
    {
        $ch = curl_init();
        $curl_options = array(
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => 1, //返回原生的（Raw）输出
            //            CURLOPT_HEADER => 0,
            //            CURLOPT_TIMEOUT => 120, //超时时间
            //            CURLOPT_FOLLOWLOCATION => 1, //是否允许被抓取的链接跳转
            CURLOPT_ENCODING=>'gzip,deflate',
            CURLOPT_HTTPHEADER => $header_options,
        );
        if (strpos($url,"https")!=false) {
            $curl_options[CURLOPT_SSL_VERIFYPEER] = false; // 对认证证书来源的检查
        }
        curl_setopt_array($ch, $curl_options);
        $res = curl_exec($ch);
        $data = json_decode($res,true);
        if(json_last_error() != JSON_ERROR_NONE){
            $data = $res;
        }
        curl_close($ch);
        return $data;
    }
    /**
     * post 请求
     * @param $url 请求url
     * @param array $param  post参数
     * @param array $header 头部信息
     * @param bool $login   是否登陆
     * @param int $ssl      启用ssl
     * @param int $log      是否记录日志
     * @param string $format返回数据格式
     * @return mixed
     */
    static function post($url, array $param = array(), array $header = array())
    {
        $ch = curl_init();
        $post_param = array();
        if (is_array($param)) {
            $post_param = http_build_query($param);
        } else if (is_string($param)) { //json字符串
            $post_param = $param;
        }
        $header_options =  $header;
        $curl_options = array(
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => 1, //返回原生的（Raw）输出
            CURLOPT_HEADER => 0,
            CURLOPT_TIMEOUT => 120, //超时时间
            CURLOPT_FOLLOWLOCATION => 1, //是否允许被抓取的链接跳转
            CURLOPT_HTTPHEADER => $header_options,
            CURLOPT_POST => 1, //POST
            CURLOPT_POSTFIELDS => $post_param, //post数据
            CURLOPT_ENCODING=>'gzip,deflate'
        );
        //debug 1
        //        curl_setopt($ch,CURLINFO_HEADER_OUT,1);
        //        curl_setopt($ch,CURLOPT_HEADER,1);
        //debug 2 详细的请求过程
        //        curl_setopt($ch,CURLOPT_VERBOSE,true);
        //        curl_setopt($ch,CURLINFO_HEADER_OUT,0);
        //        curl_setopt($ch,CURLOPT_HEADER,0);
        //        curl_setopt($ch,CURLOPT_VERBOSE,true);
        //        $fp = fopen('php://temp', 'rw+');
        //        curl_setopt($ch,CURLOPT_STDERR,$fp);
        if (strpos($url,"https")!==false) {
            $curl_options[CURLOPT_SSL_VERIFYPEER] = false; // 对认证证书来源的检查
        }
        curl_setopt_array($ch, $curl_options);
        $res = curl_exec($ch);
        // $debug_info = rewind($fp) ? stream_get_contents($fp):"";
        //$debug_info = curl_getinfo($ch);
        //  print_r($debug_info);
        $data = json_decode($res, true);
        if(json_last_error() != JSON_ERROR_NONE){
            $data = $res;
        }
        curl_close($ch);
        return $data;
    }

}
