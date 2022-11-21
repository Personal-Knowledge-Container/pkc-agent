import http.client
import urllib.request
import sys
from urllib.request import urlopen
from datetime import datetime

def send_wa_message_ext(recipient_phone_num, checked_time, server_address, checked_status):
    import requests
    import json

    # sender / receiver dari perspektif penerima WA
    req_message_template_id = "ecb20271-aea0-443e-a348-72b2c01229dc"
    req_token = get_access_token()
    req_channel_id = "e828d68b-d244-4d9c-b77f-9cda669cc76a"
    
    # endpoint URL
    url = "https://chat-service.qontak.com/api/open/v1/broadcasts/whatsapp/direct"

    payload = json.dumps({
    "to_number": recipient_phone_num,
    "to_name": "LDH Admin",
    "message_template_id": req_message_template_id,
    "channel_integration_id": req_channel_id,
    "language": {
        "code": "en"
    },
    "parameters": {
        "body": [
        {
            "key": "1",
            "value": "server_address",
            "value_text": server_address
        },
        {
            "key": "2",
            "value": "checked_time",
            "value_text": checked_time
        },  
        {
            "key": "3",
            "value": "checked_status",
            "value_text": checked_status
        }]
    }
    })
    headers = {
    'content-type': 'application/json',
    'Authorization': req_token
    }

    response = requests.request("POST", url, headers=headers, data=payload)
    return response.text        


def get_access_token():
    import requests
    import json

    # url = "https://service.qontak.com/oauth/token"
    url = "https://chat-service.qontak.com/oauth/token"

    payload = json.dumps({
    "username": "emhavis.migrasi@gmail.com",
    "password": "Password123!",
    "grant_type": "password",
    "client_id": "RRrn6uIxalR_QaHFlcKOqbjHMG63elEdPTair9B9YdY",
    "client_secret": "Sa8IGIh_HpVK1ZLAF0iFf7jU760osaUNV659pBIZR00"
    })
    headers = {
    'Content-Type': 'application/json'
    }

    response = requests.request("POST", url, headers=headers, data=payload)
    resp_dict = json.loads(response.text)
    access_token = resp_dict['access_token']

    # print(access_token)
    return access_token

def main():

    access_token = get_access_token()
    # print(access_token)
    print('Get access token')

    url_status = ''
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")

    interaction_channel_id = "e828d68b-d244-4d9c-b77f-9cda669cc76a"
    template_id = "ecb20271-aea0-443e-a348-72b2c01229dc"

    # get from arguments
    url_to_check = sys.argv[1]
    phone_num = sys.argv[2]
    web_response_code = urllib.request.urlopen(url_to_check).getcode()
    
    web_response_code = str(web_response_code)
    print('Perform Check')
    if web_response_code != '200':
        url_status = 'DOWN - Response != 200'
        print('Status != 200')
        send_wa_message_ext(phone_num, current_time, url_to_check, url_status)

    else:
        page = urlopen(url_to_check)
        html_bytes = page.read()
        html = html_bytes.decode("utf-8")
        #
        # print(html)
        #
        # print(html.find("Main Page"))
        i_main_page = html.find("Main Page")
        # print(i_main_page)
        #
        if i_main_page == -1:
            print('Server is up, but content not found')
            url_status = "Main Page not found, please check"
            send_wa_message_ext(phone_num, current_time, url_to_check, url_status)
        else:
            print('Server running ok')

if __name__ == '__main__':
    main()

# get access token
# print(data.decode("utf-8")[0])
