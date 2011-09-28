package com.bumpslide.command.robotlegs
{

	import com.bumpslide.command.Command;
	import com.bumpslide.command.CommandEvent;
	import com.bumpslide.data.type.Padding;
	import com.bumpslide.ui.Label;
	import com.bumpslide.util.ObjectUtil;

	import org.robotlegs.core.ICommandMap;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IViewMap;

	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.display.Stage;
	import flash.text.TextFormat;

	/**
	 * Command that creates a startup log
	 * 
	 * This creates a label in the contextView of this Robotlegs context.
	 * The label is used to display startup messages.
	 * 
	 * Start messages are posted using the StartMessage command which is
	 * triggered by the StartupLogEvent.
	 *
	 * @author David Knape, http://bumpslide.com/
	 */
	public class InitStartupLog extends Command
	{
		
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var viewMap:IViewMap;
		
		[Inject]
		public var commandMap:ICommandMap;
		
		public var fontName:String = "Courier New";
		public var fontSize:Number = 14;
		public var color:* = "#999999";
		public var padding:* = 20;
		public var bold:Boolean = false;
	
		override public function execute(event:CommandEvent=null):void
		{
			if(isNaN(color)) color = parseInt( String(color).replace('#',''), 16 ); 
			if(!padding is Padding) padding = Padding.create(padding);
			
			var window:NativeWindow = NativeApplication.nativeApplication.activeWindow;
			if(window==null) {
				trace('[InitStartupLog] no active window');
				notifyComplete();
				return;
			}
			
			var stage:Stage = window.stage;
			
			if(stage==null) {
				trace('[InitStartupLog] no active stage');
				notifyComplete();
				return;
			}
			
			var format:TextFormat = new TextFormat( fontName, fontSize, color, bold );
			
			// create a label to display the text
			var label:Label = ObjectUtil.create( Label, { padding:padding, width:stage.stageWidth, height:stage.stageHeight, textFormat:format} );
			
			// add it as a child to this context view
			viewMap.contextView.addChild( label );
			
			// let other commands access this label
			injector.mapValue( Label, label, 'startupLogDisplay' );
			
			commandMap.mapEvent( StartupMessageEvent.LOG_MESSAGE, StartupMessage, StartupMessageEvent );
			
			notifyComplete();
			
		}
		
	}
}
