//
//  RearrangeCollectionViewLayout.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 4/1/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "RearrangeCollectionViewLayout.h"

static  NSString * const collectionViewKey = @"collectionView";

@implementation RearrangeCollectionViewLayout



- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
        [self addObserver:self forKeyPath:collectionViewKey options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
        [self addObserver:self forKeyPath:collectionViewKey options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(22.0f, 22.0f, 13.0f, 22.0f);
    self.itemSize = CGSizeMake(100.0f, 100.0f);
    self.interItemSpacingY = 12.0f;
    self.numberOfColumns = 2;
}

- (void) setupGestureRecognizers {
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handlePanGesture:)];
    self.panGestureRecognizer.delegate = self;
    [self.collectionView addGestureRecognizer:self.panGestureRecognizer];
    
    // Useful in multiple scenarios: one common scenario being when the Notification Center drawer is pulled down
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationWillResignActive:) name: UIApplicationWillResignActiveNotification object:nil];
    
}

- (void) setupCollectionView{
    [self setupGestureRecognizers];
}

#pragma custom selectors

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    
    NSLog(@"gestureRecognizer connected");
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            break;
            
        default:
            break;
    }
}

- (void)handleApplicationWillResignActive:(NSNotification *)notification {
    self.panGestureRecognizer.enabled = NO;
    self.panGestureRecognizer.enabled = YES;
}



#pragma mark - Layout

- (void)prepareLayout
{
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
   // NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath;// = [NSIndexPath indexPathForItem:0 inSection:0];
    

    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
        
    for (NSInteger item = 0; item < itemCount; item++) {
          indexPath = [NSIndexPath indexPathForItem:item inSection:0];
                UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForStagePhotoAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    
    
    
    self.layoutInfo = cellLayoutInfo;
}


- (CGRect) frameForStagePhotoAtIndexPath:(NSIndexPath*) indexPath {
    NSInteger row = (indexPath.row / self.numberOfColumns);
    NSInteger column = indexPath.row % self.numberOfColumns;
    
    CGFloat spacingX = self.collectionView.bounds.size.width -
    self.itemInsets.left -
    self.itemInsets.right -
    (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
    
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
    
    CGFloat originY = floor(self.itemInsets.top +
                            (self.itemSize.height + self.interItemSpacingY) * row);
    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[indexPath];
}



- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
   
        [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    
    return allAttributes;
}

- (CGSize)collectionViewContentSize
{
    NSInteger rowCount = [self.collectionView numberOfItemsInSection:0] / self.numberOfColumns;
    // make sure we count another row if one is only partially filled
  //  if ([self.collectionView numberOfSections] % self.numberOfColumns) rowCount++;
    
    CGFloat height = self.itemInsets.top +
    rowCount * self.itemSize.height + (rowCount - 1) * self.interItemSpacingY +
    self.itemInsets.bottom;
    
    return CGSizeMake(self.collectionView.bounds.size.width, height);
}

#pragma mark - Key-Value Observing methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:collectionViewKey]) {
        if (self.collectionView != nil) {
            [self setupCollectionView];
        } else {
            //[self invalidatesScrollTimer];
        }
    }
}



@end
