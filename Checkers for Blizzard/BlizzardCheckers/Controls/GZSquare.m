//
//  GZSquare.m
//  BlizzardCheckers
//
//  Created by Francisco Granados on 19/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import "GZSquare.h"

@implementation GZSquare

@synthesize x;
@synthesize y;
@synthesize type;
@synthesize piece;

+ (id)squareWithType:(GZSquareType)type
{
  GZSquare *instance = [self buttonWithType:UIButtonTypeCustom];
  
  instance.type = type;
  instance.piece = GZSquarePieceNone;
  
  [instance setupBackground];

  return instance;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"GZSquare at %d, %d", self.x, self.y];
}

#pragma mark Game tasks

- (void)placePlayerPiece:(GZSquarePiece)playerPiece
{
  self.piece = playerPiece;
  if (piece == GZSquarePieceGreen) {
    [self setImage:[UIImage imageNamed:@"GreenPiece"] forState:UIControlStateNormal];
    
  } else {
    [self setImage:[UIImage imageNamed:@"RedPiece"] forState:UIControlStateNormal];
  }
}

- (void)removePlayerPiece
{
  self.piece = GZSquarePieceNone;
  [self setImage:nil forState:UIControlStateNormal];
}

#pragma mark Game utilities

- (BOOL)isPlayable
{
  return (self.type == GZSquareTypeBlack) ?  YES : NO;
}

- (BOOL)hasPiece
{
  return (self.piece != GZSquarePieceNone) ? YES : NO;
}

- (BOOL)hasPlayerPiece:(GZSquarePiece)playerPiece
{
  return (self.piece == playerPiece) ? YES : NO;
}

#pragma mark Setups

- (void)setupBackground
{
  if (type ==  GZSquareTypeBlack) {
    [self setBackgroundColor:[UIColor blackColor]];
  } else {
    [self setBackgroundColor:[UIColor whiteColor]];
  }
  
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
