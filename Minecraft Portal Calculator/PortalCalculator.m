//
//  PortalCalculator.m
//  Minecraft Portal Calculator
//
//  Created by Liana Chu on 1/26/15.
//  Copyright (c) 2015 Liana Chu. All rights reserved.
//

#import "PortalCalculator.h"

@implementation PortalCalculator

+ (int)PCNetherXCoordIntFromOverworldXCoordInt:(int)OverworldXCoordInt;
{
    return floorf((float)OverworldXCoordInt/8.0);
}

+ (int)PCNetherZCoordIntFromOverworldZCoordInt:(int)OverworldZCoordInt;
{
    return floorf((float)OverworldZCoordInt/8.0);
}

+ (int)PCOverworldXCoordIntFromNetherXCoordInt:(int)NetherXCoordInt;
{
    return floorf((8.0)*(float)NetherXCoordInt);
}

+ (int)PCOverworldZCoordIntFromNetherZCoordInt:(int)NetherZCoordInt;
{
    return floorf((8.0)*(float)NetherZCoordInt);
}

+ (int)ConsoleNetherXCoordIntFromOverworldXCoordInt:(int)OverworldXCoordInt;
{
    return floorf((float)OverworldXCoordInt/3.0);
}

+ (int)ConsoleNetherZCoordIntFromOverworldZCoordInt:(int)OverworldZCoordInt;
{
    return floorf((float)OverworldZCoordInt/3.0);
}

+ (int)ConsoleOverworldXCoordIntFromNetherXCoordInt:(int)NetherXCoordInt;
{
    return floorf((3.0)*(float)NetherXCoordInt);
}

+ (int)ConsoleOverworldZCoordIntFromNetherZCoordInt:(int)NetherZCoordInt;
{
    return floorf((3.0)*(float)NetherZCoordInt);
}

@end
