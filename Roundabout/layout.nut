//
// Attract-Mode Front-End - Roundabout
//By Tankman3737, Big thanks th @Chadnaut for the curve shader and @zestful for the game transistion code and snap//////////
// Some details in the code below


fe.layout.width=1920;
fe.layout.height=1080;
fe.layout.preserve_aspect_ratio = true

fe.load_module("wheel");
fe.load_module("inertia")
fe.load_module("animate");


//MARK: Game Transition 
/////////////////// To/From Game transition set up, animation at bottom //////////////
local toGameVideo = fe.add_image( "assets/toGame.mp4", 0, -100, 1920,1080);
local fromGameVideo = fe.add_image( "assets/fromGame.mp4", 0, -100, fe.layout.width, fe.layout.height);
toGameVideo.video_flags = Vid.NoAutoStart
fromGameVideo.video_flags = Vid.NoAutoStart
toGameVideo.video_playing = false
fromGameVideo.video_playing = false
toGameVideo.zorder = 1
fromGameVideo.zorder = 1
toGameVideo.visible = false
fromGameVideo.visible = false
/////////////////// To/From Game transition set up animation at bottom //////////////

local stars=fe.add_image("assets/stars.png"0,0,1920,1080)
stars.visible=true
stars.blend_mode=BlendMode.Screen
stars.zorder=2


local BG=fe.add_image("assets/BG2.png"0,0,1920,1080)
BG.zorder=2




//MARK: Main Screens
/////////////////////Main Screen  and Curve shader//////////////
local MS=fe.add_surface(1920,1080)
MS.x=0
MS.y=0
MS.shader = fe.add_shader(Shader.Fragment, "assets/curve.frag");
MS.shader.set_param("strength", 0.5); // amount of curvature [0..1]
MS.shader.set_param("dir", 0.5); // alignment [0..1]
MS.zorder=20
/////////////////////Main Screen  and Curve shader//////////////


//Front logo///
local logoa=MS.add_artwork("wheel",960,480,300,200)
logoa.anchor=Anchor.Centre
logoa.preserve_aspect_ratio=true
//Front logo///




//Wrap around display/////////
local Frame =
{
    function init()
    {
    slots <- 7
    speed <- 900
    artwork_label <- "frame" 
    //video_flags <- Vid.ImagesOnly
    x <- 0
    y <- 540
    layout.y <- [0,0,0,0,0,0,0 ]
    layout.x <- [  -960,-320,320, 960, 1600,2240,2880] 
    layout.width <- [640,640, 640, 640,640,640,640]
    layout.height <- [ 1080,1080,1080,1080, 1080,1080, 1080]            
    //layout.alpha <- [ 0,0, 0, 0, 0, 0,0 ]
    
    //zorder <- 1
    anchor <- Wheel.Anchor.Centre
    

    }
}	
local FrameWheel = fe.add_wheel( Frame,MS)

//Wrap around display//////////////////



/////surface for snap and bezel "wheels"/////////////////
local PS=MS.add_surface(1920,247)
PS.x=0
PS.y=600
PS.zorder=10

/////snap and bezel "wheels"/////////////////
local Snap =
{
    function init()
    {
    slots <- 7
    speed <- 900
    artwork_label <- "snap" 
    //vide o_flags <- Vid.ImagesOnly
    x <- 0
    y <- 0
    layout.y <- [ 124,124,124,124,124,124,124 ]
    layout.x <- [  -960,-320,320, 960, 1600,2240,2880] 
    layout.width <- [440,440, 440, 440,440, 440,440]
    layout.height <- [ 247,247,247,247, 247,247, 247]            
    //layout.alpha <- [ 0, 0, 255, 0, 0 ]
    layout.pinch_x<-[-40,-40,-40,-40,-40,-40,-40]
    zorder <- 2
    anchor <- Wheel.Anchor.Centre
    

    }
}	
local Snapwheel = fe.add_wheel( Snap,PS)
Snapwheel.preserve_aspect_ratio=true

local Bezel =
{
    function init()
    {
    slots <- 5
    speed <- 900
    artwork_label <- "bezel" 
    //vide o_flags <- Vid.ImagesOnly
    x <- 0
    y <- 0
    layout.y <- [ 124,124,124,124,124 ]
    layout.x <- [  -320,320, 960, 1600,2240] 
    layout.width <- [440,440, 440, 440,440]
    layout.height <- [ 245,245,245,245, 245]            
    //layout.alpha <- [ 0, 0, 255, 0, 0 ]
    layout.pinch_x<-[-37,-37,-37,-37,-37]
    zorder <- 3
    anchor <- Wheel.Anchor.Centre
    

    }
}	
local Bezelwheel = fe.add_wheel( Bezel,PS)

