/**
 * Created with IntelliJ IDEA.
 * User: Ryc
 * Date: 19.05.13
 * Time: 12:41
 * To change this template use File | Settings | File Templates.
 */
package net.retrocade.utils {
    public function tracef(string:String, ...params:Array):void{
        params.unshift(string);

        trace(printf.apply(null, params));
    }
}
