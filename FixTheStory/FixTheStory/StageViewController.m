//
//  StageViewController.m
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 4/1/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import "StageViewController.h"
#import "ContainerViewController.h"
#import "StagePhotoCell.h"

static NSString * const PhotoCellIdentifier = @"PhotoCell";

//static NSString * const remoteImageFolder = @"https://mravikiran.github.io/FixTheStory/story_images";

static NSString * const remoteImageFolder = @"http://localhost:8080/fts_test/public/images";

const NSInteger ridiculouslyHighStoryId = 100000;

@interface StageViewController ()

@end

@implementation StageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addObserver:self forKeyPath:@"parentViewController" options:NSKeyValueObservingOptionNew context:nil];
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
    self.goBackToMain.hidden = true;
    self.finishedStory.hidden = true;
    self.finishedStory.adjustsFontSizeToFitWidth = NO;
    self.finishedStory.numberOfLines=0;
    self.nextStory.hidden = true;

    
    [self.collectionView registerClass:[StagePhotoCell class]
            forCellWithReuseIdentifier:PhotoCellIdentifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleCollectionViewRearrangementComplete)
                                                 name:@"collectionViewRearrangementComplete"
                                               object:self.collectionView];
    
    //hide the layover view controller up above
    
    CGRect buttonRect = self.levelButton.frame;
    CGRect frame = CGRectMake(0, (buttonRect.origin.y - self.levelContainer.frame.size.height), self.levelContainer.frame.size.width, self.levelContainer.frame.size.height);
    
    self.levelContainer.frame = frame;
  //  NSLog([NSString stringWithFormat:@"The coordinates are %f,%f",self.levelContainer.frame.origin.x,self.levelContainer.frame.origin.y]);
  //  NSLog([NSString stringWithFormat:@"The center coordinates are %f,%f",self.levelContainer.center.x,self.levelContainer.center.y]);
    
    //setting up touch gesture recognizer for the super view
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnParentView:)];
    self.tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    

}

- (void) handleTapOnParentView:(UITapGestureRecognizer *)tapRecognizer
{
    if (self.levelContainer.frame.origin.y > 0) {
        [self ToggleHiddenStateWithAnimation];
    }
}

- (void) dealloc {
    [self removeObserver:self forKeyPath:@"parentViewController"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"collectionViewRearrangementComplete" object:self.collectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma data source methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    if(self.story)
        return self.story.numberOfImages;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StagePhotoCell *photoCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier
                                              forIndexPath:indexPath];
    
    NSInteger randomPosition = [self getRandomLocation];
    NSString * storyImageName = self.story.partsOfStory[randomPosition];
    
   // NSString * imageName = [NSString stringWithFormat:@"img%@.png",storyImageName];
    
    //photoCell.imageView.image = [UIImage imageNamed:imageName];
    //photoCell.uid = indexPath.row;
    NSString * imagePath = [NSString stringWithFormat:@"%@/%@/1.png",remoteImageFolder,storyImageName];

    NSURL *url = [NSURL URLWithString:imagePath];
    NSError * err;
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&err];
    
    //Error handle here
    //Inform that either there is no internet or 4g or watever.
    // Hence the need of imagefetcher is much ore evident. because stage view controller should not contain the logic of fetching the image.
    photoCell.imageView.image = [[UIImage alloc] initWithData:data];
    photoCell.uid = randomPosition;
    return photoCell;
}


- (IBAction)onMain:(id)sender {
    if ([self parentViewController]) {
        [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"root"];
        
    }
}

- (NSInteger) getRandomLocation
{
    
    NSInteger size = [self.usedStoryLocationsArray count];
    NSInteger randomNumber=0;
    if(size>0){
        NSInteger position = arc4random()%size;
        randomNumber = [self.usedStoryLocationsArray[position] integerValue];
        [self.usedStoryLocationsArray removeObjectAtIndex:position];
    }
    return randomNumber;
}




