#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include "base_link/start_car.h"

#define TIME_STEP	(0.05)	// in sec

tf::Transform base_link_tf;
bool begin;
bool init;
tf::Vector3 prev_vel(0, 0, 0);
tf::Vector3 prev_acc(0, 0, 0);
auto average = [](double x1, double x2, double delta){
	return (x1 + x2) * delta / 2;
};

tf::Vector3 integrate(tf::Vector3 prev_step, tf::Vector3 curr_step, tf::Vector3 input, double delta){
	tf::Vector3 output;
	output.setX(input.x() + average(prev_step.x(), curr_step.x(), delta));
	output.setY(input.y() + average(prev_step.y(), curr_step.y(), delta));
	output.setZ(input.z() + average(prev_step.z(), curr_step.z(), delta));
	return output;
}

void acc_callback(const geometry_msgs::Vector3& acc_msg){
	static tf::TransformBroadcaster br;
	if (!begin) return;
	tf::Vector3 curr_acc(acc_msg.x, acc_msg.y, acc_msg.z);
	tf::Vector3 curr_vel = integrate(prev_acc, curr_acc, prev_vel, TIME_STEP);
	base_link_tf.setOrigin(integrate(prev_vel, curr_vel, base_link_tf.getOrigin(), TIME_STEP));
	br.sendTransform(tf::StampedTransform(base_link_tf, ros::Time::now(), "world_map", "base_link_tf"));

	prev_vel = curr_vel;
	prev_acc = curr_acc;
}

bool start(base_link::start_car::Request &req, base_link::start_car::Response &res){
	begin = req.start;
	if (req.reset){
		tf::TransformBroadcaster br;
		prev_vel.setZero();
		prev_acc.setZero();
		base_link_tf.setOrigin(tf::Vector3(0, 0, 0));
		br.sendTransform(tf::StampedTransform(base_link_tf, ros::Time::now(), "world_map", "base_link_tf"));
	}
	return true;
}


int main(int argc, char** argv){
	ros::init(argc, argv, "base_link_tf");
	ros::NodeHandle nh;

	ros::Subscriber acc_sub = nh.subscribe("acceleration", 10, &acc_callback);
	ros::ServiceServer service = nh.advertiseService("start_car", start);

	base_link_tf.setRotation(tf::Quaternion(0, 0, 0, 1));
	base_link_tf.setOrigin(tf::Vector3(0, 0, 0));
	begin = false;

	ros::spin();
}
