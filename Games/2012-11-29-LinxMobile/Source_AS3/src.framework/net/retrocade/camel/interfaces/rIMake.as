package net.retrocade.camel.interfaces
{
    import net.retrocade.camel.objects.rSprite;
    import net.retrocade.standalone.Button;

    public interface rIMake{
        function button(onClick:Function, text:String, width:Number = NaN):*;
    }
}