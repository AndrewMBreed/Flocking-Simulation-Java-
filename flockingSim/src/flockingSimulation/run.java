package flockingSimulation;

import geometry.CartesianCoordinate;
import geometry.LineSegment;
import drawing.turtleTest;

public class run {
	public static void main(String[] args)
	{
		System.out.println("test");
		CartesianCoordinate cc1;
		CartesianCoordinate cc2;
		cc1 = new CartesianCoordinate(1.4,2.2);
		cc2 = new CartesianCoordinate(4.4,6.2);
		LineSegment line;
		line = new LineSegment(cc1,cc2);
		turtleTest test = new turtleTest();
	}
}
