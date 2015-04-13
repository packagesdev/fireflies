/*
 Copyright (c) 2015, Stephane Sudre
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 - Neither the name of the WhiteBox nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "FFGLConfigurationWindowController.h"

#import <ScreenSaver/ScreenSaver.h>

#import "FFGLAboutBoxWindowController.h"

#import "FFGLUserDefaults+Constants.h"

#import "FFGLSceneSettings.h"

#import "FFGLConfigurationViewController.h"

#import "FFGLTabHeaderView.h"

enum
{
    FFGLTabGeneralTag=0,
    FFGLTabSwarmModeTag,
    FFGLTabMajorModeTag
};

@interface FFGLConfigurationWindowController ()
{
    IBOutlet FFGLTabHeaderView *_tabHeaderView;
    
    IBOutlet NSView *_segmentView;

    IBOutlet NSButton * _mainScreenCheckBox;
    
    FFGLConfigurationViewController * _currentViewController;
    
    FFGLSceneSettings * _sceneSettings;
    
    BOOL _mainScreenSetting;
}

- (void)showViewControllerNamed:(NSString *)inControllerName;

- (IBAction)showSegmentedView:(id)sender;

- (IBAction)showAboutBox:(id)sender;

- (IBAction)closeDialog:(id)sender;

@end

@implementation FFGLConfigurationWindowController

- (id)init
{
    self=[super init];
    
    if (self!=nil)
    {
        NSString *tIdentifier = [[NSBundle bundleForClass:[self class]] bundleIdentifier];
        ScreenSaverDefaults *tDefaults = [ScreenSaverDefaults defaultsForModuleWithName:tIdentifier];
        
        _sceneSettings=[[FFGLSceneSettings alloc] initWithDictionaryRepresentation:[tDefaults dictionaryRepresentation]];
        
        _mainScreenSetting=[tDefaults boolForKey:FFGLUserDefaultsMainDisplayOnly];
    }
    
    return self;
}

- (NSString *)windowNibName
{
    return @"FFGLConfigurationWindowController";
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Scene Settings
    
        // Select and show General View
    
	[((NSButton *)[_tabHeaderView viewWithTag:FFGLTabGeneralTag]) setState:NSOnState];
	
    [self showViewControllerNamed:@"FFGLConfigurationGeneralViewController"];
    
    // Main Screen
    
    [_mainScreenCheckBox setState:(_mainScreenSetting==YES) ? NSOnState : NSOffState];
}

#pragma mark -

- (void)showViewControllerNamed:(NSString *)inControllerName
{
    if (_currentViewController==nil ||
        [NSStringFromClass([_currentViewController class]) isEqualToString:inControllerName]==NO)
    {
        [_currentViewController willRemoveView];
        
        [_currentViewController.view removeFromSuperview];
        
        _currentViewController=[[NSClassFromString(inControllerName) alloc] initWithSceneSettings:_sceneSettings];
        
        [_currentViewController.view setFrame:[_segmentView bounds]];
        
        [_segmentView addSubview:_currentViewController.view];
        
        [_currentViewController didAddView];
    }
}

#pragma mark -

- (IBAction)showSegmentedView:(id)sender
{
    NSInteger tTag=[sender tag];
    
    switch(tTag)
    {
        case FFGLTabGeneralTag:
            
            [self showViewControllerNamed:@"FFGLConfigurationGeneralViewController"];
            
            break;
            
        case FFGLTabSwarmModeTag:
            
            [self showViewControllerNamed:@"FFGLConfigurationSwarmModeViewController"];
            
            break;
            
        case FFGLTabMajorModeTag:
            
            [self showViewControllerNamed:@"FFGLConfigurationMajorModeViewController"];
            
            break;
            
        default:
            
            NSLog(@"Unknown tag");
            break;
    }
}

- (IBAction)showAboutBox:(id)sender
{
    static FFGLAboutBoxWindowController * sAboutBoxWindowController=nil;
    
    if (sAboutBoxWindowController==nil)
        sAboutBoxWindowController=[FFGLAboutBoxWindowController new];
    
    if ([sAboutBoxWindowController.window isVisible]==NO)
        [sAboutBoxWindowController.window center];
    
    [sAboutBoxWindowController.window makeKeyAndOrderFront:nil];
}

- (IBAction)closeDialog:(id)sender
{
    if ([sender tag]==NSOKButton)
    {
        NSString *tIdentifier = [[NSBundle bundleForClass:[self class]] bundleIdentifier];
        ScreenSaverDefaults *tDefaults = [ScreenSaverDefaults defaultsForModuleWithName:tIdentifier];
        
        // Scene Settings
        
        NSDictionary * tDictionary=[_sceneSettings dictionaryRepresentation];
        
        [tDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *bKey,id bObject, BOOL * bOutStop){
            [tDefaults setObject:bObject forKey:bKey];
        }];
        
        // Main Screen Only
        
        _mainScreenSetting=([_mainScreenCheckBox state]==NSOnState);
        
        [tDefaults setBool:_mainScreenSetting forKey:FFGLUserDefaultsMainDisplayOnly];
        
        [tDefaults synchronize];
    }
    
    [NSApp endSheet:self.window];
}

@end
