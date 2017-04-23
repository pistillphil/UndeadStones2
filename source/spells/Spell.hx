package spells;

import flixel.FlxSprite;
import flixel.FlxObject;

class Spell extends FlxSprite
{
    public var speed:Float = 300;
    public var cooldown:Float = .9;
    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);

        // Load the graphics for the spell
        loadGraphic(AssetPaths.plasmaball__png, true, 32, 32);

        // Set correct hitbox size
        setSize(12, 12);
        offset.set(10, 10);

        // Flip the sprites depending on the direction of the spell
        setFacingFlip(FlxObject.UP, false, true);
        setFacingFlip(FlxObject.DOWN, false, false);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        // Setup the animation of the spell
        animation.add("spelled", [0, 1, 2, 3], 20);
    }
}