#!/bin/bash
echo "Starting App"
nohup streamlit run app.py > streamlit.log 2>&1 &
echo "Done...!"

