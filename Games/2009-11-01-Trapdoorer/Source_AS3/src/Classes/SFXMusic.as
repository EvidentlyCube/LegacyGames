package Classes{
	public class SFXMusic	{
		[Embed("../../assets/music/omogenic/omogenic.mp3")] private var mus1: Class;
		[Embed("../../assets/music/music2.mp3")] private var mus2: Class;
		[Embed("../../assets/music/music3.mp3")] private var mus3: Class;
		[Embed("../../assets/music/music4.mp3")] private var mus4: Class;
		public function SFXMusic(){
			SFX.fill(mus1, mus2, mus3, mus4)
		}

	}
}