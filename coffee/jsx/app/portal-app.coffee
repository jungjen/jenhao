__=console.log
{ Accordion,Sidebar,Statistic, Icon, Label,Breadcrumb,Dropdown,Menu,Header,Segment,Image }=semanticUIReact


class  PortalSidebar extends React.Component
    constructor:(props)->
        super props
        @portals=props.portals||{}
        @state=active:'0',portal:props.portal

    renderSubAccordionMenu:(key,mkey,module)->
        [i,result]=[0,[]]
        result.push <a key={key+'-'+mkey+'-'+app+i++} className="alignd item" 
            data-path={"#{key}/#{mkey}/#{app}/-1"} onClick={->Portal.ChangeApp.call @,event} > 
                <Icon className='titleIcon' size="mini" name={"#{module['app_'+app]?.icon||'heart'}"} />
                {"#{module['app_'+app]?.display||''}"}
            </a> for app in module.app
        
        <React.Fragment key={key+'-'+mkey+i++}>
            <a className="title active item">
                <Icon name={"#{module?.icon||'home'}"} className="titleIcon" />
                    {module.display}
                <Icon  name="dropdown" />
            </a>
            <div className="content">{result}</div>
        </React.Fragment>

    renderSubAccordion:(key,portal)->
        menus=[]
        menus.push <a key="-1" className="title active item">
            <Icon name={"#{portal.icon||'home'}"} className="titleIcon" size="huge" />
            {portal.display}
            <Icon  name="dropdown" />
        </a>
        menus.push <div key="-2" className="inverted content">
            {@renderPortalSelector()}
        </div>
            
        for module in portal.modules
            m=portal["m_#{module}"]
            menus.push @renderSubAccordionMenu key,module,m if m
        <div key='-3' id="acc_menu" className="ui accordion inverted">
            {menus}
        </div>

    showPortal:(e)=>
        portal=e.target.dataset.portal
        @setState portal:portal
        $('#acc_menu').accordion 'open',1

    renderPortalSelector:->
        result=[]
        for k,v of @portals
            result.push  <button size="big" data-portal={k} key={k} onClick={@showPortal} 
                className="ui inverted button fluid">
                <Icon name={v.icon||'heart'} />{v.display}
            </button>
        result

    render:->
        menus=[]
        key=@state.portal
        portal=@portals[key]
        menus.push @renderSubAccordion key,portal
        <React.Fragment>
            {menus}
        </React.Fragment>
        
class PortalNavbar extends React.Component 

    PortalUser:-><div key="1" className="ui dropdown item">
        <img className="ui mini avatar image" src={"img/#{@props.logon}.jpg"} alt="label-image" /> 
        {@props.user||'Jung Jen Huang'}
        <div className="menu inverted">
            <a className="item" href="#">我的檔案</a>
            <a className="item" href="#">設定</a>
            <div className="ui divider"></div>
            <a className="item" href="#">登出</a>
        </div>
    </div>

    render:-><React.Fragment>
        <a className="item labeled openbtn"><Icon name="bars" size="large" bordered/></a>
        <a className="item labeled"><Icon name="sign out" size="large" bordered/></a>
        {@PortalUser()}
        <div className="right menu colhidden" id="settings">
            <a className="item labeled rightsidebar computer only">
                <Icon name="settings" size="large" bordered/>
            </a>
            <a className="item labeled expandit" onClick={->toggleFullScreen document.body}>
                <Icon name="expand" size="large" bordered/>
            </a>
        </div>
    </React.Fragment>
        
class Portal extends React.Component 
    @ChangeApp:(e)=>
        path=e.target.dataset.path.split '/'
        Portal.Store.dispatch  pen:path[3]||'-1',node:path[0],module:path[1],app:path[2],type:'SHOW_APP'
    
    @Root=document.getElementById 'portal'
    @Actions=
        showapp: -> type: 'SHOW_APP'
    @Reducer=(state={pen:'-1',node:'hospital',module:'nurse',app:'register'},action)->
        switch action.type
            when 'SHOW_APP' 
                app:action.app,module:action.module,node:action.node,pen:action.pen
            else state

    @Store=PortalManager.createReduxStore Portal.Reducer

    constructor:(props)->
        super props
        @_dom=document.createElement 'div'
    componentDidMount:->Portal.Root.appendChild @_dom
    componentWillUnmount:->Portal.Root.removeChild @_dom
    render:->ReactDOM.createPortal @props.children,@_dom

