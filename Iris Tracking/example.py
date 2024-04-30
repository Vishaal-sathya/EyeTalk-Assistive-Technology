"""
Demonstration of the GazeTracking library.
Check the README.md for complete documentation.
"""

import cv2
from gaze_tracking import GazeTracking

import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import time



gaze = GazeTracking()
webcam = cv2.VideoCapture(2)

cred = credentials.Certificate("firebase.json")  # Replace with your service account key file
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://iris-b4d9f-default-rtdb.asia-southeast1.firebasedatabase.app/'  # Replace with your database URL
})


last_update_time = time.time()


while True:
    # We get a new frame from the webcam
    _, frame = webcam.read()                                

    # We send this frame to GazeTracking to analyze it
    gaze.refresh(frame)

    frame = gaze.annotated_frame()
    eyeLocation = ""

    if gaze.is_blinking():
        eyeLocation = "Looking down"
    elif gaze.is_right():
        eyeLocation = "Looking right"
    elif gaze.is_left():
        eyeLocation = "Looking left"
    elif gaze.is_center():
        eyeLocation = "Looking center"



#time limit of the database push
    if time.time() - last_update_time >= 4:
        # Update the last update time
        last_update_time = time.time()

        # Push the changingString to the database
        ref = db.reference('strings')
        ref.push(eyeLocation)
        ref.push("")

    cv2.putText(frame, eyeLocation, (90, 60), cv2.FONT_HERSHEY_DUPLEX, 1.6, (0, 150, 0), 2)

    left_pupil = gaze.pupil_left_coords()
    right_pupil = gaze.pupil_right_coords()
    cv2.putText(frame, "Left pupil:  " + str(left_pupil), (90, 130), cv2.FONT_HERSHEY_DUPLEX, 0.9, (147, 58, 31), 1)
    cv2.putText(frame, "Right pupil: " + str(right_pupil), (90, 165), cv2.FONT_HERSHEY_DUPLEX, 0.9, (147, 58, 31), 1)

    cv2.imshow("Demo", frame)

    if cv2.waitKey(1) == 27:
        break
   
webcam.release()
cv2.destroyAllWindows()
