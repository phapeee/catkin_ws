;; Auto-generated. Do not edit!


(when (boundp 'imu_processing::imu_request)
  (if (not (find-package "IMU_PROCESSING"))
    (make-package "IMU_PROCESSING"))
  (shadow 'imu_request (find-package "IMU_PROCESSING")))
(unless (find-package "IMU_PROCESSING::IMU_REQUEST")
  (make-package "IMU_PROCESSING::IMU_REQUEST"))
(unless (find-package "IMU_PROCESSING::IMU_REQUESTREQUEST")
  (make-package "IMU_PROCESSING::IMU_REQUESTREQUEST"))
(unless (find-package "IMU_PROCESSING::IMU_REQUESTRESPONSE")
  (make-package "IMU_PROCESSING::IMU_REQUESTRESPONSE"))

(in-package "ROS")





(defclass imu_processing::imu_requestRequest
  :super ros::object
  :slots (_calibrate _start_conversion _isCalibrated ))

(defmethod imu_processing::imu_requestRequest
  (:init
   (&key
    ((:calibrate __calibrate) nil)
    ((:start_conversion __start_conversion) nil)
    ((:isCalibrated __isCalibrated) nil)
    )
   (send-super :init)
   (setq _calibrate __calibrate)
   (setq _start_conversion __start_conversion)
   (setq _isCalibrated __isCalibrated)
   self)
  (:calibrate
   (&optional (__calibrate :null))
   (if (not (eq __calibrate :null)) (setq _calibrate __calibrate)) _calibrate)
  (:start_conversion
   (&optional (__start_conversion :null))
   (if (not (eq __start_conversion :null)) (setq _start_conversion __start_conversion)) _start_conversion)
  (:isCalibrated
   (&optional (__isCalibrated :null))
   (if (not (eq __isCalibrated :null)) (setq _isCalibrated __isCalibrated)) _isCalibrated)
  (:serialization-length
   ()
   (+
    ;; bool _calibrate
    1
    ;; bool _start_conversion
    1
    ;; bool _isCalibrated
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _calibrate
       (if _calibrate (write-byte -1 s) (write-byte 0 s))
     ;; bool _start_conversion
       (if _start_conversion (write-byte -1 s) (write-byte 0 s))
     ;; bool _isCalibrated
       (if _isCalibrated (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _calibrate
     (setq _calibrate (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _start_conversion
     (setq _start_conversion (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _isCalibrated
     (setq _isCalibrated (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass imu_processing::imu_requestResponse
  :super ros::object
  :slots (_calibrated ))

(defmethod imu_processing::imu_requestResponse
  (:init
   (&key
    ((:calibrated __calibrated) nil)
    )
   (send-super :init)
   (setq _calibrated __calibrated)
   self)
  (:calibrated
   (&optional (__calibrated :null))
   (if (not (eq __calibrated :null)) (setq _calibrated __calibrated)) _calibrated)
  (:serialization-length
   ()
   (+
    ;; bool _calibrated
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _calibrated
       (if _calibrated (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _calibrated
     (setq _calibrated (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass imu_processing::imu_request
  :super ros::object
  :slots ())

(setf (get imu_processing::imu_request :md5sum-) "f62e73a8860f1669122b98088d03237c")
(setf (get imu_processing::imu_request :datatype-) "imu_processing/imu_request")
(setf (get imu_processing::imu_request :request) imu_processing::imu_requestRequest)
(setf (get imu_processing::imu_request :response) imu_processing::imu_requestResponse)

(defmethod imu_processing::imu_requestRequest
  (:response () (instance imu_processing::imu_requestResponse :init)))

(setf (get imu_processing::imu_requestRequest :md5sum-) "f62e73a8860f1669122b98088d03237c")
(setf (get imu_processing::imu_requestRequest :datatype-) "imu_processing/imu_requestRequest")
(setf (get imu_processing::imu_requestRequest :definition-)
      "bool calibrate
bool start_conversion
bool isCalibrated
---
bool calibrated

")

(setf (get imu_processing::imu_requestResponse :md5sum-) "f62e73a8860f1669122b98088d03237c")
(setf (get imu_processing::imu_requestResponse :datatype-) "imu_processing/imu_requestResponse")
(setf (get imu_processing::imu_requestResponse :definition-)
      "bool calibrate
bool start_conversion
bool isCalibrated
---
bool calibrated

")



(provide :imu_processing/imu_request "f62e73a8860f1669122b98088d03237c")


