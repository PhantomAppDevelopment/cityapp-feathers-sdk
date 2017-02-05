package
{
	import feathers.controls.ImageLoader;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.utils.touch.TapToSelect;
	
	import starling.display.Quad;
	
	public class PhotoItemRenderer extends LayoutGroupListItemRenderer
	{
		private var _image:ImageLoader;
		private var _select:TapToSelect;
				
		public function PhotoItemRenderer()
		{
			super();
			this._select = new TapToSelect(this);
		}
			
		override protected function initialize():void
		{
			super.initialize();
			
			this.isQuickHitAreaEnabled = true;
			this.layout = new AnchorLayout();
			this.backgroundSkin = new Quad(70, 70, 0xFFFFFF);
			
			_image = new ImageLoader();
			_image.layoutData = new AnchorLayoutData(0, 0, 0, 0, NaN, NaN);
			_image.width = 70;
			_image.height = 70;
			this.addChild(_image);			
		}
		
		override protected function commitData():void
		{
			if(this._data && this._owner)
			{
				_image.source = 'https://farm'+_data.@farm+'.staticflickr.com/'+_data.@server+'/'+_data.@id+'_'+_data.@secret+'_s.jpg'; 
			} else	{
				_image.source = null;
			}
		}
	}
}