//
//  RearrangeCollectionViewLayout.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 4/1/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "RearrangeCollectionViewLayout.h"
#import "StagePhotoCell.h"

static  NSString * const collectionViewKey = @"collectionView";

@interface RearrangeCollectionViewLayout ()

@property (strong, nonatomic) NSIndexPath *selectedItemIndexPath;
@property (strong, nonatomic) NSIndexPath *toItemIndexPath;
@property (strong, nonatomic) UIView *currentView;
@property (assign, nonatomic) CGPoint currentViewCenter;
@property (assign, nonatomic) CGPoint panStartPoint;
@property (assign, nonatomic) BOOL startMoving;

@property (assign, nonatomic) CGPoint panTranslationInCollectionView;

@end

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

- (void) setDefaults
{
    self.startMoving=false;
    self.selectedItemIndexPath=nil;
    
    
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

- (void) dealloc{
    [self removeObserver:self forKeyPath:collectionViewKey];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    

}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(50.0f, 50.0f, 50.0f, 50.0f);
    self.itemSize = CGSizeMake(100.0f, 100.0f);
    self.interItemSpacingY = 20.0f;
    self.interItemSpacingX = 20.0f;
    //Depending on orientation decide the number of columns and hence eventually number of rows.
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

#pragma Non-UI methods

- (void) findSelectedItemIndexMoveToPosition {
    if (self.selectedItemIndexPath) {
        UICollectionViewLayoutAttributes * selectedCellLayoutAttributes = self.layoutInfo[self.selectedItemIndexPath];
        
        //CGRect selectedCellLayoutAttributesFrame= CGRectMake(selectedCellLayoutAttributes.frame.origin.x+ self.panTranslationInCollectionView.x,selectedCellLayoutAttributes.frame.origin.y+ self.panTranslationInCollectionView.y,selectedCellLayoutAttributes.frame.size.width,selectedCellLayoutAttributes.frame.size.height);
        CGRect selectedCellLayoutAttributesFrame = selectedCellLayoutAttributes.frame;

        CGFloat areaOfUICollectionViewCell = selectedCellLayoutAttributes.frame.size.width*selectedCellLayoutAttributes.frame.size.height;
        for (NSIndexPath * indexPath in self.layoutInfo) {
            self.toItemIndexPath = nil;
            if (![indexPath isEqual:self.selectedItemIndexPath]) {
                UICollectionViewLayoutAttributes * currentAttributes = [self.layoutInfo objectForKey:indexPath];
                CGRect intersectedRegion = CGRectIntersection(currentAttributes.frame, selectedCellLayoutAttributesFrame);
                
               // NSLog(@"TO Cell %f,%f,%f,%f",currentAttributes.frame.origin.x,currentAttributes.frame.origin.y,currentAttributes.frame.size.width,currentAttributes.frame.size.height);
               // NSLog(@"Selected Cell %f,%f,%f,%f",selectedCellLayoutAttributesFrame.origin.x,selectedCellLayoutAttributesFrame.origin.y,selectedCellLayoutAttributesFrame.size.width,selectedCellLayoutAttributesFrame.size.height);
                
                if(!CGRectIsNull(intersectedRegion)){
                    if (intersectedRegion.size.width * intersectedRegion.size.height > areaOfUICollectionViewCell/4) {
                        self.toItemIndexPath = indexPath;
                        //NSLog(@"%ld",self.toItemIndexPath.row);
                        break;
                    }
                }
            
            }
        
        }
    }
    
}

#pragma custom selectors

- (void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            
            self.panStartPoint = [gestureRecognizer locationInView:self.collectionView];
            
            self.selectedItemIndexPath= [self.collectionView indexPathForItemAtPoint:[gestureRecognizer locationInView:self.collectionView]];
            
            
            if(self.selectedItemIndexPath!=nil){
               // NSLog(@"the current cell to be moved %ld and hte starting point is %f,%f",self.selectedItemIndexPath.row,_panStartPoint.x,_panStartPoint.y);
                [self.collectionView bringSubviewToFront:[self.collectionView cellForItemAtIndexPath:self.selectedItemIndexPath]];
                self.startMoving = true;
            }
           
            
            
            break;
    }
        case UIGestureRecognizerStateChanged: {
            self.panTranslationInCollectionView = [gestureRecognizer translationInView:self.collectionView];
           // NSLog(@"%f,%f",_panTranslationInCollectionView.x,_panTranslationInCollectionView.y);
            [self findSelectedItemIndexMoveToPosition];
            [self invalidateLayout]; // This calls prepareLayout and then layoutAttributesForElementsInRect
            break;
        }
        case UIGestureRecognizerStateEnded:{
            self.startMoving=false;
            if (self.toItemIndexPath) {
                [self.collectionView  performBatchUpdates:^{
                    [self.collectionView moveItemAtIndexPath:self.selectedItemIndexPath toIndexPath:self.toItemIndexPath];
                    [self.collectionView moveItemAtIndexPath:self.toItemIndexPath toIndexPath:self.selectedItemIndexPath];} completion:^(BOOL finished){}];
            }
            else{
                [self.collectionView  performBatchUpdates:^{
                    [self invalidateLayout];} completion:^(BOOL finished){}];
            }
            
            self.selectedItemIndexPath = nil;
            self.toItemIndexPath = nil;
           /* NSArray * photoCells = [self.collectionView visibleCells];
            for (StagePhotoCell * uivcell in photoCells) {
                NSLog(@"%ld",(long)uivcell.uid);
            }*/
            //[self invalidateLayout];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"collectionViewRearrangementComplete"
             object:self.collectionView];


            break;
        }
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
        itemAttributes.frame = [self frameForStagePhotoAtIndexPath:indexPath withRows:itemCount/self.numberOfColumns];
        
        
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    
    
    
    self.layoutInfo = cellLayoutInfo;
}

