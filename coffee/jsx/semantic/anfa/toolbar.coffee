__=console.log

if require?
    { Component }= require 'react' 
    { BrowserRouter,Link,Switch }= require 'react-router-dom' 
    { Container, Segment,Accordion,Accordion, Icon }=require 'semantic-ui-react'

LinkItem=({href,component})->
    <a className='header item' href={href}>{component}</a>

UserLabel=(props)->
    logon =
        avatar: true
        spaced: 'right'
        src: 'img/elliot.jpg'
    __ props
    
    <Label as='a' content={props.logon} inverted bordered image={logon}>


    </Label>

 TitilItem=({title,icon})-><a class="title item">
    <Icon name={icon+' titleIcon'} />
    <Icon name='dropdown'/>
</a>


Toolbar= ({color,logon})-><div className="ui fixed inverted menu">

    <Container>
        <a href="#" className="header item"><UserLabel logon={logon} /></a>
        <a href="#" className="header item"><Icon name="expand" inverted size='large' /></a>
        <a href="#" className="header item"><Icon name="expand" inverted borded size='large' /></a>
        <a href="#" className="header item"><img className="logo" src="img/logo.png" />安法</a>      
        <a href="#" className="header item"><Input icon='search' placeholder='Search...' /></a>
    </Container>
    <div className="ui vertical inverted sidebar menu" id="sidebar-left">
    </div>
</div>

Node=->

ExportComponents={
    Toolbar
}

if module?.exports then module.exports = ExportComponents else window?.AnfaComponents=ExportComponents

    
    