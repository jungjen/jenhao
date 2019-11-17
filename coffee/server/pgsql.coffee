__=console.log

SQLDatabase=require './database'
        
class PgDB extends SQLDatabase
    constructor:(option)->
        super()
        @pgdb=require('pg-promise')() option
        Object.assign @,@pgdb

    select:(view,fields,where)=>
        option=@S view,fields,where
        __ option
        @any option[0],option[1]
    
    selectAll:(view,where={})=>
        @select view,['*'],where

    update:(table,obj,where)=>
        @UPDATE table,obj,where
    
    insert:(table,data,clause)=>
        option=@INSERT table,data
        if clause then @one option[0]+(if clause then ' '+clause else ''),option[1]
        else @none option[0],option[1]

    delete:(table,data)=>
        option =@DELETE table,data
        @result option[0],option[1]

    quit:=>
        @pgdb.$pool.end()

module.exports=PgDB
