package{
    public function ASSERT(cause:*, description:String = ""):void{
        if (!cause){
            if (description)
                throw new Error(description);
            else
                 throw new Error("Assertion failed");
        }
    }
}