- (CGRect) frameForStagePhotoAtIndexPath:(NSIndexPath*) indexPath withRows:(NSInteger)numberOfRows {
    NSInteger row = (indexPath.row / self.numberOfColumns);
    NSInteger column = indexPath.row % self.numberOfColumns;
   
    
    CGFloat topMargin = (self.collectionView.bounds.size.height -
                           numberOfRows*self.itemSize.height -
                          (numberOfRows-1)*self.interItemSpacingY)/2;
    CGFloat leftMargin =(self.collectionView.bounds.size.width -
                           self.numberOfColumns*self.itemSize.width -
                          (self.numberOfColumns-1)*self.interItemSpacingX)/2;
    

    CGFloat originX = floorf((self.itemSize.width + self.interItemSpacingX) * column+leftMargin);

    CGFloat originY = floor((self.itemSize.height + self.interItemSpacingY) * row + topMargin);
    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[indexPath];
}



- (void)AdjustAttributesFrameBasedOnPanTranslation:(UICollectionViewLayoutAttributes *)attributes
{
    CGFloat originX = attributes.frame.origin.x+ self.panTranslationInCollectionView.x;
    CGFloat originY = attributes.frame.origin.y+ self.panTranslationInCollectionView.y;
    CGFloat width = attributes.frame.size.width;
    CGFloat height = attributes.frame.size.height;
    
    
    // prevent the images from being dragged out of the collection view.
    if(originX < 0) originX =0;
    if(originY < 0) originY =0;
    if(originX + width > self.collectionView.bounds.size.width) {
        originX = self.collectionView.bounds.size.width - width;
    }
    if(originY + height > self.collectionView.bounds.size.height) {
        originY = self.collectionView.bounds.size.height - height;
    }
    
    
    attributes.frame = CGRectMake(originX, originY, width, height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
   
        [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            
            UICollectionViewLayoutAttributes * attributesCopy = [[UICollectionViewLayoutAttributes alloc] init];
            attributesCopy = [attributes copy];
            
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                if(self.startMoving && [indexPath isEqual:self.selectedItemIndexPath]) {
                    
                    [self AdjustAttributesFrameBasedOnPanTranslation:attributes];
                    
                    
                }
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
    
    return CGSizeMake(self.collectionView.bounds.size.width,self.collectionView.bounds.size.height);// height);
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
