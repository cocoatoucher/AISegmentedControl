//
//  AISegmentedControl_Protected.h
//  AISegmentedControl
//
//  Created by CocoaToucher on 12/31/12.
//  Copyright (c) 2012 CocoaToucher. All rights reserved.
//

#import "AISegmentedControl.h"

/**
 Protected method of AISegmentedControl for subclasses
 */
@interface AISegmentedControl ()

/**
 setSelected:YES is sent to selected segment view (UIControl subclass) in super
 make sure to call super's implementation in this method
 if you need access to selectedSegmentIndex property in this method, do so after calling super
 @param inIdx, index of the selection candidate segment view, does not guarantee that the selectedSegmentIndex property will be set to this value after calling super
 @param sendActions, indicates whether the method is called after a touch event
 */
- (void)selectSegmentAtIndex:(NSInteger)inIdx sendActions:(BOOL)sendActions;

/**
 setSelected:YES is sent to selected segment view (UIControl subclass) in super
 override if you want to change this behavior
 @param inIdx, index of selected segment
 */
- (void)didSelectSegmentAtIndex:(NSInteger)inIdx;

/**
 setSelected:NO is sent to selected segment view (UIControl subclass) in super
 override if you want to change this behavior
 @param inIdx, index of deselected segment
 */
- (void)didDeselectSegmentAtIndex:(NSInteger)inIdx;

@end
