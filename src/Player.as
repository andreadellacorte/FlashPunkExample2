package
{
    import net.flashpunk.FP;
	import net.flashpunk.Entity;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
    import net.flashpunk.graphics.Spritemap;
    import com.matttuttle.PhysicsEntity;

	public class Player extends PhysicsEntity
	{
		[Embed(source = 'assets/swordguy.png')] private const SWORDGUY:Class;
        
        public var sprSwordguy:Spritemap = new Spritemap( SWORDGUY, 48, 32 );
        public var prevx:Number = 0;
        public var prevy:Number = 0;
		public var debug:Boolean = false;
        
        private static const kMoveSpeed:uint = 2;
		private static const kJumpForce:uint = 20;

		public function Player( )
		{
            super.update( );
            
            x = FP.width / 2;
            y = FP.height / 2;
            
            sprSwordguy.add("stand", [0, 1, 2, 3, 4, 5], 10, true);
			sprSwordguy.add("run", [6, 7, 8, 9, 10, 11], 20, true);
			
			//Setting hit box for the player
			setHitbox(48, 32); 
            
            gravity.y = 2.6;
			maxVelocity.y = kJumpForce;
			maxVelocity.x = kMoveSpeed * 2;
			friction.x = 0.7; // floor friction
			friction.y = 2.0; // wall friction
            
            graphic = sprSwordguy;
		}
        
        override public function update( ): void
        {
            super.update( );
            
            if (Input.check(Key.RIGHT)) 
            { 
                sprSwordguy.flipped = false;  
                acceleration.x = kMoveSpeed; 
            }
			else if (Input.check(Key.LEFT)) 
            { 
                sprSwordguy.flipped = true;  
                acceleration.x = -kMoveSpeed; 
            }
            
            if (Input.check( Key.SPACE ) && onGround )
			{
				acceleration.y = -FP.sign(gravity.y) * kJumpForce;
				acceleration.x = -FP.sign(gravity.x) * kJumpForce;
			}
			
			//If no longer holding a key set acceleration to zero
			//So he doesn't fly away
			if (Input.released(Key.RIGHT) || Input.released(Key.LEFT) || Input.released(Key.SPACE))
			{
				acceleration.x = 0;
				acceleration.y = 0;
			}
            
            if (prevx == x && prevy == y)
            {
                sprSwordguy.play("stand");
            }
            else
            {	
                sprSwordguy.play("run");
            }
            
			//Check if the player is touching "solid"
			if (collide("solid", x+2, y+2))
			{
				//Do fancy stuff because we have a collison!

			}
			
			//Set up debug condition
			if (Input.pressed(Key.D))
			{
				debug = !debug;
				trace("Debug set to " + debug );
			}	
			
			if (debug)
			{
				//Move are guy back to the center if he goes off screen
				if (x > FP.width || x < 0 || y > FP.height || y < 0) 
				{
					x = FP.width / 2;
					y = FP.height / 2;
					
					acceleration.x = 0;
					acceleration.y = 0;
				}
				
				//Debuging collisions with "solid" go here
				if (collide("solid", x+2, y+2))
				{
					trace("collision detected!");
				}
			}
			
            prevx = x;
            prevy = y;
        }
	}
}