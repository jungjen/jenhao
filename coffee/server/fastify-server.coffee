Path = require 'path'
Static=require 'serve-static'
Session=require 'fastify-session'
Cookie=require 'fastify-cookie'
__=console.log
class PortalContext
    constructor:(@db,@mongo,@request)->
        @user=@request.session.user

createSQLDatabasePool=(option,pools={})->
    for key,config of option
        try
            DB=require "./#{config.type}"
            pools[key]=new DB config
        catch error
            __ error
    pools

createMongoDBPool=(option,pools={})->
    MongoDB=require './mongodb'
    for key,config of option
        try 
            pools[key]=new MongoDB config
        catch error
            __ error
    pools

module.exports= (workspace,options)->
    fastify=require('fastify')
        logger:no
        ignoreTrailingSlash:yes

    fastify.register Cookie
    #  a secret with minimum length of 32 characters
    fastify.register Session,secret: '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    # static file directory map ex:{css:'/css',img:'/img',js:'/js', ...}
    fastify.use router,Static Path.join workspace,folder for folder,router of options.folders
    # createDatabasePools
    try fastify.decorate 'db', createSQLDatabasePool options.database
    catch error 
        __ error
    # createMongoDBPools
    try fastify.decorate 'mongo',createMongoDBPool options.mongo_db
    catch error 
        __ error
    fastify.decorate 'nodes',options?.nodes
    fastify.decorate 'page',new options.page if options.page
    fastify.decorate 'createPortlet',(paras,request)->
        paths=paras.split '-'
        result =require "../nodes/#{paths[0]}/#{paths[1]}-#{paths[2]}-#{paths[3]}"
        node=fastify.nodes[paths[0]]
        context=new PortalContext fastify.db[node?.db],fastify.mongo[node?.mongo],request
        new result context
            
    # fastify.decorate 'routeNode',(route,node)->
    ### Handler Session User
    fastify.addHook 'preHandler', (request, reply, next) => 
        __ 'preHandler User'
        if request.session.user then next() 
        else 
            #reply.redirect '/login'
            reply.send login:no
    fastify.addHook 'preHandler', (request, reply, next) => 
        __ 'preHandler'
        next()
    ###
    fastify.decorate 'start', (port, callback)=>
        try
            await fastify.listen port
            callback.apply fastify
        catch error
            __ error
    # set router for json request
    fastify.all '/json/:component',(request,reply)->
        Promise.resolve request.params.component
            .then (nodes)->
                portlet=fastify.createPortlet nodes,request
                result=portlet.getJSON()
                if result instanceof Promise
                    result.then (data)->
                        reply.send data
                    .catch (err)->
                        throw err
                else reply.send result
            .catch (error)->
                reply.send error:error

    # set router for portlet request
    fastify.all '/portal/:component',(request,reply)->
        reply.type 'text/html'
        Promise.resolve request.params.component
            .then (nodes)->
                portlet=fastify.createPortlet nodes,request
                result=portlet.getPortal()
                if result instanceof Promise
                    result.then (data)->
                        reply.send "<pre>#{JSON.stringify data.recordset}</pre>"
                    .catch (err)->
                        throw err
                else reply.send result
            .catch (error)->
                reply.send """<div class="ui error visible icon message">
                    <div class="content">
                        <div class="header"><i class="big red dont icon"></i> 這個模組出錯了！</div>
                        <pre>#{error.stack}</pre>
                    </div>
                </div>"""    
    fastify
            
