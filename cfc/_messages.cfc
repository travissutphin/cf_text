<cfcomponent displayname="Messages to Users" hint="">

<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
	
	<cffunction name="message" returntype="string">
    	
        <cfargument name="value" required="yes">
        
        <cfswitch expression="#arguments.value#">
 
            <cfcase value="password_sent">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
					  <h4><i class="icon fa fa-check"></i> Password Sent</h4>
					  Please check you email for password help.
					</div> 
				 '>
                 
            </cfcase>
            
            <cfcase value="invalid_email">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
					  <h4><i class="icon fa fa-ban-circle"></i> Sorry!</h4>
					  That Email Address does not exist
					</div> 
				 '>
                 
            </cfcase>
            
            <cfcase value="forgot_password">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
					  <h4><i class="icon fa fa-lock"></i> Forgot Password?</h4>
					  Enter the email address and we will help reset your password
					</div> 
				 '>
                 
            </cfcase>
            
            <cfcase value="warning_default_login">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
					  <h4><i class="icon fa fa-ban"></i> Please change login information</h4>
					  The default login is still in use and should be changed.
					</div> 
				 '>
                 
            </cfcase> 
       	
            <cfcase value="logged_out">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						<h4><i class="icon fa fa-ban"></i> Please Login</h4>
						Your session has ended
					 </div>
				 '>
                 
            </cfcase>
            
            <cfcase value="invalid_credentials">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						<h4><i class="icon fa fa-ban"></i> Sorry!</h4>
						The credentials entered are invalid.
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="created">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
						<h4><i class="icon fa fa-check"></i> Created</h4>
						The record was created
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="error_creating">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						<h4><i class="icon fa fa-exclamation"></i> Error Occured</h4>
						The record was not created
					</div>
				 '>
                 
            </cfcase>
 
            <cfcase value="updated">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
						<h4><i class="icon fa fa-check"></i> Updated</h4>
						The record was updated
					</div>
				 '>
                 
            </cfcase>

            <cfcase value="updated_test_sent">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
						<h4><i class="icon fa fa-check"></i> Done!</h4>
						Please add noReply@NeaseCrossCountry.com to your safe sender list
					</div>
				 '>
                 
            </cfcase>
            
            <cfcase value="updated_ordering">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
						<h4><i class="icon fa fa-check"></i> Order has been Updated</h4>
						The record was updated
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="error_updating">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						<h4><i class="icon fa fa-exclamation"></i> Error Occured</h4>
						The record was not updated
					 </div>
				 '>
                 
            </cfcase>
            
            <cfcase value="deleted">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
						<h4><i class="icon fa fa-check"></i> Deleted</h4>
						The record was deleted
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="error_deleting">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						<h4><i class="icon fa fa-exclamation"></i> Error Occured</h4>
						The record was not deleted
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="jpg_only">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						<h4><i class="icon fa fa-exclamation"></i> Error Occured</h4>
						Only JPG images allowed
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="contact_email_sent">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
						<h4><i class="icon fa fa-exclamation"></i> Thank you</h4>
						Your email has been sent
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="contact_email_not_sent">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						<h4><i class="icon fa fa-exclamation"></i> Sorry!</h4>
						Your email has not been sent
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="captcha_not_matched">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						<h4><i class="icon fa fa-exclamation"></i> Sorry!</h4>
						Please reenter the text in the box
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="approved">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
						<h4><i class="icon fa fa-exclamation"></i> Approved!</h4>
						This will now show on the website.
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="register_success">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
						<h4>Welcome!</h4>
						Thank you for registering.  Please check your email for a Temporary password and login below.
					 </div>
				 '>
                 
            </cfcase>


            <cfcase value="email_already_registered">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						<h4>Sorry!</h4>
						Looks like that <strong>email address</strong> has already been registered.  Use the Forgot Password for assistance
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="cell_already_registered">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						<h4>Sorry!</h4>
						Looks like that <strong>cell number</strong> has already been registered.  Use the Forgot Password for assistance
					 </div>
				 '>
                 
            </cfcase>

            <cfcase value="access_key_does_not_exist">
           		
				<cfset result = '
					<div class="alert alert-danger alert-dismissible">
						Not able to find that access key
					 </div>
				 '>
                 
            </cfcase> 

            <cfcase value="message_sent">
           		
				<cfset result = '
					<div class="alert alert-success alert-dismissible">
						You message has been sent
					 </div>
				 '>
                 
            </cfcase>            
            
            

            <cfdefaultcase>
            	
                <cfset result = ''>
                
            </cfdefaultcase>
                                                
        </cfswitch> 
        
        <cfreturn result>       
    
    </cffunction>
    
<!--- :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: --->	
    
</cfcomponent>