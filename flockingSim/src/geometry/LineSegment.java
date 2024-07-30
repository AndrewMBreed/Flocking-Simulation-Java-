package geometry;

public class LineSegment {
	CartesianCoordinate startPoint;
	CartesianCoordinate endPoint;
	
	public LineSegment(CartesianCoordinate startPoint, CartesianCoordinate endPoint)
	{
		this.startPoint = startPoint;
		this.endPoint = endPoint;
	}

	public CartesianCoordinate getStartPoint() {
		return startPoint;
	}

	public CartesianCoordinate getEndPoint() {
		return endPoint;
	}

	public double length()
	{
		double sideXSquared;
		double sideYSquared;
		sideXSquared = (startPoint.getX() - endPoint.getX())*(startPoint.getX() - endPoint.getX());
		sideYSquared = (startPoint.getY() - endPoint.getY())*(startPoint.getY() - endPoint.getY());
		return(java.lang.Math.sqrt(sideXSquared + sideYSquared));
	}
}
