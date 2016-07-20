//
//  GZColorsService.m
//  Colors
//
//  Created by Francisco Granados on 8/1/15.
//  Copyright (c) 2015 gzfrancisco. All rights reserved.
//

#import "GZColorsService.h"

@implementation GZColorsService

@synthesize inputStream;
@synthesize red;
@synthesize green;
@synthesize blue;

// These are the server properties
static NSString *const server = @"localhost";
static NSInteger const port = 1234;

- (void)start {
  [self connect];
}

- (void)stop {
  [inputStream close];
  [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
                         forMode:NSDefaultRunLoopMode];
  inputStream = nil;
}

- (void)connect {
  CFStringRef host =  (__bridge CFStringRef) server;
  CFReadStreamRef readStream;
  
  CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, host, port, &readStream, nil);
  CFReadStreamSetProperty(readStream, kCFStreamPropertyShouldCloseNativeSocket, kCFBooleanTrue);
  
  inputStream = (__bridge NSInputStream *) readStream;
  
  [inputStream setDelegate:self];
  [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  [inputStream open];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
  
  if (eventCode == NSStreamEventHasBytesAvailable) {
    uint8_t buffer[1024];
    NSUInteger length;
    
    while([inputStream hasBytesAvailable]) {
      length = [inputStream read:buffer maxLength:sizeof(buffer)];
      if (length > 0) {
        if (buffer[0] == 1) {
//        Relative instruction color
          int16_t deltaRed = (buffer[1] << 8) | buffer[2];
          int16_t deltaGreen = (buffer[3] << 8) | buffer[4];
          int16_t deltaBlue = (buffer[5] << 8) | buffer[6];
          [self updateWithDeltaRed:deltaRed deltaGreen:deltaGreen deltaBlue:deltaBlue];
          [self postUpdateWithResetInstruction:NO];
          
        } else if ( buffer[0] == 2) {
//        Absolute instruction color
          [self setNewColorWithRed:buffer[1] green:buffer[2] blue:buffer[3]];
          [self postUpdateWithResetInstruction:YES];
        }
      }
    }
  }
}

- (void)updateWithDeltaRed:(NSInteger)dRed deltaGreen:(NSInteger)dGreen deltaBlue:(NSInteger)dBlue {
  if (!red || !green || !blue) {
    red = 127;
    green = 127;
    blue = 127;
  }
  
  red += dRed;
  green +=dGreen;
  blue +=dBlue;
}

- (void)setNewColorWithRed:(NSInteger)aRed green:(NSInteger)aGreen blue:(NSInteger)aBlue {
  red = aRed;
  green = aGreen;
  blue = aBlue;
}

- (void)postUpdateWithResetInstruction:(BOOL)reset {
  NSDictionary *userInfo = @{@"color": [self currentColor],
                             @"reset": [NSNumber numberWithBool:reset]};
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ColorUpdate" object:self userInfo:userInfo];
}

- (UIColor *)currentColor {
  return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

@end
