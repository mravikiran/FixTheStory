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

static NSString * const remoteImageFolder = @"https://mravikiran.github.io/FixTheStory/story_images";

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
    
    [self.collectionView registerClass:[StagePhotoCell class]
            forCellWithReuseIdentifier:PhotoCellIdentifier];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleCollectionViewRearrangementComplete)
                                                 name:@"collectionViewRearrangementComplete"
                                               object:self.collectionView];
    

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
    NSString * imagePath = [NSString stringWithFormat:@"%@/img%@.png",remoteImageFolder,storyImageName];

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
    if ([keyPath isEqualToString:@"parentViewController"]) {
        self.story = [(ContainerViewController*)self.parentViewController getNextStory];
        if (self.story) {
            self.usedStoryLocationsArray = [[NSMutableArray alloc] initWithCapacity:[self.story.partsOfStory count]];
            for (int i=0; i<[self.story.partsOfStory count]; i++) {
                self.usedStoryLocationsArray[i]=[NSNumber numberWithInt:i];
            }
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
        if ([self parentViewController]) {
            [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"success"];
            
        }
    }

}

- (void) spewSomething
{
    NSLog(@"This should spew Something");
}

@end
