#include <geometry_msgs/Vector3.h>
#ifndef VECTOR3_H
#define VECTOR3_H
namespace vector3{
class Vector3{
	private:
		geometry_msgs::Vector3 vec;
	public:
		Vector3(geometry_msgs::Vector3 vec);
		
		Vector3(double x, double y, double z);

		Vector3();

		double magnitude();

		void normalize();

		void scaleVec(double scale);

		void scaleComp(double x, double y, double z);

		void setVector(geometry_msgs::Vector3 newVec);

		void setX(double X);

		void setY(double Y);

		void setZ(double Z);

		double getX();

		double getY();
	       	
		double getZ();

		static geometry_msgs::Vector3 create(double x, double y, double z);

		geometry_msgs::Vector3 getXComp();

		geometry_msgs::Vector3 getYComp();

		geometry_msgs::Vector3 getZCom();

		geometry_msgs::Vector3 getVector();
};
}
#endif
