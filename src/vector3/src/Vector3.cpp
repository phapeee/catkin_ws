#include "vector3/Vector3.h"
#include <geometry_msgs/Vector3.h>
#include <cmath>
namespace vector3{
Vector3::Vector3(geometry_msgs::Vector3 vec){
	vec = vec;
}

Vector3::Vector3(double x, double y, double z){
	vec = Vector3::create(x, y, z);
}

Vector3::Vector3(){
	vec.x = 0;
	vec.y = 0;
	vec.z = 0;
}

double Vector3::magnitude(){
	return sqrt(pow(vec.x, 2) + pow(vec.y, 2) + pow(vec.z, 2));
}

void Vector3::normalize(){
	double mag = magnitude();
	if (mag == 0.0) return;
	vec.x /= mag;
	vec.y /= mag;
	vec.z /= mag;
}

void Vector3::scaleVec(double scale){
	vec.x *= scale;
	vec.y *= scale;
	vec.z *= scale;
}

void Vector3::scaleComp(double x = 1, double y = 1, double z = 1){
	vec.x *= x;
	vec.y *= y;
	vec.z *= z;
}

void Vector3::setVector(geometry_msgs::Vector3 newVec){
	vec = newVec;
}

void Vector3::setX(double X){
	vec.x = X;
}

void Vector3::setY(double Y){ 
        vec.y = Y;
}

void Vector3::setZ(double Z){ 
        vec.z = Z;
}

double Vector3::getX(){
	return vec.x;
}
double Vector3::getY(){
        return vec.y;
}

double Vector3::getZ(){
        return vec.z;
}

geometry_msgs::Vector3 Vector3::create(double x, double y, double z){
	geometry_msgs::Vector3 newVec;
	newVec.x = x;
	newVec.y = y;
	newVec.z = z;
	return newVec;
}

geometry_msgs::Vector3 Vector3::getXComp(){
	return Vector3::create(vec.x, 0, 0);
}

geometry_msgs::Vector3 Vector3::getYComp(){
	return Vector3::create(0, vec.y, 0);
}

geometry_msgs::Vector3 Vector3::getZCom(){
        return Vector3::create(0, 0, vec.z);
}

geometry_msgs::Vector3 Vector3::getVector(){
	return vec;
}
}
