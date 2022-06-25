*** Settings ***

Resource    ../Utilities/MainFunctions.robot
Library         SeleniumLibrary


*** Keywords ***
Verify Trendyol Main Page Opened
    [Documentation]    Verify something
    ...
    ...                See https://trendyol.com/
    Wait Until Keyword Succeeds  10s  4s  element should be enabled  xpath=//*[@id="country-selection"]/div/div/div[2]/div[2]/select/option[1]
    click element  xpath=//*[@id="country-selection"]/div/div/div[2]/div[2]/select/option[1]
    click element  xpath=//*[@id="country-selection"]/div/div/div[2]/div[2]/select/option[2]
    click element  xpath=//*[@id="country-selection"]/div/div/div[2]/div[4]/button
    wait until element is enabled  xpath=//*[@class='header']//*[@alt='Trendyol']

Go To Sign In Page
    [Documentation]    Verify something
    ...
    ...                See https://trendyol.com/
    click element  xpath=//*[@class='link account-user']
