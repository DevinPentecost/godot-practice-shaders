# LowRes

This LowResolution effect is not actually a single shader. Instead, it is a number of components working together to achieve this effect. The shader itself is relatively simple and can be used on pretty much any CanvasItem. However, this effect is being done on 3d models! This makes things a bit more complicated.

First, we need to take advantage of the [Viewport Node](http://docs.godotengine.org/en/latest/tutorials/viewports/viewports.html). This allows us to create a whole new 'render world' to render our individual scene objects into their own canvas. These worlds include lighting, camera, positioning, the whole thing. When the camera renders the scene, it instead draws it to the Viewport. This Viewport node is then a child of a ViewportContainer node, which handles rendering into the 2d screenspace. This may seem a little complicated, and I don't fully understand it myself, but you can think of it as 'draw this 3d object, and put it on the main window here'. We have a simple script to autosize the Viewport to match the size of the window (so don't go resizing it during runtime!)

After we render our 2d image to the Viewport container, we then apply our shader material on it. The shader reads in a 'scale' value input. What this means is we will effectively scale down the image 'X' number of times, and then scale it *back* to the original size. If you've ever done this in MSPaint, you'll recall that it makes the image appear boxy and 'low resolution' since we are losing a lot of the pixel data when it is scaled down.

So, the shader takes the scale amount and converts it into a step size for the UV coordinate. It then calulates the number of steps (rounded down) that the UV is on for the sample, and then samples that location in the freshly rendered texture. Because we round down, we sample the same location *STEP* number of times, which gives the boxy appearance we're after.

This is all composited together and drawn to the main 2d window. I'd recommend you look through the nodes yourself and see their settings - they aren't doing anything *too* crazy but it took me a bit to realize what I needed to do.

For the example below, I have two objects with two materials using the same shader. To prove that I am not simply lowering the resolution of the whole scene, I have them animating their shader's scale differently. Additionally, to prove that these really are 3d objects, I have the cube rotating.

Overall, I think this turned out really neat. The main issue is getting this to implement nicely into a full project. There will be a lot of work making sure, for example, that each 3d camera matches the relative position of the 'main' camera, as well as any issues that would come up with z-indexing, lighting, coloring, etc.

# Example
![Example LowRes](https://github.com/DevinPentecost/practice-shaders/blob/master/3d/lowres/lowres.gif "Two objects at different resolutions.")

