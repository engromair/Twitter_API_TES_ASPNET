using System.Configuration;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using OAuthTwitterWrapper.JsonTypes;
using System.Xml.Linq;

namespace OAuthTwitterWrapper
{
	public class OAuthTwitterWrapper : IOAuthTwitterWrapper
    {
		public IAuthenticateSettings AuthenticateSettings { get; set; }
		public ISearchSettings SearchSettings { get; set; }

		/// <summary>
		/// The default constructor takes all the settings from the appsettings file
		/// </summary>
		public OAuthTwitterWrapper()
		{
			string oAuthConsumerKey = ConfigurationManager.AppSettings["oAuthConsumerKey"];
            string oAuthConsumerSecret = ConfigurationManager.AppSettings["oAuthConsumerSecret"];
            string oAuthUrl = ConfigurationManager.AppSettings["oAuthUrl"];
			AuthenticateSettings = new AuthenticateSettings { OAuthConsumerKey = oAuthConsumerKey, OAuthConsumerSecret = oAuthConsumerSecret, OAuthUrl = oAuthUrl };
			string screenname = ConfigurationManager.AppSettings["screenname"];
			string include_rts = ConfigurationManager.AppSettings["include_rts"];
			string exclude_replies = ConfigurationManager.AppSettings["exclude_replies"];
			int count = Convert.ToInt16(ConfigurationManager.AppSettings["count"]);
			string timelineFormat = ConfigurationManager.AppSettings["timelineFormat"];			
			
			string searchFormat = ConfigurationManager.AppSettings["searchFormat"];
			string searchQuery = ConfigurationManager.AppSettings["searchQuery"];
			SearchSettings = new SearchSettings
			{
				SearchFormat = searchFormat,
				SearchQuery = searchQuery
			};
				
		}

		/// <summary>
		/// This allows the authentications settings to be passed in
		/// </summary>
		/// <param name="authenticateSettings"></param>
		public OAuthTwitterWrapper(IAuthenticateSettings authenticateSettings)
		{
			AuthenticateSettings = authenticateSettings;
		}

		/// <summary>
		/// This allows the authentications and search settings to be passed in
		/// </summary>
		/// <param name="authenticateSettings"></param>
		/// <param name="timeLineSettings"></param>
		/// <param name="searchSettings"></param>
		public OAuthTwitterWrapper(IAuthenticateSettings authenticateSettings, ISearchSettings searchSettings)
		{
			AuthenticateSettings = authenticateSettings;
			SearchSettings = searchSettings;
		}


		public string GetSearch()
		{
			var searchJson = string.Empty;
			IAuthenticate authenticate = new Authenticate();
			AuthResponse twitAuthResponse = authenticate.AuthenticateMe(AuthenticateSettings);

			// Do the timeline
			var utility = new Utility();
			searchJson = utility.RequstJson(SearchSettings.SearchUrl, twitAuthResponse.TokenType, twitAuthResponse.AccessToken);

            var json_serializer = new JavaScriptSerializer();

            List<JsonTypes.Search> tweets = (List<JsonTypes.Search>)json_serializer.Deserialize(searchJson.ToString(), typeof(List<JsonTypes.Search>));

			return searchJson;
		}
        }
}
