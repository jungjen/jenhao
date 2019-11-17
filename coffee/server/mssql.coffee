__=console.log
SQLDatabase=require './database'

mssql = require 'mssql'

class MSSqlDB extends SQLDatabase
    constructor:(option)->
        super option

    init:(option)->
        ConnectionPool=new mssql.ConnectionPool option
        @pool=ConnectionPool.connect()
            .then (pool)=>pool
            .catch (err)=>
                __ err
    
    query:(sql,where,cb)->
        [cb,where]=[where,[]] if typeof where is 'function'
        where=[where] if typeof where is 'string'
        @pool.then (con)=>
            [k,request]=[1,new mssql.Request con]
            if Array.isArray where then request.input '$'+k++,para for para in where
            else request.input name,para for name,para of where
            request.query sql,cb
            
    select:(view,fields,where,cb)->
        option=@SELECT view,fields,where,'@$'
        @pool.then (con)=>
            [k,request]=[1,new mssql.Request con]
            request.input '$'+k++,para for para in option[1]
            request.query option[0],cb
    
    request:->

db=new MSSqlDB
    user:'ranger'
    password:'0okmnji9'
    server:'anfa2.anfa.com.tw'
    ## domain:'anfa.com.tw'
    port:8899
    database:'anfa_MSCRM'
    pool:
        max: 10
        min: 0
        idleTimeoutMillis: 30000

module.exports=MSSqlDB

###
db.query 'select name from AccountBase where name like @$1',['台%'],(err,data)->
    __ err if err
    __ data.recordset

db.query 'select name from AccountBase where name in (@name)',name:"'台灣晶技','台灣氰胺(股)'",(err,data)->
    __ err if err
    __ data

__ "000000000"

db.select 'jenhao',['id','name'],id:1,(err,data)->
    __ err if err
    __ data.recordset

db.select 'jenhao',['id','name'],name:'hao',(err,data)->
    __ err if err
    __ data.recordset

###
