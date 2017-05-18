<cfoutput>
        <p class="login-box-msg">
        	<cfif isDefined ('show_message')>
            	#show_message#
            </cfif>
        </p>        

	<div class="row">

        <form name="send_text_email" action="" method="post">
            
            <div class="col-xs-6">First Name <input type="text" name="a_name_first" class="form-control" value="#records_Admin.a_name_first#" /></div>
            
            <div class="col-xs-6">Last Name <input type="text" name="a_name_last" class="form-control" value="#records_Admin.a_name_last#" /></div>
            
            <div class="col-xs-12">&nbsp;</div>

            <div class="col-xs-6">Cell (10 digits) <input type="text" name="a_cell" class="form-control" value="#records_Admin.a_cell#" maxlength="10" /></div>
            
            <div class="col-xs-6">Email <input type="text" name="a_email" class="form-control" value="#records_Admin.a_email#" /></div>
                        
            <div class="col-xs-12">&nbsp;</div>

            <div class="col-xs-6">Cell Provider 
            <select name="provider_fk" class="form-control">
                	<option value="">Select Cell Provider</option>
                <cfloop query="records_Providers">
                	<cfif #records_Admin.provider_fk# eq #records_Providers.provider_id#>
                    	<cfset selected = "selected">
                    <cfelse>
                    	<cfset selected = "">
                    </cfif>
                    <option value="#records_Providers.provider_id#" #selected#>#records_Providers.pr_name#</option>
            	</cfloop>
			</select>
            </div>
            <div class="col-xs-6">Password <input type="password" name="a_pswd" class="form-control" value="#records_Admin.a_pswd#" /></div>

			<div class="col-xs-12">&nbsp;</div>
            
            <div class="col-xs-12">Please select text message, email or both?</div>
            <cfif #records_Admin.a_receive_text# eq '1'>
            	<cfset receive_text_checked = "checked">
            <cfelse>
            	<cfset receive_text_checked = "">
            </cfif>
            <cfif #records_Admin.a_receive_email# eq '1'>
            	<cfset receive_email_checked = "checked">
            <cfelse>
            	<cfset receive_email_checked = "">
            </cfif>         
            <div class="col-xs-3">Text <input type="checkbox" name="a_receive_text" value="1" #receive_text_checked# /></div>
        	<div class="col-xs-3">Email <input type="checkbox" name="a_receive_email" value="1" #receive_email_checked# /></div>
            <div class="col-xs-6">&nbsp;</div>
            
            <div class="col-xs-12">&nbsp;</div>
            
            <cfif #records_Admin.a_receive_email# neq '1' and #records_Admin.a_receive_text# neq '1'>
            	<div class="col-xs-12 alert alert-danger"><h3>Warning!</h3>Please select "Text" or "Email" or Both.  You will NOT receive messages until at least one is checked.</div>
            </cfif>
            
            <div class="col-xs-6"><button name="save_Admin" type="submit" class="btn btn-primary btn-block btn-flat">Save</button></div>
            <div class="col-xs-6"><button name="save_test_Admin" type="submit" class="btn btn-primary btn-block btn-flat">Save & Send Test</button></div>
            
            <div class="col-xs-12">&nbsp;</div>
        	
            <input name="admin_id" type="hidden" value="#records_Admin.admin_id#" />
            <input name="role_fk" type="hidden" value="#records_Admin.role_fk#" />
        </form>
    </div>

</cfoutput>