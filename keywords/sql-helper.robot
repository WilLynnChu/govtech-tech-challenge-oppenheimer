*** Settings ***
Library    DatabaseLibrary
Library    OperatingSystem
Library    String

*** Variables ***
${DB_API}       mysql.connector
${DB_HOST}      localhost
${DB_PORT}      3306
${DB_NAME}      testdb
${DB_USER}      user
${DB_PASSWORD}  userpassword

*** Keywords ***
Query Database
    [Arguments]    ${sql_file_name}    ${args_dict}=${EMPTY}
    Connect To Database   ${DB_API}   ${DB_NAME}   ${DB_USER}   ${DB_PASSWORD}   ${DB_HOST}   ${DB_PORT}
    ${updated_sql_query}=    Update SQL Queries With Arguments Dictionary    ${sql_file_name}    ${args_dict}
    ${delete_status}=    Run Keyword And Return Status    Should Contain    ${updated_sql_query}    DELETE    ignore_case=${True}
    IF    '${delete_status}' == '${True}'
        ${json_response}=   Execute Sql String   ${updated_sql_query}
    ELSE
        ${json_response}=   Query   ${updated_sql_query}    return_dict=${True}
    END
    Disconnect From Database
    [Return]    ${json_response}

Update SQL Queries With Arguments Dictionary
    [Arguments]    ${sql_file_name}    ${args_dict}
    ${sql_query}=    Get File    ./object-repo/sql-queries/${sql_file_name}.sql
    ${empty_status}=    Run Keyword And Return Status    Should Be Equal As Strings    ${args_dict}    ${EMPTY}
    IF    '${empty_status}' == '${False}'
        IF    ${args_dict}
            FOR    ${args_key}    IN    @{args_dict}
                ${args_key_str}=    Convert To String    ${args_key}
                ${args_value_str}=    Convert To String    ${args_dict}[${args_key_str}]
                ${sql_query}=    Replace String    ${sql_query}    ${args_key_str}    ${args_value_str}
            END
        END
    END
    [Return]    ${sql_query}