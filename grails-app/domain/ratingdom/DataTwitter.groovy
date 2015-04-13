package ratingdom



/**
 * Created by frangel on 16/11/14.
 */
class DataTwitter {
    Integer id
    //scores
    Integer totalscore
    Integer followerscore
    Integer retweetScore
    //countable
    Integer retweets_count
    Integer followers_count
    Integer statuses_count
    Integer friend_count
    Integer favorite_count
    String  screenname
    String  language
    Date updatedOn //fecha en la que fue actualizado por ultima vez

    static hasOne = [usuario:User]
    static belongsTo =[tweet:Tweet]
    static hasmany=[tweets:Tweet]
}
