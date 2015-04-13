
<%@ page import="org.springframework.security.core.context.SecurityContextHolder; org.springframework.security.core.Authentication; twitter4j.*; java.io.*; ratingdom.DashboardService; ratingdom.DataTwitter;java.util.List" %>
<%

	String screenname = DashboardService.twitterusername();
	/*DashboardService.actualizar(screenname); */%>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>    <html class="lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>    <html class="lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html> <!--<![endif]-->
<head>
	<title>Ratingdom.com - Eres lo que publicas</title>

	<!-- Meta -->
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<!-- Bootstrap -->
	<asset:stylesheet src="bootstrap.min.css"/>
	<asset:stylesheet src="jquery-ui-1.9.2.custom.min.css"/>
	<asset:stylesheet src="glyphicons.css?compile=false"/>
	<asset:javascript src="jquery-1.8.2.min.js"/>
	<asset:stylesheet src="style.css?1382104445"/>
	<asset:stylesheet src="default.css" />

	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

	<script type="text/javascript" src="https://www.google.com/jsapi"></script>
	<script type="text/javascript">
		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawPieChart);
		function drawPieChart() {

			var data1 = google.visualization.arrayToDataTable([
				['Task', 'Hours per Day'],
				['Positivo',     <%= DashboardService.positivepercent(screenname) %>],
				['Negativo',      <%= DashboardService.negativepercent(screenname) %>],
				['Neutro	',    <%= DashboardService.neutralpercent(screenname) %>]
			]);

			var options = {
				title: 'Porcentaje de sentimientos',
				'width':600,
				'height':600
			};

			var chart1 = new google.visualization.PieChart(document.getElementById('piechart'));

			chart1.draw(data1, options);
		}
	</script>

	<script type="text/javascript">
		google.load("visualization", "1", {packages:["corechart"]});
		google.setOnLoadCallback(drawChart);
		function drawChart() {

			var data = google.visualization.arrayToDataTable([
				['Sentiment', 'Positivos', 'Negativos','Neutros'],
				['Sentiment',  <%=DashboardService.positiveCount(screenname)%>,<%=DashboardService.negativeCount(screenname)%> ,<%=DashboardService.neutralCount(screenname)%>]
			]);

			var options = {
				title: 'Puntaje de sentimientos',
				'width':600,
				'height':600
			};

			var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));

			chart.draw(data, options);

		}
	</script>


	<script>
		var mapOptions;
		var geocoder;
		var map;
		function initialize() {
			var address = 'United States';

			geocoder = new google.maps.Geocoder();
			geocoder.geocode(
					{ 'address': address}, function(results, status) {
						if (status == google.maps.GeocoderStatus.OK) {
							console.debug('Debug information: ' + results[0].geometry.location);
							mapOptions = {
								zoom: 3,
								center: results[0].geometry.location ,
								mapTypeId: google.maps.MapTypeId.ROADMAP
							};
							map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);


							<%
			QueryResult result1 = DashboardService.result1(screenname);
			for(Status status : result1.getTweets() ) {
				String text = status.getText().replace("\"", "'").replace("\n", " ").replace("\'", "");
				text = " "+text+" ";
				String location = status.getUser().getLocation();
				String screen_Name = status.getUser().getScreenName();
				String prof_img = status.getUser().getProfileImageURL();

		%>

							var loc1 = "<%= location %>";
							geocoder.geocode({'address':loc1}, function (new_result) {
								// console.debug("Check here: ", new_result)
								var loc = "<%= location %>";
								var txt = '<%= text %>';
								var scrName = '<%= screen_Name %>';
								var profile_img = '<%= prof_img %>';

								var contentString = '<div id="content">'+
										'<div id="siteNotice">'+
										'</div>'+
										'<h3 id="firstHeading" class="firstHeading"><img src='+profile_img+' class="img-rounded">'+ scrName+'</h3>'+
										'<div id="bodyContent">'+
										txt  +
										'</div>'+
										'</div>';

								var infowindow = new google.maps.InfoWindow({
									content: contentString
								});

								var marker = new google.maps.Marker({
									position: new_result[0].geometry.location,
									map: map,
									title: 'Tweet'
								});
								google.maps.event.addListener(marker, 'click', function() {
									infowindow.open(map,marker);
								});
							});
							<%
			}
		%>

						} else {
							alert('Geocode was not successful for the following reason: ' + status);
						}
					});
		}

		google.maps.event.addDomListener(window, 'load', initialize);

	</script>



