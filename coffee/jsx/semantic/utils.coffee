{Table}==semanticUIReact

class SemanticJsonTable extends React.Component
    constructor:(props)->
        super props
        @state = rows:@props.rows||[]
    
    afterJsonData:->
    
    componentDidMount:->
        if @props.url then $.getJSON @props.url,(json)=> @afterJsonData()

    render:->
        [cols,th,td,i,j]=[[],[],[],0,0]
        for col in @props.cols
            cols.push <col key={i++} width={col.width}/>
            th.push <th key={i++} >{col.title}</th>
    

class SemanticDataTable extends SemanticJsonTable
    
    afterJsonData:->
        option={}
        option.scrollY=@props.scrollY if @props.scrollY
        option.dom=@props.scroldomlY if @props.dom
        option.scrollX=true if @props.scrollX
        option.paging=false if @props['no-page']
        option.ordering=false if @props['no-sort']
        option.searching=false if @props['no-search']
        # $("input[type='search']").addClass 'ui input'
        # $('#'+@props.id+'_filter').removeClass 'dataTables_filter'       
        $('#'+@props.id).DataTable option
    

###
class SemantiTable extends React.Component
    constructor:(props)->
        super props
        @state = rows : @props.rows||[]

    afterMount:->
               
    componentDidMount:->
        if @props.url 
            $.getJSON @props.url,(json)=>
                @setState rows:json.data
                option={}
                option.scrollY=@props.scrollY if @props.scrollY
                option.dom=@props.scroldomlY if @props.dom
                option.scrollX=true if @props.scrollX
                option.paging=false if @props['no-page']
                option.ordering=false if @props['no-sort']
                option.searching=false if @props['no-search']
                $('#'+@props.id).DataTable option
               # $("input[type='search']").addClass 'ui input'
               # $('#'+@props.id+'_filter').removeClass 'dataTables_filter'
                
    render:->
        [cols,th,td,i,j]=[[],[],[],0,0]
        for col in @props.cols
            cols.push <col key={i++} width={col.width}/>
            th.push <th key={i++} >{col.title}</th>
        for row in @state.rows
            j++
            data=[]
            for col in @props.cols
                switch typeof col.field 
                    when 'function'
                        value=col.field.call row,j,col
                        if col.html then data.push <td key={i++} dangerouslySetInnerHTML={{__html:value||''}} />
                        else data.push <td key={i++}>{value||''}</td>
                    when 'object'
                        data.push <td key={i++}>{col.field}</td>
                    else
                        if col.html then data.push <td key={i++} dangerouslySetInnerHTML={      {__html:row[col.field]||''}} />
                        else data.push <td key={i++} >{row[col.field]||''}</td> 

            td.push <tr key={i++}>{data}</tr>
        
        <table className={SemanticTableClass 'table',@props} id={@props.id} width={@props.width||'100%'}>
            <thead><tr>{th}</tr></thead>
            <tbody>{td}</tbody>
        </table>
     <SuiTable color="orange" no-page sort no-search scrollX dom='' cols={[
                {title:'ID',width:'100',field:'id',width:100}
                {field:'username',title:'User Name',width:100}
                {field:'age',title:'Age',width:60}
                {field:'sex',title:'性别',sort:yes}
                {title:'城市',field:'city'}
            ]} url="/json/user.json" id="jungjen" scrollY='250px' selectable celled size="small" />

            <SuiTable id="example" size='small' cols={[
                {title:'User',width:'100',field:(i)->i}
                {field:'user',title:'User',width:'100'}
                {field:'age',title:'Age',width:'200'}
                {title:'Sex',html:yes,field:=><Icon icon="search" />}
                {title:'HHH',html:yes,field:->'<h2>'+@user+'</h2>'}
            ]} rows={[
                {user:'Jung',age:20,sex:'F'}
                {user:'Jung GG',age3:20,sex:'<h3>M</h3>'}
                {user:'Jung',age:20,sex:'F'}
                {user:'Jung GG',age3:20,sex:'<h3>M</h3>'}
                {user:'Jung',age:20,sex:'F'}
                {user:'Jung GG',age3:20,sex:'<h3>M</h3>'}
                {user:'Jung',age:20,sex:'F'}
                {user:'Jung GG',age3:20,sex:'<h3>M</h3>'}
                {user:'Jung',age:20,sex:'F'}
                {user:'Jung GG',age3:20,sex:'<h3>M</h3>'}
                {user:'Jung',age:20,sex:'F'}
                {user:'Jung GG',age3:20,sex:'<h3>M</h3>'}
                {user:'Jung',age:20,sex:'F'}
                {user:'Jung GG',age3:20,sex:'<h3>M</h3>'}
            ]}/>

###
