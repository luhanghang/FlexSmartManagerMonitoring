package utils
{
    /**
     * A Box which allows the rounding of specific corners.
     * 
     * Copyright (C) 2009 Daniel Jarvis
     * 
     * This program is free software; you can redistribute it and/or 
     * modify it under the terms of the GNU General Public License as 
     * published by the Free Software Foundation; either version 2 of the License, 
     * or (at your option) any later version.
     * 
     * This program is distributed in the hope that it will be useful, 
     * but WITHOUT ANY WARRANTY; without even the implied warranty of 
     * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
     * 
     * See the GNU General Public License for more details.
     * 
     * 
     * Version 1.0.1
     * 
     * Change Log:
     * 
     * - Fixed bug where backgroundAlpha was not being used.
     * 
     * - DropShadowFilter replaced with RectangularDropShadow
     *         - After adding backgroundAlpha, the drop shadow was visible 
     *           behind the component, not just around the corners.
     */
     
    import flash.display.*;
    import flash.filters.*;
    import mx.graphics.*;
    
    import mx.containers.Box;
    import mx.events.ResizeEvent;
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.StyleManager;
    import mx.utils.GraphicsUtil;
    
    /**
     * Exclude these because they do not work with the Graphics drawing methods
     * However, we still want to enable the same effects through new styles. 
     */
    [Exclude(name = "backgroundColor", kind = "style")]
    [Exclude(name = "borderColor", kind = "style")]
    [Exclude(name = "borderStyle", kind = "style")]
    [Exclude(name = "borderSides", kind = "style")]
    [Exclude(name = "borderSkin", kind = "style")]
    [Exclude(name = "dropShadowEnabled", kind = "style")]
    [Exclude(name = "dropShadowColor", kind = "style")]
    [Exclude(name = "shadowDistance", kind = "style")]
    [Exclude(name = "shadowDirection", kind = "style")]
    
    [Style(name = "fillColor", type = "Number", format = "Color", inherit = "no")]
    [Style(name = "strokeColor", type = "Number", format = "Color", inherit = "yes")]
    [Style(name = "strokeWidth", type = "Number", format = "Number", inherit = "yes")]
    [Style(name = "shadowFillColor", type = "Number", format = "Color", inherit = "no")]
    [Style(name = "shadowLength", type = "Number", format = "Number", inherit = "no")]
    [Style(name = "shadowAngle", type = "Number", format = "Number", inherit = "no")]
    [Style(name = "shadowAlpha", type = "Number", format = "Number", inherit = "no")]
    [Style(name = "cornerRadius", type = "Number", format = "Number", inherit = "no")]
    [Style(name = "topLeftRadius", type = "Number", format = "Number", inherit = "no")]
    [Style(name = "topRightRadius", type = "Number", format = "Number", inherit = "no")]
    [Style(name = "bottomLeftRadius", type = "Number", format = "Number", inherit = "no")]
    [Style(name = "bottomRightRadius", type = "Number", format = "Number", inherit = "no")]
    
    public class StyleBox extends Box
    {
        private var bSizeChanged:Boolean = false;
        private var bStyleChanged:Boolean = true;
        private var bPropChanged:Boolean = false;
        
        private var _fill:Number;
        private var _stColor:Number;
        private var _stWidth:Number;
        private var _shEnabled:Boolean;
        private var _shColor:Number;
        private var _shLength:Number;
        private var _shAngle:Number;
        private var _shAlpha:Number;
        private var _tl:Number;    
        private var _tr:Number;                
        private var _bl:Number;            
        private var _br:Number;    
        private var _shadowFilter:RectangularDropShadow = null;

        private static var classConstructed:Boolean = classConstruct();
        private static function classConstruct():Boolean
        {
           if (!StyleManager.getStyleDeclaration("StyleBox")){
                var bCSS:CSSStyleDeclaration = new CSSStyleDeclaration();
                bCSS.defaultFactory = function():void {
                    this._fill = 0x000000;
                    this._stColor = 0x000000;
                    this._stWidth = 0;
                    this._shEnabled = true;
                    this._shColor = 0x000000;
                    this._shLength = 0;
                    this._shAngle = 0;
                    this._shAlpha = 1;
                    this._tl = 0;
                    this._tr = 0;
                    this._bl = 0;
                    this._br = 0;
                }
                StyleManager.setStyleDeclaration ("StyleBox", bCSS, true);
            }
            return true;
        }
        
        public function StyleBox()
        {
            super();
            this.addEventListener(ResizeEvent.RESIZE, handleResize);
        }
        
        private function handleResize(event:ResizeEvent):void
        {
            this.bSizeChanged = true;
            this.invalidateDisplayList();
        }
        
        override protected function updateDisplayList(w:Number, h:Number) :void
        {
            super.updateDisplayList(w, h);
          
            if ( bStyleChanged || bSizeChanged || bPropChanged) {
                   this.updateStyles();
                var _g:Graphics = graphics;
                _g.clear ();
                
                if ( this.shadowEnabled ) {
                    var shadow:RectangularDropShadow;
                    if ( this._shadowFilter == null ) {
                        shadow = new RectangularDropShadow();
                        shadow.color = this._shColor;
                        shadow.distance = this._shLength;
                        shadow.angle = this._shAngle;
                        shadow.alpha = this._shAlpha;
                        shadow.tlRadius = _tl;
                        shadow.trRadius = _tr;
                        shadow.blRadius = _bl;
                        shadow.brRadius = _br;
                    } else {
                        shadow = this._shadowFilter;
                    }
                    shadow.drawShadow(_g, 0, 0, w, h);
                   }
                   
                _g.beginFill(_fill, this.getStyle('backgroundAlpha'));
                
                if ( this._stWidth > 0 )
                    _g.lineStyle(this._stWidth, this._stColor);
                   
                GraphicsUtil.drawRoundRectComplex(_g, 0, 0, w, h, _tl, _tr, _bl, _br);
                _g.endFill();
              
                   this.bStyleChanged = false;
                   this.bSizeChanged = false;
                   this.bPropChanged = false;
                   this.invalidateSize();
            }
        }
        
        override protected function commitProperties():void
        {
            super.commitProperties();
            
            if ( this.bPropChanged ) {
                this.invalidateDisplayList();
            }
        }

        override public function styleChanged(styleProp:String) :void
        {
            super.styleChanged(styleProp);
            bStyleChanged = true; 
            this.invalidateDisplayList();
            
            if (     styleProp == "fillColor" || styleProp == "cornerRadius" || 
                    styleProp == "topLeftRadius" || styleProp == "topRightRadius" || 
                    styleProp == "bottomLeftRadius" || styleProp == "bottomRightRadius" ||
                    styleProp == "strokeColor" || styleProp == "strokeWidth" ||
                    styleProp == "shadowFillColor" || styleProp == "shadowLength" || 
                    styleProp == "shadowAngle" || styleProp == "shadowAlpha" ||
                    styleProp == "width" || styleProp == "height" ) {
                bStyleChanged = true; 
                this.invalidateDisplayList();
                return;
            }
        }
        
        private function updateStyles():void
        {
            this._fill = this.checkStyleByName('fillColor') ? this.getStyle('fillColor') : 0x000000;

            this._stWidth = this.checkStyleByName('strokeWidth') ? this.getStyle('strokeWidth') : 0;
            this._stColor = this.checkStyleByName('strokeColor') ? this.getStyle('strokeColor') : 0;
            
            this._shColor = this.checkStyleByName('shadowFillColor') ? this.getStyle('shadowFillColor') : 0x000000;
            this._shAngle = this.checkStyleByName('shadowAngle') ? this.getStyle('shadowAngle') : 0;
            this._shLength = this.checkStyleByName('shadowLength') ? this.getStyle('shadowLength') : 0;
            this._shAlpha = this.checkStyleByName('shadowAlpha') ? this.getStyle('shadowAlpha') : 1;
            
            // Corners
            if (     !this.checkStyleByName('topLeftRadius') && !this.checkStyleByName('topRightRadius') &&
                    !this.checkStyleByName('bottomLeftRadius') && !this.checkStyleByName('bottomRightRadius') ) {
                
                if ( !this.checkStyleByName('cornerRadius') ) {
                    this._tl = this._tr =  this._bl =  this._br = 0;
                } else {
                    this._tl =  this._tr =  this._bl = this._br = this.getStyle('cornerRadius');
                }            
            } else {
                this._tl = this.checkStyleByName('topLeftRadius') ? this.getStyle('topLeftRadius') : 0;
                this._tr = this.checkStyleByName('topRightRadius') ? this.getStyle('topRightRadius') : 0;
                this._bl = this.checkStyleByName('bottomLeftRadius') ? this.getStyle('bottomLeftRadius') : 0;    
                this._br = this.checkStyleByName('bottomRightRadius') ? this.getStyle('bottomRightRadius') : 0;
            }
        }
      
        private function checkStyleByName(styleName:String):Boolean
        {
            return !(this.getStyle(styleName) == null || this.getStyle(styleName) == '')
        }
         
        [Bindable]
         public function get shadowEnabled():Boolean { return this._shEnabled; }
         public function set shadowEnabled(value:Boolean):void
         {
             this._shEnabled = value;
             this.bPropChanged = true;
             this.invalidateProperties(); 
         }
         
         [Bindable]
         public function get shadowFilter():RectangularDropShadow { return this._shadowFilter }
         public function set shadowFilter(value:RectangularDropShadow):void
         {
             this._shadowFilter = value;
             this.bPropChanged = true;
             this.invalidateProperties();
        }
    }
}