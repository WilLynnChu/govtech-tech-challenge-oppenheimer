*** Settings ***
Documentation       API Object Repository

*** Variables ***
${base_url}    http://localhost:9997
${base_api_url}    ${base_url}/api/v1
${create_hero_api}    ${base_api_url}/hero
${create_hero_voucher_api}    ${create_hero_api}/vouchers
${get_hero_owe_money_api}    ${create_hero_api}/owe-money
${get_voucher_by_person_type_api}    ${base_api_url}/voucher/by-person-and-type