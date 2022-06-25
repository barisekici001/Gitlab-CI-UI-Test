*** Settings ***



*** Variables ***
@{BROWSERS}    firefox  chrome  IE
${CHROME}     chrome
${FIREFOX}    firefox
#@{chrome_arguments}    --disable-infobars    --disable-gpu    enable-automation    --no-sandbox    --disable-extensions    --dns-prefetch-disable    --dns-prefetch-disable
${MP_BASE_URL}    https://stagepartner.trendyol.com/

${TESTS_DIR}   tests
${GITLAB_API_VERSION}   v4
${GITLAB_USERNAME}   fxs
${GITLAB_NAME}   jfxs
${GRID_URL}   http://selenium:4444
${BROWSER}   Chrome
${RF_SENSITIVE_VARIABLE}   ${EMPTY}