class  PortalLayout extends React.Component
    constructor:(props)->
        super props
    
    getPortal:-> 
        {node,module,app,pen}=@props
        return <div/> if pen is '-1' or !pen 
        Result=class Result extends RemoteHtml
        <Result url={"portal/#{node}-#{module}-#{app}-#{pen}"} />

    get404:-><h1>{"404 #{new Date()}"}</h1>
    toggle: (e)=>
        $(e.target).siblings().removeClass('active')
        $(e.target).addClass 'active'
        @changeApp e
    
    changeApp:(e)=>
        path=e.target.dataset.path.split '/'
        Portal.Store.dispatch  pen:path[3]||'-1',node:path[0],module:path[1],app:path[2],type:'SHOW_APP'

    render:->
        {pen,node,module,app,showapp}=@props
        __ "#{node}/#{module}/#{app}/#{pen}"
        portal=PortalManager.portals[node]
        mod=portal['m_'+module]||{}
        ap=mod['app_'+app]||{}
        [i,itm]=[0,[]]
        # itm.push  <a key='-1'>{  }<Icon size="big" name="#{ap.icon||'heart'}" />{  }</a>
        itm.push <a key={k+i++} data-path={"#{node}/#{module}/#{app}/#{k||-1}"} 
            onClick={@toggle} data-portal={"#{k}"} className="item"> {v}</a> for k,v of ap.items
        mod_app=mod.app
        dropdownItems=[]
        for k in mod_app
            dropdownItems.push <Dropdown.Item key={k+i++} onClick={@changeApp} 
                data-path={"#{node}/#{module}/#{k}/-1"}>
                {"#{mod['app_'+k]?.display||''}"}
            </Dropdown.Item>
                            
        <React.Fragment>
            <Segment basic fluid>
                <Breadcrumb size="massive">
                <div className="ui secondary stackable pointing menu">
                <Icon name={"#{mod?.icon||'home'}"} size="huge"/>
                <Breadcrumb.Section link>{portal.display}</Breadcrumb.Section>
                <Breadcrumb.Divider icon='right chevron' />
                <Breadcrumb.Section link>{mod.display||''}</Breadcrumb.Section>
                <Breadcrumb.Divider icon='right chevron' />
                <Breadcrumb.Section active>
                    <Dropdown text={ap.display||''}>
                        <Dropdown.Menu>
                            {dropdownItems}
                        </Dropdown.Menu>
                    </Dropdown>
                    <div className="right menu">
                        {itm}
                        <a className="ui item">{    }</a>
                    </div>
                </Breadcrumb.Section>
                </div>
                </Breadcrumb>
            </Segment>
            <Portal>{@getPortal()||@get404()}</Portal>
        </React.Fragment>
        
class PortalApp extends React.Component
    constructor:(props)->
        super props
        @state=app:'booking',module:'nurse',node:'hospital',pen:'=1'
    
    componentWillMount:
        Portal.Store.subscribe (state)=>@setState state
    changeApp:(e)=>
        path=e.target.dataset.path.split '/'
        Portal.Store.dispatch  pen:path[3]||'-1',node:path[0],app:path[2],module:path[1],type:'SHOW_APP'
    
    mapLayoutState:(state,props)->node:state.node,module:state.module,app:state.app,pen:state.pen
    mapLayoutDispatch:(dispatch,props)->Redux.bindActionCreators showapp:Portal.Actions.showapp,dispatch
    renderLayout:->ReactRedux.connect(@mapLayoutState,@mapLayoutDispatch) PortalLayout
    renderHeader:->
    requestContent:(url)->
        await Promise.resolve url
        .then (url)->$.get url
        .then (data)->data
        
    renderFooter:-><footer></footer>
    render:->
        PortalLayout=@renderLayout()
        <div className="ui equal width left aligned padded grid stackable">
            {@renderHeader()}
            <ReactRedux.Provider  store={Portal.Store}>
            <PortalLayout />
            </ReactRedux.Provider>
            {@renderFooter()}
        </div>
        
class RemoteHtml extends React.Component 
    componentDidMount:->$.get @props.url,(data)=>$("##{@props.id||'remote-portal'}").html "#{data}" if @props.url
    render:-><div id={@props.id||'remote-portal'}></div>
