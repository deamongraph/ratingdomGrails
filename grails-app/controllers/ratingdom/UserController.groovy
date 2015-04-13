package ratingdom

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond User.list(params), model:[userInstanceCount: User.count()]
    }

    def list={
        render User.list() as JSON;
    }
    def data = {
        String _username = params.username
        render User.findByUsername(_username) as JSON;
    }
    //crea un usuario apartir de una entrada y devuelve un JSON
    def add = {
        def resultAsJson =[result:"success",message:"User Created Successful."]
        String _fullname = params.fullname
        String _email = params.email
        String _country = params.country
        String _birthday = params.birthday
        String _phone = params.phone
        String _website = params.website
        String _address = params.address
        Boolean _company = params.company

        //user related information
        String _username = params.username
        String _password = params.password

        //aqui toda la logica de crear un usuario
        if(_username!=null && _email!=null) {
            //  if(User.findByUsername(_username)) {
            // Si no existe un usuario registrado entonces registrar

            def user = new User(fullname: _fullname, email: _email,
                    country: _country, birthday: _birthday,
                    phone: _phone, website: _website,
                    address: _address, company: _company,
                    username: _username, password: _password).save(failOnError: true)
        }else{
            resultAsJson.result = "fail"
            resultAsJson.message ="This username is already in use."
        }


        render resultAsJson as JSON;
    }
    //actualiza la informacion posible de los usuarios
    def update = {
        def resultAsJson =[result:"success",message:"User Updated Successful."]
        String _fullname = params.fullname
        String _email = params.email
        String _country = params.country
        String _birthday = params.birthday
        String _phone = params.phone
        String _website = params.website
        String _address = params.address
        Boolean _company = params.company
        //user related information
        String _username = params.username
        String _password = params.password

        //aqui toda la logica de crear un usuario
        if(_username !=null &&_phone!=null && _email!=null) {
            // Si no existe un usuario registrado entonces registrar
            def user = User.findByUsername(_username)
            user.fullname = _fullname
            user.email = _email
            user.country = _country
            user.birthday=_birthday
            user.phone = _phone
            user.website = _website
            user.address = _address
            user.company = _company
            user.password = _password
            user.save()
        }
        render resultAsJson as JSON;
    }

    def show(User userInstance) {
        respond userInstance
    }

    def create() {
        respond new User(params)
    }

    @Transactional
    def save(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'create'
            return
        }

        userInstance.save flush:true
        UserRole.create(userInstance, Role.findByAuthority("ROLE_USUARIO"), true);
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                redirect (controller: "dashboard", action:"index")
            }
            '*' { respond userInstance, [status: CREATED] }
        }
    }

    def edit(User userInstance) {
        respond userInstance
    }

    @Transactional
    def update(User userInstance) {
        if (userInstance == null) {
            notFound()
            return
        }

        if (userInstance.hasErrors()) {
            respond userInstance.errors, view:'edit'
            return
        }

        userInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect userInstance
            }
            '*'{ respond userInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(User userInstance) {

        if (userInstance == null) {
            notFound()
            return
        }

        userInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'User.label', default: 'User'), userInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
