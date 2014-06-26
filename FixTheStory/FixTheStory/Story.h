//
//  Story.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/10/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject

@property (nonatomic) NSInteger numberOfImages;
@property (nonatomic) NSString * actualStory;
@property (nonatomic) NSMutableArray * partsOfStory;

- (void) addPartOfStory:(NSString*)part;


@end
