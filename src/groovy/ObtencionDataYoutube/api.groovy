package ObtencionDataYoutube

import groovy.sql.Sql

Properties props = new Properties()
props.setProperty('user','postgres')
props.setProperty('password','1234')
def db = Sql.newInstance('jdbc:postgresql://localhost:5432/youtube', props , 'org.postgresql.Driver')
//response.setHeader('Access-Control-Allow-Origin', "*")
def l = db.rows("SELECT h.id, video_id, h.title, watchdate, duration, uploader, uploadeddate, description, category_id, views, c.title as category, u.title as uploader_name FROM historyv3 h LEFT JOIN categories c ON c.id = h.category_id LEFT JOIN uploaders u ON u.id = h.uploader")
println new groovy.json.JsonBuilder(l)