#define STATE_STRING        "ganymede"

#include <ros/ros.h>
#include <pose_est/pose_est_msg.h> // Include the .h file that is creates from your .msg file

pose_est::pose_est_msg pose_est_out; // Creates a variable to hold the publishable data

int main(int argc, char **argv) {
    ros::init(argc, argv, "pose_est"); // Create the "master" node
    ros::NodeHandle n; // Create the node handle object

    ros::Publisher pose_est_pub = n.advertise<pose_est::pose_est_msg>("pose_est", 1); // Publish and subscribe to topics
    // ros::Subscriber keydown_sub = n.subscribe("/keyboard/keydown", 1, keydown_callback);

   ros::Time time_obj;

    pose_est_out.header.stamp = time_obj.now();
    pose_est_out.name = STATE_STRING; // Assign values to each parameter in this message type
    pose_est_out.id = 18273645;
    pose_est_out.point.x = 1.0;
    pose_est_out.point.y = -2.3;
    pose_est_out.point.z = -0.2;

    while (ros::ok()) // The ros::ok() function returns true as long as ROS is running
    {
        pose_est_out.header.stamp = time_obj.now();
        pose_est_pub.publish(pose_est_out);
        //ros::spinOnce(); // Check to see if something has been published to a topic we subscribe to
    }
}
