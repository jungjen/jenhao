hospital=
    display: '安法診所',key:'hospital', icon:'hospital outline'
    modules: 'nurse admin info drug doctor account'.split ' '
    m_nurse: 
        display:'護理部', icon:'plus square', app: 'booking register report maintain other'.split ' '
        app_booking: 
            display:'掛號作業',icon:'heart outline'
            items: b1:'病人預約',b2:'當日預約',b3:'醫生間診',b4:'藥物紀錄'
        app_register: 
            display:'報到作業',icon:'plus square outline'
            items: watching:'當日看診紀錄',booking:'醫生間診',drug:'藥物紀錄'
        app_report:
            display:'病例報表',icon:'calendar plus'
            items: watching:'當日看診紀錄',booking:'醫生間診',drug:'藥物紀錄'
        app_maintain:
            display:'維護作業'
            items: watching:'客戶資料',booking:'廠商資料',drug:'ˋ診所維護'
        app_other:
            display:'其他作業'
            items: watching:'當日看診紀錄',booking:'醫生間診',drug:'藥物紀錄'
            
    m_doctor: 
        display:'醫師看診', icon:'doctor', app: 'register info'.split ' '
        app_register:
            display:'檢驗作業'
            items:w1:'Lab Sheets',w2:'預約',w3:'預約',w4:'預約'
        app_info:
            display:'掛號作業'
            items:w1:'看診紀錄',w2:'預約',w3:'預約',w4:'預約'
    m_drug: 
        display:'藥局作業', icon:'h square', app: 'register info'.split ' '
        app_register:
            display:'藥品管理'
            items:
                d1:'看診紀錄'
                d2:'病人領藥'
        app_info:
            display:'藥品管理'
            items:
                d1:'看診紀錄'
                d2:'病人領藥'
admin=
    display: '安法診所 Demo', icon:'home', key:'admin'
    modules: 'nurse doctor'.split ' '
    m_nurse: 
        display:'護理部', icon:'plus square',app: 'booking register'.split ' '
        app_booking: 
            display:'檢驗作業',icon:'cplus square outline'
            items:w1:'Lab Sheets',w2:'檢驗項目',w3:'檢驗單位',w4:'檢驗報表'
        app_register: 
            display:'報到作業',icon:'calendar outline'
            items: watching:'當日看診紀錄',booking:'醫生間診',drug:'藥物紀錄'
            
    m_doctor: 
        display:'醫師看診', icon:'doctor',app: 'register'.split ' '
        app_register:
            display:'掛號作業'
            items:w1:'看診紀錄',w2:'預約',w3:'預約',w4:'預約'










