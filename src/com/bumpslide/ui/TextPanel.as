/** * This code is part of the Bumpslide Library by David Knape * http://bumpslide.com/ *  * Copyright (c) 2006, 2007, 2008 by Bumpslide, Inc. *  * Released under the open-source MIT license. * http://www.opensource.org/licenses/mit-license.php * see LICENSE.txt for full license terms */ package com.bumpslide.ui {	import flash.text.TextFormat;	
	
	/**	 * Simple Scrolling Text Panel	 * 	 * see ScrollPanel docs/samples for info on skinning	 *  	 * @author David Knape	 */	public class TextPanel extends ScrollPanel {						override protected function addChildren():void {						super.addChildren();						if(content==null) {				var tb:Label = new Label();				tb.content_txt.mouseEnabled = false;				tb.content_txt.selectable = false;				tb.x = -1;				content = tb;			}			_holder.cacheAsBitmap = false;		}				// Public reference to textbox content		public function get textbox():Label { 			return content as Label; 		}						public function get textFormat () : TextFormat {			return textbox.textFormat;		}				public function set textFormat ( tf:TextFormat ) : void {			textbox.textFormat = tf;			invalidate();		}								public function set text ( s:String ) : void {			textbox.text  = s;					invalidate();		}				public function get text ():String {			return textbox.text;		}				public function set htmlText ( s:String ) : void {			//content_txt.condenseWhite = true;			textbox.htmlText = s;			invalidate();		}				public function get htmlText () :String {			return textbox.htmlText;		}					}}