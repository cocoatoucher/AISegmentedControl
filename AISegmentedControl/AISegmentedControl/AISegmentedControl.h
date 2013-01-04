//
//  AISegmentedControl.h
//  AISegmentedControl
//
//  Created by CocoaToucher on 12/19/12.
//  Copyright (c) 2012 CocoaToucher. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Segmented control class providing simplest group layout of inserted single segment views
 and handles segment selection
 */
@interface AISegmentedControl : UIControl

/**
 Fixed segment witdh
 Default value is 0
 When this is not set or set to 0, actual width for each single segment view is used for layout
 */
@property(nonatomic) CGFloat fixedSegmentWidth;

/**
 Index of the last selected segment view
 When no segment is selected returns NSNotFound
 To reset to no selection set to NSNotFound
 UIControlEventValueChanged is invoked when selected index is changed by a touch event
 */
@property(nonatomic) NSInteger selectedSegmentIndex;

/**
 Image for the separator between single segment views
 Default value is none
 Size of the image doesn't increase the total segmented control width
 */
@property(nonatomic, strong) UIImage *separatorImage;

/**
 Inserted segment views array
 */
@property(nonatomic, strong, readonly) NSMutableArray *segmentViews;

/**
 Inserts a segment view to specified index
 Specified index is clamped to total segment count if it is bigger than this value
 Negative segment indeces are clamped to 0
 If inSegment is already included in segmentViews array, it is removed from the its current index and placed in the new index
 @param inSegment, segment view to be inserted
 @param inIndex, index for insertion
 */
- (void)insertSegment:(UIControl *)inSegment atIndex:(NSInteger)inIndex;

/**
 @param inIndex, index of the desired segment view
 @returns segment view at the given index
 */
- (UIControl *)segmentAtIndex:(NSInteger)inIndex;

@end
