*** Settings ***


Documentation       Create Client 

Library             OperatingSystem
Library             RPA.Browser.Selenium
Library    RPA.Desktop



*** Variables ***

${login_URL}           http://192.168.1.106:8083/custcare_cu_lhs/webresources/Login.jsp
${Username}            ALU
${password}            SY
${DELAY}               1
${prenom}              Moudi
${nom}                 Salah
${rue}                 Rue les oliviers
${passwordClient}      1234



*** Keywords ***


Open Browser To Login Page
    [Arguments]    ${login_URL}         
    Open Available Browser     ${login_URL}    
    Maximize Browser Window 

Input Username
    [Arguments]    ${Username}
    Input Text    name:j_username    ${Username}    

Input Password
    [Arguments]    ${password}
    Input Text    name:j_password    ${password}  
Input Password Client 
    [Arguments]    ${passwordClient}
    Input Text    name:CS_PASSWORD    ${passwordClient}  
Adresse Client Input Prenom
    [Arguments]    ${prenom}
    Input Text    name:ADR_FNAME    ${prenom}  

Adresse Client Input Nom
    [Arguments]    ${nom}
    Input Text    name:ADR_LNAME    ${nom}  

Adresse Client Input Rue
    [Arguments]    ${rue}
    Input Text    name:ADR_STREET    ${rue}  

Adresse Facturation Input Prenom
    [Arguments]    ${prenom}
    Input Text    name:BA_FirstName    ${prenom}  

Adresse Facturation Input Nom
    [Arguments]    ${nom}
    Input Text    name:BA_LastName    ${nom}  

Adresse Facturation Input Rue
    [Arguments]    ${rue}
    Input Text    name:BA_StreetName    ${rue}  
Submit Credentials
    Click Button    css:input[type="SUBMIT"]   #Submit

Welcome Page Should Be Open
    Title Should Be    Start page



Login cx
    Open Browser To Login Page               ${login_URL}    
    Input Username                           ${Username}
    Set Selenium Speed                       ${DELAY}
    Input Password                           ${password}
    Submit Credentials
    Welcome Page Should Be Open

Create Client
    Welcome Page Should Be Open
    Click Element                            //*[@id="CustomerNode"]/td[2]/a
    Click Element                            //*[@id="CustomerNode_sl"]/td[2]/table[1]/tbody/tr/td[2]/a
    
    #Create client
    Title Should Be                           Create customer
    
    
    #Adresse Client
    Adresse Client Input Prenom              ${prenom}
    Adresse Client Input Nom                 ${nom}
    Adresse Client Input Rue                 ${rue}
    #Pays
    #Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[10]/td[5]/nobr/div/select
    #Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[10]/td[5]/nobr/div/select/option[220]
    Select From List By Label                 name=COUNTRY_ID    Tunisie

    #Adresse Facturation
    Adresse Facturation Input Prenom         ${prenom}
    Adresse Facturation Input Nom            ${nom}
    Adresse Facturation Input Rue            ${rue}
    
    #Informations sur le client
     #Nationalité(Tunisie)
    #Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[34]/td[5]/nobr/div/select
    #Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[34]/td[5]/nobr/div/select/option[220]
    Select From List By Label                 name=ADR_NATIONALITY    Tunisie

     #Groupe Client ( Grand Compte )
    #Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[39]/td[5]/nobr/div/select
    #Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[39]/td[5]/nobr/div/select/option[2]
    Select From List By Label                 name=PRG_CODE    Grand compte
    Click Button                              name:enableGroupSelection
     #Mot de passe
    Input Password Client                     ${passwordClient}
     #Centre de coûts
    Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[40]/td[2]/nobr/div/select
    Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[40]/td[2]/nobr/div/select/option[3]
     #Plan tarifaire CTC (OCC Client)
    #Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[41]/td[5]/nobr/div/select
    #Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[41]/td[5]/nobr/div/select/option[19]  
    Select From List By Label                 name=RPCODE    OCC client
    #Select From List By Value                 name=RPCODE    3



    
    #Disposition de paiement
     #Mode de paiement 
    Click Element                            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/form/table[3]/tbody/tr[46]/td[2]/nobr/div/select
    Click Button                             name:Enable_Button


    Click Button                             name:SuNextStepButton

    Click Button                             name:SuNextStepButton

    Click Button                             name:Finish_Button

    #GetCustCode
    ${CustomerCode}=     Get Text            xpath=/html/body/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td[2]/table[1]/tbody/tr/td/div/span[8]
    Log                                      ${CustomerCode}
    
    Screenshot                               filename=%{ROBOT_ROOT}${/}Screenshots${/}${CustomerCode}.png 

*** Tasks ***
Create Client
    Login cx 
    Create Client
