//
//  GZBoardViewController.m
//  BlizzardCheckers
//
//  Here is the rules of game.
//  The controller receive the user input and evaluate the rules.
//  Also calls the opponent to take the chance and tell the view to perform the movements.
//
//  Created by Francisco Granados on 19/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import "GZBoardViewController.h"
#import "GZOpponent.h"

typedef enum : NSUInteger {
  GZBoardStatusWaitingForUser,
  GZBoardStatusWaitingSecondMovementForUser,
  GZBoardStatusPerformingMovement,
  GZBoardStatusWaitingForAI
} GZBoardStatus;

typedef enum : NSUInteger {
  GZBoardMovementUp,
  GZBoardMovementDown,
  GZBoardMovementLeft,
  GZBoardMovementRight
} GZBoardMovement;

@interface GZBoardViewController ()

@property (nonatomic, strong) GZOpponent *opponent;
@property (nonatomic) GZBoardPlayer chance;
@property (nonatomic) GZBoardStatus status;

@property (nonatomic, weak) GZSquare *firstSquareTouched;
@property (nonatomic, weak) GZSquare *secondSquareTouched;

@end

@implementation GZBoardViewController

@synthesize opponent;
@synthesize chance;
@synthesize status;
@synthesize firstSquareTouched;
@synthesize secondSquareTouched;


- (void)loadView {
  [super loadView];
  //  We can have more than 8 =)
  //  GZBoardView *board = [[GZBoardView alloc] initWithFrame:self.view.frame andSquaresInAxis:12];
  //  GZBoardView *board = [[GZBoardView alloc] initWithFrame:self.view.frame andSquaresInAxis:10];
  GZBoardView *board = [[GZBoardView alloc] initWithFrame:self.view.frame andSquaresInAxis:8];
  board.frame = CGRectOffset(board.frame, 0, 100);
  board.delegate = self;
  
  self.view = board;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  self.opponent = [[GZOpponent alloc] initWithBoardController:self];
  self.chance = GZBoardPlayerUser;
  self.status = GZBoardStatusWaitingForUser;
}

