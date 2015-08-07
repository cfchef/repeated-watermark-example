component name="Watermark"
	output="false"
{
	public any function init() {
		variables.AlphaComposite = createObject("java", "java.awt.AlphaComposite");
		variables.Color = createObject("java", "java.awt.Color");
		variables.Font = createObject("java", "java.awt.Font");
		variables.jFile = createObject("java", "java.io.File");
		variables.AffineTransform = createObject("java", "java.awt.geom.AffineTransform");
		variables.ImageIO = createObject("java", "javax.imageio.ImageIO");

		return this;
	}

	public void function addTextWatermark(
		required string text,
		required string srcImgPath,
		required string destImgPath
	) {
		try {
			// Read in the image
			var srcImg = variables.ImageIO.read(variables.jFile.init(arguments.srcImgPath));
			var g2d = srcImg.getGraphics();
			
			// Create our font properties for the supplied text and rotate it 45 degress
			var alphaChannel = variables.AlphaComposite.getInstance(variables.AlphaComposite.SRC_OVER, 0.3);
			g2d.setComposite(alphaChannel);
			g2d.setColor(variables.Color.WHITE);
			var aft = variables.AffineTransform;
			aft.rotate(45 * pi() / 180);
			var font = variables.Font.init("Arial", variables.Font.BOLD, 64);
			g2d.setFont(font.deriveFont(aft));
			
			// Get font dimensions
			var fontMetrics = g2d.getFontMetrics();
			var rect = fontMetrics.getStringBounds(arguments.text, g2d);
			
			// Get the x and y factors
			var xFactor = cos(45 * pi() / 180);
			var yFactor = sin(45 * pi() / 180);

			// Crunch through positions to place our watermark text
			for (var x = 0; x < srcImg.getWidth(); x += rect.getWidth() * xFactor + rect.getHeight() * yFactor) {
					for (var y = -60 * yFactor; y < srcImg.getHeight(); y += rect.getWidth() * yFactor + rect.getHeight() * xFactor) {
						g2d.drawString(arguments.text, x, y);
					}
		        }
		    }

		    // Write file and clean up
		    variables.ImageIO.write(srcImg, "png", variables.jFile.init(arguments.destImgPath));
		    g2d.dispose();
		}
		catch(any e) {
			throw(e.message);
		}
	}
}
