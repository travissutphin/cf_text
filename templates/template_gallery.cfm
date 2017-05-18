		<cfoutput>
        <link type="text/css" rel="stylesheet" href="#Request.siteURL#plugins/featherlight-1.5.0/release/featherlight.min.css" />
		<link type="text/css" rel="stylesheet" href="#Request.siteURL#plugins/featherlight-1.5.0/release/featherlight.gallery.min.css" />
        </cfoutput>
        
		<style type="text/css">
			@media all {
				.lightbox { display: none; }
				.fl-page h1,
				.fl-page h3,
				.fl-page h4 {
					font-family: 'HelveticaNeue-UltraLight', 'Helvetica Neue UltraLight', 'Helvetica Neue', Arial, Helvetica, sans-serif;
					font-weight: 100;
					letter-spacing: 1px;
				}
				.fl-page h1 { font-size: 110px; margin-bottom: 0.5em; }
				.fl-page h1 i { font-style: normal; color: #ddd; }
				.fl-page h1 span { font-size: 30px; color: #333;}
				.fl-page h3 { text-align: right; }
				.fl-page h3 { font-size: 15px; }
				.fl-page h4 { font-size: 2em; }
				.fl-page .jumbotron { margin-top: 2em; }
				.fl-page .btn-download { float: right; margin-top: -40px; }
				.fl-page .btn-default { vertical-align: bottom; }

				.fl-page .row { margin-top: 2em;}

				.fl-page .btn-lg span { font-size: 0.7em; }
				.fl-page .footer { margin-top: 3em; color: #aaa; font-size: 0.9em;}
				.fl-page .footer a { color: #999; text-decoration: none; margin-right: 0.75em;}
				.fl-page .github { margin: 2em 0; }
				.fl-page .github a { vertical-align: top; }

				/* customized gallery */

				.featherlight-gallery2 {
					background: rgba(100,100,100,0.5);
				}
				.featherlight-gallery2 .featherlight-content {
					background: #000;
				}
				.featherlight-gallery2 .featherlight-next:hover,
				.featherlight-gallery2 .featherlight-previous:hover {
					background: rgba(0,0,0,0.5);
				}
				.featherlight-gallery2 .featherlight-next:hover span,
				.featherlight-gallery2 .featherlight-previous:hover span {
					font-size: 25px;
					line-height: 25px;
					margin-top: -12.5px;
					color: #fff;
				}
				.featherlight-gallery2  .featherlight-close {
					background: transparent;
					color: #fff;
					font-size: 1.2em;
				}
				.featherlight-gallery2.featherlight-last-slide .featherlight-next,
				.featherlight-gallery2.featherlight-first-slide .featherlight-previous {
					display: none;
				}

				/* text slide */
				.thumbnail a { text-decoration: none; }
				.blurb {
					display: inline-block;
					width: 150px;
					height: 150px;
				}
				.blurb h2 { text-align: center;}
				.blurb .detail { display: none;}
				.blurb .teaser {
					font-style: italic;
					text-align: center;
				}
				.featherlight .blurb {
					display: inline-block;
					width: 500px;
					height: 300px;
					color: #99f;
				}
				.featherlight .blurb .detail {
					color: #ddf;
					font-size: large;
					display: inherit;
				}
				.featherlight .blurb .teaser { display: none;}

			}
			@media(max-width: 768px){
				.fl-page h1 span { display: block; }
				.fl-page .btn-download { float: none; margin-bottom: 1em; }
			}
		</style>



			<div class="row">
				<div class="col-lg-12">
					
				</div>
				
                <cfif IsDefined ('url.id')>
                
					<cfoutput query="records_Gallery">
                    <div class="col-lg-2">
                        <a class="thumbnail gallery" href="#Request.siteURL#assets/images/uploads/#records_Gallery.gal_image#"><img src="#Request.siteURL#assets/images/uploads/#records_Gallery.gal_image#" style="min-height: 150px" /></a>
                    </div>
                    </cfoutput>
                
                <cfelse>

					<cfoutput query="records_Gallery_Categories">
                    <div class="col-lg-2">
                        <a href="#Request.siteURL#Portfolio&id=#records_Gallery_Categories.gallery_category_id#"><img src="#Request.siteURL#assets/images/uploads/#records_Gallery_Categories.gal_cat_image#" style="min-height: 150px" class="thumbnail" /></a>
                    </div>
                    </cfoutput>              

                
                </cfif>
                
			</div>
   



<cfoutput>
		<script src="#Request.siteURL#plugins/featherlight-1.5.0/assets/javascripts/jquery-1.7.0.min.js"></script>
		<script src="#Request.siteURL#plugins/featherlight-1.5.0/release/featherlight.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="#Request.siteURL#plugins/featherlight-1.5.0/release/featherlight.gallery.min.js" type="text/javascript" charset="utf-8"></script>
        
</cfoutput>

		<script>
			$(document).ready(function(){
				$('.gallery').featherlightGallery({
					gallery: {
						fadeIn: 300,
						fadeOut: 300
					},
					openSpeed:    300,
					closeSpeed:   300
				});
				$('.gallery2').featherlightGallery({
					gallery: {
						next: 'next »',
						previous: '« previous'
					},
					variant: 'featherlight-gallery2'
				});
			});
		</script>