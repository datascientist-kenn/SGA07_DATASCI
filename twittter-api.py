#!/usr/bin/python
# -*- coding: utf-8 -*-

import json

# Creating a dictionary to store my twitter api credentials
twitter_cred = {}

#Inputing my credential details
    twitter_cred['CONSUMER_KEY'] = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    twitter_cred['CONSUMER_SECRET'] = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    twitter_cred['ACCESS_KEY'] = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    twitter_cred['ACCESS_SECRET'] = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

#Saving the information to a .json file for easy and safe re-use
with open('twitter_credentials.json', 'w') as json_file:
    json.dump(twitter_cred, json_file)
