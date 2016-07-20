//
//  ImageService.m
//  Photo
//
//  Created by Francisco Granados on 29/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import "ImageService.h"
#import "Photo.h"

@implementation ImageService

@synthesize delegate;

- (void)requestPhotos {
  NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
    NSURL *url = [NSURL URLWithString:@"http://static.moneymenttor.com/iostest/estructura.json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *photos = [self parseGalleryWithJson:json];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      if ([delegate conformsToProtocol:@protocol(ImageServiceDelegate)]) {
        [delegate imageService:self didReceivePhotos:photos];
      }
    }];
  }];
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  [queue addOperation:operation];
}

- (NSArray *)parseGalleryWithJson:(NSDictionary *)json {
  NSArray *items = [json objectForKey:@"items"];
  NSMutableArray *photos = [NSMutableArray array];
  [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSDictionary *photoInfo = (NSDictionary *) obj;
    Photo *photo = [[Photo alloc] init];
    [photo setUserDescription:[photoInfo objectForKey:@"Desc"]];
    [photo setNormalImageURL:[photoInfo objectForKey:@"Normal"]];
    [photo setMiniImageURL:[photoInfo objectForKey:@"Mini"]];
    [photo requestImages];
    [photos addObject:photo];
  }];
  return photos;
}

@end
