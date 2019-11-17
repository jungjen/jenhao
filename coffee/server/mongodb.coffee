{ MongoClient,ObjectId} = require 'mongodb'
__=console.log

class MongoCollection
    constructor:(@_collection)->@[k]=v for k,v of @_collection
    promise:->Promise.resolve @_collection
    findId:(id,callback)->@_collection.findOne _id:ObjectId(id),callback
    findMany:(where={},sort={},callback)->@promise().then (collection)->
        new Promise (resolve,reject)->
            collection.find(where).sort(sort).toArray (err,items)->
                if err then reject err else resolve items
    
class MongoSub
    constructor:(db,collections)->
        @[k]=new MongoCollection db.collection(k) for k in collections.split ' '

class MongoDB
    constructor:(config={},callback)->@connect config,callback
    connect:(config,callback)->
        user=config.user || ''
        password=config.password || ''
        server=config.server || 'localhost'
        port=config.port || 27017
        dbname=config.database || 'test'
        options=
            useNewUrlParser:on
        await MongoClient.connect "mongodb://#{server}:#{port}",options,(err,client)=>
            @_db=client.db dbname
            @_client=client 
            @findCollections (collections)=>
                for k in collections
                    @[k.name]=new MongoCollection @collection(k.name) if k.type is 'collection'
                callback @ if typeof callback is 'function'    

    disconnect:->@_client.close()
    collection:(name)->@_db.collection name
    subDB:(collections)->new MongoSub @,collections
    promise:->Promise.resolve @

    findCollections:(where,callback)->
        [callback,where]=[where,{}] if typeof where is 'function'
        if typeof callback is 'function'
            @_db.listCollections(where).toArray (err,items)->
                if err then throws err else callback items
        else @promise().then (mongo)->new Promise (resolve,reject)->
            mongo._db.listCollections(where).toArray (err,items)->
                if err then reject err else resolve items
            
module.exports=MongoDB
###
new MongoDB database:'jenhao',(db)-> 
    Promise.all [
        db.users.findOne()
        db.users.findMany(name:'Hao 1')
        db.users.findId '5c38c4faefb0c705d00b25ce'
    ]
    .then (data)->
        __ data[0]
        __ '-------------------'
        __ data[1]
        __ '-------------------'
        __ data[2]
    ##.then ->
    ##    mongo.findCollections (items)->
    ##        __ items[0]
    .then ->
        db.disconnect()
    
###