<cfoutput>
<!--- NOTES: --->
<!--- #session.cfc_to_use# is in the view.cfm of the file calling this page --->

<cfset #form.gal_order# = "0">
<cfset #form.gal_title# = "">

<!--- cfc_to_use is set at top of file that uses this --->
    <cfinvoke 
		component="#request.cfc#.#session.cfc_to_use#"
		method="create" 
		argumentcollection="#form#"
        returnvariable="result">
	</cfinvoke>



<cfif #result.status# eq "created">   
	<div id="status">success</div>
	<div id="message">Complete!</div>
<cfelse>
	<div id="status">error</div>
	<div id="message">Error uploading!</div>
</cfif>    

</cfoutput>