- (GZBoardView *)board {
  return (GZBoardView *)self.view;
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - User tasks

// When the square is filled with a piece is called piece
- (void)userTakePiece:(GZSquare *)piece
{
  self.firstSquareTouched = piece;
  self.status = GZBoardStatusWaitingSecondMovementForUser;
}

// When the square isnt filled with a piece is called square
- (void)userPlacePiece:(GZSquare *)square
{
  self.secondSquareTouched = square;
  self.status = GZBoardStatusPerformingMovement;
  
  [self.board performMovementFrom:self.firstSquareTouched toSquare:self.secondSquareTouched];
  
  [self giveChanceTo:GZBoardPlayerAI];
  
}

- (void)userEatPiece:(GZSquare *)space
{
  self.status = GZBoardStatusPerformingMovement;
  self.secondSquareTouched = space;
  GZSquare *oppinentPiece = [self opponentPieceToEat:self.firstSquareTouched space:self.secondSquareTouched player:chance];
  [oppinentPiece removePlayerPiece];
  [self userPlacePiece:self.secondSquareTouched];
  
}

- (void)cleanTouchedSquares
{
  self.firstSquareTouched = nil;
  self.secondSquareTouched = nil;
}


#pragma mark GZBoardViewDelegate

- (void)userDidTapInsideSquare:(GZSquare *)sender
{
  if (self.status == GZBoardStatusWaitingForUser && [self isFirstTouchAvailableForSquare:sender]) {
    [self userTakePiece:sender];
    
  } else if (self.status == GZBoardStatusWaitingSecondMovementForUser && [self canPerformMovementFromSquare:self.firstSquareTouched
                                                                                                   toSquare:sender]) {
    
    [self userPlacePiece:sender];
  } else if (self.status == GZBoardStatusWaitingSecondMovementForUser && [self canEat:firstSquareTouched
                                                                                space:sender
                                                                               player:GZBoardPlayerUser]) {
    NSLog(@"User is eating");
    [self userEatPiece:sender];

  }
}


# pragma mark - Game rules

- (BOOL)isFirstTouchAvailableForSquare:(GZSquare *)squareTouched
{
  if ([squareTouched hasPiece] && [squareTouched hasPlayerPiece:[self pieceForPlayer:GZBoardPlayerUser]]) {
    if (self.chance == GZBoardPlayerUser) {
      return YES;
    }
  }
  return NO;
}

- (BOOL)canPerformMovementFromSquare:(GZSquare *)piece toSquare:(GZSquare *)toSquare
{
  if (toSquare.hasPiece) {
    return NO;
  }
  
  int posibleY;
  int minPosibleX;
  int maxPosibleX;
  
  if (self.chance == GZBoardPlayerUser) {
    posibleY = piece.y - 1;
    
  } else {
    posibleY = piece.y + 1;
  }
  
  if (piece.x > 0) {
    minPosibleX = piece.x - 1;
  } else {
    minPosibleX = piece.x;
  }
  
  if (piece.x < self.board.size - 1) {
    maxPosibleX = piece.x + 1;
  } else {
    maxPosibleX = piece.x;
  }
  
  if (toSquare.y == posibleY) {
    if (toSquare.x == minPosibleX || toSquare.x == maxPosibleX) {
      return YES;
    }
  }
  
  return NO;
}

- (BOOL)canEat:(GZSquare *)piece space:(GZSquare *)space player:(GZBoardPlayer)player
{
  if (player == GZBoardPlayerUser) {
    int yMovAvailable = piece.y - 2;
    if (yMovAvailable == space.y) {
      int xMovMaxAvailable = piece.x + 2;
      int xMovMinAvailable = piece.x - 2;
      if (xMovMaxAvailable == space.x || xMovMinAvailable == space.x) {
        GZSquare *squareBetween = [self opponentPieceToEat:piece space:space player:player];
        GZSquarePiece opponentPiece = [self pieceForPlayer:GZBoardPlayerAI];
        if ([squareBetween hasPlayerPiece:opponentPiece]) {
          return YES;
        }
      }
    }
  }
  return NO;
}

- (GZSquare *)opponentPieceToEat:(GZSquare *)piece space:(GZSquare *)space player:(GZBoardPlayer)player
{
  GZBoardMovement xMov = GZBoardMovementRight;
  GZBoardMovement yMov = GZBoardMovementDown;
  
  if (piece.x > space.x) {
    xMov = GZBoardMovementLeft;
  }
  
  if (player == GZBoardPlayerUser) {
    yMov = GZBoardMovementUp;
  }
  
  int opponentXPos = (xMov == GZBoardMovementLeft) ? piece.x - 1 : piece.x  + 1;
  int opponentYPos = (yMov == GZBoardMovementUp) ? piece.y - 1 : piece.y + 1;
  
  GZSquare *opponentPiece = [[self board] squareForPositionX:opponentXPos y:opponentYPos];
  return opponentPiece;
}

# pragma Players and pieces

- (GZBoardPlayer)playerForPiece:(GZSquarePiece)piece
{
  if (piece == GZSquarePieceRed) {
    return GZBoardPlayerUser;
  }
  return GZBoardPlayerAI;
}

- (GZSquarePiece)pieceForPlayer:(GZBoardPlayer)player
{
  if (player == GZBoardPlayerUser) {
    return GZSquarePieceRed;
  }
  return GZSquarePieceGreen;
}

- (void)giveChanceTo:(GZBoardPlayer)player
{
  if (player == GZBoardPlayerUser) {
    self.chance = GZBoardPlayerUser;
    [self cleanTouchedSquares];
    self.status = GZBoardStatusWaitingForUser;
    
  } else {
    self.chance = GZBoardPlayerAI;
    self.status = GZBoardStatusWaitingForAI;
    [self.opponent takeTurn];
    
  }
}

- (void)opponentWantsMakeMovement:(GZSquare *)piece toSquare:(GZSquare *)space
{
  self.status = GZBoardStatusPerformingMovement;
  [[self board] performMovementFrom:piece toSquare:space];
  [self giveChanceTo:GZBoardPlayerUser];
}
@end
