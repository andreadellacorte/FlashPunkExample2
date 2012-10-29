package com.matttuttle
{
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	public class PhysicsEntity extends Entity
	{
		// Define variables
		public var velocity:Point      = new Point( 0, 0 );
		public var acceleration:Point  = new Point( 0, 0 );
		public var friction:Point      = new Point( 0, 0 );
		public var maxVelocity:Point   = new Point( 0, 0 );
		public var gravity:Point       = new Point( 0, 0 );
		public var solid:String = "solid";
        
        private var _onGround:Boolean;
		private var _onWall:Boolean;
		
		public function PhysicsEntity( )
		{
			_onGround = _onWall = false;
		}
		
		public function get onGround( ):Boolean { return _onGround; }
		public function get onWall( ):Boolean { return _onWall; }
		
		override public function update( ):void
		{
            super.update( );
            
			velocity.x += acceleration.x;
			velocity.y += acceleration.y;
            
			applyVelocity( );
			applyGravity( );
			checkMaxVelocity( );
			applyFriction( );
            
            // Reset acceleration
            acceleration.x = 0;
            acceleration.y = 0;
		}
		
		public function applyGravity( ):void
		{
			velocity.x += gravity.x;
			velocity.y += gravity.y;
		}
		
		private function checkMaxVelocity( ):void
		{
			if(maxVelocity.x > 0 && Math.abs( velocity.x ) > maxVelocity.x )
			{
				velocity.x = maxVelocity.x * FP.sign(velocity.x);
			}
			
			if( maxVelocity.y > 0 && Math.abs( velocity.y ) > maxVelocity.y )
			{
				velocity.y = maxVelocity.y * FP.sign(velocity.y);
			}
		}
		
		private function applyFriction( ):void
		{
			// If we're on the ground, apply friction
			if( onGround && friction.x )
			{
				if( velocity.x > 0 )
				{
					velocity.x -= friction.x;
					if( velocity.x < 0 )
					{
						velocity.x = 0;
					}
				}
				else if(velocity.x < 0)
				{
					velocity.x += friction.x;
					if( velocity.x > 0 )
					{
						velocity.x = 0;
					}
				}
			}
			
			// Apply friction if on a wall
			if( onWall && friction.y )
			{
				if( velocity.y > 0 )
				{
					velocity.y -= friction.y;
                    
					if( velocity.y < 0 )
					{
						velocity.y = 0;
					}
				}
				else if( velocity.y < 0 )
				{
					velocity.y += friction.y;
                    
					if( velocity.y > 0 )
					{
						velocity.y = 0;
					}
				}
			}
		}
		
		private function applyVelocity( ):void
		{
			_onGround = false;
			_onWall = false;
			
			for( var i:int = 0; i < Math.abs( velocity.x ); i++ )
			{
				if( collide( solid, x + FP.sign( velocity.x ), y ) )
				{
					_onWall = true;
					velocity.x = 0;
					break;
				}
				else
				{
					x += FP.sign(velocity.x);
				}
			}
			
			for( var j:int = 0; j < Math.abs( velocity.y ); j++  )
			{
				if( collide( solid, x, y + FP.sign( velocity.y ) ) )
				{
					if( FP.sign( velocity.y ) == FP.sign( gravity.y ) )
                    {
						_onGround = true;
                    }
                    
					velocity.y = 0;
                    
					break;
				}
				else
				{
					y += FP.sign( velocity.y );
				}
			}
		}
	}

}