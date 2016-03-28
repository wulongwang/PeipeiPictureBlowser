//
//  PeipeiPicturesView.h
//  
//
//  Created by 58 on 16/3/25.
//  Copyright © 2016年 58. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeipeiPicturesView;

@protocol PeipeiPicturesViewDelegate <NSObject>

- (void)imageView:(PeipeiPicturesView *)view didClickImageAtIndex:(NSUInteger)index;

@end

@interface PeipeiPicturesView : UIView

- (instancetype)initWithFrame:(CGRect)frame pics:(NSArray *)pics;

@property(nonatomic, weak) id<PeipeiPicturesViewDelegate>     delegate;
@property(nonatomic, strong, readonly) NSArray                *pics;
@property(nonatomic, strong, readonly) NSArray                *picViews;

@end
