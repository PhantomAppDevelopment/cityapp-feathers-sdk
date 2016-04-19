package
{
	import flash.text.TextFormat;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScrollText;
	import feathers.controls.ToggleButton;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextEditor;
	import feathers.core.ITextRenderer;
	import feathers.themes.StyleNameFunctionTheme;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class CustomTheme extends StyleNameFunctionTheme
	{
		[Embed(source="assets/font.otf", fontFamily="MyFont", fontWeight="normal", fontStyle="normal", mimeType="application/x-font", embedAsCFF="true")]
		private static const MY_FONT:Class;
		
		private var whiteText:ElementFormat = new ElementFormat(new FontDescription("_sans"), 12, 0xFFFFFF);
		private var blackText:ElementFormat = new ElementFormat(new FontDescription("_sans"), 12, 0x000000);
		
		public function CustomTheme()
		{
			super();
			
			this.initialize();
		}
		
		private function initialize():void
		{
			this.initializeGlobals();
			this.initializeStyleProviders();	
		}
		
		private function initializeGlobals():void
		{
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				return new TextBlockTextRenderer();
			}
			
			FeathersControl.defaultTextEditorFactory = function():ITextEditor
			{
				return new StageTextTextEditor();
			}
		}
		
		private function initializeStyleProviders():void
		{
			this.getStyleProviderForClass(Button).setFunctionForStyleName("back-button", this.setBackButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName("header-button", this.setHeaderButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName("transparent-button", this.setTransparentButtonStyles);
			
			this.getStyleProviderForClass(DefaultListItemRenderer).setFunctionForStyleName("orange-itemrenderer", setOrangeItemRendererStyles);
			this.getStyleProviderForClass(DefaultListItemRenderer).setFunctionForStyleName("blue-itemrenderer", setBlueItemRendererStyles);
			this.getStyleProviderForClass(DefaultListItemRenderer).setFunctionForStyleName("red-itemrenderer", setRedItemRendererStyles);

			this.getStyleProviderForClass(Header).defaultStyleFunction = this.setHeaderStyles;			
			this.getStyleProviderForClass(Header).setFunctionForStyleName("orange-header", this.setOrangeHeaderStyles);
			this.getStyleProviderForClass(Header).setFunctionForStyleName("blue-header", this.setBlueHeaderStyles);
			this.getStyleProviderForClass(Header).setFunctionForStyleName("green-header", this.setGreenHeaderStyles);
			this.getStyleProviderForClass(Header).setFunctionForStyleName("red-header", this.setRedHeaderStyles);
			
			this.getStyleProviderForClass(Label).defaultStyleFunction = this.setLabelStyles;
			this.getStyleProviderForClass(List).defaultStyleFunction = this.setListStyles;
			this.getStyleProviderForClass(PanelScreen).defaultStyleFunction = this.setPanelScreenStyles;
			
			this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName("orange-tabs", this.setOrangeTabStyles);
			this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName("red-tabs", this.setRedTabStyles);
			
			this.getStyleProviderForClass(ScrollText).defaultStyleFunction = this.setScrollTextStyles;
		}
		
		private function createGradient(topColor:uint, bottomColor:uint):Quad
		{
			var blackGradient:Quad = new Quad(3, 50);
			blackGradient.setVertexColor(0, topColor);
			blackGradient.setVertexColor(1, topColor);
			blackGradient.setVertexColor(2, bottomColor);
			blackGradient.setVertexColor(3, bottomColor);			
			return blackGradient;
		}
		
		private function createSmallGradient(topColor:uint, bottomColor:uint):Quad
		{
			var blueQuad:Quad = new Quad(3, 5);
			blueQuad.y = 45;
			blueQuad.setVertexColor(0, topColor);
			blueQuad.setVertexColor(1, topColor);
			blueQuad.setVertexColor(2, bottomColor);
			blueQuad.setVertexColor(3, bottomColor);			
			return blueQuad;
		}
		
		private function createSmallOpaqueGradient(topColor:uint, bottomColor:uint):Quad
		{
			var blueQuad:Quad = new Quad(3, 5);
			blueQuad.y = 45;
			blueQuad.alpha = 0.5;
			blueQuad.setVertexColor(0, topColor);
			blueQuad.setVertexColor(1, topColor);
			blueQuad.setVertexColor(2, bottomColor);
			blueQuad.setVertexColor(3, bottomColor);			
			return blueQuad;
		}
		
		//-------------------------
		// Button
		//-------------------------
				
		private function setTransparentButtonStyles(button:Button):void
		{
			var quad:Quad =  new Quad(3, 3, 0xFFFFFF);
			quad.alpha = 0;
			
			button.defaultSkin = quad;
		}
		
		private function setHeaderButtonStyles(button:Button):void
		{
			button.width = 	button.height = 45;
			
			var transparentQuad:Quad = new Quad(45, 45, 0xFFFFFF);
			transparentQuad.alpha = 0.2;
			button.downSkin = transparentQuad;
		}
		
		private function setBackButtonStyles(button:Button):void
		{
			var arrowIcon:ImageLoader = new ImageLoader();
			arrowIcon.source = "assets/icons/ic_arrow_back_white_48dp.png";
			arrowIcon.width = arrowIcon.height = 25;
			
			button.width = 	button.height = 45;
			button.defaultIcon = arrowIcon;
			
			var transparentQuad:Quad = new Quad(45, 45, 0xFFFFFF);
			transparentQuad.alpha = 0.2;
			button.downSkin = transparentQuad;
			
		}
		
		//-------------------------
		// Header
		//-------------------------
		
		private function setHeaderStyles(header:Header):void
		{			
			header.titleFactory = function():ITextRenderer
			{
				var font:FontDescription = new FontDescription("MyFont");
				font.fontLookup = FontLookup.EMBEDDED_CFF;
				
				var titleRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
				titleRenderer.elementFormat =new ElementFormat(font, 14, 0xFFFFFF);
				return titleRenderer;
			};
			
			header.gap = 5;
			header.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;
			header.paddingLeft = 10;
			header.backgroundSkin = new Quad(3, 50, 0x333333);
		}
		
		private function setOrangeHeaderStyles(header:Header):void
		{		
			header.titleFactory = function():ITextRenderer
			{
				var font:FontDescription = new FontDescription("MyFont");
				font.fontLookup = FontLookup.EMBEDDED_CFF;
				
				var titleRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
				titleRenderer.elementFormat = new ElementFormat(font, 14, 0xFFFFFF);
				return titleRenderer;
			};
			
			header.backgroundSkin = new Quad(3, 50, 0xFF8A00);
		}
		
		private function setBlueHeaderStyles(header:Header):void
		{		
			header.titleFactory = function():ITextRenderer
			{
				var font:FontDescription = new FontDescription("MyFont");
				font.fontLookup = FontLookup.EMBEDDED_CFF;
				
				var titleRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
				titleRenderer.elementFormat = new ElementFormat(font, 14, 0xFFFFFF);
				return titleRenderer;
			};
			
			header.backgroundSkin = new Quad(3, 50, 0x12A0CF);
		}
		
		private function setGreenHeaderStyles(header:Header):void
		{		
			header.titleFactory = function():ITextRenderer
			{
				var font:FontDescription = new FontDescription("MyFont");
				font.fontLookup = FontLookup.EMBEDDED_CFF;
				
				var titleRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
				titleRenderer.elementFormat = new ElementFormat(font, 14, 0xFFFFFF);
				return titleRenderer;
			};
			
			header.backgroundSkin = new Quad(3, 50, 0x669900);
		}

		private function setRedHeaderStyles(header:Header):void
		{		
			header.titleFactory = function():ITextRenderer
			{
				var font:FontDescription = new FontDescription("MyFont");
				font.fontLookup = FontLookup.EMBEDDED_CFF;
				
				var titleRenderer:TextBlockTextRenderer = new TextBlockTextRenderer();
				titleRenderer.elementFormat = new ElementFormat(font, 14, 0xFFFFFF);
				return titleRenderer;
			};
			
			header.backgroundSkin = new Quad(3, 50, 0xCC0000);
		}
		
		//-------------------------
		// Label
		//-------------------------
		
		private function setLabelStyles(label:Label):void
		{
			label.textRendererFactory = function():ITextRenderer
			{
				var font:FontDescription = new FontDescription("MyFont");
				font.fontLookup = FontLookup.EMBEDDED_CFF;
				
				var renderer:TextBlockTextRenderer = new TextBlockTextRenderer();
				renderer.elementFormat = new ElementFormat(font, 20, 0xFFFFFF);
				return renderer;
			}
		}
		
		//-------------------------
		// List
		//-------------------------
		
		private function setListStyles(list:List):void
		{
			list.backgroundSkin = new Quad(3, 3, 0xD7DADD);
		}
		
		private function setOrangeItemRendererStyles(renderer:DefaultListItemRenderer):void
		{
			renderer.defaultSkin = new Quad(3, 3, 0xFFFFFF);
			renderer.defaultSelectedSkin = new Quad(3, 3, 0xFF8A00);
			renderer.downSkin = new Quad(3, 3, 0xFF8A00);
			renderer.selectedDownSkin = new Quad(3, 3, 0xFF8A00);
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingLeft = 10;
			renderer.paddingRight = 0;
			renderer.paddingTop = 5;
			renderer.paddingBottom = 5;
			renderer.gap = 10;
			renderer.minHeight = 60;
			renderer.defaultLabelProperties.leading = 7;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.defaultLabelProperties.elementFormat = blackText;
			renderer.downLabelProperties.elementFormat = whiteText;
		}	
		
		private function setBlueItemRendererStyles(renderer:DefaultListItemRenderer):void
		{
			renderer.defaultSkin = new Quad(3, 3, 0xFFFFFF);
			renderer.defaultSelectedSkin = new Quad(3, 3, 0x12A0CF);
			renderer.downSkin = new Quad(3, 3, 0x12A0CF);
			renderer.selectedDownSkin = new Quad(3, 3, 0x12A0CF);
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingLeft = 10;
			renderer.paddingRight = 0;
			renderer.paddingTop = 5;
			renderer.paddingBottom = 5;
			renderer.gap = 10;
			renderer.minHeight = 65;
			renderer.defaultLabelProperties.leading = 7;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.defaultLabelProperties.elementFormat = blackText;
			renderer.downLabelProperties.elementFormat = whiteText;
		}
		
		private function setRedItemRendererStyles(renderer:DefaultListItemRenderer):void
		{
			renderer.defaultSkin = new Quad(3, 3, 0xFFFFFF);
			renderer.defaultSelectedSkin = new Quad(3, 3, 0xCC0000);
			renderer.downSkin = new Quad(3, 3, 0xCC0000);
			renderer.selectedDownSkin = new Quad(3, 3, 0xCC0000);
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingLeft = 10;
			renderer.paddingRight = 0;
			renderer.paddingTop = 5;
			renderer.paddingBottom = 5;
			renderer.gap = 10;
			renderer.minHeight = 65;
			renderer.defaultLabelProperties.leading = 7;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.defaultLabelProperties.elementFormat = blackText;
			renderer.downLabelProperties.elementFormat = whiteText;
		}
		
		//-------------------------
		// PanelScreen
		//-------------------------
		
		private function setPanelScreenStyles(screen:PanelScreen):void
		{
			screen.backgroundSkin = new Quad(3, 3, 0xFFFFFF);
		}
				
		//-------------------------
		// TabBar
		//-------------------------
		
		private function setOrangeTabStyles(button:ToggleButton):void
		{					
			var defaultSkin:Sprite = new Sprite();						
			defaultSkin.addChild(createGradient(0xFFFFFF, 0xFFFFFF));						
			defaultSkin.addChild(createSmallOpaqueGradient(0xFFAE18, 0xFF8A00));
			
			var defaultSelectedSkin:Sprite = new Sprite();
			defaultSelectedSkin.addChild(createGradient(0xFFFFFF, 0xFFFFFF));						
			defaultSelectedSkin.addChild(createSmallGradient(0xFFAE18, 0xFF8A00));
			
			button.defaultSkin = defaultSkin;
			button.downSkin = defaultSelectedSkin;
			button.selectedDownSkin = defaultSelectedSkin;
			button.defaultSelectedSkin = defaultSelectedSkin;
			
			button.defaultLabelProperties.elementFormat = blackText;
		}
		
		private function setRedTabStyles(button:ToggleButton):void
		{			
			var defaultSkin:Sprite = new Sprite();						
			defaultSkin.addChild(createGradient(0xFFFFFF, 0xFFFFFF));						
			defaultSkin.addChild(createSmallOpaqueGradient(0xE92727, 0xCC0000));
			
			var defaultSelectedSkin:Sprite = new Sprite();
			defaultSelectedSkin.addChild(createGradient(0xFFFFFF, 0xFFFFFF));						
			defaultSelectedSkin.addChild(createSmallGradient(0xE92727, 0xCC0000));
			
			button.defaultSkin = defaultSkin;
			button.downSkin = defaultSelectedSkin;
			button.selectedDownSkin = defaultSelectedSkin;
			button.defaultSelectedSkin = defaultSelectedSkin;
			
			button.defaultLabelProperties.elementFormat = blackText;
		}
		
		//-------------------------
		// ScrollText
		//-------------------------
		
		private function setScrollTextStyles(scrolltext:ScrollText):void
		{
			scrolltext.textFormat = new TextFormat("_sans", 12, 0x000000);
			scrolltext.isHTML = true;
		}
		
	}
}