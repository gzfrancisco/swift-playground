//
//  GZOpponent.h
//  BlizzardCheckers
//
//  Created by Francisco Granados on 19/12/14.
//  Copyright (c) 2014 gzfrancisco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GZBoardViewController.h"

@interface GZOpponent : NSObject

//  The name has to be something like referee because has the rules
@property(nonatomic, weak) GZBoardViewController *controller;

@property(nonatomic) int maxStartedMovements;
@property(nonatomic) int startedYLine;
@property(nonatomic) int movementNumber;

- (id)initWithBoardController:(GZBoardViewController *)aController;
- (void)takeTurn;

@end
