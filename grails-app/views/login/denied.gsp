
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

		<div class="hero-unit well">
			<h1><i class="glyphicon-warning-sign"></i> <span>Usted esta tratando de entrar a un area restringida</span></h1>
			<hr class="separator" />
			<!-- Row -->
			<div class="row row-merge">

				<!-- Column -->
				<div class="col-md-5">
					<div class="center">
						<p>Parece que la página que está buscando no está aquí. La página podría haber movido a otra dirección o simplemente eliminado por nuestro personal.</p>
					</div>
				</div>
				<!-- // Column END -->



			</div>
			<!-- // Row END -->

		</div>
	</div>
	</div>

	<asset:javascript src="jquery-ui-1.9.2.custom.min.js"/>
	<asset:javascript src="bootstrap.min.js"/>
</body>


</html>
