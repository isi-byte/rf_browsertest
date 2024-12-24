*** Settings ***
Documentation    Tests related to creating new user on luma
Library          SeleniumLibrary
Resource         MyTest_Keywords.robot
Suite Setup      Precondition for new user account



*** Test Cases ***
Verify that new user can create account
         [Tags]  Vivi
         [Setup] Precondition for new user account
         Enter required details for new user
         #[Teardown] Logout new user and go to create account page


Verify that user cannot omit firstname when creating a new account
       [Tags]  Vivi
       Enter details for new user and omit required field   ${empty}  Jane  isi09@helsinki.com  Testing123!  Testing123!
       Page should contain   This is a required field.


Verify that user cannot omit lastname when creating a new account
        [Tags]  Vivi
        reload page
        Enter details for new user and omit required field   isi  ${empty}  isi09@helsinki.com  Testing123!  Testing123!
        Page should contain   This is a required field.



Verify that user cannot omit email when creating a new account
        [Tags]  Vivi
        reload page
        Enter details for new user and omit required field    isi   Jane   ${empty}   Testing123!    Testing123!
        Page should contain   This is a required field.



Verify that user cannot omit password when creating a new account
        [Tags]  Vivi
        reload page
        Enter details for new user and omit required field   isi   Jane   isi09@helsinki.com    ${empty}   Testing123!
        Page should contain   This is a required field.



Verify that user cannot omit confirmpassword when creating a new account
        [Tags]  Vivi
        reload page
        Enter details for new user and omit required field   isi   Jane   isi09@helsinki.com   Testing123!    ${empty}
        Page should contain   This is a required field.


Verify that user can edit address details
       [Tags]  Vivi2
       [Setup]  Enter login credentials  and  click on the login button   janezoe@gmail.com  Testing123!
       Edit user address details   0465234567   2 testingkatu  Helsinki   00007



