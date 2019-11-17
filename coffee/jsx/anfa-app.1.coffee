
{Button}=semanticUIReact

class App extends React.Component
    click:=>
        alert 'a'

    render:->
        s=[]
        s.push Teact.crel Button,color:'red',onClick:@click ,basic:yes,"#{i}" for i in 'a b c d'.split ' '
        Teact.div s

PortalManager.mountReactComponent App,{},'#root'

