//
//  PeipeiPictureView.m
//  
//
//  Created by 58 on 16/3/28.
//  Copyright © 2016年 58. All rights reserved.
//

#import "PeipeiPictureView.h"

@implementation PeipeiPictureView{
    CGPoint _point;
    NSTimer *_timer;
    BOOL _longPressDetected;
}

- (instancetype)init{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        self.exclusiveTouch = YES;
    }
    return self;
}

- (void)dealloc {
    [self endTimer];
}

- (void)startTimer {
    [_timer invalidate];
    _timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(timerFire) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)endTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)timerFire {
    [self touchesCancelled:nil withEvent:nil];
    _longPressDetected = YES;
    if (_longPressBlock) _longPressBlock(self, _point);
    [self endTimer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _longPressDetected = NO;
    if (_touchBlock) {
        _touchBlock(self, UIGestureRecognizerStateBegan, touches, event);
    }
    if (_longPressBlock) {
        UITouch *touch = touches.anyObject;
        _point = [touch locationInView:self];
        [self startTimer];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_longPressDetected) return;
    if (_touchBlock) {
        _touchBlock(self, UIGestureRecognizerStateChanged, touches, event);
    }
    [self endTimer];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_longPressDetected) return;
    if (_touchBlock) {
        _touchBlock(self, UIGestureRecognizerStateEnded, touches, event);
    }
    [self endTimer];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_longPressDetected) return;
    if (_touchBlock) {
        _touchBlock(self, UIGestureRecognizerStateCancelled, touches, event);
    }
    [self endTimer];
}


@end
