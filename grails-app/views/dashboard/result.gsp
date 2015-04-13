<%@page import="twitter4j.Status; java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <link href="../default.css" rel="stylesheet">
    <!-- <link href="/static/todc-bootstrap.css" rel="stylesheet"> -->

    <link href="../bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="../bootstrap-responsive.css" rel="stylesheet">
    <link href="../bootstrap.css" rel="stylesheet">

    <style type="text/css">
    body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
    }

    /* Custom container */
    .container-narrow {
        margin: 0 auto;
        max-width: 900px;
        border-style: solid;
        border-color: transparent;
        background-color: #D8D8D8	;
        z-index: 9;
        height : 100%;
        -moz-border-radius: 15px;
        border-radius: 15px;
    }

    .container-narrow > hr {
        margin: 30px 0;
    }

    .sidebar-nav {
        padding: 20px 0;
    }

    @media (max-width: 980px) {
        /* Enable use of floated navbar text */
        .navbar-text.pull-right {
            float: none;
            padding-left: 5px;
            padding-right: 5px;
        }
    }
    </style>
    <!--
    Include the maps javascript with sensor=true because this code is using a
    sensor (a GPS locator) to determine the user's location.
    See: https://developers.google.com/apis/maps/documentation/javascript/basics#SpecifyingSensor
    -->
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
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

                            <%@ page import="twitter4j.*, java.io.*, java.util.List"  %>
                            <%
			twitter4j.QueryResult result1 = (twitter4j.QueryResult) request.getAttribute("result1");
			for(twitter4j.Status status : result1.getTweets() ) {
				String text = status.getText().replace("\"", "'").replace("\n", " ").replace("\'", "");
				text = " "+text+" ";
				String location = status.getUser().getLocation();
				String screenName = status.getUser().getScreenName();
				String prof_img = status.getUser().getProfileImageURL();
			
		%>

                            var loc1 = "<%= location %>";
                            geocoder.geocode({'address':loc1}, function (new_result) {
                                // console.debug("Check here: ", new_result)
                                var loc = "<%= location %>";
                                var txt = '<%= text %>';
                                var scrName = '<%= screenName %>';
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
<!-- <img src="http://www.logomaker.com/logo-images/555b7084659959ad.gif"/>
  <a href="http://www.logomaker.com"><img src="http://www.logomaker.com/images/logos.gif" alt="logo design" border="0"/></a> -->


<script src="../bootstrap.min.js"></script>
<script src="../bootstrap.js"></script>
<script src="../bootstrap-tooltip.js"></script>

<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">

            <a class="brand pull-left" href="../"><em>Ratingdom.com</em><small> Porque eres lo que publicas.</small></a>

            <div class="nav-collapse collapse">
                <a href="../" type="button" class="btn btn-primary">« Search again...</a>
            </div>  <!--  /.nav-collapse  -->
        </div>
    </div>
</div>  <!-- end of div for nav bar-->


  <!-- ends the div container-fluid -->

</body>
</html>