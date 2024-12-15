; Auto-generated. Do not edit!


(cl:in-package base_link-srv)


;//! \htmlinclude start_car-request.msg.html

(cl:defclass <start_car-request> (roslisp-msg-protocol:ros-message)
  ((start
    :reader start
    :initarg :start
    :type cl:boolean
    :initform cl:nil)
   (reset
    :reader reset
    :initarg :reset
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass start_car-request (<start_car-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <start_car-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'start_car-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name base_link-srv:<start_car-request> is deprecated: use base_link-srv:start_car-request instead.")))

(cl:ensure-generic-function 'start-val :lambda-list '(m))
(cl:defmethod start-val ((m <start_car-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader base_link-srv:start-val is deprecated.  Use base_link-srv:start instead.")
  (start m))

(cl:ensure-generic-function 'reset-val :lambda-list '(m))
(cl:defmethod reset-val ((m <start_car-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader base_link-srv:reset-val is deprecated.  Use base_link-srv:reset instead.")
  (reset m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <start_car-request>) ostream)
  "Serializes a message object of type '<start_car-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'start) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'reset) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <start_car-request>) istream)
  "Deserializes a message object of type '<start_car-request>"
    (cl:setf (cl:slot-value msg 'start) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'reset) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<start_car-request>)))
  "Returns string type for a service object of type '<start_car-request>"
  "base_link/start_carRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'start_car-request)))
  "Returns string type for a service object of type 'start_car-request"
  "base_link/start_carRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<start_car-request>)))
  "Returns md5sum for a message object of type '<start_car-request>"
  "25b7112e38c3a73795d5458eaa302398")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'start_car-request)))
  "Returns md5sum for a message object of type 'start_car-request"
  "25b7112e38c3a73795d5458eaa302398")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<start_car-request>)))
  "Returns full string definition for message of type '<start_car-request>"
  (cl:format cl:nil "bool start~%bool reset~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'start_car-request)))
  "Returns full string definition for message of type 'start_car-request"
  (cl:format cl:nil "bool start~%bool reset~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <start_car-request>))
  (cl:+ 0
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <start_car-request>))
  "Converts a ROS message object to a list"
  (cl:list 'start_car-request
    (cl:cons ':start (start msg))
    (cl:cons ':reset (reset msg))
))
;//! \htmlinclude start_car-response.msg.html

(cl:defclass <start_car-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass start_car-response (<start_car-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <start_car-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'start_car-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name base_link-srv:<start_car-response> is deprecated: use base_link-srv:start_car-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <start_car-response>) ostream)
  "Serializes a message object of type '<start_car-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <start_car-response>) istream)
  "Deserializes a message object of type '<start_car-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<start_car-response>)))
  "Returns string type for a service object of type '<start_car-response>"
  "base_link/start_carResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'start_car-response)))
  "Returns string type for a service object of type 'start_car-response"
  "base_link/start_carResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<start_car-response>)))
  "Returns md5sum for a message object of type '<start_car-response>"
  "25b7112e38c3a73795d5458eaa302398")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'start_car-response)))
  "Returns md5sum for a message object of type 'start_car-response"
  "25b7112e38c3a73795d5458eaa302398")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<start_car-response>)))
  "Returns full string definition for message of type '<start_car-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'start_car-response)))
  "Returns full string definition for message of type 'start_car-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <start_car-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <start_car-response>))
  "Converts a ROS message object to a list"
  (cl:list 'start_car-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'start_car)))
  'start_car-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'start_car)))
  'start_car-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'start_car)))
  "Returns string type for a service object of type '<start_car>"
  "base_link/start_car")