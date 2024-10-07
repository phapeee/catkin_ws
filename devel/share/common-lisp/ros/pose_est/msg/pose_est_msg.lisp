; Auto-generated. Do not edit!


(cl:in-package pose_est-msg)


;//! \htmlinclude pose_est_msg.msg.html

(cl:defclass <pose_est_msg> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (point
    :reader point
    :initarg :point
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point)))
)

(cl:defclass pose_est_msg (<pose_est_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pose_est_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pose_est_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name pose_est-msg:<pose_est_msg> is deprecated: use pose_est-msg:pose_est_msg instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <pose_est_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pose_est-msg:header-val is deprecated.  Use pose_est-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <pose_est_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pose_est-msg:name-val is deprecated.  Use pose_est-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <pose_est_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pose_est-msg:id-val is deprecated.  Use pose_est-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'point-val :lambda-list '(m))
(cl:defmethod point-val ((m <pose_est_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pose_est-msg:point-val is deprecated.  Use pose_est-msg:point instead.")
  (point m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pose_est_msg>) ostream)
  "Serializes a message object of type '<pose_est_msg>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'point) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pose_est_msg>) istream)
  "Deserializes a message object of type '<pose_est_msg>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'point) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pose_est_msg>)))
  "Returns string type for a message object of type '<pose_est_msg>"
  "pose_est/pose_est_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pose_est_msg)))
  "Returns string type for a message object of type 'pose_est_msg"
  "pose_est/pose_est_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pose_est_msg>)))
  "Returns md5sum for a message object of type '<pose_est_msg>"
  "08fd9b71ae659c640c4aa0550e3db897")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pose_est_msg)))
  "Returns md5sum for a message object of type 'pose_est_msg"
  "08fd9b71ae659c640c4aa0550e3db897")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pose_est_msg>)))
  "Returns full string definition for message of type '<pose_est_msg>"
  (cl:format cl:nil "Header header~%string name~%int32 id~%geometry_msgs/Point point~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pose_est_msg)))
  "Returns full string definition for message of type 'pose_est_msg"
  (cl:format cl:nil "Header header~%string name~%int32 id~%geometry_msgs/Point point~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pose_est_msg>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:length (cl:slot-value msg 'name))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'point))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pose_est_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'pose_est_msg
    (cl:cons ':header (header msg))
    (cl:cons ':name (name msg))
    (cl:cons ':id (id msg))
    (cl:cons ':point (point msg))
))
