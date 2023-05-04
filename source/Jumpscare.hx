package;

import flixel.FlxG;
import flixel.util.FlxTimer;
import flash.system.System;

using StringTools;

class Jumpscare extends MusicBeatState
{
    var jumpscare:BGSprite;

    override function create()
	{
        jumpscare = new BGSprite('lbefescary', ['jumpscare']);
		jumpscare.animation.addByPrefix('jumpscare', 'jumpscare', 24, false);
		jumpscare.screenCenter();
        jumpscare.y -= 25;
		jumpscare.scale.set(2.6, 2.6);
		add(jumpscare);
    }

    override function update(elapsed)
    {
        super.update(elapsed);
        
		jumpscare.animation.play('jumpscare', false);
        FlxG.sound.play(Paths.sound('Jumpscare'));

        new FlxTimer().start(0.7, function(tmr:FlxTimer) {
		    System.exit(0);
        });
    }
}