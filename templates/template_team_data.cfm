<cfoutput>
        <p class="login-box-msg">
        	<cfif isDefined ('show_message')>
            	#show_message#
            </cfif>
        </p>        
<!--- Show Team Information --->
	
	<table class="">
		<tr>
			<td>Name</td>
			<td>Cell</td>
			<td>Email</td>
		</tr>
	<cfloop query="records_Admin">
		<tr>
			<td>#records.Admin.a_name_first# #records.Admin.a_name_last#</td>
			<td>#records.Admin.a_cell#</td>
			<td>#records.Admin.a_email#</td>
		</tr>
	</cfloop>
	</table>
</cfoutput>