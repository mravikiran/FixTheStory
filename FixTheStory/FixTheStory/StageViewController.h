//
//  StageViewController.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 4/1/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RearrangeCollectionViewLayout.h"

@interface StageViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *mainButton;

- (IBAction)onMain:(id)sender;
@property (weak, nonatomic) IBOutlet RearrangeCollectionViewLayout *collectionViewLayout;


@end
