#include <ros/ros.h>
#include <mecanum_ik/vector4_msg.h>
#include "mecanum_ik/mecanum_ik.h"
#include <geometry_msgs/Vector3.h>

#define V_DISTANCE (8.42188976)		// Vertical distance between 2 wheels on the same side
#define H_DISTANCE (9.85681102)		// Horizontal distance between 2 wheels on the same axle
#define WHEEL_RADIUS  (1.47637796)	// Wheel's radius

geometry_msgs::Vector3 desired_vel;
mecanum_ik::vector4_msg wheel_vel;
mecanum_ik::Mecanum4Wheels mecanum_op(WHEEL_RADIUS, V_DISTANCE, H_DISTANCE);

int main(int argc, char **argv) {
	ros::init(argc, argv, "mecanum_ik_test");
	ros::NodeHandle n;
	ros::Publisher wheel_ang_vel_publish = n.advertise<mecanum_ik::vector4_msg>("wheels_ang_vel", 1);
	desired_vel.x = 0;
	desired_vel.y = 1;
	desired_vel.z = 0;
	ROS_INFO("R: %.4f, VD: %.4f, HD: %.4f", mecanum_op.getR(), mecanum_op.getVD(), mecanum_op.getHD());
	wheel_vel = mecanum_op.getLocalSpeed(desired_vel);

	while(ros::ok())
	{
		wheel_ang_vel_publish.publish(wheel_vel);
//		ROS_INFO("TL: %.3f, TR: %.3f, BL: %.3f, BR: %.3f", wheel_vel.x, wheel_vel.y, wheel_vel.w, wheel_vel.z);
	}
}
