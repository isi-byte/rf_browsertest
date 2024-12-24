*** Settings ***
Documentation    Automate API responses for pet store
Library          RequestsLibrary
Library          JSONLibrary
Library          BuiltIn
Library          Collections


*** Test Cases ***
Get pet by status
    [Documentation]  This test should get pets by status
    create session   My session    https://petstore.swagger.io/v2    verify=true
    ${response}= GET ON SESSION   My session   /pet/findByStatus?    params=status=available
    status should be   200    ${response}