//
//  containerViewController.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 3/25/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "ContainerViewController.h"
#import "ViewControllerFactory.h"
#import "RootViewController.h"
#import "SettingsViewController.h"
#import "RulesViewController.h"
#import "StoryXMLParser.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController
{
    NSMutableArray * subViewControllers;
    UIViewController * currentSubViewController;
    UIView * containerView;

}
/*
- (id) init
{
    if ([super init]) {
        
        subViewControllers = [[NSMutableArray alloc] init];
        
        RootViewController * rvc = (RootViewController*)[ViewControllerFactory getViewControllerOfType:@"root" initWithParent:self];
        [subViewControllers addObject:rvc];
        SettingsViewController * svc = (SettingsViewController*)[ViewControllerFactory getViewControllerOfType:@"settings" initWithParent:self];
        [subViewControllers addObject:svc];
        RulesViewController * rulesvc = (RulesViewController*)[ViewControllerFactory getViewControllerOfType:@"rules" initWithParent:self];
        [subViewControllers addObject:rulesvc];
        
        [self setCurrentSubViewController:rvc];
        
        
    }
    return self;
}*/

- (void) loadView
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    UIView * cView = [[UIView alloc] initWithFrame:frame];
    cView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    cView.backgroundColor = [UIColor blueColor];
    
    containerView=cView;
    self.view = cView;
}

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stories"
                                                     ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    StoryXMLParser * storyParser = [[StoryXMLParser alloc] initWithData:data];
    [storyParser setDelegate:storyParser];
    BOOL result = [storyParser parse];
    if(result){
        NSLog(@"Successfully parsed");
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
	if (currentSubViewController.parentViewController == self)
	{
		// nothing to do
		return;
	}
    
    currentSubViewController.view.frame = containerView.bounds;
    currentSubViewController.view.autoresizingMask = containerView.autoresizingMask;
    
    
    
    [self addChildViewController:currentSubViewController];
    [containerView addSubview:currentSubViewController.view];
    
    [currentSubViewController didMoveToParentViewController:self];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setCurrentSubViewController:(UIViewController*) cvc
{
    currentSubViewController = cvc;
}

- (void) spewSomething
{
    NSLog(@"This should spew Something");
}



- (void) showViewControllerWithName:(NSString*)vctype
{
    __block UIViewController * toVC = [ViewControllerFactory getViewControllerOfType:vctype];
    
    if (!toVC) {
        //do nothing
        return;
    }
    toVC.view.frame = containerView.bounds;
    toVC.view.autoresizingMask = containerView.autoresizingMask;
    
    [currentSubViewController willMoveToParentViewController:nil];
    [self addChildViewController:toVC];
    [containerView addSubview:toVC.view];

    [self transitionFromViewController:currentSubViewController
                      toViewController:toVC duration:1.0 options:UIViewAnimationOptionCurveLinear animations:^{} completion:^(BOOL finished){
                          
                          
                      }];
   [currentSubViewController removeFromParentViewController];
    [toVC didMoveToParentViewController:self];

    currentSubViewController = toVC;
    
    
}


#pragma xml parsing

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"level"]) {
        NSLog(@"Level started");
        
    }
    else
        if ([elementName isEqualToString:@"story"]) {
            NSLog(@"Story started");
            
        }
        else
            if ([elementName isEqualToString:@"image"]) {
                NSLog(@"image started");
            }
            else{
                NSLog(@"%@",elementName);
            }
    
    
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"level"]) {
        NSLog(@"Level end");
        
    }
    else
        if ([elementName isEqualToString:@"story"]) {
            NSLog(@"Story end");
            
        }
        else
            if ([elementName isEqualToString:@"image"]) {
                NSLog(@"image end");
            }
            else{
                NSLog(@"%@",elementName);
            }
    
    
}


@end
