package;

import Math;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Player extends FlxSprite
{
	var SPEED:Float = 200;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetPaths.doggy__png, true, 16, 16);
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		offset.set(4, 4);
		scale.set(2, 2);

		animation.add("run", [1, 2, 3], 6);
		animation.add("idle", [0], 6);
		drag.x = drag.y = 1600;
	}

	override function update(elapsed:Float)
	{
		updateMovement(elapsed);
		super.update(elapsed);
	}

	function updateMovement(elapsed)
	{
		var up:Bool;
		var down:Bool;
		var left:Bool;
		var right:Bool;

		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (up && down)
		{
			up = down = false;
		}
		if (left && right)
		{
			left = right = false;
		}

		var angle:Float = 0;
		if (up)
		{
			angle = -90;
			if (left)
				angle -= 45;
			if (right)
				angle += 45;
		}
		else if (down)
		{
			angle = 90;
			if (left)
				angle += 45;
			if (right)
				angle -= 45;
		}
		else if (left)
		{
			angle = -180;
		}
		else if (right)
		{
			angle = 0;
		}

		if (up || down || left || right)
		{
			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), angle);

			if (facing == FlxObject.RIGHT && Math.abs(angle) > 90)
				facing = FlxObject.LEFT;
			else if (facing == FlxObject.LEFT && Math.abs(angle) < 90)
				facing = FlxObject.RIGHT;

			animation.play("run");
		}
		else
		{
			animation.play("idle");
		}
	}
}
