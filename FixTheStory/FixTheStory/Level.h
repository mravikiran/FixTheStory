//
//  Level.h
//  FixTheStory
//
//  Created by ravi kiran mikkilineni on 6/23/14.
//  Copyright (c) 2014 ravi kiran mikkilineni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject <NSCopying>

@property(nonatomic) NSInteger number;
- (id) initWithNumber:(NSInteger) num;

@end
