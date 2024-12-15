
(cl:in-package :asdf)

(defsystem "imu_processing-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "imu_request" :depends-on ("_package_imu_request"))
    (:file "_package_imu_request" :depends-on ("_package"))
  ))