/////snap and bezel "wheels"/////////////////



///////front console,overview, animated screen,joystick etc///////////////
local screen_black =fe.add_image("assets/screen_black.png",0,0,1920,1080)
screen_black.zorder=50

local Oversurf=fe.add_surface(368,140)
Oversurf.set_pos( 795,785)
Oversurf.zorder=50
Oversurf.pinch_x=-50
local screen_green =Oversurf.add_image("assets/screen_green.mp4",0,0,360,200)
//Oversurf.alpha=0

local text = Oversurf.add_text( "[Overview]", 20, 0, 280, 600);
text.charsize = 15;
text.word_wrap = true;
text.align = Align.Centre;
text.zorder=50
text.set_rgb(128,255,0)
//text= Inertia( text, 1,"y");



///////////animation for overview....had issues and couldn't get it quite the way i wanted...nevermind//////////
local an2 = { when=Transition.ToNewSelection, property="y", start=text.y=0, end=text.y=0, time=1 }
animation.add( PropertyAnimation( text, an2 ) );

local an2 = { when=Transition.ToNewSelection, property="alpha", start=0, end=0, time=1 }
animation.add( PropertyAnimation( text, an2 ) );

local an2 = { when=Transition.EndNavigation, property="alpha", start=0, end=255,delay=1000 time=1000 }
animation.add( PropertyAnimation( text, an2 ) );
local an = { when=Transition.EndNavigation, property="y", start=text.y=0, end=text.y-500,delay=50 time=40000 }
animation.add( PropertyAnimation( text, an ) );
///////////animation for overview....had issues and couldn't get it quite the way i wanted...nevermind//////////




//MARK: Front console////////

///////front console,overview, animated screen,joystick etc///////////////
local table =fe.add_image("assets/work_station.png",0,0,1920,1080)
table.zorder=50

local joy_base=fe.add_image("assets/joy_base.png",1070,720,220,320)
joy_base.zorder=51

local joy_stick=fe.add_image("assets/joy_stick.png",1070,720,220,320)
joy_stick.zorder=51
joy_stick.rotation_origin_x=0.5
joy_stick.rotation_origin_y=0.709
joy_stick= Inertia( joy_stick , 10,"rotation");

local joy_left=fe.add_image("assets/joy_left.png",600,820,220,220)
joy_left.zorder=51
///////front console,overview, animated screen,joystick etc///////////////


///////////Game to/from animation and Joystick control////////////
 function hyperspaceTransition( ttype, var, ttime )
{
    if( ttype == Transition.StartLayout ||  ttype == Transition.ToNewSelection)
    {
        fromGameVideo.video_playing = false
        toGameVideo.video_playing = false
        toGameVideo.visible = false
        fromGameVideo.visible = false
      
//text.y=0

    }

     if( ttype == Transition.EndNavigation )
    {
        joy_stick.to_rotation=0
     
    }

    if( ttype == Transition.ToGame )
    {
       toGameVideo.visible = true
       fromGameVideo.visible = false

       toGameVideo.video_playing = true
       toGameVideo.video_flags  = Vid.NoLoop
       fromGameVideo.video_playing = false
       

        if( ttime < toGameVideo.video_duration )
            return true
    }
    if( ttype == Transition.FromGame )
        {
        toGameVideo.visible = false
        fromGameVideo.visible = true
        fromGameVideo.video_playing = true
        fromGameVideo.video_flags  = Vid.NoLoop
        toGameVideo.video_playing = false
            
            if( ttime < fromGameVideo.video_duration )
                return true
        }
}


fe.add_transition_callback( "hyperspaceTransition" )


function interationControls(sig)
{
    switch (sig)
    {
        case "left":
            fe.signal("prev_game")
            joy_stick.to_rotation=-15

            return true;
        case "right":
            fe.signal("next_game")
            joy_stick.to_rotation=15

            return true;
        case "up":
            fe.signal("prev_game")

            return true;
        case "down":
            fe.signal("next_game")
			
            return true;
        default:
            return false;
    }
}
fe.add_signal_handler("interationControls");

///////////Game to/from animation and Joystick control////////////

