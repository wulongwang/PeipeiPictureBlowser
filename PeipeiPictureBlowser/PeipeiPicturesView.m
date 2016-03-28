//
//  PeipeiPicturesView.m
//  PeipeiPictureBlowser
//
//  Created by 58 on 16/3/25.
//  Copyright © 2016年 58. All rights reserved.
//

#import "PeipeiPicturesView.h"
#import "UIView+Add.h"
#import "PeipeiPictureGroupView.h"
#import "UIImageView+WebCache.h"
#import "PeipeiPicture.h"
#import "PeipeiPictureView.h"
#import "PeipeiPictureGroupView.h"

@interface PeipeiPicturesView()

@property (nonatomic, assign) CGSize   picSize;

@end

@implementation PeipeiPicturesView

- (instancetype)initWithFrame:(CGRect)frame pics:(NSArray *)pics{
    if (self = [super initWithFrame:frame]) {
        _pics = pics;
        @weakify(self);
        NSMutableArray *picViews = [NSMutableArray new];
        for (NSUInteger i = 0; i < 9; i++) {
            PeipeiPictureView *imageView = [[PeipeiPictureView alloc] init];
            imageView.size = self.picSize;
            imageView.hidden = YES;
            imageView.touchBlock =^(PeipeiPictureView *view, UIGestureRecognizerState state, NSSet *touches, UIEvent *event) {
                if (state == UIGestureRecognizerStateEnded) {
                    UITouch *touch = touches.anyObject;
                    CGPoint p = [touch locationInView:view];
                    if (CGRectContainsPoint(view.bounds, p)) {
                        [weak_self.delegate imageView:weak_self didClickImageAtIndex:i];
                    }
                }
            };
            [picViews addObject:imageView];
            [self addSubview:imageView];
        }
        _picViews = picViews;
        NSUInteger picsCount = _pics.count;
        CGSize picSize = self.picSize;
        for (int i = 0; i < 9; i++) {
            UIImageView *imageView = (UIImageView *)_picViews[i];
            if (i >= picsCount) {
                imageView.hidden = YES;
            } else {
                CGPoint origin = {0};
                switch (picsCount) {
                    case 1: {
                        origin.x = 0;
                        origin.y = 0;
                    } break;
                    case 2:
                    case 4:{
                        origin.x = (i % 2) * (picSize.width + kWBCellPaddingPic);
                        origin.y = (int)(i / 2) * (picSize.height + kWBCellPaddingPic);
                    } break;
                    default: {
                        origin.x = (i % 3) * (picSize.width + kWBCellPaddingPic);
                        origin.y = (int)(i / 3) * (picSize.height + kWBCellPaddingPic);
                    } break;
                }
                imageView.frame = (CGRect){.origin = origin, .size = picSize};
                imageView.hidden = NO;
                [imageView.layer removeAnimationForKey:@"contents"];
                PeipeiPicture  *pic = _pics[i];
                @weakify(imageView);
                [imageView sd_setImageWithURL:pic.thumbnail.url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    @strongify(imageView);
                    if (!imageView) return;
                    if (image) {
                        NSUInteger width = pic.thumbnail.width > 0 ? pic.thumbnail.width : picSize.width;
                        NSUInteger height = pic.thumbnail.height > 0 ? pic.thumbnail.height : picSize.height;
                        CGFloat scale = (height / width) / (imageView.height / imageView.width);
                        if (scale < 0.99 || isnan(scale)) { // 宽图把左右两边裁掉
                            imageView.contentMode = UIViewContentModeScaleAspectFill;
                            imageView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
                        } else { // 高图只保留顶部
                            imageView.contentMode = UIViewContentModeScaleToFill;
                            imageView.layer.contentsRect = CGRectMake(0, 0, 1, (float)width / height);
                        }
                        imageView.image = image;
                        CATransition *transition = [CATransition animation];
                        transition.duration = 0.15;
                        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                        transition.type = kCATransitionFade;
                        [imageView.layer addAnimation:transition forKey:@"contents"];
                    }
                }];
            }
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat picHeight = 0;
    NSUInteger count = [_pics count];
    if (count > 0 && count <= 3) {
        picHeight = self.picSize.height;
    }else if(count > 3 && count <= 6){
        picHeight = self.picSize.height * 2 + kWBCellPaddingPic;
    }else{
        picHeight = self.picSize.height * 3 + 2 * kWBCellPaddingPic;
    }
    self.frame = CGRectMake(0, self.origin.y, self.width, picHeight);
}
    
#pragma mark - getter and setter

- (CGSize )picSize{
    if (0 == _pics.count) {
        return CGSizeZero;
    }
    switch (_pics.count) {
        case 1:
            return CGSizeMake(self.width, self.width);
            break;
        case 2:
        case 4:{
            CGFloat w = (self.width - kWBCellPaddingPic) *0.5f;
            CGFloat h = w;
            return CGSizeMake(w, h);
        }
            break;
        default:{
            CGFloat w = (self.width - 2 * kWBCellPaddingPic) /3.0f;
            CGFloat h = w;
            return CGSizeMake(w, h);
        }
            break;
    }
}


@end
