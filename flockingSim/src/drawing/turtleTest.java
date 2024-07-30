package drawing;

import javax.swing.JFrame;
import java.awt.event.WindowEvent;
import java.awt.event.WindowAdapter;

//import drawing.Canvas;
import geometry.CartesianCoordinate;
import geometry.LineSegment;

public class turtleTest {
	
	public void testTurtle() {
		// A JFrame is a window for containing graphical elements
		 JFrame frame = new JFrame();
		 // Set the title of the JFrame
		 frame.setTitle("Canvas");
		 // Set the size of the JFrame
		 frame.setSize(800, 600);
		 // Make pressing the ‘X’ close the window
		 frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		 // Make the JFrame visible
		 frame.setVisible(true);
		 // Add a window adapter that will make sure the program closes
		 // after closing the window
		 frame.addWindowListener(new WindowAdapter() {
		 public void windowClosing(WindowEvent e) {
		 System.exit(0);
		 }
		 });
		 // The Canvas which is provided for this course
		 Canvas canvas = new Canvas();
		 // Add the canvas to the window
		 frame.getContentPane().add(canvas); 
		 }
}
