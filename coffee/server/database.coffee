__=console.log

class SQLDatabase
    constructor:(option)->
        @init option

    init:(option)=>

    INSERT:(table,obj,para='$')=>
        [index,data]=[1,[]]
        result='insert into '+table
        value='values'
        for field,v of obj
            data.push v
            result=result+ if index is 1 then '(' else ','
            result=result+field
            value=value+ if index is 1 then '(' else ','
            value=value+para+ index++
        [result+') '+ value+')',data]
            

    UPDATE:(table,obj,where,para='$')=>
        [index,k,data]=[1,1,[]]
        result='update '+table
        for field,value of obj
            data.push value
            result=result+ if index is 1 then ' set ' else ','
            result=result+field+'='+para+index++
        
        for field,value of where
            data.push value
            result=result + if k++ is 1 then ' where ' else ','
            result=result+field+'='+para+index++
        [result,data]

    SELECT:(view,fields,where,para='$')=>
        [index,data,result]=[1,[],'']
        for field in fields 
            result=result+if index++ is 1 then 'select ' else ','
            result =result+field
        index=1
        result=result+' from '+view
        for field,value of where 
            data.push value
            result=result+if index is 1 then ' where ' else ' and '
            result=result+field+'='+para+index++

        [result,data]
    
    DELETE:(table,where,para='$')=>
        [index,data]=[1,[]]
        result='delete from '+table
        value='value'
        for field,v of where
            data.push v
            result=result+ if index is 1 then ' where ' else ' and '
            result=result+field+'='+para+index++
        [result,data]
        
module.exports=SQLDatabase

sql=new SQLDatabase()

# __ sql.SELECT 'jenhao',['id','name'],id:1
# __ sql.SELECT 'jenhao',[''],id:1

