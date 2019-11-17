{Form,Input,Select,TextArea,Checkbox,Radio,Button,Table,Step,Modal}=semanticUIReact

genderOptions = [
  { key: 'M', text: 'Male（男）', value: 'male' }
  { key: 'F', text: 'Female（女）', value: 'female' }
]

inspector_org=[
  { key: '國泰醫院', text: '國泰醫院', value: '國泰醫院' }
  { key: '長庚醫院', text: '長庚醫院', value: '長庚醫院' }
]

inspectors={
  c1:{ key: 'c1', text: '賀爾蒙檢驗', value: '賀爾蒙檢驗' }
  c2:{ key: 'c2', text: '膽固醇代謝', value: '膽固醇代謝' }
  c3:{ key: 'c3', text: '一般生化檢查', value: '一般生化檢查' }
  c4:{ key: 'c4', text: '胰臟內分泌檢查', value: '胰臟內分泌檢查' }
  c5:{ key: 'c5', text: '免疫病毒檢驗', value: '免疫病毒檢驗' }
  c6:{ key: 'c6', text: '血液檢驗', value: '血液檢驗' }
  c7:{ key: 'c7', text: '免疫細胞標記', value: '免疫細胞標記' }
  c8:{ key: 'c8', text: '尿液檢驗', value: '尿液檢驗' }
  c9:{ key: 'c9', text: '糞便檢驗', value: '糞便檢驗' }
  c10:{ key: 'c10', text: '腫瘤標記', value: '腫瘤標記' }
}

inspector_items=[]
inspector_items.push v for k,v of inspectors

sheets={
    c1:[
        { value:5.99, key:'c1_01',name:'TSH',unit:'μIU/ml',range:'0.550 ~ 4.780',max:10.00,step:0.01}
        { key:'c1_02',name:'T3',unit:'ng/dL',range:'60 ~ 181',max:250,step:1 }
        { key:'c1_03',name:'T4',unit:'μg/dL',range:'4.5 ~ 10.9' }
        { key:'c1_04',name:'Free T4',unit:'μg/dL',range:'4.5 ~ 10.9' }
        { key:'c1_05',name:'Thyroglobulin',unit:'ng/dL',range:'<35.00' }
        { key:'c1_06',name:'LH',unit:'μg/dL',range:'4.5 ~ 10.9' }
        { key:'c1_07',name:'FSH',sub:'',unit:'μg/dL',range:'4.5 ~ 10.9' }
        { key:'c1_08',name:'FSH',sub:'',unit:'μg/dL',max:'#text' }
        { key:'c1_09',name:'尿酸用藥',sub:'',unit:'μg/dL',max:'#memo' }
        { key:'c1_10',name:'尿酸用藥',sub:'',unit:'μg/dL',max:'#check' }
        { key:'c1_11',name:'尿酸用藥',sub:'',unit:'μg/dL',max:'#radio' }
    ]
###
    c2:[
        { key:c2_01,name:'BUN',unit:'mg/dL',range:'9.0 ~ 23.0'}
        { key:c2_02,name:'Creatinine',unit:'mg/dL',range:'M: 0.70 ~ 1.30, F: 0.50 ~ 1.10'}
    ]
    c3:[
        { key:c3_01,name:'BUN',unit:'mg/dL',range:[9.0,23.0]}
        { key:c3_02,name:'Creatinine',unit:'mg/dL',range:{M:[0.70,1.30],F:0.50,1.10}}
    ]
###
}

orders=[
    {date:'2019-01-01', org:'國泰醫院',sheet:'賀爾蒙檢驗'}
    {date:'2019-01-02', org:'長庚醫院',sheet:'賀爾蒙檢驗'}
    {date:'2019-01-03', org:'本院',sheet:'賀爾蒙檢驗'}
    {date:'2019-01-04', org:'國泰醫院',sheet:'賀爾蒙檢驗'}
    {date:'2019-01-05', org:'國泰醫院',sheet:'賀爾蒙檢驗'}
    {date:'2019-01-06', org:'國泰醫院',sheet:'賀爾蒙檢驗'}
    {date:'2019-01-07', org:'國泰醫院',sheet:'賀爾蒙檢驗'}        
]

