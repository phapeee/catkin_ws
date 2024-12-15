#include <ros/ros.h>
#include <geometry_msgs/Vector3.h>
#include <pose_est/pose_est_msg.h>
#include <cmath>

#define IDLE		(0)
#define ALIGNMENT	(1)
#define FORWARD		(2)
#define STOP		(3)
#define RESET		(4)
#define WAIT		(5)
#define ROTATE		(6)

#define ACC		(1)
#define CONST		(2)
#define DEACC		(3)
#define PRE_ACC		(4)

#define WAIT_TIME	(1)

#define MAX_LIN_VEL	(3.0)
#define MAX_ANG_VEL	((double) 10*M_PI/180)
#define LIN_ACC_KICK	(0.1)
#define ANG_ACC_KICK	(0.03)
#define H_PI		(M_PI / 2)
#define F_PI		(M_PI * 2)
#define LIN_ACC_RANGE	(3)
#define ANG_ACC_RANGE	((double) 20*M_PI/180)
#define STOP_LIN_RANGE	(0.1)
#define STOP_ANG_RANGE	(0.01)
#define LIN_COEFF	(M_PI/LIN_ACC_RANGE)
#define ANG_COEFF	(M_PI/ANG_ACC_RANGE)

geometry_msgs::Vector3 desired_pose;
geometry_msgs::Point curr_pose;
geometry_msgs::Vector3 curr_dist;
geometry_msgs::Vector3 normal_vec;
double dist_mag;

//auto smoothLinAcc = [](double d, bool is_acc, double max_vel) {return ((max_vel - is_acc * LIN_ACC_KICK) * sin(LIN_COEFF * d - H_PI) + is_acc * LIN_ACC_KICK + max_vel) / 2;};
auto smoothLinAcc = [](double d) {return d * (1 - LIN_ACC_KICK) / LIN_ACC_RANGE + LIN_ACC_KICK;};
///auto smoothAngAcc = [](double a, bool is_acc, double max_vel) {return ((max_vel - is_acc * ANG_ACC_KICK) * sin(ANG_COEFF * a - H_PI) + is_acc * ANG_ACC_KICK + max_vel) / 2;};
auto smoothAngAcc = [](double a) {return a * (1 - ANG_ACC_KICK) / ANG_ACC_RANGE + ANG_ACC_KICK;};
auto vec_mag = [](geometry_msgs::Vector3 vec) {return sqrt(pow(vec.x, 2) + pow(vec.y, 2));};
auto dot_pro = [](geometry_msgs::Vector3 vec1, geometry_msgs::Vector3 vec2) {return vec1.x * vec2.x + vec1.y * vec2.y;};

char movement_state;
char acc_state;

void pose_ctl_callback(const geometry_msgs::Vector3 &new_desired_pose){
	desired_pose.x = new_desired_pose.x + curr_pose.x;
	desired_pose.y = new_desired_pose.y + curr_pose.y;
	desired_pose.z = new_desired_pose.z;
	movement_state = RESET;
}

void update_pose(const pose_est::pose_est_msg &new_pose){
	//ROS_INFO("x: %.4f, y: %.4f, z: %.4f", new_pose.point.x, new_pose.point.y, new_pose.point.z);
	curr_dist.x = desired_pose.x - new_pose.point.x;
	curr_dist.y = desired_pose.y - new_pose.point.y;
	curr_dist.z = new_pose.point.z;
	curr_pose = new_pose.point;
	normal_vec.x = cos(new_pose.point.z);
	normal_vec.y = sin(new_pose.point.z);
	dist_mag = sqrt(pow(curr_dist.x, 2) + pow(curr_dist.y, 2));
}

