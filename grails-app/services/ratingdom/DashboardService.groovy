package ratingdom

import grails.transaction.Transactional
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import twitter4j.Paging
import twitter4j.Query
import twitter4j.QueryResult
import twitter4j.Status
import twitter4j.Twitter
import twitter4j.TwitterFactory
import twitter4j.auth.AccessToken

@Transactional
class DashboardService {
    private static String consumer_key = "UtaoEPEIJ9X69dK24UGKqqahY";
    private static String consumer_secret="IBD6WdIHCYBikOFjpP4xJ0nPFKCsaug8VWlrGMlkJ9DUIwsQ0H";
    private static String access_token="713382811-vAh2Vl7CXEZKt82EWui3kwyw40WjZCtBiRif0Djg";
    private static String access_key="WvkVigmjQ3RNFkIoxu17sltssTZnjTRGcXOMGOl92gDAa";
/* porcentaje = count *100 /200*/


    public static String twitterusername(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String un = auth.getName();
        User user = User.findByUsername(un);
        String screen_name = user.twitterUser;
        return screen_name;
    }
    public static String followercount(String screen_name){

        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);


        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);

        twitter4j.User a_name = twitter.showUser(twitterUsername);
        int followerCount = a_name.getFollowersCount();
        return followerCount
    }
    public static String  mentionscount(String screen_name) {

        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();

        AccessToken accessToken = new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        int followerCount = a_name.getFollowersCount();
        List<Status> retweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 20)); // get the first ten tweets
        int retweetCount = 0;
        for (Status tweet : retweets) {
            retweetCount += (int) tweet.getRetweetCount();
        }
        int mentionCount = 0;



        Query query = new Query("@" + twitterUsername);
        query.setCount(100);
        query.setResultType(Query.RECENT);
        QueryResult result = twitter.search(query);
        mentionCount += result.getTweets().size();
        List<Status> tweets = result.getTweets();
        Query query1 = new Query("@" + twitterUsername);
        query.setCount(20);
        query.setResultType(Query.RECENT);
        QueryResult result1 = twitter.search(query1);
        return mentionCount.toString();
    }
    public static String  tweetcount(String screen_name) {

        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();

        AccessToken accessToken = new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);

        return a_name.getStatusesCount();
    }
    public static String  retweetcount(String screen_name) {

        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();

        AccessToken accessToken = new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        int followerCount = a_name.getFollowersCount();
        List<Status> retweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 20)); // get the first ten tweets
        int retweetCount = 0;
        for (Status tweet : retweets) {
            retweetCount += (int) tweet.getRetweetCount();
        }
        int mentionCount = 0;



        Query query = new Query("@" + twitterUsername);
        query.setCount(100);
        query.setResultType(Query.RECENT);
        QueryResult result = twitter.search(query);
        mentionCount += result.getTweets().size();
        List<Status> tweets = result.getTweets();
        Query query1 = new Query("@" + twitterUsername);
        query.setCount(20);
        query.setResultType(Query.RECENT);
        QueryResult result1 = twitter.search(query1);
        return retweetCount.toString();
    }
    public static List<Status> tweets(String screen_name){
        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        List<Status> tweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 10));

        return tweets;

    }
    public static QueryResult result1(String screen_name){

        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        int followerCount = a_name.getFollowersCount();
        List<Status> retweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 10)); // get the first ten tweets
        int retweetCount = 0;
        for (Status tweet : retweets) {
            retweetCount += (int) tweet.getRetweetCount();
        }



        int mentionCount = 0;

        int retweetScore = 0;
        int followerScore = 0;

        if (retweetCount >= 100000)
            retweetScore = 60;
        else if (retweetCount >= 20000)
            retweetScore = 50;
        else if (retweetCount >= 10000)
            retweetScore = 40;
        else if (retweetCount >= 5000)
            retweetScore = 30;
        else if (retweetCount >= 1000)
            retweetScore = 20;
        else if (retweetCount >= 500)
            retweetScore = 10;
        else if (retweetCount >= 100)
            retweetScore = 5;
        else if (retweetCount >= 10)
            retweetScore = 1;

        if (followerCount >= 10000000)
            followerScore = 40;
        else if (followerCount >= 1000000)
            followerScore = 35;
        else if (followerCount >= 500000)
            followerScore = 30;
        else if (followerCount >= 100000)
            followerScore = 25;
        else if (followerCount >= 1000)
            followerScore = 20;
        else if (followerCount >= 500)
            followerScore = 15;
        else if (followerCount >= 100)
            followerScore = 10;
        else if (followerCount >= 10)
            followerScore = 5;

        Query query = new Query("@" + twitterUsername);
        query.setCount(100);
        query.setResultType(Query.RECENT);
        QueryResult result = twitter.search(query);
        mentionCount += result.getTweets().size();
        int totalscore = retweetScore + followerScore + mentionCount;
        List<Status> tweets = result.getTweets();
        Query query1 = new Query("@" + twitterUsername);
        query.setCount(20);
        query.setResultType(Query.RECENT);
        QueryResult result1 = twitter.search(query1);




        return result1
    }
    public static String totalscore(String screen_name){

        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        int followerCount = a_name.getFollowersCount();
        List<Status> retweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 20)); // get the first ten tweets
        int retweetCount = 0;
        for (Status tweet : retweets) {
            retweetCount += (int) tweet.getRetweetCount();
        }



        int mentionCount = 0;

        int retweetScore = 0;
        int followerScore = 0;

        if (retweetCount >= 100000)
            retweetScore = 60;
        else if (retweetCount >= 20000)
            retweetScore = 50;
        else if (retweetCount >= 10000)
            retweetScore = 40;
        else if (retweetCount >= 5000)
            retweetScore = 30;
        else if (retweetCount >= 1000)
            retweetScore = 20;
        else if (retweetCount >= 500)
            retweetScore = 10;
        else if (retweetCount >= 100)
            retweetScore = 5;
        else if (retweetCount >= 10)
            retweetScore = 1;

        if (followerCount >= 10000000)
            followerScore = 40;
        else if (followerCount >= 1000000)
            followerScore = 35;
        else if (followerCount >= 500000)
            followerScore = 30;
        else if (followerCount >= 100000)
            followerScore = 25;
        else if (followerCount >= 1000)
            followerScore = 20;
        else if (followerCount >= 500)
            followerScore = 15;
        else if (followerCount >= 100)
            followerScore = 10;
        else if (followerCount >= 10)
            followerScore = 5;

        Query query = new Query("@" + twitterUsername);
        query.setCount(100);
        query.setResultType(Query.RECENT);
        QueryResult result = twitter.search(query);
        mentionCount += result.getTweets().size();
        int totalscore = retweetScore + followerScore + mentionCount;
        List<Status> tweets = result.getTweets();
        Query query1 = new Query("@" + twitterUsername);
        query.setCount(20);
        query.setResultType(Query.RECENT);
        QueryResult result1 = twitter.search(query1);




        return totalscore.toString();
    }
    public static String actualizar(String screen_name){
        def datat = new DataTwitter();
        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        int followerCount = a_name.getFollowersCount();
        List<Status> retweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 10)); // get the first ten tweets
        int retweetCount = 0;
        for (Status tweet : retweets) {
            retweetCount += (int) tweet.getRetweetCount();
        }



        int mentionCount = 0;

        int retweetScore = 0;
        int followerScore = 0;

        if (retweetCount >= 100000)
            retweetScore = 60;
        else if (retweetCount >= 20000)
            retweetScore = 50;
        else if (retweetCount >= 10000)
            retweetScore = 40;
        else if (retweetCount >= 5000)
            retweetScore = 30;
        else if (retweetCount >= 1000)
            retweetScore = 20;
        else if (retweetCount >= 500)
            retweetScore = 10;
        else if (retweetCount >= 100)
            retweetScore = 5;
        else if (retweetCount >= 10)
            retweetScore = 1;

        if (followerCount >= 10000000)
            followerScore = 40;
        else if (followerCount >= 1000000)
            followerScore = 35;
        else if (followerCount >= 500000)
            followerScore = 30;
        else if (followerCount >= 100000)
            followerScore = 25;
        else if (followerCount >= 1000)
            followerScore = 20;
        else if (followerCount >= 500)
            followerScore = 15;
        else if (followerCount >= 100)
            followerScore = 10;
        else if (followerCount >= 10)
            followerScore = 5;

        Query query = new Query("@" + twitterUsername);
        query.setCount(100);
        query.setResultType(Query.RECENT);
        QueryResult result = twitter.search(query);
        mentionCount += result.getTweets().size();
        int totalscore = retweetScore + followerScore + mentionCount;
        List<Status> tweets = result.getTweets();
        Query query1 = new Query("@" + twitterUsername);
        query.setCount(20);
        query.setResultType(Query.RECENT);
        QueryResult result1 = twitter.search(query1);


        //hay que revisar que no se repitan
        datat.totalscore = totalscore;
        datat.followerscore = followerScore;
        datat.retweetScore = retweetScore;
        datat.retweets_count = retweetCount;
        datat.followers_count = a_name.followersCount;
        datat.statuses_count = a_name.getStatusesCount();
        datat.friend_count = a_name.getFriendsCount();
        datat.favorite_count = a_name.getFavouritesCount();
        datat.screenname = a_name.screenName;
        datat.language = a_name.getLang();
        datat.updatedOn = new Date();
        datat.save();


    }
    public static String sentimentscore(String screen_name){
        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        List<Status> tweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 20));
        int score = 0;
        for(Status tweet: tweets){
            String text  = tweet.text;
            if(DashboardService.sentiment(text).equals("Positivo"))
                score = score +1;
            else if(DashboardService.sentiment(text).equals("Negativo")){
                score = score-1;
            }

        }
        if(score==1)
            return "Positive";
        else if(score==-1)
        {
            return "Negative";
        }else if(score==0){
            return "Neutral";
        }
    }
    public static String positiveCount(String screen_name){
        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        List<Status> tweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 20));
        int score = 0;
        for(Status tweet: tweets){
            String text  = tweet.text;
            if(DashboardService.sentiment(text).equals("Positivo"))
                score = score+1;


        }
        return score.toString();
    }
    public static String negativeCount(String screen_name){
        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        List<Status> tweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 20));
        int score = 0;
        for(Status tweet: tweets){
            String text  = tweet.text;
            if(DashboardService.sentiment(text).equals("Negativo"))
                score = score+1;


        }
        println(score);

        return score.toString();
    }
    public static String neutralCount(String screen_name){
        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        List<Status> tweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 20));
        int score = 0;
        for(Status tweet: tweets){
            String text  = tweet.text;
            if(DashboardService.sentiment(text).equals("Neutral"))
                score = score+1;


        }
        return score.toString();
    }

    public static String positivepercent(String screen_name){
        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        List<Status> tweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 20));
        int score = 0;
        for(Status tweet: tweets){
            String text  = tweet.text;
            if(DashboardService.sentiment(text).equals("Positivo"))
                score = score+1;


        }
        return ((score*100)/200).toString();
    }
    public static String negativepercent(String screen_name){
        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        List<Status> tweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 20));
        int score = 0;
        for(Status tweet: tweets){
            String text  = tweet.text;
            if(DashboardService.sentiment(text).equals("Negativo"))
                score = score+1;


        }


        return ((score*100)/200).toString();
    }
    public static String neutralpercent(String screen_name){
        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);
        List<Status> tweets = twitter.getUserTimeline(twitterUsername, new Paging(1, 20));
        int score = 0;
        for(Status tweet: tweets){
            String text  = tweet.text;
            if(DashboardService.sentiment(text).equals("Neutral"))
                score = score+1;


        }
        return ((score*100)/200).toString();
    }
    public static String sentiment(String tweet) {
        List<String> posWords = new ArrayList<String>();
        List<String> negWords = new ArrayList<String>();
        posWords = Sentiment.findAllBySentiment("positive").word;
        negWords = Sentiment.findAllBySentiment("negative").word;

        // normalize!
        tweet = tweet.toLowerCase();
        tweet = tweet.trim();
        // remove all non alpha-numeric non whitespace chars
        tweet = tweet.replaceAll("[^a-zA-Z0-9\\s]", "");

        int negCounter = 0;
        int posCounter = 0;

        // so what we got?
        String[] words = tweet.split(" ");

        // check if the current word appears in our reference lists...
        for (int i = 0; i < words.length; i++) {
            if (posWords.contains(words[i])) {
                posCounter++;
            }
            if (negWords.contains(words[i])) {
                negCounter++;
            }
        }

        // positive matches MINUS negative matches
        int result = (posCounter - negCounter);

        // negative?
        if (result < 0) {
            return "Negativo";
            // or positive?
        } else if (result > 0) {
            return "Positivo";
        }

        // neutral to the rescue!
        return "Neutral";
    }
}