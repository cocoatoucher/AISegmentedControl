//
//  AIIOSSegmentedControl.m
//  AISegmentedControl
//
//  Created by CocoaToucher on 1/3/13.
//  Copyright (c) 2013 CocoaToucher. All rights reserved.
//

#import "AIIOSSegmentedControl.h"


@interface AIIOSSegmentButton : UIButton

@end

@implementation AIIOSSegmentButton

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.titleLabel.numberOfLines = 2;
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
		
		[self setTitleColor:[UIColor blackColor]
				   forState:UIControlStateNormal];
	}
	return self;
}

@end

@implementation AIIOSSegmentedControl

- (void)insertSegmentWithTitle:(NSString *)inTitle atIndex:(NSInteger)inIndex {
	AIIOSSegmentButton *btn = [[AIIOSSegmentButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.fixedSegmentWidth, 57.0f)];
	[btn setTitle:inTitle forState:UIControlStateNormal];
	
	[self insertSegment:btn atIndex:inIndex];
	
	for (AIIOSSegmentButton *btn in self.segmentViews) {
		NSInteger btnIdx = [self.segmentViews indexOfObject:btn];
		
		UIImage *normalImage = nil;
		UIImage *selectedImage = nil;
		
		if (btnIdx == 0) {
			normalImage = [UIImage imageNamed:@"segment_left_0.png"];
			selectedImage = [UIImage imageNamed:@"segment_left_1.png"];
		} else if (btnIdx == self.segmentViews.count - 1) {
			normalImage = [UIImage imageNamed:@"segment_right_0.png"];
			selectedImage = [UIImage imageNamed:@"segment_right_1.png"];
		} else {
			normalImage = [UIImage imageNamed:@"segment_middle_0.png"];
			selectedImage = [UIImage imageNamed:@"segment_middle_1.png"];
		}
		
		[btn setBackgroundImage:[normalImage stretchableImageWithLeftCapWidth:27 topCapHeight:0] forState:UIControlStateNormal];
		[btn setBackgroundImage:[selectedImage stretchableImageWithLeftCapWidth:27 topCapHeight:0] forState:UIControlStateSelected];
	}
	
#if !(__has_feature(objc_arc))
	[btn release];
#endif
}

@end
