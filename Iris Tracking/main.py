

import cv2
from gaze_tracking import GazeTracking

import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import time

# def get_available_cameras():
#     available_cameras = []
#     # Check for 5 cameras 
#     for i in range(5):
#         cap = cv2.VideoCapture(i)
#         if cap.isOpened():
#             available_cameras.append(i)
#             cap.release()
#     return available_cameras

# print(get_available_cameras())

gaze = GazeTracking()
webcam = cv2.VideoCapture(0)

cred = credentials.Certificate("firebase.json")  
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://smarthome-310c5-default-rtdb.asia-southeast1.firebasedatabase.app/'  
})


last_update_time = time.time()


while True:
    _, frame = webcam.read()                                

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



    if time.time() - last_update_time >= 1:
        last_update_time = time.time()

        ref = db.reference('strings')
        ref.push(eyeLocation)

    cv2.putText(frame, eyeLocation, (90, 60), cv2.FONT_HERSHEY_DUPLEX, 1.6, (0, 150, 0), 2)

    left_pupil = gaze.pupil_left_coords()
    right_pupil = gaze.pupil_right_coords()
    
    cv2.imshow("Demo", frame)

    if cv2.waitKey(1) == 27:
        break
   
webcam.release()
cv2.destroyAllWindows()
