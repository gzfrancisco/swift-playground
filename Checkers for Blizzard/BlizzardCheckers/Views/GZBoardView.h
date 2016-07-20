//
//  GZBoardView.h
//  BlizzardCheckers
//
//  Created by Francisco Granados on 19/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GZSquare.h"

@protocol GZBoardViewDelegate <NSObject>

- (void)userDidTapInsideSquare:(GZSquare *)sender;

@end

@interface GZBoardView : UIView

//  I dont know which name is the best, but size is the number of squares in the board in one axis
@property (nonatomic) int size;
//  I dont know which name is the best, but size is the number of squares in the board in the two axis
@property (nonatomic) int fullSize;
//  I need a delegate object to send the taps inside the view
@property (nonatomic, assign) id<GZBoardViewDelegate> delegate;


- (id)initWithFrame:(CGRect)frame andSquaresInAxis:(int)numberOfSquares;
- (void)performMovementFrom:(GZSquare *)piece toSquare:(GZSquare *)square;
- (void)performRemovePiece:(GZSquare *)piece;
- (NSMutableArray *)piecesForPlayer:(GZSquarePiece)playerPiece;
- (NSMutableArray *)squaresAvailable;
- (GZSquare *)squareForPositionX:(int)x y:(int)y;

@end
