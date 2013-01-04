//
//  AIAnimatedSegmentedControl.m
//  AISegmentedControl
//
//  Created by CocoaToucher on 1/4/13.
//  Copyright (c) 2013 CocoaToucher. All rights reserved.
//

#import "AIAnimatedSegmentedControl.h"
#import "AISegmentedControl_Protected.h"
#import <QuartzCore/QuartzCore.h>

@interface AIAnimatedSegmentedControl ()

@property(nonatomic, strong) UIView *selectionView;

@end

@implementation AIAnimatedSegmentedControl

- (void)awakeFromNib {
	[super awakeFromNib];
	
	UIView *tSelectionView = [[UIView alloc] initWithFrame:CGRectZero];
	self.selectionView = tSelectionView;
#if !(__has_feature(objc_arc))
	[tSelectionView release];
#endif
	self.selectionView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5f];
	self.selectionView.layer.cornerRadius = 5.0f;
	self.selectionView.alpha = 0.0f;
	[self addSubview:self.selectionView];
}

- (void)selectSegmentAtIndex:(NSInteger)inIdx sendActions:(BOOL)sendActions {
	[super selectSegmentAtIndex:inIdx sendActions:sendActions];
	
	if (self.selectedSegmentIndex == NSNotFound) {
		self.selectionView.alpha = 0.0f;
	} else {
		[self moveSelectionToFrame:[self segmentAtIndex:self.selectedSegmentIndex].frame];
	}
}

- (void)moveSelectionToFrame:(CGRect)rect {
	
	if (_selectionView.alpha == 0.0f) {
		_selectionView.frame = rect;
	}
	
	[UIView animateWithDuration:0.3
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
					 animations:^(void) {
						 
						 if (_selectionView.alpha == 0.0f) {
							 _selectionView.alpha = 1.0f;
						 } else {
							_selectionView.frame = rect; 
						 }
						 
					 } completion:nil];
}

- (void)dealloc {
#if !(__has_feature(objc_arc))
	[_selectionView release];
	_selectionView = nil;
	
	[super dealloc];
#endif
}

@end
