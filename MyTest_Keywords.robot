*** Settings ***
Documentation     Keywords for luma project
Library           SeleniumLibrary
Library           FakerLibrary


*** Variables ***
${URL}   https://magento.softwaretestingboard.com/
${BROWSER}   chrome
${HOMEPAGE_SIGNIN_LINK}    class:authorization-link
${LOGIN_USERNAME_FIELD}    name:login[username]
${LOGIN_PASSWORD_FIELD}    id:pass
${SIGNIN_BUTTON}           id:send2
${LOGIN_SUCCESS_MESSAGE}   Welcome, Jane Zoe!
${USERNAME}  ${EMPTY}
${PASSWORD}  ${EMPTY}
${CREATE_NEW_ACCOUNT_LINK}   xpath://a[text() = 'Create an Account']
${CREATEACC_FIRSTNAME_FIELD}   id:firstname
${CREATEACC_LASTNAME_FIELD}     name:lastname
${CREATEACC_EMAIL_FIELD}       name:email
${CREATEACC_PASSWORD_FIELD}    name:password
${CREATEACC_CONFIRMPASS_FIELD}  id:password-confirmation
${CREATEACC_BTN}   xpath://a[text() = 'Create an Account']
${ADDRESS_BOOK}  xpath://*[@id="block-collapsible-nav"]/ul/li[6]
${EDITADD_PHONE}    id=telephone
${EDITADD_STREETADD}   name:street[]
${EDITADD_CITY}     name:city
${EDITADD_STATE}    id:region_id
${EDITADD_PC}       id:zip
${EDIT_COUNTRY}     id:country
${EDIT_SAVEADDRESS}  xpath://*[@id="form-validate"]/div/div[1]/button/span




*** Keywords ***
Navigate to homepage
     open browser   ${URL}   ${BROWSER}
     maximize browser window


Precondition for new user account
      open browser   ${URL}   ${BROWSER}
      maximize browser window
      Wait and Click Element  ${CREATE_NEW_ACCOUNT_LINK}


Edit user address details
     [Arguments]   ${phone_number}   ${street_address}   ${city}   ${postcode}
     wait and click element   ${ADDRESS_BOOK}
     wait and input text      ${EDITADD_PHONE}      ${phone_number}
     wait and input text      ${EDITADD_STREETADD}  ${street_address}
     wait and input text      ${EDITADD_CITY}       ${city}
     select from list by label   ${EDIT_COUNTRY}    Finland
     select from list by index   ${EDITADD_STATE}   6
     wait and input text    ${EDITADD_PC}      ${postcode}
     wait and click element    ${EDIT_SAVEADDRESS}


Enter login credentials and click on the login button
     [Arguments]   ${username}   ${password}
      Wait and Click Element   ${HOMEPAGE_SIGNIN_LINK}
      Wait and Input Text      ${LOGIN_USERNAME_FIELD}   ${username}
      Wait and Input Text   ${LOGIN_PASSWORD_FIELD}   ${password}
      Wait and Click Element    ${SIGNIN_BUTTON}


Enter required details for new user
       #Wait and Click Element   ${CREATE_NEW_ACCOUNT_LINK}
       Enter new user firstname
       Enter new user lastname
       Enter email for creating new user
       Wait and Input Text      ${CREATEACC_PASSWORD_FIELD}      Testing123!
       Wait and Input Text      ${CREATEACC_CONFIRMPASS_FIELD}   Testing123!
       Wait and Click Element  ${CREATEACC_BTN}
       page should contain   ${LOGGEDIN_USER}



Enter required details for new user and omit firstname
       Enter new user lastname
       Enter email for creating new user
       Wait and Input Text    ${CREATEACC_PASSWORD_FIELD}      Testing123!
       Wait and Input Text      ${CREATEACC_CONFIRMPASS_FIELD}   Testing123!
       Wait and Click Element   ${CREATEACC_BTN}


Logout new user and go to create account page
      Wait and Click Element  class:action switch
      wait until element is enabled  class:authorization-link
      Wait and Click Element   class:authorization-link
      Wait and Click Element    ${CREATE_NEW_ACCOUNT_LINK}


Enter details for new user and omit required field
        [Arguments]  ${firstname}  ${lastname}  ${email}  ${password}  ${confirmpassword}
        Wait and Input Text  ${CREATEACC_FIRSTNAME_FIELD}   ${firstname}
        Wait and Input Text   ${CREATEACC_LASTNAME_FIELD}    ${lastname}
        Wait and Input Text  ${CREATEACC_EMAIL_FIELD}       ${email}
        Wait and Input Text  ${CREATEACC_PASSWORD_FIELD}    ${password}
        Wait and Input Text  ${CREATEACC_CONFIRMPASS_FIELD}  ${confirmpassword}
        Wait and Click Element  ${CREATEACC_BTN}



#Click create account button and assert that user has been created successfully
     #[Arguments]    ${new_user}
    # page should contain   Thank you for registering with Main Website Store.


Enter email for creating new user
    ${email}=  FakerLibrary.email
    Log  ${email}
    Set Test Variable  ${email}
    input text   ${CREATEACC_EMAIL_FIELD}   ${email}


Enter new user firstname
    ${firstname}=  FakerLibrary.firstname
    Log  ${firstname}
    Set Test Variable  ${firstname}
    input text   ${CREATEACC_FIRSTNAME_FIELD}   ${firstname}


Enter new user lastname
    ${lastname}=  FakerLibrary.lastname
    Log  ${lastname}
    Set Test Variable  ${lastname}
    input text   ${CREATEACC_LASTNAME_FIELD}   ${lastname}


Wait and Click Element
    [Documentation]  wait for an element to be enabled before clicking
    [Arguments]  ${locator}   ${timeout}=10s
    wait until element is enabled  ${locator}
    click element  ${locator}

Wait and Input Text
     [Documentation]  wait for an element to be enabled before inputing text
     [Arguments]  ${locator}   ${text}   ${timeout}=10s
     wait until element is enabled   ${locator}
     input text   ${locator}  ${text}





