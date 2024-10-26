REM

Version information:


# More advanced logger which logs to file;
# Monster AI, following player;
# Beginning of all the complex stuff involving interactive objects (initializing parameters);
# Battling enemies;
# Objects parser;


V0.03 - 25 IV 2010 (25: 977 / 1964):
01. Level parser has been finished and at the moment it actually reads
    the whole level data from the file. Character - Tile association is also
	read from the respective file. No dynamic, per-level changes YET, note that
	doubly hashed comments mean not working functions in Data files.
02. It is now perfectly possible to walk from one room to another. Yay, eh?
03. Force Arrows are done. They work in the same way as in DyROD, and the best
    thing is that they use simple flags and you can easily use these flags
	right now to create Ortho-Squares, or horizontal/vertical only passages,
	or Tile which can be only entered from Top but left in any direction you
	can imagine. Pretty purdy ain't it?

V0.02 - 19 IV 2010 (785 / 1714):
01. First of all I managed to successfully transliterate the whole code and 
    structure (and improve it) to BlitzMax from Flex. Oh, how I just LOVE
    blitzmax (despite it having no Getters/Setters and private properties). Not
    to mention it is slick fast, better, handier, prettier, faster, cooler, 
    nicer and faster. So with that I can safely believe that with my mediocre
    (but fanatical) optimization skills I can manage the whole project
    successfully.
02. Content is external - well, mostly. Right now Levels, Tiles and Objects are
    externally definable, but in the future I hope to make loads of stuff
    external (statuses, elements, effects, items, body parts, AI, scripted
    monsters and probably some world shaking things) but, though it might ONLY
    be because I am not that great of a programmer, thinks like that are dang
    problematic and difficult to make, especially that I still don't know how
    much cycles I will have left to use. So until some unspecific point in the
    future I am not promising ANYTHING about it. Unless you can, like, help then
    that's entirely different matter.
03. You can rotate all the way to the left and right, something which took
    around 2 minutes to code and yet gives so much fun!
04. Graphic manager which takes care of all the object graphics loaded and
    cleans them on the fly without any need for special, sort of Garbage Image
    Collector by Skell Industries to make sure memory is not cluttered with
    hundreds of sprites. Not to mention that most likely it won't be enough and
    WILL require some fine tuning, but hey! at least it's there, right?
05. *rummages through the code* Externalized enemies AI (that is, internally
    externalized, every object is hooked to a singleton TBrain instance which is
    obviously not singleton enough... not singleton AT ALL to be precise);
06. Strict documentation of every function, method, field, global and constant
    (but internal workings of functions are not yet commented properly which
    should change in the future);
07. A nifty (that is, just ONE function called Log) logger with lots of
    Conditionally Compiled calls in critical places. In the future it will be
    extended by more Logging options, like LogInitializationMessages,
    LogBattleMessages, LogStatisticsChanges, LogPlayerActions, LogEnemyActions
    and so on. Just a good starting point for now;
08. And all that with every property being (fictionally) private :)
09. And we shouldn't forget that the whole thing consists of roughly...
   


V0.01:
Original flash version