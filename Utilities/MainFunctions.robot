*** Settings ***

Library    SeleniumLibrary
Library    FakerLibrary
Resource    ../Resources/GlobalVariables.robot
Resource    ../Resources/MainPageVariables.robot

*** Keywords ***

Launch Trendyol Main Page
    [Documentation]    ***Description:***
    ...    Robot will create Chrome Driver
    ...    *Note:*
    ...    ---
    open browser    https://www.trendyol.com/   ${BROWSER}  remote_url=${GRID_URL}    options=add_argument("--disable-popup-blocking"); add_argument("--ignore-certificate-errors"); add_argument("--disable-notifications"); add_argument("disable-infobars")
    Maximize Browser Window

    #sleep  3s
    #Execute Javascript      window.localStorage.setItem('sp-camp-4026', '{"data":{"step1-displayed":true,"viDa":1653338328,"salesLogDuration":1653424728,"closed":true,"clDa":1653338361},"_expires":1653424761000}')

Launch Browser With FireFox

    Set Screenshot Directory    ${CURDIR}/../TestsResults/${TEST_NAME}
    Open Browser    ${MP_BASE_URL}    ${FIREFOX}
    Maximize Browser Window
    Capture Page Screenshot

HeadlessChrome
    [Arguments]    ${URL}    ${alias}=None
    [Documentation]    ***Description:***
    ...    Robot will open headless chrome browser
    ...    *Note:*
    ...    Working with element id
    ...    ---
    ${chrome_options}=    Set Chrome Options
    ${ws}=    Set Variable    window-size=1920,1200
    ${disableLogging}=    Set Variable    --log-level=3
    Call Method    ${chrome_options}    add_argument    ${ws}
    Call Method    ${chrome_options}    add_argument    ${disableLogging}
    Create Webdriver    Chrome    ${alias}    chrome_options=${chrome_options}
    consolelog    Created WebDriver
    Go To    ${URL}
    Maximize Browser Window
    #Capture Page Screenshot

Open Browser with SeleniumHub
    [Arguments]    ${MP_BASE_URL}     ${CHROME}
    #Log To Console    'Using browser: ${browser}'
    #Log To Console   'Using url: ${url}'
    ${browser_options} =     Evaluate    sys.modules['selenium.webdriver'].${browser}Options()    sys, selenium.webdriver
    ${options} =     Call Method     ${browser_options}    to_capabilities
    Open Browser    ${url}    browser=${browser}    remote_url=http://localhost:4444/wd/hub    desired_capabilities=${options}
    Set Window Size       1920    1400
    Set Selenium Implicit Wait  1 seconds

Capture Page Screenshot and Get URL Information
    [Documentation]    ***Description:***
    ...    Robot will Wait element on page through timeout if
    ...    When element is exist robot will click
    ...    *Note:*
    ...    ---
    Capture Page Screenshot
    ${url}=    Get Location

Set Chrome Options
    [Documentation]    ***Description:***
    ...    Robot will set chrome arguments
    ...    *Note:*
    ...    Working with element id
    ...    ---
    ...    _Author:_ BARIS EKICI\ \ _Creation:_ 2021/06/14
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    FOR  ${option}    IN  @{chrome_arguments}
        Call Method    ${options}    add_argument    ${option}
    END
    Log  Exited
    [Return]    ${options}

CreateChrome
    [Arguments]    ${URL}    ${alias}=None
    [Documentation]    ***Description:***
    ...    Robot will open chrome browser
    ...    *Note:*
    ...    Working with element id
    ...    ---
    ${chrome_options}=    Set Chrome Options
    ${ws}=    Set Variable    window-size=1920,1200
    ${disableLogging}=    Set Variable    --log-level=3
    Call Method    ${chrome_options}    add_argument    ${ws}
    Call Method    ${chrome_options}    add_argument    ${disableLogging}
    Call Method    ${chrome_options}    set_headless    headless=False
    Create Webdriver    Chrome    ${alias}    chrome_options=${chrome_options}
    consolelog    Created WebDriver
    Go To    ${URL}  remote_url=${GRID_URL}
    Capture Page Screenshot

When Test Fail Take Screenshot
    [Documentation]    ***Description:***
    ...    When Test Fail Robot will Take a Screenshot
    ...    *Note:*
    ...    ---
    ...    _Author:_ BARIS EKICI \ \ _Creation:_ 2021/06/14
    Run Keyword If Test Failed    Capture Page Screenshot and Get URL Information
    Run Keyword If Test Failed    Close Browser
    Run Keyword If Test Passed    Close Browser

Wait And Send Text
    [Arguments]    ${element}    ${text}    ${timeout}=15 sec    ${interval}=0.5 sec
    [Documentation]    ***Description:***
    ...    Robot will Wait element on page through timeout if
    ...    When element is exist robot will Type text
    Wait For Element To Be Enabled    ${element}    ${timeout}    ${interval}
    Input Text    ${element}    ${text}

Wait For Element To Be Enabled
    [Arguments]    ${element}    ${timeout}=30 sec    ${interval}=1 sec
    [Documentation]    ***Description:***
    ...    Robot will Wait element on page through timeout
    ...    *Note:*
    ...    _Author:_ BARIS EKICI \ \ _Creation:_ 2021/06/07
    Wait Until Keyword Succeeds    ${timeout}    ${interval}    Element Should Be Enabled    ${element}
    #Capture Page Screenshot and Get URL Information

Generate Random First Name
    [Documentation]    ***Description:***
    ...    Robot will Genarate Fake First name
    ${randomFirstName}=    FakerLibrary.first_name
    [Return]    ${randomFirstName}

Generate Random Last Name
    [Documentation]    ***Description:***
    ...    Robot will Genarate Fake Last name
    ...    *Note:*
    ...    ---
    ...    _Author:_ Baris Ekici \ \ _Creation:_ 2021/06/07
    ${randomLastname}=    FakerLibrary.last_name
    [Return]    ${randomLastname}

Generate Fake Email
    [Tags]
#    DEBUG
    ${randomFirstName}=    Generate Random First Name
    ${randomLastname}=    Generate Random Last Name
    ${fakeEmail}=    set variable    ${randomFirstName}${randomLastname}@barisekici.com
    [Return]  ${fakeEmail}

Generate Fake Password
    [Tags]
    ${fakePassword}=    FakerLibrary.Password
    #Set Suite Variable  ${fakePassword}
    [Return]  ${fakePassword}

Scroll Down The Page
    Execute JavaScript   window.scrollBy(0, 4000);
