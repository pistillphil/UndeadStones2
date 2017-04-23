package spells;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

class Spell extends FlxSprite
{
    // Defines the speed and cooldown of this particular spell
    public var speed:Float = 300;
    public var cooldown:Float = .9;

    // Manages the time to live of this spell
    public var time_to_live:Float = 3.33;
    public var timer:FlxTimer;

    // Particle emitter for the timeout animation
    private var _timeout_emitter:FlxEmitter;
    private var _num_timeout_particles:Int = 24;
    
    public function new(?X:Float=0, ?Y:Float=0)
    {
        super(X, Y);

        // Load the graphics for the spell
        loadGraphic(AssetPaths.plasmaball__png, true, 32, 32);

        // Set correct hitbox size
        setSize(12, 12);
        offset.set(10, 10);

        // Initialize the timer
        timer = new FlxTimer();

        // Flip the sprites depending on the direction of the spell
        setFacingFlip(FlxObject.UP, false, true);
        setFacingFlip(FlxObject.DOWN, false, false);
        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        // Setup the animation of the spell
        animation.add("spelled", [0, 1, 2, 3], 20);

        // Initialize particle emitter and particles
        _timeout_emitter = new FlxEmitter();
        _timeout_emitter.alpha.set(0.6, 1, 0, 0);
        _timeout_emitter.lifespan.set(0.1, 0.5);
        for(i in 0..._num_timeout_particles)
        {
            var particle = new FlxParticle();
            particle.makeGraphic(2, 2, FlxColor.PINK);
            particle.exists = false;
            _timeout_emitter.add(particle);
        }
        FlxG.state.add(_timeout_emitter);
    }

    /**
     *  Handles the case of a spell timing out.
     *  TODO: Add knockback for enemies
     *  
     *  @param   timer the timer triggering this callback, as soon as it finishes running
     */
    public function timeout(timer:FlxTimer):Void
    {
        _timeout_emitter.x = x;
        _timeout_emitter.y = y;
        _timeout_emitter.start(true);
        exists = false;
    }
}