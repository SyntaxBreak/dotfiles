#!/bin/bash

song_info=$(playerctl metadata --format '{{status_icon}} {{title}}   {{player_icon}}   {{artist}}')

echo "$song_info" 
