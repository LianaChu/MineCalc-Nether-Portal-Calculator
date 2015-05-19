//
//  PortalCalculator.h
//  Minecraft Portal Calculator
//
//  Created by Liana Chu on 1/26/15.
//  Copyright (c) 2015 Liana Chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PortalCalculator : NSObject

+ (int)PCNetherXCoordIntFromOverworldXCoordInt:(int)OverworldXCoordInt;
+ (int)PCNetherZCoordIntFromOverworldZCoordInt:(int)OverworldZCoordInt;
+ (int)PCOverworldXCoordIntFromNetherXCoordInt:(int)NetherXCoordInt;
+ (int)PCOverworldZCoordIntFromNetherZCoordInt:(int)NetherZCoordInt;

+ (int)ConsoleNetherXCoordIntFromOverworldXCoordInt:(int)OverworldXCoordInt;
+ (int)ConsoleNetherZCoordIntFromOverworldZCoordInt:(int)OverworldZCoordInt;
+ (int)ConsoleOverworldXCoordIntFromNetherXCoordInt:(int)NetherXCoordInt;
+ (int)ConsoleOverworldZCoordIntFromNetherZCoordInt:(int)NetherZCoordInt;

@end