#pragma key observer methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"parentViewController"])
    {
        self.story = [(ContainerViewController*)self.parentViewController getNextStory];
        NSString * levelButtonTitle;
        if (!self.story) {
            Story * endStory = [[Story alloc] init];
            endStory.id = ridiculouslyHighStoryId;
            endStory.numberOfImages = 4;
            [endStory addPartOfStory:@"carry"];
            [endStory addPartOfStory:@"mila"];
            [endStory addPartOfStory:@"natalie"];
            [endStory addPartOfStory:@"scarlette"];
            self.story = endStory;
            levelButtonTitle= [NSString stringWithFormat:@"The End"];
        }
        else
        {
            levelButtonTitle = [NSString stringWithFormat:@"Story %ld", (long)[(ContainerViewController*)self.parentViewController getCurrentStoryNumber]];
        }
        
        [self.levelButton setTitle:levelButtonTitle forState:UIControlStateNormal];
    
    self.usedStoryLocationsArray = [[NSMutableArray alloc] initWithCapacity:self.story.numberOfImages];
    for (int i=0; i<[self.story.partsOfStory count]; i++) {
        self.usedStoryLocationsArray[i]=[NSNumber numberWithInt:i];
    }
    }
}


//Todo : handle multiple solutions  to the puzzle.
-(void) handleCollectionViewRearrangementComplete {

    int matchedCells=0;
    for(StagePhotoCell* cell in self.collectionView.visibleCells){
        NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
        if(indexPath.row == cell.uid){
            matchedCells++;
        }
        
    }
    if(matchedCells == self.story.numberOfImages)
    {
        NSLog(@"Hurrah puzzle solved");
        [(ContainerViewController*)self.parentViewController updateLastFixedStoryCounter];
        if ([self parentViewController] && self.story.id != ridiculouslyHighStoryId) {
            [self.finishedStory setText: self.story.actualStory];
            self.finishedStory.hidden = false;
            self.nextStory.hidden = false;
//            [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"success"];
            
        }
        else
        {
            self.goBackToMain.hidden = false;
        }
    }

}

- (void)ToggleHiddenStateWithAnimation {

    if (self.levelContainer.frame.origin.y < 0) {
        
    [self.collectionView removeGestureRecognizer:self.collectionViewLayout.panGestureRecognizer];
        
    [UIView animateWithDuration:1.0
                          delay: 0.0
                        options: UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
//                         self.levelContainer.alpha = 0.0;
                         CGFloat levelContainerNewX=0;
                         CGFloat levelContainerNewY = self.levelButton.frame.origin.y + self.levelButton.frame.size.height;
                         
                         self.levelContainer.frame = CGRectMake(levelContainerNewX, levelContainerNewY, self.levelContainer.frame.size.width, self.levelContainer.frame.size.height);
                       
                         
                     }
                     completion:^(BOOL finished){
                         // Wait one second and then fade in the view
                         
                     }];
    }
    else
    {
    [self.collectionView addGestureRecognizer:self.collectionViewLayout.panGestureRecognizer];

        self.levelContainer.frame = CGRectMake(0 , (self.levelButton.frame.origin.y - self.levelContainer.frame.size.height), self.levelContainer.frame.size.width, self.levelContainer.frame.size.height);
    }
}

- (IBAction)onLevelButton:(id)sender {
    //hide other container views and then
    [self ToggleHiddenStateWithAnimation];
}

- (void) spewSomething
{
    NSLog(@"This should spew Something");
}

#pragma UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // Determine if the touch is inside the custom subview
    if ([touch view] == self.levelContainer.subviews[0]){
        //An important point to notice is that levelcontainer has a subview and inside those subviews we have buttons etc.
        // If it is, prevent all of the delegate's gesture recognizers
        // from receiving the touch
        return NO;
    }
    return YES;
}

- (IBAction)OnNext:(id)sender {
    
    if ([self parentViewController]) {
        [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"stage"];
        
    }
    
}
@end
