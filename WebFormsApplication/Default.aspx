<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFormsApplication.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="/js/twitter-text.js"></script>
    <title></title>

    <style type="text/css">
	.container-tweet{
		width:500px;
		margin:0 auto;
	}
	.container-tweet .tweet {
	  padding:10px;
	  background: #fff;
	  border-radius: 5px;
	  box-shadow: 0 0 4px #555 !important;
      margin-bottom:10px;
	}
	.container-tweet .profile{
		float:left;
		width:70%;
	}
	.container-tweet .photo{
		float:left;
		margin-right:8px;
		border-radius:3px;
	}
	.container-tweet .full-name {
		font-size: 16px;
		color: #292f33;
		font-weight: bold;
		line-height: 16px;
		font-family: "Helvetica Neue",Roboto,"Segoe UI",Calibri,sans-serif;
		float:left;
	}
	.container-tweet .nickname{
		  font-size: 14px;
		  line-height: 18px;
		  color: #707070;
		  font-family: "Helvetica Neue",Roboto,"Segoe UI",Calibri,sans-serif;
		  text-decoration:none;
		  float:left;
		  font-weight:100;
	}
	.container-tweet .clear{
		clear:both;
	}
	.container-tweet .button{
		width:30%;
		float:left;
	}
	.container-tweet .follow-button:link, .container-tweet .follow-button:visited {
	  display: inline-block;
	  padding: 0 5px 0 3px;
	  font: bold 11px/18px 'Helvetica Neue',Arial,sans-serif;
	  color: #333;
	  text-decoration: none;
	  text-shadow: 0 1px 0 rgba(255,255,255,0.5);
	  white-space: nowrap;
	  cursor: pointer;
	  background-color: #eee;
	  background-image: -webkit-linear-gradient(#fff,#dedede);
	  background-image: linear-gradient(#fff,#dedede);
	  border: #ccc solid 1px;
	  border-radius: 3px;
	  float:right;
	  width:65px;
	}
	.container-tweet .ic-button-bird {
	  width: 16px;
	  height: 16px;
	  margin: 0 3px 0 0;
	  display: inline-block;
	  vertical-align: middle;
	  background: transparent url(sprite.png) no-repeat -73px -160px;
	}
	.container-tweet .entry-title {
	  font-size: 18px;
	  line-height: 24px;
	  margin: 10px 5px 0 0;
	  overflow: hidden;
	  clear: both;
	  word-wrap: break-word;
	  white-space: pre-wrap;
	  font-family: "Helvetica Neue",Roboto,"Segoe UI",Calibri,sans-serif;
	}
	.container-tweet .time{
		  color: #707070;
		  font-family: "Helvetica Neue",Roboto,"Segoe UI",Calibri,sans-serif;
		  font-size:12px;
	}
	.container-tweet .footer{
		margin-top: 5px;
		padding-top: 11px;
		border-top: 1px solid #e8e8e8;
		min-height: 16px;
	}
	.stats{
		font-size: 10px;
		display: inline-block;
		text-transform: uppercase;
		font-family: "Helvetica Neue",Roboto,"Segoe UI",Calibri,sans-serif;
		width:50%;
		float: left;
	}
	.stats a{
		color: #707070;
		text-decoration:none;
		margin-right: 3px;
	}
	.tweet-actions {
		position: static;
		float: right;
		margin-bottom: 4px;
		visibility: visible;
		margin:0;
		padding:0;
		list-style-type:none;
	}
	.tweet-actions li{
		float:left;
	}
	.tweet-actions a{
		 background-image: url(sprite.png);
		 background-repeat:no-repeat;
		 width:22px;
		 height:22px;
		 float:left;
	}
	.tweet-actions a.reply-action{
		background-position:-104px -81px;
		zoom:1;
	}
	.tweet-actions a.retweet-action{
		background-position:-108px -99px;
		zoom:1;
	}
	.tweet-actions a.favorite-action{
		background-position:-101px -118px;
		zoom:1;
	}
	.tweet-actions a.reply-action:hover{
		background-position:-81px -81px;
		zoom:1;
	}
	.tweet-actions a.retweet-action:hover{
		background-position:-81px -99px;
		zoom:1;
	}
	.tweet-actions a.favorite-action:hover{
		background-position:-80px -119px;
		zoom:1;
	}

    </style>
    <script type="text/javascript">
        $(function () {

            $.ajax({
                url: "/Default.aspx/GetTwitterFeed",
                data: {},
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                timeout: 10000,
                success: function (result) {
                    if (result.hasOwnProperty("d")) {
                        bindTweets(result.d);
                    }
                    else {
                        bindTweets(result);
                    }

                },
                error: function (xhr, status) {
                    alert(status + " - " + xhr.responseText);
                }
            });

            function bindTweets(result) {
                //alert(result);
                var json = $.parseJSON(result);
                //alert(json.statuses[0].user.geo_enabled);
                try{
                    for (var i = 0; i < json.statuses.length; i++) {
                        //alert(json.statuses[i].geo);
                    $("#results").append('<div class="tweet"><a class="profile" href=""><img class="photo avatar" src="' + json.statuses[i].user.profile_image_url + '"/><span class="full-name">' + json.statuses[i].user.name + '</span><br /><span class="nickname">@' + json.statuses[i].user.screen_name + '</span><div class="clear"></div></a><div class="clear"></div><p class="entry-title">' + twttr.txt.autoLink(json.statuses[i].text) + '</p><p class="time">' + json.statuses[i].created_at.substring(0, 16) + '</p></div>');
                    //try {
                    //    for (var j = 0; j < json.statuses[i].entities.media.length; j++) {
                    //        $("#results").append('<a href="' + json.statuses[i].entities.media[j].media_url + '" ><img src="' + json.statuses[i].entities.media[j].media_url + ':thumb" /></a>');
                    //    }

                    //} catch (e) {
                    //}
                }
            }
            catch(e){}
                
                }
            

        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="sm" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
    <div id="results" class="container-tweet" />
    </form>
</body>
</html>
