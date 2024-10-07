//#include "vector3/Vector3.h"
#include <ros/ros.h>
#include <geometry_msgs/Vector3.h>
#include <std_msgs/Float64.h>
#include <chrono>
#include <thread>

#define WHEEL_RADIUS (1.3125) // inches
#define WHEEL_DISTANCE (9.5625) // distance between 2 wheels

//Global Variables
std_msgs::Float64 right_speed; // right wheel speed
std_msgs::Float64 left_speed; // left wheel speed
double a_p;
double b_p;
double c_p;
double d_p;

void inverse_kinematic_callback(const geometry_msgs::Vector3& velocities){
	// Perform inverse kinametic from given forward velocity(velocities.y) and rotational velocity(velocities.z)
	right_speed.data = a_p * velocities.y + b_p * velocities.z;
	left_speed.data = c_p * velocities.y + d_p * velocities.z;

	// Print out speed of two wheels;
//	ROS_INFO("Left speed: %.3f, Right Speed: %.3f", left_speed.data, right_speed.data);
}

// Receive a 3D vector from topic "local_velocities", perform inverse kinematic to calculate wheel velocities of 2-Wheel drive car
int main(int argc, char **argv){
	ros::init(argc, argv, "mobile_ik");	// create a node named "mobile_ik"
	ros::NodeHandle n;	// node handler

	ros::Publisher right_wheel_publisher = n.advertise<std_msgs::Float64>("right_wheel_ang_vel", 1);
	// Publish angular velocity to /right_wheel_ang_vel topic which controls the right motor. 

	ros::Publisher left_wheel_publisher = n.advertise<std_msgs::Float64>("left_wheel_ang_vel", 1);
	// Publish angular velocity to /left_wheel_ang_vel topic which controls the left motor. 

	ros::Subscriber velocities = n.subscribe("/local_velocities", 1, inverse_kinematic_callback);
	// Subsribe to /local_veclocities topic which contains geometry_msgs/Vector3 message whose y-component is forward velocity and z-component is rotationalwq velocity.

	// Initialize car's speed to 0.
	right_speed.data = 0;
	left_speed.data = 0;

	// calulating inversed Jacobian matrix
	double a = WHEEL_RADIUS / 2;
        double b = a;
        double c = WHEEL_RADIUS / WHEEL_DISTANCE;
        double d = -c;
        double inv_det = 1 / (a*d - b*c);
        a_p = d * inv_det;
        b_p = -b * inv_det;
	c_p = -c * inv_det;
	d_p = a * inv_det;


	// main while loop
	while(ros::ok()){
		using namespace std::this_thread; // sleep_for, sleep_until
    		using namespace std::chrono; // nanoseconds, system_clock, seconds

		sleep_for(milliseconds(100));
    		//sleep_until(system_clock::now() + seconds(1));

		right_wheel_publisher.publish(right_speed);
		// publish speed for right wheel

		left_wheel_publisher.publish(left_speed);
		// publish speed for left wheel

		ros::spinOnce(); // run ros funtionalities
	}
}
