from flask import Flask, request, jsonify
import cv2
from gaze_tracking import GazeTracking  # Assuming gaze_tracking.py is in the same directory

import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import time
import numpy as np

# Initialize Firebase app (credentials setup needed)
firebase_admin.initialize_app(credentials.Certificate("firebase.json"))

app = Flask(__name__)

gaze = GazeTracking()

@app.route('/process_video', methods=['POST'])
def process_video():
    # Retrieve video data from request
    video_bytes = request.get_data()

    # Decode video bytes into a frame (assuming a single frame is sent)
    frame = cv2.imdecode(np.fromstring(video_bytes, np.uint8), cv2.IMREAD_COLOR)

    # Process video frame using GazeTracking
    gaze.refresh(frame)
    eye_location = ""

    if gaze.is_blinking():
        eye_location = "Looking down"
    elif gaze.is_right():
        eye_location = "Looking right"
    elif gaze.is_left():
        eye_location = "Looking left"
    elif gaze.is_center():
        eye_location = "Looking center"

    # Update Firebase with eye location (replace with actual write operation)
    ref = db.reference('strings')
    ref.push(eye_location)
    ref.push("")  # Assuming you still need this empty push

    # Return response to Flutter
    return jsonify({'eye_location': eye_location}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
