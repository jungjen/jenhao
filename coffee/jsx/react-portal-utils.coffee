__=console.log
###

####

class ReactPortalManager
    @portlets={}
    constructor=(@nodes,@portlets={})->

    setIframeHeight:(iframe)->
        iframe.onload=->
            iframeWin=iframe.contentWindow || iframe.contentDocument.parentWindow
            iframeHeight=iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight
            iframe.height = iframeHeight+10
    

    registerPortletComponent:(path,component)->@portlets[path]=component
 
    saveLocal:(key,obj)->
        value=@findLocal(key) || {}
        value[k]=v for k,v of obj
        @setLocal key,value
        
    setLocal:(key,value)->
        localStorage.setItem "#{key}",JSON.stringify value
        @
    findLocal:(key)->
        result=localStorage.getItem "#{key}"
        if result then JSON.parse result else result

    removeLocal:(key)->
        localStorage.removeItem "#{key}"
        @
    mountReactComponent:(component,props,selector,callbacks)->
        ReactDOM.render React.createElement(component, props),$(selector)[0]
        callback.call component if typeof callback is 'function'

    promiseTemplate:(template,options)->
        {render,renderable}=teacup
        Promise.resolve render renderable template,options

    promiseComponents:(script,callback,path='jsx/components/')->
        __ 'promiseComponents: '+script
        return if !script
        await Promise.resolve "#{path}#{script}.js" 
            .then (url)->$.getScript  url,callback
        
    promisePortalContent:(url)->
        Promise.resolve url
            .then (url)->$.get url
            .then (data)->data
    
    createReduxStore:(reducer)->
        Redux.createStore reducer,window.__REDUX_DEVTOOLS_EXTENSION__ and window.__REDUX_DEVTOOLS_EXTENSION__()

Vue.use SemanticUIVue if Vue
`const PortalManager=new ReactPortalManager()`




