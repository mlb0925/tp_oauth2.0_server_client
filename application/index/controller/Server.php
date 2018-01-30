<?php
namespace app\index\controller;

use think\Controller;

class Server extends Controller
{

    public function __construct()
    {
        parent::__construct ();
        $config = config('database');
        \OAuth2\Autoloader::register();
        $this->storage = new \OAuth2\Storage\Pdo(array('dsn' =>$config['api_dns'], 'username' => $config['username'], 'password' => $config['password']));
        $this->server = new \OAuth2\Server($this->storage);
        $this->server->addGrantType(new \OAuth2\GrantType\ClientCredentials($this->storage));
        $this->server->addGrantType(new \OAuth2\GrantType\AuthorizationCode($this->storage));
        $this->request = \OAuth2\Request::createFromGlobals();
        $this->response = new \OAuth2\Response();
    }
    public function resource() {
        if (!$this->request) {//验证token
            $this->server->getResponse()->send();
            echo json_encode(array('status' => -1, 'msg' => 'token error','data'=>array()));
        }else{//验证成功
               $token = $this->server->getAccessTokenData(\OAuth2\Request::createFromGlobals());
                $model = M ( "users" );
                $user_info = $model->where ( "user_id='{$token['user_id']}'" )->field('user_id,username,last_name')->find ();
                $data = array(
                    'status' => 1,
                    'msg' => 'msg',
                    'data'=>array(
                        'token_info'=>$token,
                        'user_info'=>$user_info
                    )
                );
                echo json_encode($data);
            }

        /*
        if ($rs = $this->require_scope ( "userinfo" )) {//授权成功
            $model = M ( 'access_tokens' );
            $data = $model->field ( "user_id" )->where ( "access_token='{$_GET['access_token']}'" )->find ();
            $model = M ( "users" );
            $data = $model->where ( "user_id='{$data['user_id']}'" )->find ();
            $this->arrayRecursive ( $data, 'urlencode', true );
            $json = json_encode ( $data );
            echo urldecode ( $json );exit;
        }*/
    }
    public function authorize(){
        if (!$this->server->validateAuthorizeRequest($this->request, $this->response)) {
            $this->response->send();
            die;
        }
        if (empty($_POST)) {
            exit('
<form method="post">
  <label>第三方登录?</label><br />
  <p><span>账号:</span><input type="text" name="username" value=""></p>
  <p><span>密码:</span><input type="password" name="password" value="" /></p>
  <input type="submit" name="authorized" value="登录">
</form>');
        }
        $name = $_POST ['username'];
        $pass = $_POST ['password'];
        $model = M ( "users" );
        $rs = $model->where ( "username='{$name}' and password='{$pass}'" )->find ();
        if (empty ( $rs )) {
            echo "用户名 密码错误";
            die ();
        }
        $is_authorized = ($_POST['authorized'] === '登录');
        $this->server->handleAuthorizeRequest($this->request, $this->response, $is_authorized,$rs['user_id']);
        if ($is_authorized) {
            // this is only here so that you get to see your code in the cURL request. Otherwise, we'd redirect back to the client
            $code = substr($this->response->getHttpHeader('Location'), strpos($this->response->getHttpHeader('Location'), 'code=')+5, 40);
            $result = $this->response->setRedirect2(302,$_GET['redirect_uri'].'?code='.$code."&state=".$_GET['state']);
            /*
             * $code = substr ( $this->response->getHttpHeader ( 'Location' ), strpos ( $this->response->getHttpHeader ( 'Location' ), 'code=' ) + 5, 40 );
			header ( "Location: " . $this->response->getHttpHeader ( 'Location' ) );
             */
            header("Location:$result");exit;
        }
        $this->response->send();
    }
    public function token(){
        $this->server->handleTokenRequest(\OAuth2\Request::createFromGlobals())->send();
    }
    /**
     * token校验
     * 正确返回 true
     * 错误返回错误信息
     * @param string $scope
     */
    public function require_scope($scope = "") {
        if (! $this->server->verifyResourceRequest ( $this->request, $this->response, $scope )) {
            return $this->server->getResponse ()->send ();
        } else {
            return true;
        }
    }
    /**
     * token 过期后 刷新token
     */
    public function refresh_token(){
        $this->server->addGrantType(new \OAuth2\GrantType\RefreshToken($this->storage, array(
            "always_issue_new_refresh_token" => true,
            "unset_refresh_token_after_use" => true,
            "refresh_token_lifetime" => 2419200,
        )));
        $this->server->handleTokenRequest($this->request)->send();
    }
    /**
     * 客户端认证模式
     */
    public function client_credentials(){
        $this->server->addGrantType(new \OAuth2\GrantType\ClientCredentials($this->storage, array(
            "allow_credentials_in_request_body" => true
        )));
        $this->server->handleTokenRequest($this->request)->send();
    }
    //json乱码
    function arrayRecursive(&$array, $function, $apply_to_keys_also = false) {
        foreach ( $array as $key => $value ) {
            if (is_array ( $value )) {
                $this->arrayRecursive ( $array [$key], $function, $apply_to_keys_also );
            } else {
                $array [$key] = $function ( $value );
            }

            if ($apply_to_keys_also && is_string ( $key )) {
                $new_key = $function ( $key );
                if ($new_key != $key) {
                    $array [$new_key] = $array [$key];
                    unset ( $array [$key] );
                }
            }
        }
    }
}
