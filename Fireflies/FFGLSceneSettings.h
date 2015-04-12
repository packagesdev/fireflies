/*
 Copyright (c) 2015, Stephane Sudre
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 - Neither the name of the WhiteBox nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Cocoa/Cocoa.h>

@interface FFGLSceneSettings : NSObject

@property NSUInteger minimumBaits;
@property NSUInteger maximumBaits;

@property NSUInteger minimumFireflies;
@property NSUInteger maximumFireflies;

@property BOOL drawBaits;

@property double fireflySize;
@property double fireflySpeed;
@property double fireflyAcceleration;

@property double baitSpeed;
@property double baitAcceleration;

@property double colorCycleSpeed;
@property double glowFactor;

@property double tailLength;
@property double tailWidth;
@property double tailOpacity;

@property double windSpeed;

@property double bModeNothing;
@property double bModeNormal;
@property double bModeStop;
@property double bModeAttractor;
@property double bModeRainbow;
@property double bModeGlow;
@property double bModeHyperspeed;
@property double bModeFaded;

@property double sModeNothing;
@property double sModeSwarms;
@property double sModeFlyKill;
@property double sModeFlyBirth;
@property double sModeWindy;
@property double sModeMatrix;
@property double sModeSwarmSplit;
@property double sModeSwarmMerge;

- (id)initWithDictionaryRepresentation:(NSDictionary *)inDictionary;

- (NSDictionary *)dictionaryRepresentation;

- (void)resetToFactorySettings;

@end
