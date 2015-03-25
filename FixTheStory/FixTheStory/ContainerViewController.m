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

- (NSInteger)GetMaxLevelNumber:(NSArray *)allLevels
{
    NSInteger maxLevel = 0;
    for(NSNumber * level in allLevels)
    {
        if([level integerValue] > maxLevel)
        {
            maxLevel = [level integerValue];
        }
    }
    return maxLevel;
}

- (void)RecieveDataFetchComplete
{
    //update the stories completd so far array
    //read from the file but for now just using a bogus array
//    NSMutableDictionary * newArray = [[NSMutableDictionary alloc] init];
//    self.fixedStoryCounter = [[FixedStoriesCounter alloc] init];
//    NSArray* allLevels = [self.storyJSONParser GetAllLevels];
//    for (NSNumber * level in allLevels) {
//        [newArray setObject:[NSNumber numberWithInt:0] forKey:level];
//    }
//    [self.fixedStoryCounter UpdateCompletedStoriesByLevelDictionary:newArray];

    NSArray * allLevels = [self.storyJSONParser GetAllLevels];
    NSInteger maxLevel;
    maxLevel = [self GetMaxLevelNumber:allLevels];
    self.fixedStoryCounter = [[FixedStoriesCounter alloc] initWithNumberOfLevels:maxLevel];
    self.currentLevel = [[Level alloc] initWithNumber:1];
    self.currentStory = nil;
    self.storyNumber = 0;
}

- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(RecieveDataFetchComplete)
                                                 name:@"dataFetchComplete"
                                               object:nil];
    
    NSMutableArray * usedStoriesMap = [self getUsedStoriesMapFromStoryParser];
    NSString *xmlDataPath = [[NSBundle mainBundle] pathForResource:@"stories"
                                                     ofType:@"xml"];
    
    self.storyXMLParser = [[StoryXMLParser alloc] init];
    [self.storyXMLParser LoadStoriesFromUrl:xmlDataPath];
    
    NSString *webServicePath = [NSString stringWithFormat:@"http://localhost:8080/getallstories"];
    self.storyJSONParser = [[StoryJSONParser alloc] init];
    [self.storyJSONParser LoadStoriesFromUrl:webServicePath];
    
    //initialize the story Dispatch service.
    self.storyDispatchService =[[StoryDispatchService alloc] init];
    
    
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
- (NSInteger) getCurrentStoryNumber;
{
    return self.storyNumber;
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


- (NSMutableArray*) getUsedStoriesMapFromStoryParser
{
    NSMutableArray *availableFixedStories = [[NSMutableArray alloc] init];
    NSMutableDictionary * storiesByLevel = self.storyXMLParser.storiesByLevel;
    NSArray * stories;
    for(Level *key in storiesByLevel)
    {
        stories = storiesByLevel[key];
        NSInteger storyId = [self.fixedStoryCounter LastFixedStoryForLevel:key];
        for(Story * story in stories)
        {
            if (story.id <= storyId) {
                [availableFixedStories addObject: [NSNumber numberWithLong:story.id]];
            }
        }
    }
    return availableFixedStories;
}

- (BOOL) findStoryIn:(NSMutableArray*) previouslyAvailableFixedStories withStoryId:(NSInteger)storyId
{
    for (NSNumber * availableId in previouslyAvailableFixedStories) {
        if([availableId integerValue] == storyId)
            return true;
    }
    return false;
}

- (void) updateFixedStoriesCounter:(NSMutableArray*)previouslyAvailableFixedStories
{
    NSMutableDictionary * storiesByLevel = self.storyXMLParser.storiesByLevel;
    NSArray * stories;
    for(Level *key in storiesByLevel)
    {
        //Are the stories sorted??
        [self.fixedStoryCounter UpdateLastFixedStoryForLevel:key ToStory:NULL];
        stories = storiesByLevel[key];
        NSUInteger numberOfStories = [stories count];
        for (unsigned int i = 0; i < numberOfStories; i++)
        {
            Story * story = stories[i];
            if(![self findStoryIn:previouslyAvailableFixedStories withStoryId : story.id] && i > 0)
            {
                Story * previousStory = stories[i-1];
                [self.fixedStoryCounter UpdateLastFixedStoryForLevel:key ToStory:previousStory];
                break;
            }
            //an if flag probably??
            [self.fixedStoryCounter UpdateLastFixedStoryForLevel:key ToStory:story];
        }
    }

}

#pragma xml story parsing functions


- (Story*) getNextStory {
    
    Level * level = [[Level alloc] init];
    Story * story = [self.storyDispatchService getNextStoryFromParser:self.storyJSONParser givenFixedStoriesCounter:self.fixedStoryCounter updateLevel:&level withCurrentLevel:self.currentLevel];
    self.currentStory = story;
    self.currentLevel = level;
    if (story) {
        self.storyNumber = self.storyNumber + 1;
    }
    return story;
}

-(void) updateLastFixedStoryCounter{
    [self.fixedStoryCounter UpdateLastFixedStoryForLevel:self.currentLevel ToStory:self.currentStory ];
}





@end
