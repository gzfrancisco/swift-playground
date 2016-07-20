//
//  GZBoardViewController.h
//  BlizzardCheckers
//
//  Created by Francisco Granados on 19/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZBoardView.h"

typedef enum : NSUInteger {
  GZBoardPlayerUser,
  GZBoardPlayerAI
} GZBoardPlayer;

@interface GZBoardViewController : UIViewController <GZBoardViewDelegate>

//  I need this for the opponent, maybe i can use the faccade patter
- (GZBoardView *)board;
- (void)opponentWantsMakeMovement:(GZSquare *)piece toSquare:(GZSquare *)space;
- (GZSquarePiece)pieceForPlayer:(GZBoardPlayer)player;
- (BOOL)canPerformMovementFromSquare:(GZSquare *)piece toSquare:(GZSquare *)toSquare;

@end
