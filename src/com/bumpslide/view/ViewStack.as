﻿package com.bumpslide.view {	import com.bumpslide.ui.IResizable;	import com.bumpslide.view.ViewLoader;		import flash.display.DisplayObject;		/**	 * A stack of views that can be selected by index.	 * 	 * Views are stored as class references and are 	 * re-instantiated each time they are needed.	 * 	 * ViewStacks can contain IViews or any display object.	 * Be sure to implement destroy on your views so that	 * things can get properly cleaned up and garbage 	 * collected.	 * 	 * There is not currently any support for keeping child views	 * in memory.  If you want to waste resources, use Flex. ;)	 * 	 * @author David Knape	 */	public class ViewStack extends ViewLoader {				protected var _selectedIndex:int=0;				protected var _dataProvider:Array = [];				public function ViewStack( classes:Array=null ) {			if(classes==null) classes=[];			super();			dataProvider = classes;		}		public function get selectedIndex():int {			return _selectedIndex;		}				public function set selectedIndex(selectedIndex:int):void {			log('selectedIndex='+selectedIndex );			_selectedIndex = selectedIndex;			invalidate( VALID_VIEW );		}						public function get dataProvider():Array {			return _dataProvider;		}				public function set dataProvider(dataProvider:Array):void {			_dataProvider = dataProvider;			invalidate( VALID_VIEW );		}		override protected function initView():void {						// selected index of -1 means show nothing			if(selectedIndex==-1) {				log('initView failed (selectedIndex=-1)');				return;			}						// get the view class - if it's null, just don't show anthing			var viewClass:Class = dataProvider[ selectedIndex ] as Class;			if(viewClass==null) {				log('initView failed (view class is null for selectedIndex of '+selectedIndex+')');				return;			}						// instantiate the view			var obj:* = new viewClass();						// If object is not an IView, wrap it with the component wrapper			if(obj is IView) {				currentView = obj;			} else if (obj is DisplayObject){				currentView = new ComponentWrapper( obj );			}						if(currentView!=null) {				if(currentView is IResizable) {					(currentView as IResizable).setSize( width, height );				}								if(currentView is DisplayObject) {					addChild( currentView as DisplayObject );				}							} 						log( 'initView() currentView=' + currentView );						sendChangeEvent( 'selectedIndex', selectedIndex );		}	}}