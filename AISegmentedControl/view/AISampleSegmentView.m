//
//  AISampleSegmentView.m
//  AISegmentedControl
//
//  Created by CocoaToucher on 12/19/12.
//  Copyright (c) 2012 CocoaToucher. All rights reserved.
//

#import "AISampleSegmentView.h"

@interface AISampleSegmentView ()

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation AISampleSegmentView

- (void)dealloc {
#if !(__has_feature(objc_arc))
	[_titleLabel release];
	_titleLabel = nil;
	
	[super dealloc];
#endif
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		_titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
		_titleLabel.textColor = [UIColor blackColor];
		_titleLabel.highlightedTextColor = [UIColor redColor];
		_titleLabel.numberOfLines = 2;
		_titleLabel.backgroundColor = [UIColor clearColor];
		_titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		_titleLabel.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.4f];
		
		_titleLabel.text = NSLocalizedString(@"Custom segment view", nil);
		
		_titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self addSubview:_titleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	
	_titleLabel.highlighted = selected;
}

@end
