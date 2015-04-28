
#import "FFGLFirefliesView.h"

#import "FFGLConfigurationWindowController.h"

#import "FFGLUserDefaults+Constants.h"

#import "FFGLSceneSettings.h"

#include "scene.h"
#include "modes.h"

#include <sys/time.h>


@interface FFGLFirefliesView ()
{
    BOOL _preview;
    BOOL _mainScreen;
    
    BOOL _OpenGLIncompatibilityDetected;
    
    NSOpenGLView *_openGLView;
    
    Scene * _scene;
    long long _lastTick;	// in milliseconds
	
    // Preferences
    
    FFGLConfigurationWindowController *_configurationWindowController;
}

+ (long long) _timeOfDay;
+ (void)_initializeScene:(Scene *)inScene withSettings:(FFGLSceneSettings *)inSettings;

@end

@implementation FFGLFirefliesView

+ (long long) _timeOfDay
{
	struct timeval tTime;
	
	gettimeofday(&tTime, NULL);
	
	return (tTime.tv_sec*1000+tTime.tv_usec/1000);
}

+ (void)_initializeScene:(Scene *)inScene withSettings:(FFGLSceneSettings *)inSettings
{
	if (inScene!=NULL && inSettings!=nil)
	{
		inScene->minbaits=(unsigned int)inSettings.minimumBaits;
		inScene->maxbaits=(unsigned int)inSettings.maximumBaits;
		
		inScene->minflies=(unsigned int)inSettings.minimumFireflies;
		inScene->maxflies=(unsigned int)inSettings.maximumFireflies;
		
		inScene->draw_bait=inSettings.drawBaits;
		
		inScene->fsize=inSettings.fireflySize;
		inScene->fspeed=inSettings.fireflySpeed;
		inScene->faccel=inSettings.fireflyAcceleration;
		
		inScene->bspeed=inSettings.baitSpeed;
		inScene->baccel=inSettings.baitAcceleration;
		
		inScene->hue_rate=inSettings.colorCycleSpeed;
		inScene->glow_factor=inSettings.glowFactor;
		
		inScene->tail_length=inSettings.tailLength;
		inScene->tail_width=inSettings.tailWidth;
		inScene->tail_opaq=inSettings.tailOpacity;
		
		inScene->wind_speed=inSettings.windSpeed;
		
		inScene->bmodes.change(BMODE_NORMAL, inSettings.bModeNormal);
		inScene->bmodes.change(BMODE_STOP, inSettings.bModeStop);
		inScene->bmodes.change(BMODE_ATTRACTOR, inSettings.bModeAttractor);
		inScene->bmodes.change(BMODE_RAINBOW, inSettings.bModeRainbow);
		inScene->bmodes.change(BMODE_GLOW, inSettings.bModeGlow);
		inScene->bmodes.change(BMODE_HYPERSPEED, inSettings.bModeHyperspeed);
		inScene->bmodes.change(BMODE_FADED, inSettings.bModeFaded);
		
		inScene->smodes.change(SMODE_SWARMS, inSettings.sModeSwarms);
		inScene->smodes.change(SMODE_FLYKILL, inSettings.sModeFlyKill);
		inScene->smodes.change(SMODE_FLYBIRTH, inSettings.sModeFlyBirth);
		inScene->smodes.change(SMODE_WINDY, inSettings.sModeWindy);
		inScene->smodes.change(SMODE_MATRIX, inSettings.sModeMatrix);
		inScene->smodes.change(SMODE_SWARMSPLIT, inSettings.sModeSwarmSplit);
		inScene->smodes.change(SMODE_SWARMMERGE, inSettings.sModeSwarmMerge);
	}
}

#pragma mark -

- (instancetype)initWithFrame:(NSRect)frameRect isPreview:(BOOL)isPreview
{
    self=[super initWithFrame:frameRect isPreview:isPreview];
    
    if (self!=nil)
    {
        _preview=isPreview;
        
        if (_preview==YES)
            _mainScreen=YES;
        else
            _mainScreen= (NSMinX(frameRect)==0 && NSMinY(frameRect)==0);
        
        [self setAnimationTimeInterval:0.05];
    }
    
    return self;
}

#pragma mark -

- (void) setFrameSize:(NSSize)newSize
{
    [super setFrameSize:newSize];
    
    if (_openGLView!=nil)
        [_openGLView setFrameSize:newSize];
}

#pragma mark -

