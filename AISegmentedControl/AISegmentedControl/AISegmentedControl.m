//
//  AISegmentedControl.m
//  AISegmentedControl
//
//  Created by CocoaToucher on 12/19/12.
//  Copyright (c) 2012 CocoaToucher. All rights reserved.
//

#import "AISegmentedControl.h"
#import "AISegmentedControl_Protected.h"

@interface AISeparatorOverlayView : UIView

@property(nonatomic, strong) UIImage *separatorImage;
@property(nonatomic, strong) NSMutableArray *segmentViews;

@end

@implementation AISeparatorOverlayView

- (void)dealloc {
#if !(__has_feature(objc_arc))
	[_separatorImage release];
	_separatorImage = nil;
	[_segmentViews release];
	_segmentViews = nil;
	
	[super dealloc];
#endif
}

- (void)drawRect:(CGRect)rect {
	
	if (self.separatorImage == nil)
		return;
	
	for (UIView *view in self.segmentViews) {
		if ([[self.segmentViews lastObject] isEqual:view])
			break;
		
		CGFloat originX = view.frame.origin.y + view.frame.size.width - floorf(self.separatorImage.size.width / 2.0f);
		
		[self.separatorImage drawInRect:CGRectMake(originX, 0.0f, self.separatorImage.size.width, self.separatorImage.size.height)];
	}
	
}

@end

@interface AISegmentedControl ()

@property(nonatomic) BOOL isFixedSegmentWidthSet;
@property(nonatomic, strong) NSMutableArray *segmentViews;
@property(nonatomic, strong) NSMutableArray *hitButtons;
@property(nonatomic, strong) UIView *separatorOverlayView;
@property(nonatomic, strong) AISeparatorOverlayView *separatorOverlay;

- (void)selectSegmentAtIndex:(NSInteger)inIdx sendActions:(BOOL)sendActions;

@end

@implementation AISegmentedControl

- (id)init {
	self = [super init];
	if (self) {
		[self initialize];
	}
	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	
	[self initialize];
}

- (void)initialize {
	self.segmentViews = [NSMutableArray array];
	self.hitButtons = [NSMutableArray array];
	
	AISeparatorOverlayView *tOverlay = [[AISeparatorOverlayView alloc] initWithFrame:self.bounds];
	self.separatorOverlay = tOverlay;
#if !(__has_feature(objc_arc))
	[tOverlay release];
#endif
	self.separatorOverlay.backgroundColor = [UIColor clearColor];
	self.separatorOverlay.userInteractionEnabled = NO;
	self.separatorOverlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.separatorOverlay.segmentViews = self.segmentViews;
	[self addSubview:self.separatorOverlay];
	
	_selectedSegmentIndex = NSNotFound;
}

- (void)addSubview:(UIView *)view {
	[super addSubview:view];
	
	[self bringSubviewToFront:self.separatorOverlay];
}

- (void)dealloc
{
#if !(__has_feature(objc_arc))
	[_segmentViews release];
	_segmentViews = nil;
	[_hitButtons release];
	_hitButtons = nil;
	[_separatorImage release];
	_separatorImage = nil;
	[_separatorOverlay release];
	_separatorOverlay = nil;
	
    [super dealloc];
#endif
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat originX = 0.0f;
	
	for (UIView *view in self.segmentViews) {
		CGRect rect = view.frame;
		rect.origin.x = originX;
		rect.origin.y = 0.0f;
		
		if (self.isFixedSegmentWidthSet) {
			rect.size.width = self.fixedSegmentWidth;
		}
		
		view.frame = rect;
		originX += rect.size.width;
		
		UIButton *btnHit = [self.hitButtons objectAtIndex:[self.segmentViews indexOfObject:view]];
		btnHit.frame = view.frame;
	}
	
	[self.separatorOverlay setNeedsDisplay];
	
	self.frame = self.frame;
}

