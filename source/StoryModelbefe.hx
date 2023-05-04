package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.input.keyboard.FlxKey;
import Discord.DiscordClient;
import flixel.FlxObject;

using StringTools;

class StoryModelbefe extends MusicBeatState
{

    var lbefestory:BGSprite;
    var assault:BGSprite;

	var camFollowPos:FlxObject;

    override function create()
	{
        super.create();

        FlxG.mouse.visible = true;
        PlayState.isStoryMode = true;

		DiscordClient.changePresence("Which lbefe will you play? Time to decide!", null);

		WeekData.reloadWeekFiles(true);

        var bg:BGSprite = new BGSprite('bg_ui', 0, 0, 0.7, 0.7);
        bg.screenCenter();
        add(bg);
        
        var lbefe:BGSprite = new BGSprite('selectscreen_lbefe', ['Symbol 3'], true);
        lbefe.animation.addByPrefix('anim', 'Symbol 3', 12, true);
        lbefe.screenCenter();
        lbefe.y -= 50;
        add(lbefe);
        lbefe.animation.play('anim');

        lbefestory = new BGSprite('storymenu/lbefeweek', 40, 500, ['lbefe'], true);
        lbefestory.animation.addByPrefix('anim', 'lbefe', 12, true);
        add(lbefestory);
        lbefestory.animation.play('anim');

        assault = new BGSprite('storymenu/assaultweek', 930, 470, ['lbefs assault'], true);
        assault.animation.addByPrefix('anim', 'lbefs assault', 12, true);
        add(assault);
        assault.animation.play('anim');
		
		camFollowPos = new FlxObject(500, 0, 1, 1);
		add(camFollowPos);
		
		FlxG.camera.follow(camFollowPos, LOCKON, 1);
    }

    override function update(elapsed)
    {
        super.update(elapsed);

        if(FlxG.mouse.overlaps(lbefestory))
        {
            if(FlxG.mouse.justPressed)
            {
                FlxG.mouse.visible = false;
                PlayState.storyPlaylist = ['bob', 'nob', "Arachibutyrophobia"];
                PlayState.storyDifficulty = 0;
				PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + "", StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
				LoadingState.loadAndSwitchState(new PlayState(), true);
            }
        }

        if(FlxG.mouse.overlaps(assault))
        {
            if(FlxG.mouse.justPressed)
            {
                FlxG.mouse.visible = false;
                PlayState.storyPlaylist = ['redguy72', 'pob', "assault"];
                PlayState.storyDifficulty = 0;
				PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + "", StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
				LoadingState.loadAndSwitchState(new PlayState(), true);
            }
        }
        
		camFollowPos.x = 630 + (FlxG.mouse.x/50);
		camFollowPos.y = 350 + (FlxG.mouse.y/50);

		if(FlxG.keys.justPressed.CONTROL)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}

		if (FlxG.keys.justPressed.ESCAPE)
		{
            FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new MainMenuState());
		}
    }
}