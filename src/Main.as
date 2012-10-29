package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	[SWF(width = "640", height = "480")]
    
	public class Main extends Engine 
	{
		public function Main( ):void 
		{
			super( 640, 480, 60, false );
		}
		
		override public function init( ):void 
		{
			super.init( );
            
            FP.world = new SplashScreen;
		}
		
		override public function update( ):void
		{
			super.update();
		}
	}
}