
#import "FFGLTabBox.h"

#ifndef NSAppKitVersionNumber10_14
#define NSAppKitVersionNumber10_14 1641.10
#endif

@implementation FFGLTabBox

- (void)awakeFromNib
{
	self.boxType=NSBoxCustom;
	self.borderType=NSNoBorder;
	self.borderWidth=1.0;
	
	self.fillColor=(NSAppKitVersionNumber>=NSAppKitVersionNumber10_14) ? [NSColor controlBackgroundColor] : [NSColor whiteColor];
	self.contentViewMargins=NSZeroSize;
}

@end
