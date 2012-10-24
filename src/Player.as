package
{
	import net.flashpunk.Entity;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
    import net.flashpunk.graphics.Spritemap;

	public class Player extends Entity
	{
		[Embed(source = 'assets/swordguy.png')]
		private const SWORDGUY:Class;
        
        public var sprSwordguy:Spritemap = new Spritemap( SWORDGUY, 48, 32 );
        public var prevx:Number = 0;
        public var prevy:Number = 0;

		public function Player( )
		{
            sprSwordguy.add("stand", [0, 1, 2, 3, 4, 5], 10, true);
			sprSwordguy.add("run", [6, 7, 8, 9, 10, 11], 20, true);
            
            graphic = sprSwordguy;
		}
        
        override public function update( ): void
        {
            if (Input.check(Key.RIGHT)) { sprSwordguy.flipped = false;  x += 5; }
			else if (Input.check(Key.LEFT)) { sprSwordguy.flipped = true;  x -= 5; }
            
            if (Input.check(Key.DOWN)) { y += 5; }
            else if (Input.check(Key.UP)) { y -= 5; }
            
            if (prevx == x && prevy == y)
            {
                sprSwordguy.play("stand");
            }
            else
            {	
                sprSwordguy.play("run");
            }
            
            prevx = x;
            prevy = y;
        }
	}
}