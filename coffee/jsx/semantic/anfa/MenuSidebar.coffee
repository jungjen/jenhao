if require?
    { Component }= require 'react' 
    { BrowserRouter,Link,Switch }= require 'react-router-dom' 
    { Segment,Accordion,Accordion, Icon }=require 'semantic-ui-react'

AccordionNode=({index})->

AccordionItem=({index})->
    <Accordion.Content active={activeIndex is index} index={index} />


class MenuSidebar extends Component
    
    constructor:(props)->
        super props
        @item=props.items=[]
        state=active:0


    
    renderMenu:({})->


    render:-><Accordion inverted>
        <Accordion.Title active={@state.active is @props.index} index={@props.index} 
            onClick={-> @setState @props.index}>
            <Icon name={@props.icon} />
            {}
            <Icon name='dropdown' />
        </Accordion.Title>

    </Accordion>


