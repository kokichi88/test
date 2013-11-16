package component
{
    import flash.text.*;

    public class EmbedFormat extends TextFormat
    {
        private var titleEmbed:Class;
        private var fontEmbed:Class;

        public function EmbedFormat(param1:Object = null, param2:Object = null, param3:Boolean = false)
        {
            this.titleEmbed = EmbedFormat_titleEmbed;
            this.fontEmbed = EmbedFormat_fontEmbed;
            if (param3)
            {
                font = "SieuDuong";
            }
            else
            {
                font = "Fista";
            }
            if (!param2)
            {
                param2 = 16777215;
            }
            super(font, param1, param2);
            return;
        }// end function

    }
}
