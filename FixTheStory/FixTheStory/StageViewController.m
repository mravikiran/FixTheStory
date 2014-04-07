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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
    
    [self.collectionView registerClass:[StagePhotoCell class]
            forCellWithReuseIdentifier:PhotoCellIdentifier];
    

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
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StagePhotoCell *photoCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:PhotoCellIdentifier
                                              forIndexPath:indexPath];
    
    NSString * imageName = [NSString stringWithFormat:@"img%ld.jpg",indexPath.row+1];
    
    photoCell.imageView.image = [UIImage imageNamed:imageName];
    
    return photoCell;
}


- (IBAction)onMain:(id)sender {
    if ([self parentViewController]) {
        [(ContainerViewController*)[self parentViewController] showViewControllerWithName:@"root"];
        
    }
}
@end
