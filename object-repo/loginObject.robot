*** Settings ***
Documentation       Login Object Repository
Resource    ../object-repo/apiObject.robot

*** Variables ***
#Buttons
${btn_submit_login}    //input[@type='submit']

#Labels
${lbl_header_login}    //h1[normalize-space()='Working Class Hero System']

#Text Fields
${input_username_login}    //input[@id='username-in']
${input_password_login}    //input[@id='password-in']
