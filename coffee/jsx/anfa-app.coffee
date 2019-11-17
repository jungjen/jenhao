__=console.log
store=null
class AppStore

addItem=(state=['item 1','item 2','item 3'],{type,text})->
    switch type
        when 'ADD_ITEM' then state.push text
        else
    state

store=Redux.createStore addItem,window.__REDUX_DEVTOOLS_EXTENSION__ and window.__REDUX_DEVTOOLS_EXTENSION__()

{BrowserRouter,Route,Link,Redirect,withRouter,Prompt}=ReactRouterDOM
{Button,Input}=semanticUIReact

class App extends React.Component 

    render:->
        <div>
            <div id="itemlist"></div>
            <div id="itemlist2"></div>
            <div>
                <Input id="user" icon='users' iconPosition='left' placeholder='Search users...' />
                <Button id="add" size={@props.size}>Click Here</Button>
            </div>
        </div>

    componentDidMount:->
        @renderItemList()
        @renderItemList2()
        store.subscribe @renderItemList
        store.subscribe @renderItemList2
        $('#add').click =>
            store.dispatch type:'ADD_ITEM',text:$('#user').val()
            $('#user').val('')
    
    renderItemList:->
        items=store.getState().map (item)=>"<li>#{item}</li>"
        $('#itemlist').html "<ul>#{items.join('')}</ul>"

    renderItemList2: ->
        items=store.getState().reverse().map (item)=>"<li>#{item}</li>"
        $('#itemlist2').html "<ul>#{items.join('')}</ul>"


MountReactComponent App,{size:'mini'},'#app'

MountReactComponent AnfaComponents.Toolbar,{color:'red',logon:'Ranger'},'#fixedbar'
    

