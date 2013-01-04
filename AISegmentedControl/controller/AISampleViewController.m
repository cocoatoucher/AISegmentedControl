//
//  AISampleViewController.m
//  AISegmentedControl
//
//  Created by CocoaToucher on 12/19/12.
//  Copyright (c) 2012 CocoaToucher. All rights reserved.
//

#import "AISampleViewController.h"
#import "AISegmentedControl.h"
#import "AISampleSegmentView.h"
#import "AIIOSSegmentedControl.h"
#import "AIAnimatedSegmentedControl.h"

@interface AISampleViewController ()

@property(nonatomic, strong) IBOutlet AISegmentedControl *mixedSegmentedControl;
@property(nonatomic, strong) IBOutlet AIIOSSegmentedControl *iosSegmentedControl;
@property(nonatomic, strong) IBOutlet AIAnimatedSegmentedControl *animatedSegmentedControl;

- (IBAction)onSegmentedControlValueChange:(id)sender;

@end

@implementation AISampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//segment control with mixed type of segment views
	
	UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[segmentButton setTitle:NSLocalizedString(@"Segment button", nil) forState:UIControlStateNormal];
	[segmentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[segmentButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
	segmentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
	segmentButton.titleLabel.numberOfLines = 2;
	[segmentButton setFrame:CGRectMake(0.0f, 0.0f, 120.0f, 44.0f)];
	
	[self.mixedSegmentedControl insertSegment:segmentButton atIndex:0];
	self.mixedSegmentedControl.backgroundColor = [UIColor yellowColor];
	
	AISampleSegmentView *tSegmentView = [[AISampleSegmentView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 44.0f)];
	[self.mixedSegmentedControl insertSegment:tSegmentView atIndex:1];
#if !(__has_feature(objc_arc))
	[tSegmentView release];
#endif
	
	//iOS style segmented control
	
	[self.iosSegmentedControl setFixedSegmentWidth:75.0f];
	[self.iosSegmentedControl insertSegmentWithTitle:@"Very long title 1" atIndex:0];
	[self.iosSegmentedControl insertSegmentWithTitle:@"Very long title 2" atIndex:1];
	[self.iosSegmentedControl insertSegmentWithTitle:@"Very long title 3" atIndex:2];
	[self.iosSegmentedControl insertSegmentWithTitle:@"Very long title 4" atIndex:3];
	
	tSegmentView = [[AISampleSegmentView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 44.0f)];
	[self.animatedSegmentedControl insertSegment:tSegmentView atIndex:0];
#if !(__has_feature(objc_arc))
	[tSegmentView release];
#endif
	
	tSegmentView = [[AISampleSegmentView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 44.0f)];
	[self.animatedSegmentedControl insertSegment:tSegmentView atIndex:1];
#if !(__has_feature(objc_arc))
	[tSegmentView release];
#endif
	
	//Animated-selection segmented control
	
	tSegmentView = [[AISampleSegmentView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 44.0f)];
	[self.animatedSegmentedControl insertSegment:tSegmentView atIndex:2];
#if !(__has_feature(objc_arc))
	[tSegmentView release];
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSegmentedControlValueChange:(id)sender {
	
}

@end
