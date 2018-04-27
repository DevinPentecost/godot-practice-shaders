# Sprite Outline

Sprite outlining is a very common effect used in 2D games. Many engines come with this feature built in, but Godot did not seem to have that, so I decided to create a shader to handle it.
It took a while to find a solution, but finally I have one that seems to keep pixel-perfect while adding the outline.

There are solutions without shaders. For example, you can duplicate the sprite 4 times, shift each copy a few pixels in each cardinal direction, and draw the moved sprites the outline color behind the regular sprite. However, this is a bit cumbersome and is something that a shader should be perfect for!

To accomplish this, I first expand the sprite by the size of the outline in the vertex shader, so that there is more 'canvas' to work with. Then, on the fragment shader, I 'scale' the image back down to figure out where the sprite would be drawn normally. I compare the 'exploded' and 'normal' sprites, and if I see normal sprite data, I draw that. If I see expanded data and not normal sprite, I draw the outline instead. Finally, if I don't see any data, then we are on the outside of the outline and just draw transparent pixels.

I haven't tested this shader with too many sprites, but I'd imagine that it works best with center aligned sprites. If you have too much offset, it might start to act goofy but once again, I haven't tested it too much. It should work well enough anyways.

In the following example, I have an unshaded (un-outlined) sprite moving up and down over the top of the outlined sprite to prove that the size is consistent. I also have the outline animating it's size to prove it's really creating the outline accurately.


# Example
![Example Outline](https://github.com/DevinPentecost/practice-shaders/blob/master/2d/sprite_outline/outline.gif "We can see that the sprite doesn't change size too")

