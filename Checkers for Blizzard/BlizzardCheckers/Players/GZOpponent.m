//
//  GZOpponent.m
//  BlizzardCheckers
//
//  Created by Francisco Granados on 19/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import "GZOpponent.h"

@implementation GZOpponent

@synthesize controller;
@synthesize maxStartedMovements;
@synthesize startedYLine;
@synthesize movementNumber;

- (id)initWithBoardController:(GZBoardViewController *)aController
{
  self = [super init];
  if (self) {
    self.controller = aController;
    self.maxStartedMovements = 3;
  }
  return self;
}

- (void)takeTurn
{
  if (movementNumber == 0) {
    [self starterYPosition];
  }
  
  movementNumber++;
  
  if (movementNumber <= maxStartedMovements) {
    [self performFirstMovement];
  } else {
    [self performAIMovement];
  }
}

- (void)performFirstMovement
{
  GZSquare *piece = [self chooseFirstMovementPiece];
  GZSquare *square = [self chooseFirstMovementSquare:piece];
  if (square == nil) {
    [self performAIMovement];
  } else {
    [controller opponentWantsMakeMovement:piece toSquare: square];

  }
  
}

- (GZSquare *)chooseFirstMovementPiece
{
  GZSquarePiece playerPiece = [controller pieceForPlayer:GZBoardPlayerAI];
  NSMutableArray *pieces = [[controller board] piecesForPlayer:playerPiece];
  
  // Took the pieces on the front
  NSMutableArray *frontPieces = [NSMutableArray array];
  
  for (GZSquare *piece in pieces) {
    if (self.startedYLine == piece.y) {
      [frontPieces addObject:piece];
    }
  }
  // take one of the front randomly
  int random = arc4random();
  int maxIndex = (int) (frontPieces.count - 1);
  int pieceIndex = (int) (random % maxIndex);
  int idx = abs(pieceIndex);
  
  GZSquare *randomPiece = frontPieces[idx];
  return randomPiece;
}

- (GZSquare *)chooseFirstMovementSquare:(GZSquare *)piece
{
  NSMutableArray *squares = [[controller board] squaresAvailable];
  NSMutableArray *spaces = [NSMutableArray array];
  
  for (GZSquare *square in squares) {
    if ([controller canPerformMovementFromSquare:piece toSquare:square]) {
      [spaces addObject:square];
    }
  }
  
  if ([spaces count] == 0) {
    return nil;
  } else {
    return (GZSquare *)[spaces firstObject];
  }
}

- (void)starterYPosition
{
  GZSquarePiece playerPiece = [controller pieceForPlayer:GZBoardPlayerAI];
  NSMutableArray *pieces = [[controller board] piecesForPlayer:playerPiece];
  int frontYValue = 0;
  // This can be perform with a map or mapReduction function
  for (GZSquare *piece in pieces) {
    if (frontYValue < piece.y) {
      frontYValue = piece.y;
    }
  }
  self.startedYLine = frontYValue;
}

- (void)performAIMovement
{
  // Here I come MUAHAHAHA!
  NSLog(@"I don have time =( ");
}

@end
