*** Settings ***
Documentation       Clerk Object Repository

*** Variables ***
#Buttons
${btn_add_hero_clerk}    //button[@id='dropdownMenuButton2']
${btn_create_clerk}    //button[normalize-space()='Create']

#Dropdown
${dropdown_option_upload_csv_clerk}    //a[@class='dropdown-item' and text()='Upload a csv file']

#Labels
${lbl_header_clerk}    //h1[normalize-space()='Clerk Dashboard']
${lbl_created_success_clerk}    //div[@class='bg-success pt-2']
${lbl_created_unsuccess_warning_clerk}    //div[@class='bg-warning pt-2']

#Text Fields
${input_upload_csv_file_clerk}    //input[@id='upload-csv-file']
