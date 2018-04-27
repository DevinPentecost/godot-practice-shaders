# Transition

By utilizing a grayscale mask, we can transition an image to black over time following a pattern.
The shader simply samples the mask, and compares it to an input percentage value.
If the mask's value is less than the input, the pixel is turned to black. Otherwise, it is left alone.

The scene has an animation to change the material input value over time, with some easing.

# Example
![Spiral Transition](./transition_spiral.gif "Spiral transition")
![Weird Transition](./transition_weird.gif "Pattern that is seperated into multiple segments")

