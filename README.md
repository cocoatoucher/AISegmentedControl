#AISegmentedControl

a modular and fully customizable segmented control for iOS

#Requirements

Classes in this project supports both ARC and non-ARC projects

#Installation

Add the AISegmentedControl folder to your project

#How to use it?

##AISegmentedControl

    #import "AISegmentedControl.h"
    
    //Either programmatically create an AISegmentedControl or put one in interface builder
    //initial size of the segmentedControl doesn't matter, because it is resized with the size of inserted segment controls
    AISegmentedControl *segmentedControl = [[AISegmentedControl alloc] initWithFrame:CGRectZero];
    
    UIControl *aSegment = //create a UIControl subclass as your single segment view 
    [segmentedControl insertSegment:aSegment atIndex:0];
    
    //optionally set a fixed segment width if you want all your segments in same width
    segmentedControl.fixedSegmentWidth = 70.0f;
    
    //AISegmentedControl is a UIControl just like the standard UISegmentedControl
    [segmentedControl addTarget:self action:@selector(onSegmentedControlValueChange:) forControlEvents:UIControlEventValueChanged];
    
##Subclassing notes

AISegmentedControl's protected methods are in a class extension file called "AISegmentedControl_Protected.h"
You can get use of these methods to unify your single segment controls or animate selections

    #import "AISegmentedControl_Protected.h"
    
    //animating selections
    //override this method
    - (void)selectSegmentAtIndex:(NSInteger)inIdx sendActions:(BOOL)sendAction {
        [super selectSegmentAtIndex:inIdx sendActions:sendActions];
        
        UIControl *selectedSegment = [self segmentAtIndex:self.selectedSegmentIndex];
        //move your animated selection view over selectedSegment here
    }
    
    - (void)didSelectSegmentAtIndex:(NSInteger)inIdx {
        UIControl *selectedSegment = [self segmentAtIndex:inIdx];
        //apply a custom animation for selectedSegment selection
        //default is selectedSegment.selected = NO;
    }
    
    - (void)didDeselectSegmentAtIndex:(NSInteger)inIdx {
        UIControl *selectedSegment = [self segmentAtIndex:inIdx];
        //apply a custom animation for selectedSegment selection
        //default is selectedSegment.selected = NO;
    }
    
    //to unify your single segment controls implement a method like this in your AISegmentedControl subclass
    //and then call insertSegment:atIndex: of super
    - (void)insertSegmentWithTitle:(NSString *)inTitle atIndex:(NSInteger)inIndex {
        MyCustomSegmentButton *btn = [[MySegmentButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 44.0f)];
        [btn setTitle:inTitle forState:UIControlStateNormal];
        
        [self insertSegment:btn atIndex:inIndex];
    }
    
