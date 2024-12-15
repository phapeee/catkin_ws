;; Auto-generated. Do not edit!


(when (boundp 'base_link::start_car)
  (if (not (find-package "BASE_LINK"))
    (make-package "BASE_LINK"))
  (shadow 'start_car (find-package "BASE_LINK")))
(unless (find-package "BASE_LINK::START_CAR")
  (make-package "BASE_LINK::START_CAR"))
(unless (find-package "BASE_LINK::START_CARREQUEST")
  (make-package "BASE_LINK::START_CARREQUEST"))
(unless (find-package "BASE_LINK::START_CARRESPONSE")
  (make-package "BASE_LINK::START_CARRESPONSE"))

(in-package "ROS")





(defclass base_link::start_carRequest
  :super ros::object
  :slots (_start _reset ))

(defmethod base_link::start_carRequest
  (:init
   (&key
    ((:start __start) nil)
    ((:reset __reset) nil)
    )
   (send-super :init)
   (setq _start __start)
   (setq _reset __reset)
   self)
  (:start
   (&optional (__start :null))
   (if (not (eq __start :null)) (setq _start __start)) _start)
  (:reset
   (&optional (__reset :null))
   (if (not (eq __reset :null)) (setq _reset __reset)) _reset)
  (:serialization-length
   ()
   (+
    ;; bool _start
    1
    ;; bool _reset
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _start
       (if _start (write-byte -1 s) (write-byte 0 s))
     ;; bool _reset
       (if _reset (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _start
     (setq _start (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _reset
     (setq _reset (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass base_link::start_carResponse
  :super ros::object
  :slots ())

(defmethod base_link::start_carResponse
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass base_link::start_car
  :super ros::object
  :slots ())

(setf (get base_link::start_car :md5sum-) "25b7112e38c3a73795d5458eaa302398")
(setf (get base_link::start_car :datatype-) "base_link/start_car")
(setf (get base_link::start_car :request) base_link::start_carRequest)
(setf (get base_link::start_car :response) base_link::start_carResponse)

(defmethod base_link::start_carRequest
  (:response () (instance base_link::start_carResponse :init)))

(setf (get base_link::start_carRequest :md5sum-) "25b7112e38c3a73795d5458eaa302398")
(setf (get base_link::start_carRequest :datatype-) "base_link/start_carRequest")
(setf (get base_link::start_carRequest :definition-)
      "bool start
bool reset
---

")

(setf (get base_link::start_carResponse :md5sum-) "25b7112e38c3a73795d5458eaa302398")
(setf (get base_link::start_carResponse :datatype-) "base_link/start_carResponse")
(setf (get base_link::start_carResponse :definition-)
      "bool start
bool reset
---

")



(provide :base_link/start_car "25b7112e38c3a73795d5458eaa302398")


