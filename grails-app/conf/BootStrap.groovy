import ratingdom.Role
import ratingdom.Sentiment
import ratingdom.User
import ratingdom.UserRole

class BootStrap {

    def init = { servletContext ->
        //Creando el rol
        def roleAdmin = new Role(authority: "ROLE_ADMIN").save(failOnError: true);
        def roleUsuario = new Role(authority: "ROLE_USUARIO").save(failOnError: true);
        def rolePremium = new Role(authority: "ROLE_PREMIUM").save(failOnError: true);

        def admin = new User(fullname:"frangel hernandez",email: "info@host809.com",
                 phone: "8096516999",website: "www.host809.com",
                 company: true,
                username: "admin",password:"admin", twitterUser: "frangelh").save()

        def usuario = new User(fullname:"karina peralta",email: "d3amondesign@gmail.com",
                phone: "8096516999",website: "www.host809.com",
               company: true,
                username: "karina",password:"karina",twitterUser:"karinaperalta91").save()
        def shakira = new User(fullname:"shakira",email: "d3amondesign@gmail.com",
                phone: "8096516999",website: "www.host809.com",
                company: true,
                username: "shakira",password:"shakira",twitterUser:"shakira").save()
        //asignando el usuario.
        UserRole.create(admin, roleAdmin, true);
        UserRole.create(usuario, roleUsuario, true);
        UserRole.create(shakira,roleUsuario,true);
        sentimentToDB();
    }
    def destroy = {}
    def sentimentToDB(){
        BufferedReader negReader = new BufferedReader(new FileReader(new File(
                "/home/deamon3/Desktop/ratingdom/grails-app/utils/negative-words.txt")));
        BufferedReader posReader = new BufferedReader(new FileReader(new File(
                "/home/deamon3/Desktop/ratingdom/grails-app/utils/positive-words.txt")));
        List<String> positivas;
        List<String> negativas
        String word1;
        String word2;
        int conta = 0;
        while (conta <= 10000) {
            word1 = negReader.readLine();
            Sentiment s1 = new Sentiment();
            s1.word = word1;
            s1.sentiment = "negative";
            s1.save();
            conta++;


        }
        conta = 0;
        while (conta <= 10000) {
            word2 = posReader.readLine();
            Sentiment s2 = new Sentiment();
            s2.word = word2;
            s2.sentiment = "positive";
            s2.save();
            conta++;

        }
    }


}
