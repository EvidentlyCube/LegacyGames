package game.functions{
    public function colorFromColor(color:uint):uint{
        switch(color) {
            case(0): return 0xFFF0F0F0;
            case(1): return 0xFFFF0000;
            case(2): return 0xFFFF8822;
            case(3): return 0xFFFFFF00;
            case(4): return 0xFF00FF00;
            case(5): return 0xFF00FFFF;
            case(6): return 0xFF0000FF;
            case(7): return 0xFFFF00FF;
            case(8): return 0xFF444444;
            default: return 0;
        }
    }
}