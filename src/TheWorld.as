package
{
    import net.flashpunk.FP;
	import net.flashpunk.World;
	public class TheWorld extends World
	{
		public function TheWorld()
		{
            trace("TheWorld created!");
            add( new Player );
		}
        
        override public function begin( ):void
        {
            FP.screen.color = 0
        }
        
        override public function update( ):void
        {
            super.update( );
        }
	}
}