</head>
<body>

<!-- Start Content -->
<div class="first-container container fluid">

	<div class="navbar main hidden-print">


		<a href="#" class="appbrand"><span>RatingDom</span></a>

		<!-- Menu Toggle Button -->
		<button type="button" class="btn btn-navbar">
			<span class="glyphicons show_lines toggle"></span>
		</button>
		<!-- // Menu Toggle Button END -->

		<%     Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String un = auth.getName();%>
		<ul class="topnav pull-right">
			<li class="account">
				<a data-toggle="dropdown" href="my_account.html?lang=en" class="glyphicons logout unlock"><span class="hidden-sm text"><%=un%></span></a>
				<ul class="dropdown-menu pull-right">
					<li><a href="my-accoutn.html?lang=en" class="glyphicons cogwheel">Configuraciones</a></li>
					<li class="highlight profile">
						<span>
							<span class="heading">Twitter</span>

							<span class="details">

								<strong>@<%=DashboardService.twitterusername() %></strong>
							</span>
							<span class="clearfix"></span>
						</span>
					</li>
					<li>
						<span>
							<g:link controller='logout' action=''>Logout </g:link>						</span>
					</li>
				</ul>
			</li>
		</ul>
	</div>
	<div id="wrapper">
		<div id="menu" class="hidden-sm hidden-print">
			<div id="menuInner">

				<!-- Scrollable menu wrapper with Maximum height -->
				<div class="slim-scroll" data-scroll-height="420px">


					<ul>

						<li class="heading"><span>Social Networks</span></li>
						<li class="glyphicons social twitter"><a href="index.html?lang=en"><span>Twitter</span></a></li>
						<li class="glyphicons social youtube"><a href="landing_page.html?lang=en"><span>Youtube</span></a></li>
						<li class="glyphicons social google_plus"><a href="pricing_tables.html?lang=en"><span>Google+</span></a></li>
						<li class="glyphicons social facebook"><a href="faq.html?lang=en"><span>Facebook</span></a></li>
						<li class="glyphicons social linked_in"><a href="invoice.html?lang=en"><span>LinkedIn</span></a></li>
					</ul>
					<ul>
						<li class="heading"><span>Options</span></li>
						<li class="hasSubmenu">
							<a data-toggle="collapse" class="glyphicons group" href="#menu_account"><span>My Account</span></a>
							<ul class="menuCollapse" id="menu_account">
								<li class=""><a href="my_account.html?lang=en"><span>Edit account</span></a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<!-- // Nice Scroll Wrapper END -->
		</div>

		<div id="content" 	>
			<ul class="breadcrumb">
				<li><a href="index.html?lang=en" class="glyphicons home">Home</a></li>
				<li class="divider"></li>
				<li>Twitter Analysis</li>
			</ul>
			<div class="separator bottom"></div>

			<div class="heading-buttons">
				<h3 class="glyphicons social twitter">Twitter</h3>
				<div class="clearfix" style="clear: both;"></div>
			</div>
			<div class="separator bottom"></div>

			<div class="menubar">
			</div>
			<ul class="nav nav-tabs">
				<li class="active"><a href="#home" data-toggle="tab" aria-expanded="true">Inicio</a></li>
				<li class=""><a href="#profile" data-toggle="tab" aria-expanded="false">Sentiment</a></li>

			</ul>
			<div id="myTabContent" class="tab-content">
				<div class="tab-pane fade active in" id="home">
					<div class="innerLR">
						<div class="row">

							<div class="col-md-12">
								<div class="row">


									<div class="col-md-2">
										<a href="" class="widget-stats">
											<span class="glyphicons star"></span>
											<span class="txt"><strong>${ratingdom.DashboardService.totalscore(screenname)}</strong>Total Score</span>
											<div class="clearfix"></div>
										</a>
									</div>
									<div class="col-md-3">
										<a href="" class="widget-stats">
											<span class="glyphicons user_add"></span>
											<span class="txt"><strong>${ratingdom.DashboardService.followercount(screenname)}</strong>Followers</span>
											<div class="clearfix"></div>
										</a>
									</div>
									<div class="col-md-2">
										<a href="" class="widget-stats">
											<span class="glyphicons tag"></span>
											<span class="txt"><strong>${ratingdom.DashboardService.tweetcount(screenname)}</strong>Tweets</span>
											<div class="clearfix"></div>
										</a>
									</div>
									<div class="col-md-3">
										<a href="" class="widget-stats">
											<span class="glyphicons retweet_2"></span>
											<span class="txt"><strong>${ratingdom.DashboardService.retweetcount(screenname)}</strong>Retweets</span>
											<div class="clearfix"></div>
										</a>
									</div>
									<div class="col-md-2">
										<a href="" class="widget-stats">
											<span class="glyphicons tag"></span>
											<span class="txt"><strong>${ratingdom.DashboardService.mentionscount(screenname)}</strong>Mentions</span>
											<div class="clearfix"></div>
										</a>
									</div>

								</div>
							</div>
						</div>
					</div>
					<div class="separator bottom"></div>

					<div class="widget widget-2 widget-tabs widget-tabs-2">
						<div class="widget-body">

						</div>
					</div>

					<div class="innerLR">

					</div>

					<div class="separator bottom"></div>

					<div class="innerLR">
						<div class="row-fluid">
							<div>
								<h3>Recent Mentions: </h3>
								<div id="map-canvas"></div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<h4 class="glyphicons clock"> Ultimos tweets</h4>

								<div class="row">
									<div class="">

										<table class="table table-striped table-hover ">
											<thead>
											<tr>

												<th>Tweets</th>
											</tr>
											</thead>

											<%
												//List<Status> tw = DashboardService.tweets(screenname)

												for(Status tweet:DashboardService.tweets(screenname))
												{
											%>
											<tr class="info"><td><span><%=tweet.text %></span></td></tr>
											<%
												}%>

										</tbody>
										</table>

									</div>

								</div>
							</div>
						</div>
						<div class="separator bottom"></div>


					</div>
					<!-- FIN DEL PRIMER TAB-->
				</div>
				<div class="tab-pane fade" id="profile">
					<div class="innerLR">
						<div class="row">

							<div class="col-md-12">
								<div class="row">


									<div class="col-md-3">
										<a href="" class="widget-stats">
											<span class="glyphicons star"></span>
											<span class="txt"><strong><%= ratingdom.DashboardService.sentimentscore(screenname)%></strong>Sentiment Score</span>
											<div class="clearfix"></div>
										</a>
									</div>
									<div class="col-md-3">
										<a href="" class="widget-stats">
											<span class="glyphicons star"></span>
											<span class="txt"><strong><%= ratingdom.DashboardService.positiveCount(screenname)%></strong>Positivos</span>
											<div class="clearfix"></div>
										</a>
									</div>
									<div class="col-md-3">
										<a href="" class="widget-stats">
											<span class="glyphicons star"></span>
											<span class="txt"><strong><%= ratingdom.DashboardService.negativeCount(screenname)%></strong>Negativos</span>
											<div class="clearfix"></div>
										</a>
									</div>
									<div class="col-md-3">
										<a href="" class="widget-stats">
											<span class="glyphicons star"></span>
											<span class="txt"><strong><%= ratingdom.DashboardService.neutralCount(screenname)%></strong>Neutrales</span>
											<div class="clearfix"></div>
										</a>
									</div>

								</div>
							</div>
						</div>
					</div>
					<div class="separator bottom"></div>

					<div class="widget widget-2 widget-tabs widget-tabs-2">
						<div class="widget-body">

						</div>
					</div>

					<div class="innerLR">

					</div>

					<div class="separator bottom"></div>
					<div class="innerLR">
						<div class="row">
							<div class="col-md-12">
								<h4 class="glyphicons clock"> Graficas</h4>

								<div class="row">
									<div class="">
										<div class="col-md-12">
										<div class="col-md-6" >
										<div id="chart_div" ></div>
											</div>
											<div class="col-md-6" >
										<div id="piechart"></div>
										</div>
											</div>
										<table class="table table-striped table-hover ">
											<thead>
											<tr>

												<th>Tweets</th>
												<th>Sentiment</th>
											</tr>
											</thead>

											<%
												//List<Status> tw = DashboardService.tweets(screenname)

												for(Status tweet:DashboardService.tweets(screenname))
												{
											%>
											<tr class="info">
											<td><span><%=tweet.text %></span></td>
											<td><span><%=DashboardService.sentiment(tweet.text) %></span></td></tr>
											<%
												}%>

										</tbody>
										</table>

									</div>

								</div>
							</div>
						</div>
						<div class="separator bottom"></div>


					</div>				</div>

			</div>


			<!-- End Wrapper -->
		</div>
	</div>

	<div id="themer" class="collapse">
		<div class="wrapper">
			<span class="close2">&times; close</span>
			<h4>Themer <span>color options</span></h4>
			<ul>
				<li>Theme: <select id="themer-theme" class="pull-right"></select><div class="clearfix"></div></li>
				<li>Primary Color: <input type="text" data-type="minicolors" data-default="#ffffff" data-slider="hue" data-textfield="false" data-position="left" id="themer-primary-cp" /><div class="clearfix"></div></li>
				<li>
					<span class="link" id="themer-custom-reset">reset theme</span>
					<span class="pull-right"><label>advanced <input type="checkbox" value="1" id="themer-advanced-toggle" /></label></span>
				</li>
			</ul>
			<div id="themer-getcode" class="hide">
				<hr class="separator" />
				<button class="btn btn-primary btn-small pull-right btn-icon glyphicons download" id="themer-getcode-less"><i></i>Get LESS</button>
				<button class="btn btn-inverse btn-small pull-right btn-icon glyphicons download" id="themer-getcode-css"><i></i>Get CSS</button>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>


	<!-- Global -->
	<script>
		var basePath = '',
				commonPath = '',


		// charts data
				charts_data = {

					// 24 hours
					graph24hours: {
						from: 1381874400000,
						to: 1381960800000			},

					// 7 days
					graph7days: {
						from: 1381356000000,
						to: 1381960800000			},

					// 14 days
					graph14days: {
						from: 1380751200000,
						to: 1381960800000			},

					// main dashboard graph - website traffic
					website_traffic: {
						d1: [[1379455200000, 2173],[1379541600000, 2964],[1379628000000, 3048],[1379714400000, 2609],[1379800800000, 3731],[1379887200000, 2772],[1379973600000, 2677],[1380060000000, 2154],[1380146400000, 2749],[1380232800000, 2889],[1380319200000, 3293],[1380405600000, 3906],[1380492000000, 2573],[1380578400000, 3068],[1380664800000, 2709],[1380751200000, 3707],[1380837600000, 3018],[1380924000000, 3440],[1381010400000, 2842],[1381096800000, 2873],[1381183200000, 3623],[1381269600000, 2650],[1381356000000, 3825],[1381442400000, 2850],[1381528800000, 3707],[1381615200000, 2569],[1381701600000, 3999],[1381788000000, 3680],[1381874400000, 2852],[1381960800000, 2335]],
						d2: [[1379455200000, 643],[1379541600000, 690],[1379628000000, 630],[1379714400000, 412],[1379800800000, 654],[1379887200000, 471],[1379973600000, 569],[1380060000000, 628],[1380146400000, 477],[1380232800000, 639],[1380319200000, 621],[1380405600000, 486],[1380492000000, 498],[1380578400000, 412],[1380664800000, 422],[1380751200000, 414],[1380837600000, 615],[1380924000000, 614],[1381010400000, 424],[1381096800000, 402],[1381183200000, 464],[1381269600000, 698],[1381356000000, 595],[1381442400000, 526],[1381528800000, 402],[1381615200000, 427],[1381701600000, 508],[1381788000000, 565],[1381874400000, 620],[1381960800000, 486]]
					}

				};
	</script>


	<asset:javascript src="jquery-ui-1.9.2.custom.min.js"/>
	<asset:javascript src="bootstrap.min.js"/>
</body>


</html>
