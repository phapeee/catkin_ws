#define STATE_STRING        "Khuong's Bot"
#define SAMPLING_PERIOD (0.05) // time between the speed encoders sample and publish the 2 wheels' position
#define WHEEL_RADIUS (1.3125) // wheels' radius in inches
#define WHEEL_DISTANCE (9.5625) // distance between 2 wheels

#include <ros/ros.h>
#include <pose_est/pose_est_msg.h> // Include the .h file that is creates from your .msg file
#include <std_msgs/Float64.h>
#include <cmath>

pose_est::pose_est_msg pose_est_out; // Creates a variable to hold the publishable data
std_msgs::Float64 right_wheel_pos; // Variable holds right wheel's current position in radian.
std_msgs::Float64 left_wheel_pos; // Variable holds left wheel's current position in radian.
double right_wheel_ang_vel;  // variable holds calculated right wheel's angular velocity in rad/s
double left_wheel_ang_vel; // variable holds calculated left wheel's angular velocity in rad/s

// variables indicate the first wheels' position are initialized, this prevent miscalculate velocity at the first sample
bool is_initialize_right_wheel;
bool is_initialize_left_wheel;

// variables indicate new velocities have been updated.
bool right_wheel_updated;
bool left_wheel_updated;

// Jacobian matrix elements
// | a*cos(theta) a*cos(theta) |
// | a*sin(theta) a*sin(theta) |
// | b            -b           |
double a;
double b;

// Those right_wheel_callback and left_wheel_callback recevie wheels' position from /right_wheel_enc and /left_wheel_enc, respectively,
// and calculate angular velocities of two wheels, then update the current positions with new position
void right_wheel_callback(const std_msgs::Float64& position){
	if (is_initialize_right_wheel) {
		right_wheel_ang_vel = (position.data - right_wheel_pos.data) / SAMPLING_PERIOD;	// calculate angular velocity
		right_wheel_updated = true;
	}
	else is_initialize_right_wheel = true;
	right_wheel_pos = position;	// update to new position
//	ROS_INFO("Right vel: %.3f", right_wheel_ang_vel);
}

void left_wheel_callback(const std_msgs::Float64& position){
	if (is_initialize_left_wheel) {
		left_wheel_ang_vel = (position.data - left_wheel_pos.data) / SAMPLING_PERIOD;	// calculate angular velocity
		left_wheel_updated = true;
	}
	else is_initialize_left_wheel = true;
	left_wheel_pos = position;	// update to new position
//	ROS_INFO("Left vel: %.3f", left_wheel_ang_vel);
}

// function perform forward kinematic to calculate world pose
void calculate_pose(){
	double a_cos = a * cos(pose_est_out.point.z);
	//double a_sin = a * sin(pose_est_out.point.z);
	double x_vel = a_cos * right_wheel_ang_vel + a_cos * left_wheel_ang_vel;
	//double y_vel = a_sin * right_wheel_ang_vel + a_sin * left_wheel_ang_vel;
	double ang_vel = b * right_wheel_ang_vel - b * left_wheel_ang_vel;
	double y_vel = x_vel * tan(pose_est_out.point.z);
	pose_est_out.point.x += SAMPLING_PERIOD * x_vel;
	pose_est_out.point.y += SAMPLING_PERIOD * y_vel;
	pose_est_out.point.z += SAMPLING_PERIOD * ang_vel;

//	ROS_INFO("Velocity: x=%.3f y=%.3f z=%.3f", x_vel, y_vel, ang_vel);
	ROS_INFO("Position: x=%.3f y=%.3f z=%.3f", pose_est_out.point.x, pose_est_out.point.y, pose_est_out.point.z);
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "pose_est"); // Create the "pose_est" node
    ros::NodeHandle n; // Create the node handle object

    ros::Publisher pose_est_pub = n.advertise<pose_est::pose_est_msg>("pose_est", 1000); // Publish and subscribe to topics
    ros::Subscriber right_wheel_sub = n.subscribe("/right_wheel_enc", 1000, right_wheel_callback);	// Subsription to /right_wheel_enc topic where holds right wheel's position in rad.
    ros::Subscriber left_wheel_sub = n.subscribe("/left_wheel_enc", 1000, left_wheel_callback);	// Subsription to /right_wheel_enc topic where holds left wheel's position in rad.
    // ros::Subscriber keydown_sub = n.subscribe("/keyboard/keydown", 1, keydown_callback);

    ros::Time time_obj;

    // initialize global variables
    pose_est_out.header.stamp = time_obj.now();
    pose_est_out.name = STATE_STRING; // Assign values to each parameter in this message type
    pose_est_out.id = 0;
    pose_est_out.point.x = 0;	// initialize the pose at x=0(in)
    pose_est_out.point.y = 0;	// initialize the pose at y=0(in)
    pose_est_out.point.z = 0;	// initialize the pose at orientation=0(rad)

    is_initialize_right_wheel = false;
    is_initialize_left_wheel = false;
    right_wheel_updated = false;
    left_wheel_updated = false;

    // initial conditions
    right_wheel_ang_vel = 0;
    left_wheel_ang_vel = 0;

    // calculate jacobian matrix
    a = WHEEL_RADIUS / 2;
    b = WHEEL_RADIUS / WHEEL_DISTANCE;

    while (ros::ok()) // The ros::ok() function returns true as long as ROS is running
    {
	if (right_wheel_updated && left_wheel_updated){
		calculate_pose();
		right_wheel_updated = false;
		left_wheel_updated = false;
	}
        pose_est_out.header.stamp = time_obj.now();
        pose_est_pub.publish(pose_est_out);
        ros::spinOnce(); // Check to see if something has been published to a topic we subscribe to
    }
}