- (void) drawRect:(NSRect) inFrame
{
    [[NSColor blackColor] set];
    
    NSRectFill(inFrame);
    
    if (_OpenGLIncompatibilityDetected==YES)
    {
        BOOL tShowErrorMessage=_mainScreen;
        
        if (tShowErrorMessage==NO)
        {
            NSString *tIdentifier = [[NSBundle bundleForClass:[self class]] bundleIdentifier];
            ScreenSaverDefaults *tDefaults = [ScreenSaverDefaults defaultsForModuleWithName:tIdentifier];
            
            tShowErrorMessage=![tDefaults boolForKey:FFGLUserDefaultsMainDisplayOnly];
        }
        
        if (tShowErrorMessage==YES)
        {
            NSRect tFrame=[self frame];
            
            NSMutableParagraphStyle * tMutableParagraphStyle=[[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            [tMutableParagraphStyle setAlignment:NSCenterTextAlignment];
            
            NSDictionary * tAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont systemFontOfSize:[NSFont systemFontSize]],NSFontAttributeName,
                                          [NSColor whiteColor],NSForegroundColorAttributeName,
                                          tMutableParagraphStyle,NSParagraphStyleAttributeName,nil];
            
            
            NSString * tString=NSLocalizedStringFromTableInBundle(@"Minimum OpenGL requirements\rfor this Screen Effect\rnot available\ron your graphic card.",@"Localizable",[NSBundle bundleForClass:[self class]],@"No comment");
            
            NSRect tStringFrame;
            
            tStringFrame.origin=NSZeroPoint;
            tStringFrame.size=[tString sizeWithAttributes:tAttributes];
            
            tStringFrame=SSCenteredRectInRect(tStringFrame,tFrame);
            
            [tString drawInRect:tStringFrame withAttributes:tAttributes];
        }
    }
}

#pragma mark -

- (void)startAnimation
{
    _OpenGLIncompatibilityDetected=NO;
    
    [super startAnimation];
    
    NSString *tIdentifier = [[NSBundle bundleForClass:[self class]] bundleIdentifier];
    ScreenSaverDefaults *tDefaults = [ScreenSaverDefaults defaultsForModuleWithName:tIdentifier];

    BOOL tBool=[tDefaults boolForKey:FFGLUserDefaultsMainDisplayOnly];
    
    if (tBool==YES && _mainScreen==NO)
        return;
	
    // Add OpenGLView
    
    NSOpenGLPixelFormatAttribute attribs[] =
    {
        NSOpenGLPFADoubleBuffer,
        NSOpenGLPFADepthSize,(NSOpenGLPixelFormatAttribute)16,
        NSOpenGLPFAMinimumPolicy,
        (NSOpenGLPixelFormatAttribute)0
    };
    
    NSOpenGLPixelFormat *tFormat = [[NSOpenGLPixelFormat alloc] initWithAttributes:attribs];
    
    if (tFormat==nil)
    {
        _OpenGLIncompatibilityDetected=YES;
        return;
    }
    _openGLView = [[NSOpenGLView alloc] initWithFrame:[self bounds] pixelFormat:tFormat];
    
    if (_openGLView!=nil)
    {
        [_openGLView setWantsBestResolutionOpenGLSurface:YES];
        
        [self addSubview:_openGLView];
    }
    else
    {
        _OpenGLIncompatibilityDetected=YES;
        return;
    }
    
    [self lockFocus];
    
    [[_openGLView openGLContext] makeCurrentContext];
    
    glClearColor(1.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [[_openGLView openGLContext] flushBuffer];
    
    NSRect tPixelBounds=[_openGLView convertRectToBacking:[_openGLView bounds]];
    NSSize tSize=tPixelBounds.size;
    
	_scene=new Scene();
	
	if (_scene!=NULL)
	{
		_scene->resize((int)tSize.width, (int)tSize.height);
		_scene->create();
		
		[FFGLFirefliesView _initializeScene:_scene
							   withSettings:[[FFGLSceneSettings alloc] initWithDictionaryRepresentation:[tDefaults dictionaryRepresentation]]];
		
		_lastTick=[FFGLFirefliesView _timeOfDay];
	}
	
    const GLint tSwapInterval=1;
    CGLSetParameter(CGLGetCurrentContext(), kCGLCPSwapInterval,&tSwapInterval);
    
    [self unlockFocus];
}

- (void)stopAnimation
{
    [super stopAnimation];
	
	if (_scene!=NULL)
	{
		delete _scene;
		_scene=NULL;
	}
}

- (void)animateOneFrame
{
	if (_openGLView!=nil)
	{
		[[_openGLView openGLContext] makeCurrentContext];
		
		glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
			
		if (_scene!=NULL)
		{
			long long tCurentTick=[FFGLFirefliesView _timeOfDay];
			
			_scene->elapse((tCurentTick-_lastTick)*0.001);
			
			_scene->apply_camera();
			_scene->draw();
			
			_lastTick=tCurentTick;
		}
		
		glFinish();
			
		[[_openGLView openGLContext] flushBuffer];
	}
}

#pragma mark - Configuration

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
	if (_configurationWindowController==nil)
		_configurationWindowController=[[FFGLConfigurationWindowController alloc] init];
	
	NSWindow * tWindow=_configurationWindowController.window;
	
	[_configurationWindowController restoreUI];
	
	return tWindow;
}

@end
