﻿package com.bumpslide.net 
	import flash.errors.IOError;

		protected var _httpStatus:int;
		protected var _dataFormat:String = URLLoaderDataFormat.TEXT;
		
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = _dataFormat;
			return _httpStatus;
		}

		public function get dataFormat() : String {
			return _dataFormat;
		}

		public function set dataFormat(dataFormat:String) : void {
			_dataFormat = dataFormat;
		}