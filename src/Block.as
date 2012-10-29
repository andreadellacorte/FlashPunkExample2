package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Rob Filippi
	 */
	public class Block extends Entity 
	{
		[Embed(source = 'assets/red_block.png')] private const RBLOCK:Class;
		
		public function Block( ) 
		{
			graphic = new Image( RBLOCK );
			x = FP.width / 2;
            y = ( FP.height / 2 ) + 150;
			
			setHitbox( 100, 100 );
			
			type = "solid";
		}
		
	}

}