class LabSheets extends React.Component
    constructor:(props)->
        super props
        @state = {
            date: props.date || 'xxxx-xx-xx'
            sheet:'c1'
        }

    AddInspectorItem:-><Form>
        <Form.Group>
            <Form.Input name='add_date' id='date-labs2' className='datedrop' type='date' error label='檢驗日期' 
                placeholder='檢驗日期' width={4} />
            <Form.Input error readOnly name='add_name' label='姓名' placeholder='姓名' width={4} />
            <Form.Input error readOnly name='add_no' label='病歷號碼' placeholder='病歷號碼' width={4} />
            <Form.Input error readOnly name='add_sex' label='性別' placeholder='性別' width={2} />
        </Form.Group>
        <Form.Group>
            <Form.Field error control={Select} options={inspector_org}  width={7}
            placeholder='檢驗機構' name='add_org' search searchInput={{ id: 'form-select-control-inspector' }} />
            <Form.Field error control={Select} options={inspector_items}  width={9}
            placeholder='檢驗摘要' name='add_sheet' search searchInput={{ id: 'form-select-control-inspector_items' }} />
        </Form.Group>
    </Form>

    FormHeader:-><Form.Group widths='equal'>
        <Form.Field name='no' control={Input} icon='search' label='病歷號碼' placeholder='病歷號碼' error/>
        <Form.Field name='name' control={Input} label='姓名' placeholder='姓名'/>
        <Form.Field name='birth' id='birth' readOnly control={Input} label='生日' placeholder='生日'/>
        <Form.Field name='sex' control={Select} options={genderOptions} label={{ children: '性別', htmlFor: 'control-gender' }}
            placeholder='性別' readOnly search searchInput={{ id: 'control-gender' }} />
    </Form.Group>

    componentDidMount:->
        $('#birth').daterangepicker
            format: 'YYYY-MM-DD'
            locale:
                daysOfWeek: [ '日', '一', '二', '三', '四', '五', '六' ]
                monthNames:  [ '一月', '二月', '三月', '四月', '五月', '六月','七月', '八月', '九月', '十月', '十一月', '十二月' ]

        $('#date-labs').daterangepicker 
            format: 'YYYY-MM-DD'

    handleSave:=>
        __  $('#LabForm').serialize()

    render:-><Form name='LabForm' id='LabForm'>
        {@FormHeader()}
        <Table striped compact>
            <Table.Body>
            <Table.Cell  inverted width={4} verticalAlign='top'>
                <Input label="過濾" fluid iconPosition='left' placeholder=''>
                    <Icon name='at' />
                    <input />
                </Input>
                <SheetList orders={orders}/>
            </Table.Cell>
            <Table.Cell  verticalAlign='top'>
                <Button basic color='red' content='檢驗機構'
                    label={as: 'a' ,basic: yes, fluid:yes, color:'blue', pointing: 'left'
                    , content: "#{@state.org||'國泰醫院'}" }/>
                <Modal bacic size='small' centered={off} closeIcon closeOnDimmerClick={no}
                    trigger={<Button content='新增' secondary icon='plus' labelPosition='left' />}>
                    <Modal.Header>檢驗摘要新增</Modal.Header>
                    <Modal.Content>
                        <Modal.Description>{@AddInspectorItem()}</Modal.Description>
                    </Modal.Content>
                    <Modal.Actions>
                        <Button onClick={this.close} negative content='取消' />
                        <Button onClick={this.close} secondary labelPosition='right' 
                            icon='checkmark' content='新增' />
                    </Modal.Actions>
                </Modal>
                <Button content='刪除' color='red' icon='close' labelPosition='right' />
                <Button onClick={@handleSave} content='存檔' primary icon='refresh' labelPosition='right' />
                <SheetListItem sheets={sheets.c1}/>
            </Table.Cell>
            </Table.Body>
        </Table>
    </Form>

class SheetList extends React.Component
    constructor:(props)->
        super props
        @state={
            orders:props.orders||[]
        }
    render:-><Table  basic='very' size='small' celled collapsing>
        <Table.Header >
        <Table.Row>
            <Table.HeaderCell>檢驗日期</Table.HeaderCell>
            <Table.HeaderCell>檢驗摘要</Table.HeaderCell>
            <Table.HeaderCell>檢驗機構</Table.HeaderCell>
        </Table.Row>
        </Table.Header> { @state.orders.map (order,i)->
            <Table.Row key={i++} >
                <Table.Cell>{order.date}</Table.Cell>
                <Table.Cell>{order.sheet}</Table.Cell>
                <Table.Cell>{order.org}</Table.Cell>
            </Table.Row>
         }
    </Table>

