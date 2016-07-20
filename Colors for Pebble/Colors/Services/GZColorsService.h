//
//  GZColorsService.h
//  Colors
//
//  Created by Francisco Granados on 8/1/15.
//  Copyright (c) 2015 gzfrancisco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZColorsService : NSObject <NSStreamDelegate>

@property(strong, nonatomic) NSInputStream *inputStream;

@property(nonatomic) NSInteger red;
@property(nonatomic) NSInteger green;
@property(nonatomic) NSInteger blue;

- (void)start;
- (void)stop;

@end
