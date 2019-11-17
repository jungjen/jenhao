$.ajaxSetup cache: on
$(document).ready ->
    {renderable,div,h1,a,i}=teacup
    PortalManager.promiseTemplate ->
        div '#portal-root'
        div '#portal',style:'padding-left:10px; padding-right:10px'
    .then (html)-> $('#app').html html
    .then ->
        PortalManager.promiseComponents 'app/PortalData',->
            PortalManager.saveLocal 'alan2-hospital',hospital
            PortalManager.saveLocal 'alan2-admin',admin

    .then ->
        hospital=PortalManager.findLocal 'alan2-hospital'
        __ hospital.display
        hospital.key='hospital'
        admin=PortalManager.findLocal 'alan2-admin'
        admin?.key='admin'
        PortalManager.portals={hospital,admin}
    .then (portals)-> 
        PortalManager.promiseComponents 'app/portal-app',->
            PortalManager.mountReactComponent PortalSidebar,{portals,portal:'admin'},'#sidebar'
            PortalManager.mountReactComponent PortalNavbar,{portals,logon:'alan',user:'Alan Dong'},'#navbar'
        portals
    .then (portals)->
        $.get 'html/settings.html',(html)->$('#sidebar-right').html html
        portals
    .then (portals)->
        __ portals
        $.getScript 'js/main.js',->
            PortalManager.mountReactComponent PortalApp,{portals:portals,portal:'admin'},'#portal-root'
    .catch (error)->
        __ error
        # throw error
