*** Setting ***
# Run script robot Todaolist.robot
Library           SeleniumLibrary
Library           Collections

Test Setup        Set up 
Test Teardown     Close Browser

*** Variables ***
${URL}            https://abhigyank.github.io/To-Do-List/
${Task1}          Buy groceries
${Task2}          Finish homework
${Task3}          Call mom
${Task4}          works out
${AddItemButton}  //*[@class="material-icons"][normalize-space()='add']
${AddItem}        //*[@href="#todo"]  

*** Test Cases ***
Test Adding New Tasks
    [Tags]    @AddingTasks
    [Setup]   Open Todo List Page
    Add Task  ${Task1}

Test Marking Tasks as Completed
    [Tags]    @CompletingTasks
    [Setup]   Open Todo List Page
    Add Task  ${Task2}
    Mark Task as Completed  ${Task2}


Test Deleting Tasks
    [Tags]    @DeletingTasks
    [Setup]   Open Todo List Page
    Add Task  ${Task3}
    Delete Task  ${Task3}


Test Deleting completed task
    [Tags]     @DeletingCompleated 
    [Setup]    Open Todo List Page
    Add Task    ${Task4}
    Mark Task as Completed     ${Task4}
    Delete Completed Task      ${Task4}


    

    
*** Keywords ***
Set up 
    Open Browser    ${URL}    chrome
    # Set Selenium Speed     .2S

Open Todo List Page
    Open Browser    ${URL}    Chrome 
    Wait Until Page Contains Element    id=new-task

Add Task
    [Arguments]    ${task}
    Input Text    id=new-task    ${task}
    # Press Keys    id=new-task    //3
    Wait Until Element Is Visible    ${AddItemButton}     timeout=10s  
    Click Element    ${AddItemButton} 

Mark Task as Completed
    [Arguments]    ${task}
    Wait Until Element Is Visible    ${AddItem}      timeout=10s
    Click Element    ${AddItem}  
    Wait Until Element Is Visible    //*[@id="text-1"]   timeout=10s
    Click Element    //*[@class="mdl-checkbox__label"]
    Wait Until Element Is Visible    //*[@href="#completed"]    timeout=10s
    Click Element    //*[@href="#completed"] 


Delete Task
    [Arguments]    ${task}
    Wait Until Element Is Visible    //*[@href="#todo"]    timeout=10s
    Click Element    //*[@href="#todo"]
    Wait Until Element Is Visible    //*[@id="todo"]//*[@for="1"]/following-sibling::*[contains(@class,'delete')][text()='Delete']    timeout=10s
    Click Button    //*[@id="todo"]//*[@for="1"]/following-sibling::*[contains(@class,'delete')][text()='Delete']
    Wait Until Element Is Visible     //*[@href="#completed"]    timeout=10s
    Click Element    //*[@href="#completed"] 


Delete Completed Task      
    [Arguments]    ${task}
    Wait Until Element Is Visible    //*[@href="#completed"]     timeout=10s
    Click Element    //*[@href="#completed"] 
    Wait Until Element Is Visible    //*[@id="completed"]//*[@id="completed-tasks"]//*[text()='${task}']/following-sibling::*[contains(@class,'delete')]    timeout=10s
    Click Element    //button[contains(@class, 'mdl-button') and contains(@class, 'delete') and contains(text(), 'Delete')]