
(cl:in-package :asdf)

(defsystem "base_link-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "start_car" :depends-on ("_package_start_car"))
    (:file "_package_start_car" :depends-on ("_package"))
  ))