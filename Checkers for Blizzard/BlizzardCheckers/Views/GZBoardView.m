//
//  GZBoardView.m
//  BlizzardCheckers
//
//  Responsabilities: Create the touchable controls,
//  Place the pieces in their position
//  Send a method when one piece is touched
//
//  Created by Francisco Granados on 19/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import "GZBoardView.h"
#import "GZSquare.h"
#import "GZBoardViewController.h"

@implementation GZBoardView

@synthesize size;
@synthesize fullSize;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame andSquaresInAxis:(int)numberOfSquares {
  self = [super initWithFrame:frame];
  
  if (self !=  nil) {
    [self setSize:numberOfSquares];
    int full = (int) pow(size, 2);
    [self setFullSize:full];
    double squaresSize = frame.size.width / size;
    [self createSquaresWithSize:squaresSize];
    [self placeSquares];
    [self placePieces];
  }
  return self;
}

- (void)createSquaresWithSize:(double)squareSize {
  for (int i = 0; i < self.fullSize; i++) {
    GZSquare *square = [GZSquare squareWithType:[self squareTypeForIndex:i]];
    square.frame = CGRectMake(0, 0, squareSize, squareSize);
    
//    I only need the black ones receive the touch
    if ([square isPlayable]) {
      [square addTarget:self action:@selector(userDidTapInsideSquare:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:square];
  }
}

- (GZSquareType)squareTypeForIndex:(int)idx
{
  int i = idx;
  int row = (int) (idx / self.size);
  if (row % 2 == 0) {
    i++;
  }
  if (i % 2 == 0) {
    return GZSquareTypeBlack;
  } else {
    return GZSquareTypeWhite;
  }
  
}

- (void)placeSquares
{
  int col = 0;
  for (int i = 0; i < self.subviews.count; i++) {
    
    GZSquare *square = (GZSquare *)self.subviews[i];
    int row = (int) (i / self.size);
    if (i % self.size == 0) {
      col = 0;
    }
    
    double x = (double) square.frame.size.width * (double) col;
    double y = (double) square.frame.size.height * (double) row;
    square.frame = CGRectMake(x, y, square.frame.size.width, square.frame.size.height);
    square.x = col;
    square.y = row;
    
    col++;
  }
}

- (void)placePieces
{
  for (int i = 0; i < self.subviews.count; i++) {
    GZSquare *square = (GZSquare *)self.subviews[i];
    
    if ([square isPlayable]) {
      int row = (int) i / self.size;
      
      if (row < [self numberOfRowsWithPieces]) {
        [square placePlayerPiece:GZSquarePieceGreen];
        
      } else if (row >= self.size - [self numberOfRowsWithPieces]) {
        [square placePlayerPiece:GZSquarePieceRed];
      }
    }
  }
}

- (int)numberOfRowsWithPieces
{
  // 2 Opponents
  // In normal games they have 2 rows between at start
  return (int) ((self.size - 2) / 2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

# pragma mark - User actions

- (void)userDidTapInsideSquare:(GZSquare *)sender
{
  if ([self.delegate conformsToProtocol:@protocol(GZBoardViewDelegate)]) {
    [self.delegate userDidTapInsideSquare:sender];
  }
}

# pragma mark - Board movements

- (void)performMovementFrom:(GZSquare *)piece toSquare:(GZSquare *)square
{
  [square placePlayerPiece:piece.piece];
  [piece removePlayerPiece];
}

- (void)performRemovePiece:(GZSquare *)piece
{
  [piece removePlayerPiece];
}

# pragma mark - Board information

- (NSMutableArray *)piecesForPlayer:(GZSquarePiece)playerPiece
{
  NSMutableArray *pieces = [NSMutableArray array];
  
  for (UIView *view in self.subviews) {
    GZSquare *square = (GZSquare *)view;
    if (square.piece == playerPiece) {
      [pieces addObject:square];
    }
  }
  return pieces;
}

- (NSMutableArray *)squaresAvailable
{
  NSMutableArray *squares = [NSMutableArray array];
  
  for (UIView *view in self.subviews) {
    GZSquare *square = (GZSquare *)view;
    if (![square hasPiece] && [square isPlayable]) {
      [squares addObject:square];
    }
  }
  
  return squares;
}

- (GZSquare *)squareForPositionX:(int)x y:(int)y
{
  GZSquare *result;
  
  for (UIView *view in self.subviews) {
    GZSquare *square = (GZSquare *)view;
    if (square.x == x && square.y == y) {
      result = square;
    }
  }
  return result;
}

@end
