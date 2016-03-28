//
//  PeipeiPictureView.h
//  
//
//  Created by 58 on 16/3/28.
//  Copyright © 2016年 58. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeipeiPictureView : UIImageView
@property (nonatomic, copy) void (^touchBlock)(PeipeiPictureView *view, UIGestureRecognizerState state, NSSet *touches, UIEvent *event);
@property (nonatomic, copy) void (^longPressBlock)(UIView *view, CGPoint point);
@end
