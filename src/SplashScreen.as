package
{
	import net.flashpunk.World;
    import net.flashpunk.FP;
    import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
    import net.flashpunk.Entity;
    
    import splash.Splash;
	public class SplashScreen extends World
	{
        public var s:Splash;
        
		public function SplashScreen( )
		{
			add( s = new Splash( ) );
            
			s.start( new TheWorld );
		}
        
        override public function update( ):void 
        {
            super.update( );
            
            if ( Input.check( Key.ENTER ) )
            {
                s.splashEnd( );
            }
        }
	}
}