- (void)setFrame:(CGRect)frame {
	if (self.segmentViews.count > 0) {
		CGFloat totalWidth = 0.0f;
		CGFloat maxHeight = 0.0f;
		
		for (UIView *view in self.segmentViews) {
			CGRect rect = view.frame;
			rect.origin.x = totalWidth;
			rect.origin.y = 0.0f;
			
			if (self.isFixedSegmentWidthSet) {
				rect.size.width = self.fixedSegmentWidth;
			}
			
			view.frame = rect;
			
			totalWidth += rect.size.width;
			maxHeight = MAX(maxHeight, view.frame.size.height);
			
			UIButton *btnHit = [self.hitButtons objectAtIndex:[self.segmentViews indexOfObject:view]];
			btnHit.frame = view.frame;
		}
		
		frame.size.width = totalWidth;
		frame.size.height = maxHeight;
	}
	
	[super setFrame:frame];
}

- (void)onHitButtonTap:(UIButton *)sender {
	[self selectSegmentAtIndex:[self.hitButtons indexOfObject:sender] sendActions:YES];
}

- (void)selectSegmentAtIndex:(NSInteger)inIdx sendActions:(BOOL)sendActions {
	if (inIdx > self.hitButtons.count - 1 ||
		inIdx < 0 ||
		self.selectedSegmentIndex == inIdx) {
		return;
	}
	
	if (_selectedSegmentIndex != NSNotFound) {
		[self didDeselectSegmentAtIndex:_selectedSegmentIndex];
	}
	
	_selectedSegmentIndex = inIdx;
	
	if (_selectedSegmentIndex != NSNotFound) {
		[self didSelectSegmentAtIndex:_selectedSegmentIndex];
	}
	
	if (sendActions) {
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
}

- (void)setSelectedSegmentIndex:(NSInteger)inIndex {
	[self selectSegmentAtIndex:inIndex sendActions:NO];
}

- (void)setFixedSegmentWidth:(CGFloat)fixedSegmentWidth {
	_fixedSegmentWidth = fixedSegmentWidth;
	
	self.isFixedSegmentWidthSet = _fixedSegmentWidth == 0;
	
	[self setNeedsLayout];
}

- (void)insertSegment:(UIControl *)inSegment atIndex:(NSInteger)inIndex {
	if (inSegment == nil)
		return;
	
	NSInteger idx = inIndex;
	if (inIndex > self.segmentViews.count)
		idx = self.segmentViews.count;
	else if (inIndex < 0)
		idx = 0;
	
	if ([self.segmentViews containsObject:inSegment]) {
		[self.hitButtons removeObjectAtIndex:[self.segmentViews indexOfObject:inSegment]];
		[self.segmentViews removeObject:inSegment];
	}
	
	UIButton *btnHit = [UIButton buttonWithType:UIButtonTypeCustom];
	btnHit.exclusiveTouch = YES;
	[btnHit addTarget:self action:@selector(onHitButtonTap:) forControlEvents:UIControlEventTouchDown];
	
	[self.segmentViews insertObject:inSegment atIndex:idx];
	[self.hitButtons insertObject:btnHit atIndex:idx];
	
	if (idx >= self.selectedSegmentIndex) {
		[self selectSegmentAtIndex:self.selectedSegmentIndex - idx sendActions:NO];
	}
	
	[self addSubview:inSegment];
	[self addSubview:btnHit];
	
	[self setNeedsLayout];
}

- (UIControl *)segmentAtIndex:(NSInteger)inIndex {
	if (inIndex < 0 || inIndex > self.segmentViews.count - 1)
		return nil;
	
	return [self.segmentViews objectAtIndex:inIndex];
}

- (void)setSeparatorImage:(UIImage *)separatorImage {
	if (separatorImage != _separatorImage) {
#if !(__has_feature(objc_arc))
		[_separatorImage release];
		_separatorImage = [separatorImage retain];
#endif
	}
	
	self.separatorOverlay.separatorImage = _separatorImage;
	[self.separatorOverlay setNeedsDisplay];
}

- (void)didDeselectSegmentAtIndex:(NSInteger)inIdx {
	[[self.segmentViews objectAtIndex:inIdx] setSelected:NO];
}

- (void)didSelectSegmentAtIndex:(NSInteger)inIdx {
	[[self.segmentViews objectAtIndex:inIdx] setSelected:YES];
}

@end
