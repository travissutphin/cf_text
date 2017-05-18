<cfoutput>
<cfinclude template="controller.cfm">
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>CMS Log in</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="#request.siteURL#assets/css_admin/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="#request.siteURL#assets/css_admin/dist/css/AdminLTE.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body class="hold-transition login-page">
    <div class="login-box">
      <div class="login-logo">
        <a href="##"><b>Thorium</b> CMS</a>
      </div><!-- /.login-logo -->
      <div class="login-box-body">
        <p class="login-box-msg">
        	<cfif isDefined ('show_message')>
            	#show_message#
            </cfif>
        </p>
        
        <cfif isDefined('url.msg') and #url.msg# eq "forgot_password">
        
        <form name="login" action="index.cfm" method="post">
          <div class="form-group has-feedback">
            <input name="a_email" type="email" class="form-control" placeholder="Email">
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
			&nbsp;
          </div>
          <div class="row">
            <div class="col-xs-8">
             
            </div><!-- /.col -->
            <div class="col-xs-4">
              <button name="recover_password" type="submit" class="btn btn-primary btn-block btn-flat">Recover</button>
            </div><!-- /.col -->
          </div>
        </form>
        
        <a href="index.cfm">Login</a><br>
        
        <cfelse>
        
        <form name="login" action="index.cfm" method="post">
          <div class="form-group has-feedback">
            <input name="a_email" type="email" class="form-control" placeholder="Email">
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <input name="a_pswd" type="password" class="form-control" placeholder="Password">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
          </div>
          <div class="row">
            <div class="col-xs-8">
             
            </div><!-- /.col -->
            <div class="col-xs-4">
              <button name="login" type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
            </div><!-- /.col -->
          </div>
          
          <input name="current_location" value="cms" type="hidden">
          
        </form>

        <a href="index.cfm?msg=forgot_password">I forgot my password</a><br>
		
        </cfif>
        
      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->

  </body>
</html>
</cfoutput>
