package ratingdom

import grails.converters.JSON
import twitter4j.Paging
import twitter4j.Query
import twitter4j.QueryResult
import twitter4j.Status
import twitter4j.Twitter
import twitter4j.TwitterFactory
import twitter4j.auth.AccessToken

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class APIController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    private Map<String, String> env;
    private String consumer_key = "OHA0TxbHBg6kcpp3tcOkdiLti";
    private String consumer_secret="bRB0x9xhefFGKtKxiIJtzQyYRztahhvNjnIlBrFfIW073aNtgt";
    private String access_token="2841168340-zASHIjFBW5qp3ldgpwVRUW77zCJnD3WYYGSKUsM";
    private String access_key="lxteahjvSnxgAvAsr8IUfhlp6opHFbMbuV7uEMTw2OFco";

    Twitter twitter = new TwitterFactory().getInstance();



    def data(String screen_name){

        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();
        env = System.getenv();
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

        List<String> data = new ArrayList<>();
        data.add("Total Score: "+totalscore);
        data.add("ScreenName: "+twitterUsername);
        data.add("Followers: "+followerCount);
        data.add("Follower score: "+followerScore);
        data.add("Retweet: "+retweetCount);
        data.add("RetweetScore: "+retweetScore);
        data.add("Mentions: "+mentionCount);

        render data as JSON;
    }
    def tweets(String screen_name){

        String twitterUsername = screen_name;
        Twitter twitter = new TwitterFactory().getInstance();

        AccessToken accessToken= new AccessToken(access_token, access_key);
        twitter.setOAuthConsumer(consumer_key, consumer_secret);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User a_name = twitter.showUser(twitterUsername);


        Query query = new Query("@" + twitterUsername);
        query.setCount(100);
        query.setResultType(Query.RECENT);
        QueryResult result = twitter.search(query);

        List<Status> tweets = result.getTweets();
        List<String> data = new ArrayList<>();
        //para cada tweet generar un json
        String[] flag;
        for(Status tweet:tweets){
            flag=[{tweet.geoLocation.toString()}, {tweet.favoriteCount.toString()}, {tweet.text}];
            data.add(flag.toString());
        }



        render data as JSON;
    }
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DataTwitter.list(params), model: [dataTwitterInstanceCount: DataTwitter.count()]
    }

    def show(DataTwitter dataTwitterInstance) {
        respond dataTwitterInstance
    }

    def create() {
        respond new DataTwitter(params)
    }

    @Transactional
    def save(DataTwitter dataTwitterInstance) {
        if (dataTwitterInstance == null) {
            notFound()
            return
        }

        if (dataTwitterInstance.hasErrors()) {
            respond dataTwitterInstance.errors, view: 'create'
            return
        }

        dataTwitterInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'dataTwitter.label', default: 'DataTwitter'), dataTwitterInstance.id])
                redirect dataTwitterInstance
            }
            '*' { respond dataTwitterInstance, [status: CREATED] }
        }
    }

    def edit(DataTwitter dataTwitterInstance) {
        respond dataTwitterInstance
    }

    @Transactional
    def update(DataTwitter dataTwitterInstance) {
        if (dataTwitterInstance == null) {
            notFound()
            return
        }

        if (dataTwitterInstance.hasErrors()) {
            respond dataTwitterInstance.errors, view: 'edit'
            return
        }

        dataTwitterInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DataTwitter.label', default: 'DataTwitter'), dataTwitterInstance.id])
                redirect dataTwitterInstance
            }
            '*' { respond dataTwitterInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(DataTwitter dataTwitterInstance) {

        if (dataTwitterInstance == null) {
            notFound()
            return
        }

        dataTwitterInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DataTwitter.label', default: 'DataTwitter'), dataTwitterInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'dataTwitter.label', default: 'DataTwitter'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
