        <cfinvoke 
            component="#request.cfc#.slide_show"
            method="read"
            returnvariable="data_Slide_Show">
        </cfinvoke> 
		
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
		<cfoutput><script src="#request.siteURL#plugins/simple_slideshow/slippry.min.js"></script></cfoutput>
		<script src="//use.edgefonts.net/cabin;source-sans-pro:n2,i2,n3,n4,n6,n7,n9.js"></script>
		<meta name="viewport" content="width=device-width">
    <cfoutput><link rel="stylesheet" href="#request.siteURL#plugins/simple_slideshow/slippry.css"></cfoutput>

		<section class="demo_wrapper">
			<article class="demo_block">				
			<ul id="demo1">
				<cfoutput query="data_Slide_Show">
                <cfif #data_Slide_Show.ss_link# neq "">
					<cfset show_link = " <a href=#data_Slide_Show.ss_link# target='_blank'>#data_Slide_Show.ss_caption#</a> " >
				<cfelse>
					<cfset show_link = "">
				</cfif>
				
                <li><a width="500px" href="##slide#data_Slide_Show.currentrow#">
                	<img src="#request.siteURL#assets/images/uploads/#data_Slide_Show.ss_image#" alt="#data_Slide_Show.ss_title# #show_link#" />
                    </a>
				</li>
                </cfoutput>
			</ul>
			</article>
		</section>		

		<script>
			$(function() {
				var demo1 = $("#demo1").slippry({
					// transition: 'fade',
					// useCSS: true,
					// speed: 1000,
					// pause: 3000,
					// auto: true,
					// preload: 'visible',
					// autoHover: false
				});

				$('.stop').click(function () {
					demo1.stopAuto();
				});

				$('.start').click(function () {
					demo1.startAuto();
				});

				$('.prev').click(function () {
					demo1.goToPrevSlide();
					return false;
				});
				$('.next').click(function () {
					demo1.goToNextSlide();
					return false;
				});
				$('.reset').click(function () {
					demo1.destroySlider();
					return false;
				});
				$('.reload').click(function () {
					demo1.reloadSlider();
					return false;
				});
				$('.init').click(function () {
					demo1 = $("#demo1").slippry();
					return false;
				});
			});
		</script>
