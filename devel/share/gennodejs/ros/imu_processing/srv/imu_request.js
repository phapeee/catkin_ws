// Auto-generated. Do not edit!

// (in-package imu_processing.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class imu_requestRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.calibrate = null;
      this.start_conversion = null;
      this.isCalibrated = null;
    }
    else {
      if (initObj.hasOwnProperty('calibrate')) {
        this.calibrate = initObj.calibrate
      }
      else {
        this.calibrate = false;
      }
      if (initObj.hasOwnProperty('start_conversion')) {
        this.start_conversion = initObj.start_conversion
      }
      else {
        this.start_conversion = false;
      }
      if (initObj.hasOwnProperty('isCalibrated')) {
        this.isCalibrated = initObj.isCalibrated
      }
      else {
        this.isCalibrated = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type imu_requestRequest
    // Serialize message field [calibrate]
    bufferOffset = _serializer.bool(obj.calibrate, buffer, bufferOffset);
    // Serialize message field [start_conversion]
    bufferOffset = _serializer.bool(obj.start_conversion, buffer, bufferOffset);
    // Serialize message field [isCalibrated]
    bufferOffset = _serializer.bool(obj.isCalibrated, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type imu_requestRequest
    let len;
    let data = new imu_requestRequest(null);
    // Deserialize message field [calibrate]
    data.calibrate = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [start_conversion]
    data.start_conversion = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [isCalibrated]
    data.isCalibrated = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 3;
  }

  static datatype() {
    // Returns string type for a service object
    return 'imu_processing/imu_requestRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '0f813b7b5dae5791c52992bacb5a1150';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool calibrate
    bool start_conversion
    bool isCalibrated
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new imu_requestRequest(null);
    if (msg.calibrate !== undefined) {
      resolved.calibrate = msg.calibrate;
    }
    else {
      resolved.calibrate = false
    }

    if (msg.start_conversion !== undefined) {
      resolved.start_conversion = msg.start_conversion;
    }
    else {
      resolved.start_conversion = false
    }

    if (msg.isCalibrated !== undefined) {
      resolved.isCalibrated = msg.isCalibrated;
    }
    else {
      resolved.isCalibrated = false
    }

    return resolved;
    }
};

class imu_requestResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.calibrated = null;
    }
    else {
      if (initObj.hasOwnProperty('calibrated')) {
        this.calibrated = initObj.calibrated
      }
      else {
        this.calibrated = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type imu_requestResponse
    // Serialize message field [calibrated]
    bufferOffset = _serializer.bool(obj.calibrated, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type imu_requestResponse
    let len;
    let data = new imu_requestResponse(null);
    // Deserialize message field [calibrated]
    data.calibrated = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'imu_processing/imu_requestResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '57ce5b1e5005f046a42a167a2178463c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool calibrated
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new imu_requestResponse(null);
    if (msg.calibrated !== undefined) {
      resolved.calibrated = msg.calibrated;
    }
    else {
      resolved.calibrated = false
    }

    return resolved;
    }
};

module.exports = {
  Request: imu_requestRequest,
  Response: imu_requestResponse,
  md5sum() { return 'f62e73a8860f1669122b98088d03237c'; },
  datatype() { return 'imu_processing/imu_request'; }
};
