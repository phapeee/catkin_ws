#include <ros/ros.h>
#include <rosbag/bag.h>
#include <geometry_msgs/Vector3.h>
#include <std_msgs/Float64.h>
#include <experimental/filesystem>

#define RECORDING_COUNT	(500)

namespace fs = std::experimental::filesystem;

rosbag::Bag bag;
std::string file_path = "/home/ubuntu/records/acceleration.bag";
fs::path path = file_path;

void acc_callback(const geometry_msgs::Vector3& acc_msgs){
	static bool recording = true;
	static bool init = true;
	static unsigned int count;
	if (init) {
		ROS_INFO("Recording acceleration...");
		init = false;
		count = 0;
		if (!fs::is_empty(path)) {
			fs::remove(path);
			ROS_WARN("Removed file: %s", file_path.c_str());
		}
	}
	if (recording){
		bag.write("acc", ros::Time::now(), acc_msgs);
		ROS_INFO("Recorded: %d times.", ++count);
		if (count >= RECORDING_COUNT) {
			recording = false;
			ROS_INFO("Finish recording. Size: %lu", bag.getSize());
			bag.close();
		}
	}
}


int main(int argc, char** argv){
	ros::init(argc, argv, "record_acceleration");
	ros::NodeHandle nh;
	ros::Subscriber acc_sub = nh.subscribe("acceleration", 10, acc_callback);
	bag.open(file_path, rosbag::bagmode::Write);

	ros::spin();
}
