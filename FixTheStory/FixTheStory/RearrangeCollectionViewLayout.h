//
//  RearrangeCollectionViewLayout.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 4/1/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RearrangeCollectionViewLayout : UICollectionViewLayout <UIGestureRecognizerDelegate>

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;

@property (nonatomic, strong) NSDictionary *layoutInfo;

@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;


@end
