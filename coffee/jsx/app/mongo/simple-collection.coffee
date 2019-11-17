
{Form,Input,Menu,Select,Segment,TextArea,Button,Table}=semanticUIReact

EditorPanel=->
Editors={
    Range:1
}

class SimpleCollection extends ReactComponent
    constructor:(props)->
        super props
        @state={
            rows:[]
            visible:no
            fields:@props.fields||[]
        }

    showEditor:(idx)->
    renderEditor:->

    render:-><Form name='SimpleCollection'>
        <Sidebar.Pushable as={Segment}>
             <Sidebar as={Menu} animation='overlay' icon='labeled'
                inverted onHide={@handleSidebarHide}
                vertical
                visible={visible}
                width='thin'
                >
                renderEditor()
             </Sidebar>
            <Sidebar.Pusher>
                <Segment basic>
                    <Header as='h3'>Application Content</Header>
                    <Image src='/images/wireframe/paragraph.png' />
                </Segment>
            </Sidebar.Pusher>
         </Sidebar.Pushable>
    </Form>





