/*
 Copyright (c) 2015, Stephane Sudre
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 - Neither the name of the WhiteBox nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "FFGLConfigurationGeneralViewController.h"

@interface FFGLConfigurationGeneralViewController ()
{
    IBOutlet NSTextField * _minimumBaitsTextField;
    IBOutlet NSStepper * _minimumBaitsStepper;
    
    IBOutlet NSTextField * _maximumBaitsTextField;
    IBOutlet NSStepper * _maximumBaitsStepper;
    
    IBOutlet NSTextField * _minimumFirefliesTextField;
    IBOutlet NSStepper * _minimumFirefliesStepper;
    
    IBOutlet NSTextField * _maximumFirefliesTextField;
    IBOutlet NSStepper * _maximumFirefliesStepper;
    
    IBOutlet NSButton * _drawBaits_;
    
    IBOutlet NSTextField * _fireflySizeTextField;
    IBOutlet NSStepper * _fireflySizeStepper;
    
    IBOutlet NSTextField * _fireflySpeedTextField;
    IBOutlet NSStepper * _fireflySpeedStepper;
    
    IBOutlet NSTextField * _fireflyAccelerationTextField;
    IBOutlet NSStepper * _fireflyAccelerationStepper;
    
    IBOutlet NSTextField * _baitSpeedTextField;
    IBOutlet NSStepper * _baitSpeedStepper;
    
    IBOutlet NSTextField * _baitAccelerationTextField;
    IBOutlet NSStepper * _baitAccelerationStepper;
    
    IBOutlet NSTextField * _colorCycleSpeedTextField;
    IBOutlet NSStepper * _colorCycleSpeedStepper;
    
    IBOutlet NSTextField * _glowFactorTextField;
    IBOutlet NSStepper * _glowFactorStepper;
    
    IBOutlet NSTextField * _tailLengthTextField;
    IBOutlet NSStepper * _tailLengthStepper;
    
    IBOutlet NSTextField * _tailWidthTextField;
    IBOutlet NSStepper * _tailWidthStepper;
    
    IBOutlet NSTextField * _tailOpacityTextField;
    IBOutlet NSStepper * _tailOpacityStepper;
    
    IBOutlet NSTextField * _windSpeedTextField;
    IBOutlet NSStepper * _windSpeedStepper;
}

@end

@implementation FFGLConfigurationGeneralViewController

- (NSString *)nibName
{
    return @"FFGLConfigurationGeneralViewController";
}

#pragma mark -

- (void)restoreUI
{
    [_minimumBaitsTextField setIntegerValue:_sceneSettings.minimumBaits];
    [_minimumBaitsStepper setIntegerValue:_sceneSettings.minimumBaits];
    
    [_maximumBaitsTextField setIntegerValue:_sceneSettings.maximumBaits];
    [_maximumBaitsStepper setIntegerValue:_sceneSettings.maximumBaits];
    
    
    [_minimumFirefliesTextField setIntegerValue:_sceneSettings.minimumFireflies];
    [_minimumFirefliesStepper setIntegerValue:_sceneSettings.minimumFireflies];
    
    [_maximumFirefliesTextField setIntegerValue:_sceneSettings.maximumFireflies];
    [_maximumFirefliesStepper setIntegerValue:_sceneSettings.maximumFireflies];
    
    
    [_drawBaits_ setState:(_sceneSettings.drawBaits==YES) ? NSOnState : NSOffState];
    
    
    [_fireflySizeTextField setDoubleValue:_sceneSettings.fireflySize];
    [_fireflySizeStepper setDoubleValue:_sceneSettings.fireflySize];
     
    [_fireflySpeedTextField setDoubleValue:_sceneSettings.fireflySpeed];
    [_fireflySpeedStepper setDoubleValue:_sceneSettings.fireflySpeed];
       
    [_fireflyAccelerationTextField setDoubleValue:_sceneSettings.fireflyAcceleration];
    [_fireflyAccelerationStepper setDoubleValue:_sceneSettings.fireflyAcceleration];
    
    
    [_baitSpeedTextField setDoubleValue:_sceneSettings.baitSpeed];
    [_baitSpeedStepper setDoubleValue:_sceneSettings.baitSpeed];
    
    [_baitAccelerationTextField setDoubleValue:_sceneSettings.baitAcceleration];
    [_baitAccelerationStepper setDoubleValue:_sceneSettings.baitAcceleration];
    
    
    [_colorCycleSpeedTextField setDoubleValue:_sceneSettings.colorCycleSpeed];
    [_colorCycleSpeedStepper setDoubleValue:_sceneSettings.colorCycleSpeed];
      
    [_glowFactorTextField setDoubleValue:_sceneSettings.glowFactor];
    [_glowFactorStepper setDoubleValue:_sceneSettings.glowFactor];
     
       
    [_tailLengthTextField setDoubleValue:_sceneSettings.tailLength];
    [_tailLengthStepper setDoubleValue:_sceneSettings.tailLength];
        
    [_tailWidthTextField setDoubleValue:_sceneSettings.tailWidth];
    [_tailWidthStepper setDoubleValue:_sceneSettings.tailWidth];
         
    [_tailOpacityTextField setDoubleValue:_sceneSettings.tailOpacity];
    [_tailOpacityStepper setDoubleValue:_sceneSettings.tailOpacity];
     
          
    [_windSpeedTextField setDoubleValue:_sceneSettings.windSpeed];
    [_windSpeedStepper setDoubleValue:_sceneSettings.windSpeed];
}

- (void)updateSettings
{
    _sceneSettings.minimumBaits=[_minimumBaitsStepper integerValue];
    _sceneSettings.maximumBaits=[_maximumBaitsStepper integerValue];
    
    _sceneSettings.minimumFireflies=[_minimumFirefliesStepper integerValue];
    _sceneSettings.maximumFireflies=[_maximumFirefliesStepper integerValue];
    
    _sceneSettings.drawBaits=([_drawBaits_ state]==NSOnState);
    
    _sceneSettings.fireflySize=[_fireflySizeStepper doubleValue];
    _sceneSettings.fireflySpeed=[_fireflySpeedStepper doubleValue];
    _sceneSettings.fireflyAcceleration=[_fireflyAccelerationStepper doubleValue];
    
    _sceneSettings.baitSpeed=[_baitSpeedStepper doubleValue];
    _sceneSettings.baitAcceleration=[_baitAccelerationStepper doubleValue];
    
    _sceneSettings.colorCycleSpeed=[_colorCycleSpeedStepper doubleValue];
    _sceneSettings.glowFactor=[_glowFactorStepper doubleValue];
    
    _sceneSettings.tailLength=[_tailLengthStepper doubleValue];
    _sceneSettings.tailWidth=[_tailWidthStepper doubleValue];
    _sceneSettings.tailOpacity=[_tailOpacityStepper doubleValue];
    
    _sceneSettings.windSpeed=[_windSpeedStepper doubleValue];
}

@end
