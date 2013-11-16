﻿package org.as3commons.reflect
{

    public interface IMetadataContainer
    {

        public function IMetadataContainer();

        function addMetadata(param1:Metadata) : void;

        function hasMetadata(param1:String) : Boolean;

        function hasExactMetadata(param1:Metadata) : Boolean;

        function getMetadata(param1:String) : Array;

        function get metadata() : Array;

    }
}
