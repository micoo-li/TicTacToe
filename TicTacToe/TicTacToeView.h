//
//  TicTacToeView.h
//  TicTacToe
//
//  Created by Michael on 5/9/13.
//  Copyright (c) 2013 michael. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TicTacToeView : NSView
{
    int *board;
    
    BOOL turn; //0 = x, 1 = y
    
    NSBezierPath *winLine;
    
    BOOL reset;
    
}

@end
