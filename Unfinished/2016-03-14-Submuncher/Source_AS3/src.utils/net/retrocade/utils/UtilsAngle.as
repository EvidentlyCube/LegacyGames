/*
 * Copyright (C) 2013 Maurycy Zarzycki
 * Unless stated otherwise in the rest of the source file
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

package net.retrocade.utils {
   /**
    * An utility class which containst number-related functions
    *
    * @author Maurycy Zarzycki
    */
    public class UtilsAngle{
       public static function easeTwoRadians(startRadian:Number, targetRadian:Number, factor:Number):Number {
           var angle360:Number = Math.PI * 2;
           var angle180:Number = Math.PI;

           var delta:Number = targetRadian - startRadian;

           if (delta > angle180){
               delta -= angle360;
           } else if (delta < -angle180){
               delta += angle360;
           }

           var result:Number = startRadian + delta * factor;
           if (result > angle180){
               result -= angle360;
           } else if (result < -angle180){
               result += angle360;
           }

           return result;
       }
       public static function easeTwoRadiansByStep(startRadian:Number, targetRadian:Number, step:Number):Number {
           var angle360:Number = Math.PI * 2;
           var angle180:Number = Math.PI;

           var delta:Number = targetRadian - startRadian;

           if (delta > angle180){
               delta -= angle360;
           } else if (delta < -angle180){
               delta += angle360;
           }

           var result:Number = startRadian + UtilsNumber.limit(delta, step, -step);
           if (result > angle180){
               result -= angle360;
           } else if (result < -angle180){
               result += angle360;
           }

           return result;
       }
    }
}