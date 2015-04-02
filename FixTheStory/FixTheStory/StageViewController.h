//
//  StageViewController.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 4/1/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RearrangeCollectionViewLayout.h"
#import "Story.h"

@interface StageViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *levelButton;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *mainButton;
@property (atomic) Story * story;

@property (atomic) NSMutableArray * usedStoryLocationsArray;
@property (atomic) NSMutableArray * partsOfStoryLocationArray;
@property (atomic) NSMutableArray * fixedStoryLocations;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageLoadingIndicator;
@property (nonatomic) NSInteger loadedImageCount;
- (IBAction)onMain:(id)sender;
@property (weak, nonatomic) IBOutlet RearrangeCollectionViewLayout *collectionViewLayout;
@property (weak, nonatomic) IBOutlet UILabel *finishedStory;
@property (weak, nonatomic) IBOutlet UIButton *nextStory;
- (IBAction)OnNext:(id)sender;

@property (strong, nonatomic) UITapGestureRecognizer * tapGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *goBackToMain;

- (IBAction)onLevelButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *levelContainer;
@property (weak, nonatomic) IBOutlet UIView *buttonHolderView;

- (void) handleTapOnParentView:(UITapGestureRecognizer*)tapRecognizer;
- (void) spewSomething;
- (void) handleCollectionViewRearrangementComplete;
- (NSInteger) getRandomLocationforPosition:(NSInteger)actualIndex;

@end
