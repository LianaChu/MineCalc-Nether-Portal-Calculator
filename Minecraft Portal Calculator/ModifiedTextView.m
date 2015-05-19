//
//  ModifiedTextView.m
//  Minecraft Portal Calculator
//
//  Created by Liana Chu on 2/5/15.
//  Copyright (c) 2015 Liana Chu. All rights reserved.
//

#import "ModifiedTextView.h"

@implementation ModifiedTextView



- (BOOL)canBecomeFirstResponder
{
    return NO;
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:) || action == @selector(selectAll:) || action == @selector(paste:)) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}



@end
