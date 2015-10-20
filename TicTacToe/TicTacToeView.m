//
//  TicTacToeView.m
//  TicTacToe
//
//  Created by Michael on 5/9/13.
//  Copyright (c) 2013 michael. All rights reserved.
//

#import "TicTacToeView.h"

@implementation TicTacToeView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)awakeFromNib
{
    turn = FALSE;
    reset = FALSE;
    //Initialize board
    board = malloc(sizeof(int)*9);
    for (int a=0;a<9;a++)
        board[a] = -1;
    
}

- (void)drawRect:(NSRect)dirtyRect
{
    if (reset==FALSE)
    {
        for (int i=0;i<9;i++)
        {
            if (board[i] == -1) continue;
            NSFont *font = [NSFont fontWithName:@"Helvetica-Bold" size:50];
            NSAttributedString *x = [[NSAttributedString alloc] initWithString:@"X" attributes:@{NSFontAttributeName: font}];
            NSAttributedString *o = [[NSAttributedString alloc] initWithString:@"O" attributes:@{NSFontAttributeName: font}];
        
            NSPoint point = NSMakePoint(0, 0);
        
            if (i==0)
                point = NSMakePoint(50, 250);
            else if (i==1)
                point = NSMakePoint(150, 250);
            else if (i==2)
                point = NSMakePoint(250, 250);
            else if (i==3)
                point = NSMakePoint(50, 150);
            else if (i==4)
                point = NSMakePoint(150, 150);
            else if (i==5)
                point = NSMakePoint(250, 150);
            else if (i==6)
                point = NSMakePoint(50, 50);
            else if (i==7)
                point = NSMakePoint(150, 50);
            else if (i==8)
                point = NSMakePoint(250, 50);
        
            if (board[i]==0)
            {
                point.x-=x.size.width/2;
                point.y-=x.size.height/2;
            
                [x drawAtPoint:point];
            }
            else if (board[i]==1)
            {
                point.x-=o.size.width/2;
                point.y-=o.size.height/2;
            
                [o drawAtPoint:point];
            }
        }
    
        if (winLine != nil)
        {
            [winLine stroke];
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(newGame) userInfo:nil repeats:NO];
        }
    }
    else {
        [[NSColor controlColor] set];
        NSRectFill(dirtyRect);
        reset = FALSE;
    }
}

-(void)mouseDown:(NSEvent *)theEvent
{
    NSPoint p = [theEvent locationInWindow];
    
    int n=-1;
 
    if (p.x < 100 && p.y > 200 && board[0]==-1)
        n=0;
    else if (p.x > 100 && p.x < 200 && p.y > 200 && board[1]==-1)
        n=1;
    else if (p.x > 200 && p.y > 200 && board[2]==-1)
        n=2;
    else if (p.x < 100 && p.y < 200 && p.y > 100 && board[3]==-1)
        n=3;
    else if (p.x > 100 && p.x < 200 && p.y > 100 && p.y< 200 && board[4]==-1)
        n=4;
    else if (p.x > 200 && p.y > 100 && p.y < 200 && board[5]==-1)
        n=5;
    else if (p.x < 100 && p.y < 100 && board[6]==-1)
        n=6;
    else if (p.x > 100 && p.x < 200 && p.y < 100 && board[7]==-1)
        n=7;
    else if (p.x > 200 && p.y < 100 && board[8]==-1)
        n=8;
    
    if (n!=-1)
    {
        board[n] = turn;
        
        if (board[0]==board[1] && board[1]==board[2] && board[0]!=-1)
            winLine = [NSBezierPath bezierPathWithRect:NSMakeRect(50, 250, 200, 0)];
        else if (board[3]==board[4] && board[4]==board[5] && board[3]!=-1)
            winLine = [NSBezierPath bezierPathWithRect:NSMakeRect(50, 150, 200, 0)];
        else if (board[6]==board[7] && board[7]==board[8] && board[6]!=-1)
            winLine = [NSBezierPath bezierPathWithRect:NSMakeRect(50, 50, 200, 0)];
        else if (board[0]==board[3] && board[3]==board[6] && board[0]!=-1)
            winLine = [NSBezierPath bezierPathWithRect:NSMakeRect(50, 50, 0, 200)];
        else if (board[1]==board[4] && board[4]==board[7] && board[1]!=-1)
            winLine = [NSBezierPath bezierPathWithRect:NSMakeRect(150, 50, 0, 200)];
        else if (board[2]==board[5] && board[5]==board[8] && board[2]!=-1)
            winLine = [NSBezierPath bezierPathWithRect:NSMakeRect(250, 50, 0, 200)];
        else if (board[0]==board[4] && board[4]==board[8] && board[0]!=-1)
        {
            winLine = [[NSBezierPath alloc] init];
            [winLine moveToPoint:NSMakePoint(50, 250)];
            [winLine lineToPoint:NSMakePoint(250, 50)];
        }
        else if (board[2]==board[4] && board[4]==board[6] && board[2]!=-1)
        {
            winLine = [[NSBezierPath alloc] init];
            [winLine moveToPoint:NSMakePoint(50, 50)];
            [winLine lineToPoint:NSMakePoint(250, 250)];
        }
        
        BOOL full = TRUE;
        
        for (int i=0;i<9;i++)
        {
            if (board[i]==-1){ full = FALSE; break;}
        }
        
        if (full==TRUE)
            winLine = [NSBezierPath bezierPathWithRect:NSMakeRect(-1, -1, 0, 0)];
        
        [self setNeedsDisplay:YES];
        turn=!turn;
    }
    
}

-(void)newGame
{
    for (int i=0;i<9;i++)
        board[i] = -1;
    turn = 0;
    winLine = nil;
    reset = TRUE;
    [self setNeedsDisplay:YES];
}

@end
