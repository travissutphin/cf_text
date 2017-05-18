<cfoutput>
<br />
    <div class="login-box">

      <div class="login-box-body">
        <p class="login-box-msg">
        	<cfif isDefined ('show_message')>
            	#show_message#
            </cfif>
        </p>
        
        <cfif isDefined('session.msg') and #session.msg# eq "forgot_password">

<!--- FORGOT PASSWORD FORM --->         
        <form name="Login" action="" method="post">
          <div class="form-group has-feedback">
            <input name="a_email" type="email" class="form-control" placeholder="Email" >
            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
          </div>

          <div class="row">
          
            <div class="col-xs-12 col-sm-hidden midden-md hidden-lg">
              <button name="recover_password" type="submit" class="btn btn-primary btn-block btn-flat">Recover</button>
            </div><!-- /.col -->

            <div class="col-xs-12 col-sm-hidden midden-md hidden-lg">
            <p>&nbsp;</p>
            </div>
                        
            <div class="col-xs-12 col-sm-hidden midden-md hidden-lg">
            	<button name="msg" value="login" type="submit" class="btn btn-primary btn-block btn-flat">Login</button>
            </div>

            <div class="col-xs-12 col-sm-hidden midden-md hidden-lg">
            <p>&nbsp;</p>
            </div>
            
            <div class="col-xs-12 col-sm-hidden midden-md hidden-lg">
            	<button name="msg" value="register_1" type="submit" class="btn btn-primary btn-block btn-flat">Register</button>
            </div>
            
          </div>
        </form>
<!--- FORGOT PASSWORD FORM --->    

		<cfelseif isDefined('session.msg') and #session.msg# eq "register_1" or isDefined('session.msg') and #session.msg# eq "access_key_does_not_exist">

<!--- REGISTER --->
        
			<!---
            <div class="col-xs-6">
 
				<form name="Login" action="" method="post">
                <div class="form-group">
                  Enter Access Code below:
                  <input name="gr_access_key" type="text" class="form-control" placeholder="Access Key">
                </div>
				<div class="form-group">
                    <button name="join_group" type="submit" class="btn btn-primary btn-block btn-flat">Join Group</button>
                </div>
                </form>
                   
            </div>
            --->
            
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                <form name="Login" action="" method="post">
                  <div class="form-group">
                    <input name="a_name_first" type="text" class="form-control" placeholder="First Name" >
                  </div>
                  <div class="form-group">
                    <input name="a_name_last" type="text" class="form-control" placeholder="Last Name" >
                  </div>
                  <div class="form-group">
                    <input name="a_email" type="email" class="form-control" placeholder="Email" >
                  </div>
                  <div class="form-group">
                    Password:<br />
                    Will be emailed to you to validate email address
                  </div>
                  <div class="form-group">
                    <input name="a_cell" type="text" class="form-control" placeholder="10 Digit Cell Number - Numbers Only" maxlength="10" >
                  </div>
                  <div class="form-group">
                    <select name="provider_fk" class="form-control">
                        <option value="">Select Cell Provider</option>
                    <cfloop query="records_Providers">
                        <option value="#records_Providers.provider_id#">#records_Providers.pr_name#</option>
                    </cfloop>
                    </select>
                  </div>
                  <div class="row">
                    <div class="col-xs-8">
                     
                    </div><!-- /.col -->
                    <div class="col-xs-4">
                      <button name="register" type="submit" class="btn btn-primary btn-block btn-flat">Register</button>
                      <input type="hidden" name="role_fk" value="3" />
                    </div><!-- /.col -->
                  </div>
                </form>		

            </div>      
<!--- REGISTER --->       

        <cfelse>
 
<!--- MAIN LOGIN FORM --->       

        
        <form name="Login" action="" method="post">
          
          <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
          
          <div class="form-group has-feedback">
            <input name="a_email" type="email" class="form-control" placeholder="Email">
          </div>
          <div class="form-group has-feedback">
            <input name="a_pswd" type="password" class="form-control" placeholder="Password">
          </div>
          
          </div>
          
          <div class="col-md-8">
          
          </div>
          
          <div class="col-md-12">
          
          </div>
            
            <div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
              <button name="msg" value="login" type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
            </div><!-- /.col -->
			
            <div class="col-xs-12 col-sm-hidden midden-md hidden-lg">
            <p>&nbsp;</p>
            </div>
            
			<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
            	<button name="msg" value="forgot_password" type="submit" class="btn btn-primary btn-block btn-flat">Forgot Password</button>
            </div>

            <div class="col-xs-12 col-sm-hidden midden-md hidden-lg">
            <p>&nbsp;</p>
            </div>
                        
            <div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
            	<button name="msg" value="register_1" type="submit" class="btn btn-primary btn-block btn-flat">Register</button>
            </div>
            
            <input name="current_location" value="website" type="hidden">

        </form>
        
<!--- MAIN LOGIN FORM ---> 
		
        </cfif>
        
      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->

</cfoutput>