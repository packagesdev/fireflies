/*
 Copyright (c) 2015, Stephane Sudre
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 - Neither the name of the WhiteBox nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "FFGLConfigurationSwarmModeViewController.h"

@interface FFGLConfigurationSwarmModeViewController ()
{
    IBOutlet NSTextField * _normalModeTextField;
    IBOutlet NSStepper * _normalModeStepper;
    
    IBOutlet NSTextField * _breatherTextField;
    IBOutlet NSStepper * _breatherStepper;
    
    IBOutlet NSTextField * _loopTextField;
    IBOutlet NSStepper * _loopStepper;
    
    IBOutlet NSTextField * _psychadelicTextField;
    IBOutlet NSStepper * _psychadelicStepper;
    
    IBOutlet NSTextField * _glowingTextField;
    IBOutlet NSStepper * _glowingStepper;
    
    IBOutlet NSTextField * _hyperTextField;
    IBOutlet NSStepper * _hyperStepper;
    
    IBOutlet NSTextField * _fadedTextField;
    IBOutlet NSStepper * _fadedStepper;
}

@end

@implementation FFGLConfigurationSwarmModeViewController

- (NSString *)nibName
{
    return @"FFGLConfigurationSwarmModeViewController";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do view setup here.
}

#pragma mark -

- (void)updateUI
{
    [_normalModeTextField setDoubleValue:_sceneSettings.bModeNormal];
    [_normalModeStepper setDoubleValue:_sceneSettings.bModeNormal];
    
    [_breatherTextField setDoubleValue:_sceneSettings.bModeStop];
    [_breatherStepper setDoubleValue:_sceneSettings.bModeStop];
    
    [_loopTextField setDoubleValue:_sceneSettings.bModeAttractor];
    [_loopStepper setDoubleValue:_sceneSettings.bModeAttractor];
    
    [_psychadelicTextField setDoubleValue:_sceneSettings.bModeRainbow];
    [_psychadelicStepper setDoubleValue:_sceneSettings.bModeRainbow];
    
    [_glowingTextField setDoubleValue:_sceneSettings.bModeGlow];
    [_glowingStepper setDoubleValue:_sceneSettings.bModeGlow];
    
    [_hyperTextField setDoubleValue:_sceneSettings.bModeHyperspeed];
    [_hyperStepper setDoubleValue:_sceneSettings.bModeHyperspeed];
    
    [_fadedTextField setDoubleValue:_sceneSettings.bModeFaded];
    [_fadedStepper setDoubleValue:_sceneSettings.bModeFaded];
}

- (void)updateSettings
{
    _sceneSettings.bModeNormal=[_normalModeStepper doubleValue];
    _sceneSettings.bModeStop=[_breatherStepper doubleValue];
    _sceneSettings.bModeAttractor=[_loopStepper doubleValue];
    _sceneSettings.bModeRainbow=[_psychadelicStepper doubleValue];
    _sceneSettings.bModeGlow=[_glowingStepper doubleValue];
    _sceneSettings.bModeHyperspeed=[_hyperStepper doubleValue];
    _sceneSettings.bModeFaded=[_fadedStepper doubleValue];
}

@end
