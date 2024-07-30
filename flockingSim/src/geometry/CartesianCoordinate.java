package geometry;

public class CartesianCoordinate {
	private double xPosition;
	private double yPosition;
	public CartesianCoordinate(double x, double y) 
	{
		 xPosition = x;
		 yPosition = y;
	}
	public double getX()
	{
		return xPosition;
	}
	public double getY()
	{
		return yPosition;
	}
}
