//
//  GZSquare.h
//  BlizzardCheckers
//
//  Created by Francisco Granados on 19/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  GZSquareTypeWhite,
  GZSquareTypeBlack
} GZSquareType;

typedef enum : NSUInteger {
  GZSquarePieceRed,
  GZSquarePieceGreen,
  GZSquarePieceNone
} GZSquarePiece;

@interface GZSquare : UIButton

@property(nonatomic) int x;
@property(nonatomic) int y;
@property(nonatomic) GZSquareType type;
@property(nonatomic) GZSquarePiece piece;


+ (id)squareWithType:(GZSquareType)type;

- (NSString *)description;

- (void)placePlayerPiece:(GZSquarePiece)playerPiece;
- (void)removePlayerPiece;

- (BOOL)isPlayable;
- (BOOL)hasPiece;
- (BOOL)hasPlayerPiece:(GZSquarePiece)playerPiece;

@end
