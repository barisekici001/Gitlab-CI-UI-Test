*** Settings ***
Library     SeleniumLibrary
Resource    ../Utilities/MainFunctions.robot
Resource    ../Utilities/MainPage.robot
Resource    ../Utilities/SignInPage.robot

Suite Teardown    Close All Browsers
Test Setup        Launch Trendyol Main Page
Test Teardown     Run Keywords
...               When Test Fail Take Screenshot
...               Close Browser

*** Test Cases ***

TC.01.Client Logs In Fake User Credentials
    [Tags]    trendyol-ui
    [Documentation]    Verify that client open browser and
    ...                go to the Trendyol Page
    ...                See https://trendyol.com/
    Verify Trendyol Main Page Opened
    Go To Sign In Page
    Verify Sign In Page Opened
    Sign In Fake User Credentials

TC.02.Client Logs In Fake User Credentials
    [Tags]    trendyol-ui
    [Documentation]    Verify that client open browser and
    ...                go to the Trendyol Page
    ...                See https://trendyol.com/
    Verify Trendyol Main Page Opened
    Go To Sign In Page
    Verify Sign In Page Opened
    Sign In Fake User Credentials

