*** Settings ***

Resource    ../Utilities/MainFunctions.robot

*** Keywords ***
Verify Sign In Page Opened
    [Documentation]    Verify something
    ...
    ...                See https://trendyol.com/
    Wait Until Keyword Succeeds  10s  4s  element should be enabled  xpath=//*[@class='q-layout lr-header']

Sign In Fake User Credentials
    ${fakeEmail}=  Generate Fake Email
    ${fakePassword}=  Generate Fake Password
    wait and send text  //*[@data-testid="email-input"]  ${fakeEmail}
    wait and send text  //*[@data-testid="password-input"]  ${fakePassword}
    click element  //*[@type='submit']
    sleep  3s