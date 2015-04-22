/*
 Copyright (c) 2015, Stephane Sudre
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 - Neither the name of the WhiteBox nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "FFGLConfigurationMajorModeViewController.h"

@interface FFGLConfigurationMajorModeViewController ()
{
    IBOutlet NSTextField * _allModeTextField;
    IBOutlet NSStepper * _allModeStepper;
    
    IBOutlet NSTextField * _killTextField;
    IBOutlet NSStepper * _killStepper;
    
    IBOutlet NSTextField * _createTextField;
    IBOutlet NSStepper * _createStepper;
    
    IBOutlet NSTextField * _pickupTextField;
    IBOutlet NSStepper * _pickupStepper;
    
    IBOutlet NSTextField * _matrixTextField;
    IBOutlet NSStepper * _matrixStepper;
    
    IBOutlet NSTextField * _splitTextField;
    IBOutlet NSStepper * _splitStepper;
    
    IBOutlet NSTextField * _mergeTextField;
    IBOutlet NSStepper * _mergeStepper;
}

@end

@implementation FFGLConfigurationMajorModeViewController

- (NSString *)nibName
{
    return @"FFGLConfigurationMajorModeViewController";
}

#pragma mark -

- (void)updateUI
{
    [_allModeTextField setDoubleValue:_sceneSettings.sModeSwarms];
    [_allModeStepper setDoubleValue:_sceneSettings.sModeSwarms];
    
    [_killTextField setDoubleValue:_sceneSettings.sModeFlyKill];
    [_killStepper setDoubleValue:_sceneSettings.sModeFlyKill];
    
    [_createTextField setDoubleValue:_sceneSettings.sModeFlyBirth];
    [_createStepper setDoubleValue:_sceneSettings.sModeFlyBirth];
    
    [_pickupTextField setDoubleValue:_sceneSettings.sModeWindy];
    [_pickupStepper setDoubleValue:_sceneSettings.sModeWindy];
    
    [_matrixTextField setDoubleValue:_sceneSettings.sModeMatrix];
    [_matrixStepper setDoubleValue:_sceneSettings.sModeMatrix];
    
    [_splitTextField setDoubleValue:_sceneSettings.sModeSwarmSplit];
    [_splitStepper setDoubleValue:_sceneSettings.sModeSwarmSplit];
    
    [_mergeTextField setDoubleValue:_sceneSettings.sModeSwarmMerge];
    [_mergeStepper setDoubleValue:_sceneSettings.sModeSwarmMerge];
}

- (void)updateSettings
{
    _sceneSettings.sModeSwarms=[_allModeStepper doubleValue];
    _sceneSettings.sModeFlyKill=[_killStepper doubleValue];
    _sceneSettings.sModeFlyBirth=[_createStepper doubleValue];
    _sceneSettings.sModeWindy=[_pickupStepper doubleValue];
    _sceneSettings.sModeMatrix=[_matrixStepper doubleValue];
    _sceneSettings.sModeSwarmSplit=[_splitStepper doubleValue];
    _sceneSettings.sModeSwarmMerge=[_mergeStepper doubleValue];
}

@end
