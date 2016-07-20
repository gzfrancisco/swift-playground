//
//  ImageService.h
//  Photo
//
//  Created by Francisco Granados on 29/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ImageService;

@protocol ImageServiceDelegate <NSObject>

- (void)imageService:(ImageService *)imageService didReceivePhotos:(NSArray *)photos;

@end

@interface ImageService : NSObject

@property (assign, nonatomic) id<ImageServiceDelegate> delegate;
@property (strong, nonatomic) NSDictionary *photos;

- (void)requestPhotos;

@end
