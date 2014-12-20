//
//  SuccessViewController.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 7/13/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "SuccessViewController.h"
#import "ContainerViewController.h"

@implementation SuccessViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onContinue:(id)sender {
    
    
    if ([self parentViewController]) {
        [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"stage"];
        
    }

    
}
- (IBAction)onMain:(id)sender {
    
    if ([self parentViewController]) {
        [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"root"];
        
    }

}
@end
