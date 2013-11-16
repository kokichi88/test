package modules.battle.data
{
	import __AS3__.vec.*;
	import component.avatar.model.animation.*;
	import component.avatar.things.*;
	import flash.display.*;
	import gameData.*;
	import map.*;
	import modules.battle.*;
	import modules.battle.logic.*;
	import modules.battle.logic.bean.*;
	import modules.city.*;
	import resMgr.*;
	
	public class BattleData extends Object
	{
		public var objList:Vector.<DataObject>;
		public var imageList:Vector.<DisplayObject>;
		public var imageRIPList:Vector.<DisplayObject>;
		private var genObjId:int = 0;
		
		public function BattleData()
		{
			this.objList = new Vector.<DataObject>;
			this.imageList = new Vector.<DisplayObject>;
			this.imageRIPList = new Vector.<DisplayObject>;
			return;
		} // end function
		
		public function addObj(param1:DataObject):void
		{
			var _loc_2:Layer = null;
			var _loc_3:int = 0;
			if (param1.objId < 0)
			{
				param1.objId = this.genObjId;
				
				this.genObjId++
			}
			this.objList.push(param1);
			if (param1.displayImage)
			{
				param1.avatar.x = param1.move.x;
				param1.avatar.y = param1.move.y;
				_loc_2 = LayerMgr.getInstance().getLayer(GlobalVar.LAYER_GAME);
				_loc_3 = this.getIndexAvatar(param1.displayImage);
				if (param1.baseInfo.id == BuildingType.ARMY_CAMP)
				{
					_loc_3 = 0;
				}
				if (_loc_3 >= 0)
				{
					_loc_2.addChildAt(param1.displayImage, _loc_3);
				}
				else
				{
					_loc_2.addChild(param1.displayImage);
				}
				if (param1 is DataHouse)
				{
					DataHouse(param1).updatePosAvatar();
				}
			}
			if (param1 is Bullet)
			{
				return;
			}
			this.renderObj(true);
			return;
		} // end function
		
		public function removeObj(param1:DataObject):void
		{
			param1.destroy();
			this.removeObjById(param1.objId);
			param1 = null;
			return;
		} // end function
		
		public function clearAllObj():void
		{
			this.genObjId = 0;
			var _loc_1:int = 0;
			while (_loc_1 < this.objList.length)
			{
				
				this.objList[_loc_1].destroy();
				this.objList[_loc_1] = null;
				_loc_1++;
			}
			this.objList.splice(0, this.objList.length);
			this.objList = new Vector.<DataObject>;
			_loc_1 = 0;
			while (_loc_1 < this.imageList.length)
			{
				
				if (this.imageList[_loc_1] && this.imageList[_loc_1].parent)
				{
					this.imageList[_loc_1].parent.removeChild(this.imageList[_loc_1]);
					this.imageList[_loc_1].visible = false;
					this.imageList[_loc_1] = null;
				}
				_loc_1++;
			}
			this.imageList.splice(0, this.imageList.length);
			this.imageList = new Vector.<DisplayObject>;
			_loc_1 = 0;
			while (_loc_1 < this.imageRIPList.length)
			{
				
				if (this.imageRIPList[_loc_1] && this.imageRIPList[_loc_1].parent)
				{
					this.imageRIPList[_loc_1].parent.removeChild(this.imageRIPList[_loc_1]);
					this.imageRIPList[_loc_1].visible = false;
					this.imageRIPList[_loc_1] = null;
				}
				_loc_1++;
			}
			this.imageRIPList.splice(0, this.imageRIPList.length);
			this.imageRIPList = new Vector.<DisplayObject>;
			return;
		} // end function
		
		public function getObjectCell(param1:int):DataObject
		{
			var _loc_2:int = 0;
			while (_loc_2 < this.objList.length)
			{
				
				if (this.objList[_loc_2].move.curCell == param1)
				{
					return this.objList[_loc_2];
				}
				_loc_2++;
			}
			return null;
		} // end function
		
		public function getObjectByIso(param1:int, param2:int):DataObject
		{
			var _loc_3:* = MapMgr.getInstance().battleMap.isoToCell(param1, param2);
			var _loc_4:int = 0;
			while (_loc_4 < this.objList.length)
			{
				
				if (this.objList[_loc_4].move.curCell == _loc_3)
				{
					return this.objList[_loc_4];
				}
				_loc_4++;
			}
			return null;
		} // end function
		
		public function getObject(param1:int):DataObject
		{
			var _loc_2:* = this.getIndexObject(param1, this.objList);
			if (_loc_2 == -1)
			{
				return null;
			}
			return this.objList[_loc_2];
		} // end function
		
		public function removeObjById(param1:int):void
		{
			var _loc_3:DataObject = null;
			var _loc_2:* = this.getIndexObject(param1, this.objList);
			if (_loc_2 >= 0)
			{
				_loc_3 = this.objList[_loc_2];
				this.objList.splice(_loc_2, 1);
				;
			}
			return;
		} // end function
		
		public function getIndexObject2(param1:int, param2:Vector.<DataObject>):int
		{
			if (param2.length <= 0)
			{
				return -1;
			}
			var _loc_3:int = 0;
			while (_loc_3 < param2.length)
			{
				
				if (param1 == param2[_loc_3].objId)
				{
					return _loc_3;
				}
				_loc_3++;
			}
			return -1;
		} // end function
		
		public function getIndexObject(arg0:int, arg1:Vector.<DataObject>):int
		{
			if (arg1.length <= 0)
			{
				return -1;
			}
			else
			{
				var local0:* = 0;
				var int1:int = arg1.length - 1;
				var int2:int = (arg1.length - 1 + local0) / 2;
				if (local0 < int1)
				{
					if (arg0 != arg1[int2].objId)
					{
						if (arg0 < arg1[int2].objId)
						{
							int1 = int2 - 1;
						}
						else
						{
							local0 = int2 + 1;
						}
						int2 = (int1 + local0) / 2;
					}
					else
					{
						return int2;
					}
				}
				else if (arg0 != arg1[local0].objId)
				{
					return -1;
				}
				else
				{
					return local0;
				}
			}
			return -1;
		} // end function
		
		public function loop():void
		{
			var _loc_1:int = 0;
			while (_loc_1 < this.objList.length)
			{
				
				this.objList[_loc_1].loop();
				_loc_1++;
			}
			return;
		} // end function
		
		public function showCheckSum():void
		{
			var _loc_1:int = 0;
			var _loc_2:int = 0;
			var _loc_3:Number = 0;
			var _loc_4:Number = 0;
			var _loc_5:String = "";
			var _loc_6:int = 0;
			while (_loc_6 < this.objList.length)
			{
				
				if (this.objList[_loc_6] is Bullet)
				{
				}
				else
				{
					_loc_1++;
					if (this.objList[_loc_6].objectType != 7)
					{
						_loc_2 = _loc_2 + this.objList[_loc_6].baseInfo.curHp;
					}
					_loc_3 = _loc_3 + this.objList[_loc_6].move.x;
					_loc_4 = _loc_4 + this.objList[_loc_6].move.y;
					if (this.objList[_loc_6].objectType == DataObject.OBJTYPE_TROOP)
					{
					}
				}
				_loc_6++;
			}
			_loc_5 = _loc_5 + (BattleModule.getInstance().goldRop + "_" + BattleModule.getInstance().elixirRop + " " + BattleModule.getInstance().totalHp + "_" + BattleModule.getInstance().curHp);
			return;
		} // end function
		
		public function hideAllObject():void
		{
			var _loc_1:int = 0;
			while (_loc_1 < this.objList.length)
			{
				
				this.objList[_loc_1].setVisible(false);
				_loc_1++;
			}
			return;
		} // end function
		
		public function showAllObject():void
		{
			var _loc_1:int = 0;
			while (_loc_1 < this.objList.length)
			{
				
				this.objList[_loc_1].setVisible(true);
				_loc_1++;
			}
			return;
		} // end function
		
		public function removeAllEvent():void
		{
			var _loc_1:int = 0;
			while (_loc_1 < this.objList.length)
			{
				
				if (this.objList[_loc_1].avatar)
				{
					this.objList[_loc_1].avatar.removeFrameScript();
				}
				_loc_1++;
			}
			return;
		} // end function
		
		public function setActionAllTroop():void
		{
			var _loc_1:int = 0;
			while (_loc_1 < this.objList.length)
			{
				
				if (this.objList[_loc_1].avatar)
				{
					this.objList[_loc_1].avatar.setAction(AnConst.STAND, this.objList[_loc_1].avatar.anSetting.currDir);
				}
				_loc_1++;
			}
			return;
		} // end function
		
		public function renderObj2():void
		{
			var _loc_2:int = 0;
			var _loc_3:int = 0;
			this.objList.sort(this.compareDataObject);
			var _loc_1:int = 0;
			while (_loc_1 < (this.objList.length - 1))
			{
				
				if (this.objList[_loc_1].avatar && this.objList[(_loc_1 + 1)].avatar)
				{
					_loc_2 = this.objList[_loc_1].avatar.parent.getChildIndex(this.objList[_loc_1].avatar);
					_loc_3 = this.objList[(_loc_1 + 1)].avatar.parent.getChildIndex(this.objList[(_loc_1 + 1)].avatar);
					if (_loc_2 > _loc_3)
					{
						this.objList[_loc_1].avatar.parent.swapChildrenAt(_loc_2, _loc_3);
					}
				}
				_loc_1++;
			}
			return;
		} // end function
		
		private function getArrObj(param1:Boolean = false):Array
		{
			var _loc_2:* = new Array();
			var _loc_3:int = 0;
			while (_loc_3 < this.objList.length)
			{
				
				if (this.objList[_loc_3].displayImage)
				{
					if (this.objList[_loc_3] is DataHouse && DataHouse(this.objList[_loc_3]).mapObject.type == BuildingType.ARMY_CAMP)
					{
					}
					else
					{
						if (!param1)
						{
							if (this.objList[_loc_3] is Wall)
							{
								;
							}
						}
						_loc_2.push(this.objList[_loc_3].displayImage);
					}
				}
				_loc_3++;
			}
			var _loc_4:* = CityMgr.getInstance().farmerList;
			_loc_3 = 0;
			while (_loc_3 < _loc_4.length)
			{
				
				if (_loc_4[_loc_3].avatar)
				{
					_loc_2.push(_loc_4[_loc_3].avatar);
				}
				_loc_3++;
			}
			_loc_2.sortOn("y", Array.NUMERIC);
			return _loc_2;
		} // end function
		
		private function getIndexAvatar(param1:DisplayObjectContainer):int
		{
			var _loc_2:* = this.getArrObj(true);
			var _loc_3:int = 0;
			while (_loc_3 < _loc_2.length)
			{
				
				if (_loc_2[_loc_3].y > param1.y)
				{
					return _loc_2[_loc_3].parent.getChildIndex(_loc_2[_loc_3]);
				}
				_loc_3++;
			}
			return -1;
		} // end function
		
		public function renderObj(param1:Boolean = false):void
		{
			var _loc_4:int = 0;
			var _loc_5:int = 0;
			var _loc_2:* = this.getArrObj(param1);
			var _loc_3:int = 0;
			while (_loc_3 < (_loc_2.length - 1))
			{
				
				_loc_4 = _loc_2[_loc_3].parent.getChildIndex(_loc_2[_loc_3]);
				_loc_5 = _loc_2[(_loc_3 + 1)].parent.getChildIndex(_loc_2[(_loc_3 + 1)]);
				if (_loc_4 > _loc_5)
				{
					_loc_2[_loc_3].parent.swapChildrenAt(_loc_4, _loc_5);
				}
				_loc_3++;
			}
			return;
		} // end function
		
		public function updateWall():void
		{
			var _loc_1:int = 0;
			while (_loc_1 < (this.objList.length - 1))
			{
				
				if (this.objList[_loc_1] is Wall)
				{
					Wall(this.objList[_loc_1]).updateBonusFavorite();
				}
				_loc_1++;
			}
			return;
		} // end function
		
		private function compareAvatar(param1:Avatar, param2:Avatar):int
		{
			if (param1.y > param2.y)
			{
				return 1;
			}
			if (param1.y < param2.y)
			{
				return -1;
			}
			if (param1.x > param2.x)
			{
				return 1;
			}
			if (param1.x < param2.x)
			{
				return -1;
			}
			return 0;
		} // end function
		
		private function compareDataObject(param1:DataObject, param2:DataObject):int
		{
			if (param1.move.y > param2.move.y)
			{
				return 1;
			}
			if (param1.move.y < param2.move.y)
			{
				return -1;
			}
			if (param1.move.x > param2.move.x)
			{
				return 1;
			}
			if (param1.move.x < param2.move.x)
			{
				return -1;
			}
			return 0;
		} // end function
	
	}
}
