package ratingdom


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DataTwitterController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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
