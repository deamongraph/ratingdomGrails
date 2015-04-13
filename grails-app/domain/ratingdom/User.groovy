package ratingdom

class User {

    transient springSecurityService
    //personal information
    String fullname
    String email
    String phone
    String website
    Boolean company
    String username
    String password
    String twitterUser
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    //un usuario tiene varios Datatweets atravez del tiempo
    static belongsTo = [DataTwitter]
    static hasMany = [dataTwitters: DataTwitter]

    static transients = ['springSecurityService']

    static constraints = {
        username blank: false, unique: true
        password blank: false
        fullname blank:false
        email blank: false
        phone blank: false
        twitterUser blank: false;
        website nullable: true
        company nullable: true
        dataTwitters nullable: true
    }

    static mapping = {
        password column: '`password`'
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this).collect { it.role }
    }

    def beforeInsert() {
               encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }
}
