
#import "CheckmarkTile.h"

@implementation CheckmarkTile

@synthesize checkmarked;

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGFloat width = self.bounds.size.width;
	CGFloat height = self.bounds.size.height;
	
	// Draw the checkmark if applicable
    if (self.checkmarked) {
        unichar	character = 0x2713; //Unicode checkmark
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [[UIColor colorWithHue:0.4f saturation:0.8f brightness:0.8f alpha:1.f] CGColor]);
        CGContextSetShadowWithColor(ctx, CGSizeMake(0.0f, -1.0f), 1.0f, [[UIColor blackColor] CGColor]);
        NSString *checkmark = [NSString stringWithCharacters:&character length:1];
        [checkmark drawInRect:CGRectMake(4, 4, width-8, height-8) withFont: [UIFont boldSystemFontOfSize:0.89f*width] lineBreakMode: UILineBreakModeClip alignment: UITextAlignmentCenter];
        CGContextRestoreGState(ctx);
    }
}

@end
