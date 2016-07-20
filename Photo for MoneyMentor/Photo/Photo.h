//
//  Photo.h
//  Photo
//
//  Created by Francisco Granados on 29/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (strong, nonatomic) NSString *userDescription;
@property (strong, nonatomic) NSString *normalImageURL;
@property (strong, nonatomic) NSString *miniImageURL;

- (void)requestImages;

@end
