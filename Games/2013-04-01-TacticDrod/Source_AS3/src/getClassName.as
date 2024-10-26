package{
    import flash.utils.getQualifiedClassName;

    public function getClassName(object:Object):String{
        return getQualifiedClassName(object).replace(/.+::/, '');
    }
}