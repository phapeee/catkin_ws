; Auto-generated. Do not edit!


(cl:in-package imu_processing-srv)


;//! \htmlinclude imu_request-request.msg.html

(cl:defclass <imu_request-request> (roslisp-msg-protocol:ros-message)
  ((calibrate
    :reader calibrate
    :initarg :calibrate
    :type cl:boolean
    :initform cl:nil)
   (start_conversion
    :reader start_conversion
    :initarg :start_conversion
    :type cl:boolean
    :initform cl:nil)
   (isCalibrated
    :reader isCalibrated
    :initarg :isCalibrated
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass imu_request-request (<imu_request-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <imu_request-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'imu_request-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name imu_processing-srv:<imu_request-request> is deprecated: use imu_processing-srv:imu_request-request instead.")))

(cl:ensure-generic-function 'calibrate-val :lambda-list '(m))
(cl:defmethod calibrate-val ((m <imu_request-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader imu_processing-srv:calibrate-val is deprecated.  Use imu_processing-srv:calibrate instead.")
  (calibrate m))

(cl:ensure-generic-function 'start_conversion-val :lambda-list '(m))
(cl:defmethod start_conversion-val ((m <imu_request-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader imu_processing-srv:start_conversion-val is deprecated.  Use imu_processing-srv:start_conversion instead.")
  (start_conversion m))

(cl:ensure-generic-function 'isCalibrated-val :lambda-list '(m))
(cl:defmethod isCalibrated-val ((m <imu_request-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader imu_processing-srv:isCalibrated-val is deprecated.  Use imu_processing-srv:isCalibrated instead.")
  (isCalibrated m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <imu_request-request>) ostream)
  "Serializes a message object of type '<imu_request-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'calibrate) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'start_conversion) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isCalibrated) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <imu_request-request>) istream)
  "Deserializes a message object of type '<imu_request-request>"
    (cl:setf (cl:slot-value msg 'calibrate) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'start_conversion) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'isCalibrated) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<imu_request-request>)))
  "Returns string type for a service object of type '<imu_request-request>"
  "imu_processing/imu_requestRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'imu_request-request)))
  "Returns string type for a service object of type 'imu_request-request"
  "imu_processing/imu_requestRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<imu_request-request>)))
  "Returns md5sum for a message object of type '<imu_request-request>"
  "f62e73a8860f1669122b98088d03237c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'imu_request-request)))
  "Returns md5sum for a message object of type 'imu_request-request"
  "f62e73a8860f1669122b98088d03237c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<imu_request-request>)))
  "Returns full string definition for message of type '<imu_request-request>"
  (cl:format cl:nil "bool calibrate~%bool start_conversion~%bool isCalibrated~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'imu_request-request)))
  "Returns full string definition for message of type 'imu_request-request"
  (cl:format cl:nil "bool calibrate~%bool start_conversion~%bool isCalibrated~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <imu_request-request>))
  (cl:+ 0
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <imu_request-request>))
  "Converts a ROS message object to a list"
  (cl:list 'imu_request-request
    (cl:cons ':calibrate (calibrate msg))
    (cl:cons ':start_conversion (start_conversion msg))
    (cl:cons ':isCalibrated (isCalibrated msg))
))
;//! \htmlinclude imu_request-response.msg.html

(cl:defclass <imu_request-response> (roslisp-msg-protocol:ros-message)
  ((calibrated
    :reader calibrated
    :initarg :calibrated
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass imu_request-response (<imu_request-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <imu_request-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'imu_request-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name imu_processing-srv:<imu_request-response> is deprecated: use imu_processing-srv:imu_request-response instead.")))

(cl:ensure-generic-function 'calibrated-val :lambda-list '(m))
(cl:defmethod calibrated-val ((m <imu_request-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader imu_processing-srv:calibrated-val is deprecated.  Use imu_processing-srv:calibrated instead.")
  (calibrated m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <imu_request-response>) ostream)
  "Serializes a message object of type '<imu_request-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'calibrated) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <imu_request-response>) istream)
  "Deserializes a message object of type '<imu_request-response>"
    (cl:setf (cl:slot-value msg 'calibrated) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<imu_request-response>)))
  "Returns string type for a service object of type '<imu_request-response>"
  "imu_processing/imu_requestResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'imu_request-response)))
  "Returns string type for a service object of type 'imu_request-response"
  "imu_processing/imu_requestResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<imu_request-response>)))
  "Returns md5sum for a message object of type '<imu_request-response>"
  "f62e73a8860f1669122b98088d03237c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'imu_request-response)))
  "Returns md5sum for a message object of type 'imu_request-response"
  "f62e73a8860f1669122b98088d03237c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<imu_request-response>)))
  "Returns full string definition for message of type '<imu_request-response>"
  (cl:format cl:nil "bool calibrated~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'imu_request-response)))
  "Returns full string definition for message of type 'imu_request-response"
  (cl:format cl:nil "bool calibrated~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <imu_request-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <imu_request-response>))
  "Converts a ROS message object to a list"
  (cl:list 'imu_request-response
    (cl:cons ':calibrated (calibrated msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'imu_request)))
  'imu_request-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'imu_request)))
  'imu_request-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'imu_request)))
  "Returns string type for a service object of type '<imu_request>"
  "imu_processing/imu_request")