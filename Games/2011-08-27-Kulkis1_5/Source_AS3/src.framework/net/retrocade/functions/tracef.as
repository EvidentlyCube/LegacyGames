package net.retrocade.functions {

    public function tracef(string:String, ...params:Array):void{
        params.unshift(string);

        trace(printf.apply(null, params));
    }
}
