# Invert

This is a basic shader that simply reads in the screen buffer and inverts the color. The intensity of the inversion is controlled by the sprite, where the alpha channel defines the intensity. The higher the alpha (the more opaque) the more the screen will be inverted at that pixel.

The shader will not interact with anything else, including itself (for example, two inverts won't go back to normal). This is shown in the example below. I am currently trying to fix this...

I added some simple movements with two example gradients for the intensity.

# Example
![Example Invert](https://github.com/DevinPentecost/practice-shaders/blob/master/2d/invert/invert.gif "Simple Inversion with movement")

