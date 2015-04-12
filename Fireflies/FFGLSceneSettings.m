/*
 Copyright (c) 2015, Stephane Sudre
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 - Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 - Neither the name of the WhiteBox nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "FFGLSceneSettings.h"

NSString * const FFGL_Settings_MinimumFirefliesKey=@"Minimum Fireflies";
NSString * const FFGL_Settings_MaximumFirefliesKey=@"Maximum Fireflies";

NSString * const FFGL_Settings_MinimumBaitsKey=@"Minimum Baits";
NSString * const FFGL_Settings_MaximumBaitsKey=@"Maximum Baits";

NSString * const FFGL_Settings_DrawBaitsKey=@"Draw Baits";

NSString * const FFGL_Settings_FireflySizeKey=@"Firefly Size";
NSString * const FFGL_Settings_FireflySpeedKey=@"Firefly Speed";
NSString * const FFGL_Settings_FireflyAccelerationKey=@"Firefly Acceleration";

NSString * const FFGL_Settings_BaitSpeedKey=@"Bait Speed";
NSString * const FFGL_Settings_BatAccelerationKey=@"Bait Acceleration";

NSString * const FFGL_Settings_ColorCycleSpeedKey=@"Color Cycle Speed";
NSString * const FFGL_Settings_GlowFactorKey=@"Glow Factor";

NSString * const FFGL_Settings_TailLengthKey=@"Tail Length";
NSString * const FFGL_Settings_TailWidthKey=@"Tail Width";
NSString * const FFGL_Settings_TailOpacityKey=@"Tail Opacity";

NSString * const FFGL_Settings_WindSpeedKey=@"Wind Speed";

NSString * const FFGL_Settings_BModeNothingKey=@"bmode0";
NSString * const FFGL_Settings_BModeNormalKey=@"bmode1";
NSString * const FFGL_Settings_BModeStopKey=@"bmode2";
NSString * const FFGL_Settings_BModeAttractorKey=@"bmode3";
NSString * const FFGL_Settings_BModeRainbowKey=@"bmode4";
NSString * const FFGL_Settings_BModeGlowKey=@"bmode5";
NSString * const FFGL_Settings_BModeHyperspeedKey=@"bmode6";
NSString * const FFGL_Settings_BModeFadedKey=@"bmode7";

NSString * const FFGL_Settings_SModeNothingKey=@"smode0";
NSString * const FFGL_Settings_SModeSwarmsKey=@"smode1";
NSString * const FFGL_Settings_SModeFlyKillKey=@"smode2";
NSString * const FFGL_Settings_SModeFlyBirthKey=@"smode3";
NSString * const FFGL_Settings_SModeWindyKey=@"smode4";
NSString * const FFGL_Settings_SModeMatrixKey=@"smode5";
NSString * const FFGL_Settings_SModeSwarmSplitKey=@"smode6";
NSString * const FFGL_Settings_SModeSwarmMergeKey=@"smode7";

@implementation FFGLSceneSettings

- (id)initWithDictionaryRepresentation:(NSDictionary *)inDictionary
{
	self=[super init];
	
	if (self!=nil)
	{
		[self resetToFactorySettings];
		
		NSNumber * tNumber=inDictionary[FFGL_Settings_MinimumBaitsKey];
		if (tNumber!=nil)
			_minimumBaits=[tNumber unsignedIntegerValue];
		
		tNumber=inDictionary[FFGL_Settings_MaximumBaitsKey];
		if (tNumber!=nil)
			_maximumBaits=[tNumber unsignedIntegerValue];
		
		
		tNumber=inDictionary[FFGL_Settings_MinimumFirefliesKey];
		if (tNumber!=nil)
			_minimumFireflies=[tNumber unsignedIntegerValue];
		
		tNumber=inDictionary[FFGL_Settings_MaximumFirefliesKey];
		if (tNumber!=nil)
			_maximumFireflies=[tNumber unsignedIntegerValue];
		
		
		tNumber=inDictionary[FFGL_Settings_DrawBaitsKey];
		if (tNumber!=nil)
			_drawBaits=[tNumber boolValue];
		
		
		tNumber=inDictionary[FFGL_Settings_FireflySizeKey];
		if (tNumber!=nil)
			_fireflySize=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_FireflySpeedKey];
		if (tNumber!=nil)
			_fireflySpeed=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_FireflyAccelerationKey];
		if (tNumber!=nil)
			_fireflyAcceleration=[tNumber doubleValue];
		
		
		tNumber=inDictionary[FFGL_Settings_BaitSpeedKey];
		if (tNumber!=nil)
			_baitSpeed=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_BatAccelerationKey];
		if (tNumber!=nil)
			_baitAcceleration=[tNumber doubleValue];
		
		
		tNumber=inDictionary[FFGL_Settings_ColorCycleSpeedKey];
		if (tNumber!=nil)
			_colorCycleSpeed=[tNumber doubleValue];
		tNumber=inDictionary[FFGL_Settings_GlowFactorKey];
		
		if (tNumber!=nil)
			_glowFactor=[tNumber doubleValue];
		
		
		tNumber=inDictionary[FFGL_Settings_TailLengthKey];
		if (tNumber!=nil)
			_tailLength=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_TailWidthKey];
		if (tNumber!=nil)
			_tailWidth=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_TailOpacityKey];
		if (tNumber!=nil)
			_tailOpacity=[tNumber doubleValue];
		
		
		tNumber=inDictionary[FFGL_Settings_WindSpeedKey];
		
		if (tNumber!=nil)
			_windSpeed=[tNumber doubleValue];
		
		
		tNumber=inDictionary[FFGL_Settings_BModeNothingKey];
		
		if (tNumber!=nil)
			_bModeNothing=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_BModeNormalKey];
		
		if (tNumber!=nil)
			_bModeNormal=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_BModeStopKey];
		
		if (tNumber!=nil)
			_bModeStop=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_BModeAttractorKey];
		
		if (tNumber!=nil)
			_bModeAttractor=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_BModeRainbowKey];
		
		if (tNumber!=nil)
			_bModeRainbow=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_BModeGlowKey];
		
		if (tNumber!=nil)
			_bModeGlow=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_BModeHyperspeedKey];
		
		if (tNumber!=nil)
			_bModeHyperspeed=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_BModeFadedKey];
		
		if (tNumber!=nil)
			_bModeFaded=[tNumber doubleValue];

		
		tNumber=inDictionary[FFGL_Settings_SModeNothingKey];
		
		if (tNumber!=nil)
			_sModeNothing=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_SModeSwarmsKey];
		
		if (tNumber!=nil)
			_sModeSwarms=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_SModeFlyKillKey];
		
		if (tNumber!=nil)
			_sModeFlyKill=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_SModeFlyBirthKey];
		
		if (tNumber!=nil)
			_sModeFlyBirth=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_SModeWindyKey];
		
		if (tNumber!=nil)
			_sModeWindy=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_SModeMatrixKey];
		
		if (tNumber!=nil)
			_sModeMatrix=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_SModeSwarmSplitKey];
		
		if (tNumber!=nil)
			_sModeSwarmSplit=[tNumber doubleValue];
		
		tNumber=inDictionary[FFGL_Settings_SModeSwarmMergeKey];
		
		if (tNumber!=nil)
			_sModeSwarmMerge=[tNumber doubleValue];
	}
	
	return self;
}

#pragma mark -

- (NSDictionary *)dictionaryRepresentation
{
	NSMutableDictionary * tMutableDictionary=[NSMutableDictionary dictionary];
	
	if (tMutableDictionary!=nil)
	{
		tMutableDictionary[FFGL_Settings_MinimumBaitsKey]=@(_minimumBaits);
		tMutableDictionary[FFGL_Settings_MaximumBaitsKey]=@(_maximumBaits);
		
		tMutableDictionary[FFGL_Settings_MinimumFirefliesKey]=@(_minimumFireflies);
		tMutableDictionary[FFGL_Settings_MaximumFirefliesKey]=@(_maximumFireflies);
		
		tMutableDictionary[FFGL_Settings_DrawBaitsKey]=@(_drawBaits);
		
		tMutableDictionary[FFGL_Settings_FireflySizeKey]=@(_fireflySize);
		tMutableDictionary[FFGL_Settings_FireflySpeedKey]=@(_fireflySpeed);
		tMutableDictionary[FFGL_Settings_FireflyAccelerationKey]=@(_fireflyAcceleration);
		
		tMutableDictionary[FFGL_Settings_BaitSpeedKey]=@(_baitSpeed);
		tMutableDictionary[FFGL_Settings_BatAccelerationKey]=@(_baitAcceleration);
		
		tMutableDictionary[FFGL_Settings_ColorCycleSpeedKey]=@(_colorCycleSpeed);
		tMutableDictionary[FFGL_Settings_GlowFactorKey]=@(_glowFactor);
		
		tMutableDictionary[FFGL_Settings_TailLengthKey]=@(_tailLength);
		tMutableDictionary[FFGL_Settings_TailWidthKey]=@(_tailWidth);
		tMutableDictionary[FFGL_Settings_TailOpacityKey]=@(_tailOpacity);
		
		tMutableDictionary[FFGL_Settings_WindSpeedKey]=@(_windSpeed);
		
		tMutableDictionary[FFGL_Settings_BModeNothingKey]=@(_bModeNothing);
		tMutableDictionary[FFGL_Settings_BModeNormalKey]=@(_bModeNormal);
		tMutableDictionary[FFGL_Settings_BModeStopKey]=@(_bModeStop);
		tMutableDictionary[FFGL_Settings_BModeAttractorKey]=@(_bModeAttractor);
		tMutableDictionary[FFGL_Settings_BModeRainbowKey]=@(_bModeRainbow);
		tMutableDictionary[FFGL_Settings_BModeGlowKey]=@(_bModeGlow);
		tMutableDictionary[FFGL_Settings_BModeHyperspeedKey]=@(_bModeHyperspeed);
		tMutableDictionary[FFGL_Settings_BModeFadedKey]=@(_bModeFaded);
		
		tMutableDictionary[FFGL_Settings_SModeNothingKey]=@(_sModeNothing);
		tMutableDictionary[FFGL_Settings_SModeSwarmsKey]=@(_sModeSwarms);
		tMutableDictionary[FFGL_Settings_SModeFlyKillKey]=@(_sModeFlyKill);
		tMutableDictionary[FFGL_Settings_SModeFlyBirthKey]=@(_sModeFlyBirth);
		tMutableDictionary[FFGL_Settings_SModeWindyKey]=@(_sModeWindy);
		tMutableDictionary[FFGL_Settings_SModeMatrixKey]=@(_sModeMatrix);
		tMutableDictionary[FFGL_Settings_SModeSwarmSplitKey]=@(_sModeSwarmSplit);
		tMutableDictionary[FFGL_Settings_SModeSwarmMergeKey]=@(_sModeSwarmMerge);
	}
	
	return [tMutableDictionary copy];
}

#pragma mark -

- (void)resetToFactorySettings
{
	_minimumBaits=2;
	_maximumBaits=5;
	
	_minimumFireflies=100;
	_maximumFireflies=175;
	
	_drawBaits=NO;
	
	_fireflySize=1.5;
	_fireflySpeed=100.;
	_fireflyAcceleration=300.;
	
	_baitSpeed=50.0;
	_baitAcceleration=600.0;
	
	_colorCycleSpeed=15.0;
	_glowFactor=2.0;
	
	_tailLength=2.25;
	_tailWidth=2.5;
	_tailOpacity=0.6;
	
	_windSpeed=3.0;
	
	_bModeNothing=10;
	_bModeNormal=20;
	_bModeStop=10;
	_bModeAttractor=10;
	_bModeRainbow=10;
	_bModeGlow=15;
	_bModeHyperspeed=10;
	_bModeFaded=10;
	
	_sModeNothing=10;
	_sModeSwarms=5;
	_sModeFlyKill=10;
	_sModeFlyBirth=10;
	_sModeWindy=10;
	_sModeMatrix=10;
	_sModeSwarmSplit=10;
	_sModeSwarmMerge=10;
}

@end
