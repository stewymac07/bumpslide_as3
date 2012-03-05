﻿/**
 * This code is part of the Bumpslide Library maintained by David Knape
 * Fork me at http://github.com/tkdave/bumpslide_as3
 * 
 * Copyright (c) 2010 by Bumpslide, Inc. 
 * http://www.bumpslide.com/
 *
 * This code is released under the open-source MIT license.
 * See LICENSE.txt for full license terms.
 * More info at http://www.opensource.org/licenses/mit-license.php
 */

package com.bumpslide.view {	import com.bumpslide.ui.IResizable;	import com.bumpslide.view.ViewLoader;		import flash.display.DisplayObject;	
	[DefaultProperty("dataProvider")]
	/**	 * A stack of views that can be selected by index.	 * 	 * Views are stored as class references and are 	 * re-instantiated each time they are needed.	 * 	 * ViewStacks can contain IViews or any display object.	 * Be sure to implement destroy on your views so that	 * things can get properly cleaned up and garbage 	 * collected.	 * 	 * Update Oct. 2010: dataProvider can now holder display objects
	 * as well as class references.  These objects will get 
	 * reused each time.	 * 	 * @author David Knape	 */	public class ViewStack extends ViewLoader {				protected var _selectedIndex:int=0;				protected var _dataProvider:Array = [];				/**		 * Create a view stack using passed in array as the dataProvider		 */		public function ViewStack( views:Array=null ) {			if(views==null) views=[];			super();			dataProvider = views;		}		public function get selectedIndex():int {			return _selectedIndex;		}				public function set selectedIndex(selectedIndex:int):void {			log('selectedIndex='+selectedIndex );
			if(_selectedIndex==selectedIndex) return;			_selectedIndex = selectedIndex;			invalidate( VALID_VIEW );		}						public function get dataProvider():Array {			return _dataProvider;		}				/**		 * Array of classes and/or display objects		 */		public function set dataProvider(dataProvider:Array):void {			_dataProvider = dataProvider;			invalidate( VALID_VIEW );		}		override protected function initView():void {						// selected index of -1 means show nothing			if(selectedIndex==-1) {				log('initView failed (selectedIndex=-1)');				return;			}									var view:* = dataProvider[ selectedIndex ];			var obj:DisplayObject;						if(view is Class) {				obj = new view();			} else if(view is DisplayObject){				obj = view;			}							// If object is not an IView, wrap it with the component wrapper			if(obj is IView) {				currentView = obj as IView;			} else if (obj is DisplayObject){
				var wrapper:ComponentView = new ComponentView();
				wrapper.content = obj;				currentView = wrapper;			}						if(currentView!=null) {				if(currentView is IResizable) {					(currentView as IResizable).setSize( width, height );				}								if(currentView is DisplayObject) {					addChild( currentView as DisplayObject );				}							} 						log( 'initView() currentView=' + currentView );						sendChangeEvent( 'selectedIndex', selectedIndex );		}	}}