double go_forward(){
	static double start_dist;
	static double max_vel;
	double temp;

	switch(acc_state){
		case CONST:
			if (dist_mag <= LIN_ACC_RANGE) acc_state = DEACC;
			return max_vel;
		case PRE_ACC:
			start_dist = dist_mag;
			acc_state = ACC;
		case ACC:
			temp = start_dist - dist_mag;
			//max_vel = smoothLinAcc(temp, true, MAX_LIN_VEL);
			max_vel = MAX_LIN_VEL;
			if (temp >= LIN_ACC_RANGE) {
				acc_state = CONST;
				max_vel = MAX_LIN_VEL;
			}
			if (dist_mag <= LIN_ACC_RANGE) acc_state = DEACC;
			return std::min(max_vel * smoothLinAcc(dist_mag), MAX_LIN_VEL);
		case DEACC:
			temp = dot_pro(normal_vec, curr_dist) / (vec_mag(normal_vec) * vec_mag(curr_dist));
			ROS_INFO("%.4f, dist_mag: %.4f, x: %.4f, y: %.4f", temp, dist_mag, curr_pose.x, curr_pose.y);
			if (dist_mag <= STOP_LIN_RANGE) acc_state = IDLE;
			//else return smoothLinAcc(dist_mag, false, max_vel) * (temp > 0 ? 1 : -1);
			else return std::min(max_vel * smoothLinAcc(dist_mag), MAX_LIN_VEL) * (temp > 0 ? 1 : -1);
		default: return 0;
	}
}

double rotate(double target_angle, bool non_stop){
	double ang_diff = target_angle - curr_dist.z;
	static double start_angle;
	static double max_vel;
	double temp;
	double direction;

	if (ang_diff > M_PI) ang_diff -= F_PI;
	else if (ang_diff < -M_PI) ang_diff += F_PI;
	direction = ang_diff > 0 ? 1 : (ang_diff < 0 ? -1 : 0);
	ang_diff = abs(ang_diff);

	switch(acc_state){
		case CONST:
			if (ang_diff <= ANG_ACC_RANGE) acc_state = DEACC;
			return max_vel * direction;
		case PRE_ACC:
			start_angle = ang_diff;
			acc_state = ACC;
		case ACC:
			temp = start_angle - ang_diff;
			//max_vel = smoothAngAcc(temp, true, MAX_ANG_VEL) * direction;
			max_vel = MAX_ANG_VEL;
			if (abs(temp) >= ANG_ACC_RANGE) {
				acc_state = CONST;
				max_vel = MAX_ANG_VEL;
			}
			if (ang_diff <= ANG_ACC_RANGE) acc_state = DEACC;
			return max_vel * direction;
		case DEACC:
			if (!non_stop && ang_diff <= STOP_ANG_RANGE) {
				acc_state = IDLE;
			}
//			else return  smoothAngAcc(ang_diff, false, max_vel) * direction;
			else return max_vel * smoothAngAcc(ang_diff) * direction;
		default: return 0;
	}

}

int main(int argc, char** argv){
	ros::init(argc, argv, "pose_controller");
	ros::NodeHandle nh;
	ros::Rate rate(40);
	ros::Publisher local_vel_pub = nh.advertise<geometry_msgs::Vector3>("local_velocities", 1);
	ros::Subscriber pose_est_sub = nh.subscribe("pose_est", 1, update_pose);
	ros::Subscriber pose_ctl_sub = nh.subscribe("pose_controller", 1, pose_ctl_callback);

	geometry_msgs::Vector3 local_vel;
	movement_state = STOP;
	ros::Time timer;

	while(ros::ok()){
		switch(movement_state){
			case ALIGNMENT:
				local_vel.z = rotate(atan2(curr_dist.y, curr_dist.x), false);
				local_vel_pub.publish(local_vel);
				if (acc_state == IDLE) {
					acc_state = PRE_ACC;
					movement_state = FORWARD;
				}
				break;
			case FORWARD:
				local_vel.y = go_forward();
				local_vel.z = rotate(atan2(curr_dist.y, curr_dist.x), true);
				local_vel_pub.publish(local_vel);
				if (acc_state == IDLE) {
					acc_state = PRE_ACC;
					movement_state = ROTATE;
				}
				break;
			case ROTATE:
				local_vel.z = rotate(desired_pose.z, false);
				local_vel_pub.publish(local_vel);
				if (acc_state == IDLE){
					movement_state = STOP;
				}
				break;
			case RESET:
				timer = ros::Time::now();
				movement_state = WAIT;
			case STOP:
				local_vel.y = 0;
				local_vel.z = 0;
				local_vel_pub.publish(local_vel);
				if (movement_state != WAIT) movement_state = IDLE;
				break;
			case WAIT:
				if ((ros::Time::now() - timer).toSec() >= WAIT_TIME) {
					movement_state = ALIGNMENT;
					acc_state = PRE_ACC;
				}
				break;
			default: break;
		}
		ros::spinOnce();
		//rate.sleep();
	}
}
