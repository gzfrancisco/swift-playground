//
//  Photo.m
//  Photo
//
//  Created by Francisco Granados on 29/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import "Photo.h"
#import <CocoaSecurity.h>
#import <NSData+Base64.h>

@implementation Photo

static NSString * const key = @"3L5fA0jyM7rGbKwd";
static NSString * const iv = @"a65452e4b1fda748";

@synthesize userDescription;
@synthesize normalImageURL;
@synthesize miniImageURL;

- (void)requestImages {

  NSData *normalData = [normalImageURL dataUsingEncoding:NSUTF8StringEncoding];
  NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
  NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
  NSString *normal64 = [normalData base64EncodedString];
  NSString *key64 = [keyData base64EncodedString];
  NSString *iv64 = [ivData base64EncodedString];
  
//  CocoaSecurityResult *b = [CocoaSecurity aesDecryptWithBase64:normal hexKey:@"3L5fA0jyM7rGbKwd" hexIv:@"a65452e4b1fda748"];
//  CocoaSecurityResult *result = [CocoaSecurity aesDecryptWithBase64:normal key:@"3L5fA0jyM7rGbKwd"];
//  CocoaSecurityResult *result = [CocoaSecurity aesDecryptWithBase64:normal64 key:keyData iv:ivData];
  CocoaSecurityResult *result = [CocoaSecurity aesDecryptWithBase64:normal64 key:keyData iv:ivData];
  NSLog(@"%@", [result utf8String]);
}

@end
