import 'dart:math';
 
void main() {

  final rnd = Random();
 
  final circle = Circle(rnd.nextInt(10) + 1);
 
  final triangle =

      RightAngledTriangle(rnd.nextInt(10) + 1, rnd.nextInt(10) + 1);
 
  final circleArea = pi * pow(circle.r, 2);
 
  final triangleArea = triangle.w * triangle.h / 2.0;
 
  print('The area of the circle is $circleArea');
 
  print('The area of the triangle is $triangleArea');
 
  if (circleArea > triangleArea) {

    print("The circle is the largest");

  } else if (circleArea < triangleArea) {

    print("The triangle is the largest");

  } else {

    print("The circle and triangle are the same size");

  }

}
 
class Circle {

  final int r;
 
  Circle(this.r);

}
 
class RightAngledTriangle {

  final int w;

  final int h;
 
  RightAngledTriangle(this.w, this.h);

}

 
