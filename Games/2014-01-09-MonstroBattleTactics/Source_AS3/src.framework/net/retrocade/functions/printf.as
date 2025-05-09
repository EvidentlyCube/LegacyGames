


package net.retrocade.functions {
    public function printf(string:String, ...params:Array):String{
        var matchCount:int = 0;

        return string.replace(/%%/g, function(match:String, index:int, fullString:String):String{
            if (params.length > matchCount){
                matchCount++;
                return params[matchCount - 1] !== null ? params[matchCount - 1].toString() : '';
            }

            return "%%";
        });
    }
}
