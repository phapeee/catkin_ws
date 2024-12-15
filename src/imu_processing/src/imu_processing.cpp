#include <ros/ros.h>
#include <geometry_msgs/Vector3.h>
#include <tf/transform_listener.h>
#include <sensor_msgs/Imu.h>
#include "imu_processing/imu_request.h"

#define GRAVITATIONAL_ACC               (386.08858267717)       // in/s^2
#define CALIBRATION_TIME                (10)    // second
#define CALIBRATION_FAILURE             (150)
#define CALIBRATION_ATTEMP              (5)

// Global variables
geometry_msgs::Vector3Stamped acceleration;
geometry_msgs::Vector3Stamped tfAcceleration;
long double cali_acc_x;
long double cali_acc_y;
long double cali_acc_z;
double prev_acc_x;
double prev_acc_y;
double prev_acc_z;
unsigned int count;
unsigned int cali_attemp;
bool calibrating;
bool cali_failed;
bool calibrated;
bool acc_updated;
bool re_calibrating;
bool start_conversion;
double acc_scale;

void processIMU(const sensor_msgs::Imu& imu_msgs){
        if (cali_failed) return;
        geometry_msgs::Vector3 acc = imu_msgs.linear_acceleration;
        if (calibrating){
                static ros::Time timer = ros::Time::now();
                if (re_calibrating){
                        if ((ros::Time::now() - timer).toSec() >= 2.0){
                                count = 0;
                                cali_acc_x = 0;
                                cali_acc_y = 0;
                                cali_acc_z = 0;
                                re_calibrating = false;
                                timer = ros::Time::now();
                        }
                        else return;
                }
                if (count != 0 && (abs(acc.x - prev_acc_x) >= CALIBRATION_FAILURE || abs(acc.y - prev_acc_y) >= CALIBRATION_FAILURE || abs(acc.z - prev_acc_z) >= CALIBRATION_FAILURE)) {
                        ROS_ERROR("Calibration failed!");
                        if (cali_attemp < CALIBRATION_ATTEMP - 1){
                                cali_attemp++;
                                ROS_WARN("Attempting to re-calibrate! %d attemp(s) left", CALIBRATION_ATTEMP - cali_attemp);
                                re_calibrating = true;
                                timer = ros::Time::now();
                        }
                        else {
                                ROS_WARN("Unable to calibrate IMU!");
                                cali_failed = true;
                        }
                        return;
                }
                prev_acc_x = acc.x;
                prev_acc_y = acc.y;
                prev_acc_z = acc.z;
                cali_acc_x += prev_acc_x;
                cali_acc_y += prev_acc_y;
                cali_acc_z += prev_acc_z;
                count++;
                if ((ros::Time::now() - timer).toSec() > CALIBRATION_TIME){
                        cali_acc_x /= count;
                        cali_acc_y /= count;
                        cali_acc_z /= count;

                        acc_scale = GRAVITATIONAL_ACC / sqrt(pow(cali_acc_x, 2) + pow(cali_acc_y, 2) + pow(cali_acc_z, 2));

                        calibrating = false;
			calibrated = true;
                        ROS_WARN("Calibration done!");
                }
        }
        else if (start_conversion){
		if (!calibrated) {
			ROS_WARN("IMU has not been calibrated!");
			start_conversion = false;
			return;
		}
                acceleration.vector.x = acc.x * acc_scale;
                acceleration.vector.y = acc.y * acc_scale;
                acceleration.vector.z = acc.z * acc_scale;
                acc_updated = true;
//              ROS_INFO("acc_x: %.5f, acc_y: %.5f, acc_z: %.5f", acceleration.x, acceleration.y, acceleration.z);
        }
}

bool IMUservices(imu_processing::imu_request::Request& req, imu_processing::imu_request::Response& res){
	if (req.calibrate){
	        ROS_WARN("Calibrating IMU... DO NOT MOVE THE DEVICE!");
	        cali_failed = false;
	        calibrating = true;
	        re_calibrating = false;
		acc_updated = false;
	        count = 0;
	        cali_acc_x = 0;
	        cali_acc_y = 0;
	        cali_acc_z = 0;
	}
	start_conversion = req.start_conversion;
	if (req.isCalibrated) res.calibrated = calibrated;
	return true;
}


int main(int argc, char** argv){
	ros::init(argc, argv, "imu_process");
	ros::NodeHandle nh;
	ros::Rate rate(60);

	ros::ServiceServer service = nh.advertiseService("imu_process", IMUservices);
	ros::Subscriber imu_sub = nh.subscribe("imu", 100, processIMU);
	ros::Publisher acc_pub = nh.advertise<geometry_msgs::Vector3>("acceleration", 100);

	calibrated = false;
	acc_updated = false;

	tf::TransformListener listener;
	acceleration.header.frame_id = "imu_link";
	tfAcceleration.header.frame_id = "base_link";

	while(ros::ok()){
		if (acc_updated){
	                tf::StampedTransform transform;
        	        try{
                	        ros::Time lattest = ros::Time(0);
                	        listener.waitForTransform("base_link", "imu_link", lattest, ros::Duration(5.0));
                	        listener.lookupTransform("base_link", "imu_link", lattest, transform);
               		} catch (tf::TransformException &ex) {
                        	ROS_WARN("%s", ex.what());
                	}

	                acc_updated = false;
	                acceleration.header.stamp = ros::Time();
	                listener.transformVector("base_link", acceleration, tfAcceleration);
	                tfAcceleration.vector.z -= GRAVITATIONAL_ACC;
        	        acc_pub.publish(tfAcceleration.vector);
//              	ROS_INFO("acc: x=%.4f, y=%.4f, z=%.4f", acceleration.vector.x, acceleration.vector.y, acceleration.vector.z);
//              	ROS_INFO("acc: x=%.4f, y=%.4f, z=%.4f", tfAcceleration.vector.x, tfAcceleration.vector.y, tfAcceleration.vector.z);

			acc_updated = false;
		}
		ros::spinOnce();
		rate.sleep();
	}
}
