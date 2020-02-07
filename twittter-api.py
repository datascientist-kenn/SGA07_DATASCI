#!/usr/bin/python
# -*- coding: utf-8 -*-

import json

# Creating a dictionary to store my twitter api credentials
twitter_cred = {}

#Inputing my credential details
    twitter_cred['CONSUMER_KEY'] = 'iGLGGPwbK5YP86U2eLhlm6DJS'
    twitter_cred['CONSUMER_SECRET'] = 'RLRHaEVq5NHb3PhwNEr8yf4Y0QwcNZNmjgvk5WaBMo3SSkRQY8'
    twitter_cred['ACCESS_KEY'] = '1220695170028621824-RI7ZQQCEpBuaz3rqlrsBN3TNxXmTOY'
    twitter_cred['ACCESS_SECRET'] = 'A8a8QODsZeiWnhxaWNXImNL2imrh0VnXYXRhOI6Ud1vqk'

#Saving the information to a .json file for easy and safe re-use
with open('twitter_credentials.json', 'w') as json_file:
    json.dump(twitter_cred, json_file)