class SheetListItem extends React.Component
    constructor:(props)->
        super props
        @state={
            sheets:props.sheets||[]
        }
    render:->
        <Table basic size='mini' celled collapsing>
        <Table.Body >
            <Table.Row negative>
                <Table.HeaderCell  verticalAlign='bottom' textAlign='left' colSpan={2}>
                    <Button basic color='red' content='檢驗項目'
                        label={as: 'a' ,basic: yes, fluid:yes, color:'blue', pointing: 'left'
                        , content:inspectors.c1?.text  }
                    />
                    <Button basic color='red' content='檢驗日期'
                        label={{ as: 'a' ,basic: true,fluid:yes,color: 'blue',pointing: 'left'
                        , content: "#{@state.date||'2019-12-1'}" }}
                    />
                
                </Table.HeaderCell>
                <Table.HeaderCell>檢驗數值</Table.HeaderCell>
                <Table.HeaderCell>單位</Table.HeaderCell>
                <Table.HeaderCell>標準範圍</Table.HeaderCell>
            </Table.Row>
            {   
                @state.sheets.map (item,i)->
                    <SheetListItemEditorRow key={i} display={item.name}
                        name={item.key} range={item.range||''}
                        min={item.min||0} max={item.max||100} 
                        step={item.step||0.1} 
                        value={item.value||0} unit={item.unit}
                    />
            }
            <Table.Row>
                <Table.HeaderCell colSpan={4}>{''}</Table.HeaderCell>
            </Table.Row>
            <Table.Row>
                <Table.HeaderCell colSpan={4}>{''}</Table.HeaderCell>
            </Table.Row>
        </Table.Body>
    </Table>

class SheetListItemEditorRow extends React.Component
    constructor:(props)->
        super props
        switch @props.max 
            when '#memo','#text' then @state= "#{props.name}" : @props.value||''
            when '#check','#radio' then @state= "#{props.name}" : @props.value||''
            else @state= "#{props.name}" : @props.value||0

    handleChange:(e, { name, value }) =>
        __ name+','+value
        @setState [name]: value

    renderEditor:->
        switch @props.max
            when '#text' then <React.Fragment>
                <Table.Cell colSpan={3} nowrap>
                    <div className='ui inverted segment'>
                        <Form.Input onChange={@handleChange}  value={@state[@props.name]} name={@props.name}/>  
                    </div> 
                </Table.Cell>
                <Table.Cell>{@props.range||''}</Table.Cell>
            </React.Fragment>
            
            when '#memo' then <React.Fragment>
                <Table.Cell colSpan={3} nowrap>
                    <div className='ui inverted segment'>
                        <Form.TextArea onChange={@handleChange} value={@state[@props.name]} name={@props.name}/>
                    </div> 
                </Table.Cell>
                <Table.Cell>{@props.range||''}</Table.Cell>
            </React.Fragment>

            when '#check' then <React.Fragment>
                <Table.Cell colSpan={3} nowrap>
                    <Segment inverted compact><Checkbox onChange={@handleChange} value={@state[@props.name]} name={@props.name} /></Segment>
                </Table.Cell>
                <Table.Cell>{@state.duration}</Table.Cell>
            </React.Fragment>
            
            when '#radio' then <React.Fragment>
                <Table.Cell colSpan={3} nowrap>
                    <Segment inverted className="inline fields">
                        <label className='ui segment white inverted'>Pears</label>
                        <Radio toggle value={1} name={@props.name}/> 
                        <label className='ui segment white inverted'>Pears</label>
                        <Radio toggle value={2} name={@props.name}/>
                        <label className='ui segment white inverted'>Pears</label>
                        <Radio toggle value={3} name={@props.name}/>
                    </Segment>
                </Table.Cell>
                <Table.Cell>{@props.range||''}</Table.Cell>
            </React.Fragment>

            else <React.Fragment>
                <Table.Cell nowrap>
                    <table className='ui inverted table' border={0}><tr><td>
                    <Form.Input color='red' error size='big'
                        min={@props.min||0} max={@props.max||500} name={@props.name}
                        onChange={@handleChange} step={@props.step||0.1}
                        type='range' value={@state[@props.name]}
                    /></td><td>{@props.max}</td></tr></table>
                </Table.Cell>
                <Table.HeaderCell textAlign='right'>{@state[@props.name]}</Table.HeaderCell>
                <Table.Cell>{@props.unit||''}</Table.Cell>
                <Table.Cell>{@props.range||''}</Table.Cell>
            </React.Fragment>

    render:-><Table.Row>
        <Table.HeaderCell align='right'>
            <Header.Content negative>
                {@props.display||@props.name}
                <Header.Subheader></Header.Subheader>
            </Header.Content>
        </Table.HeaderCell>
        {@renderEditor()}
    </Table.Row>

class SheetEditor extends React.Component
    render:-><Step.Group vertical size='mini'> {
        inspector_items.map (item,index)=>
            <Step  active={item.key is @props.sheet} completed={item.key is @props.sheet} 
                key={index++}>
                <Icon  name='' />
                <Step.Content><Step.Title>{item.text}</Step.Title></Step.Content>
            </Step>
        }
    </Step.Group>


