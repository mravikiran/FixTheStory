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

- (IBAction)onMain:(id)sender;
@property (weak, nonatomic) IBOutlet RearrangeCollectionViewLayout *collectionViewLayout;

@property (strong, nonatomic) UITapGestureRecognizer * tapGestureRecognizer;

- (IBAction)onLevelButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *levelContainer;
@property (weak, nonatomic) IBOutlet UIView *buttonHolderView;

- (void) handleTapOnParentView:(UITapGestureRecognizer*)tapRecognizer;
- (void) spewSomething;
- (void) handleCollectionViewRearrangementComplete;
- (NSInteger) getRandomLocation;

@end
