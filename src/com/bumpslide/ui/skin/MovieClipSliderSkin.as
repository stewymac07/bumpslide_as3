package com.bumpslide.ui.skin 
{
	import com.bumpslide.data.type.Padding;

	/**
	 * MovieClipSliderSkin
	 *
	 * @author David Knape
	 * @version SVN: $Id: $
	 */
	public class MovieClipSliderSkin extends BasicSliderSkin 
	{

		override public function initHostComponent(host_component:ISkinnable):void 
		{
			super.initHostComponent(host_component);
			
			// init padding based on position of handle on the stage
				
			var p:Padding = new Padding(handle.y, handle.x, handle.y, handle.x);
			
			if(hostComponent.isVertical) {
				p.right = hostComponent.width - handle.getBounds(this).right;
			} else {
				p.bottom = hostComponent.height - handle.getBounds(this).bottom;
			}
			
			
			hostComponent.padding = p;						
			hostComponent.fixedHandleSize = ( hostComponent.isVertical ) ? handle.height : handle.width;
		}

		
		override protected function drawBack():void 
		{
			if(hostComponent.isVertical) {
				background.height = hostComponent.height;
			} else {
				background.width = hostComponent.width;
			}
		}
	}
}