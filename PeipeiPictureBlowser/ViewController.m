//
//  ViewController.m
//  PeipeiPictureBlowser
//
//  Created by 58 on 16/3/25.
//  Copyright © 2016年 58. All rights reserved.
//

#import "ViewController.h"
#import "PeipeiPicture.h"
#import "PeipeiPicturesView.h"
#import "PeipeiPictureGroupView.h"


@interface ViewController () <PeipeiPicturesViewDelegate>

@property (nonatomic, strong) NSArray *models;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     NSLog(@"viewcontroller------%@",[NSThread currentThread]);
    
    //http://ww2.sinaimg.cn/or360/6204ece1gw1evvzegkumsj20k069f4hm.jpg long image thumail url
    //http://ww2.sinaimg.cn/wap720/6204ece1gw1evvzegkumsj20k069f4hm.jpg long image origin url
    
    NSArray *urls = @[@"http://ww3.sinaimg.cn/or360/648ac377gw1evvb5q5xw9j20k50qo7ar.jpg",
                      @"http://ww4.sinaimg.cn/wap720/648ac377gw1evvb64986kj20ke0qo79q.jpg",
                      @"http://ww3.sinaimg.cn/or360/648ac377gw1evvb638ctyj20jg0qon80.jpg",
                      @"http://ww2.sinaimg.cn/or360/648ac377gw1evvb5p5racj20kg0p07eo.jpg",
                      @"http://ww3.sinaimg.cn/or360/648ac377gw1evvb61yq07j20kg0q8wqx.jpg",
                      @"http://ww1.sinaimg.cn/or360/648ac377gw1evvb671w2nj20kg0pugvo.jpg",
                      @"http://ww2.sinaimg.cn/or360/648ac377gw1evvb6917s9j20kg0qdwkm.jpg",
                      @"http://ww1.sinaimg.cn/or360/648ac377gw1evvb69y6z0j20kg0ox0y5.jpg",
                      @"http://ww1.sinaimg.cn/or360/648ac377gw1evvb6bwk53j20kg0o7q8n.jpg"];
    
    NSArray *originUrls = @[@"http://ww3.sinaimg.cn/wap720/648ac377gw1evvb5q5xw9j20k50qo7ar.jpg",
                            @"http://ww4.sinaimg.cn/wap720/648ac377gw1evvb64986kj20ke0qo79q.jpg",
                            @"http://ww3.sinaimg.cn/wap720/648ac377gw1evvb638ctyj20jg0qon80.jpg",
                            @"http://ww2.sinaimg.cn/wap720/648ac377gw1evvb5p5racj20kg0p07eo.jpg",
                            @"http://ww3.sinaimg.cn/wap720/648ac377gw1evvb61yq07j20kg0q8wqx.jpg",
                            @"http://ww1.sinaimg.cn/wap720/648ac377gw1evvb671w2nj20kg0pugvo.jpg",
                            @"http://ww2.sinaimg.cn/wap720/648ac377gw1evvb6917s9j20kg0qdwkm.jpg",
                            @"http://ww1.sinaimg.cn/wap720/648ac377gw1evvb69y6z0j20kg0ox0y5.jpg",
                            @"http://ww1.sinaimg.cn/wap720/648ac377gw1evvb6bwk53j20kg0o7q8n.jpg"];
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < urls.count; i ++) {
        PeipeiPicture *pic = [[PeipeiPicture alloc] init];
        PeipeiPictureMetadata *thumbnail = [PeipeiPictureMetadata new];
        thumbnail.url = [NSURL URLWithString:urls[i]];
        thumbnail.type = @"WEBP",
        thumbnail.badgeType = PeipeiPictureBadgeTypeNone;
        
        PeipeiPictureMetadata *origin = [PeipeiPictureMetadata new];
        origin.url = [NSURL URLWithString:originUrls[i]];
        origin.type = @"WEBP",
        origin.badgeType = PeipeiPictureBadgeTypeNone;
        
        pic.thumbnail = thumbnail;
        pic.origin = origin;
        
        [models addObject:pic];
    }
    _models = [models copy];
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    PeipeiPicturesView *view = [[PeipeiPicturesView alloc] initWithFrame:CGRectMake(0, 100, mainSize.width, mainSize.height) pics:models];
    view.delegate = self;
    [self.view addSubview:view];
}

- (void)imageView:(PeipeiPicturesView *)view didClickImageAtIndex:(NSUInteger)index{
    if (nil == view || 0 == [_models count]) {
        return;
    }
    UIView *fromView = nil;
    NSMutableArray *items = [NSMutableArray new];
    for (NSUInteger i = 0, max = _models.count; i < max; i++) {
        UIView *imgView = view.picViews[i];
        PeipeiPicture *pic = _models[i];
        PeipeiPictureGroupItem *item = [PeipeiPictureGroupItem new];
        item.thumbView = imgView;
        item.largeImageURL = pic.origin.url;
        item.largeImageSize = CGSizeMake(pic.origin.width, pic.origin.height); //no size back
        [items addObject:item];
        if (i == index) {
            fromView = imgView;
        }
    }
    PeipeiPictureGroupView *v = [[PeipeiPictureGroupView alloc] initWithGroupItems:items];
    //v.blurEffectBackground = NO;
    [v presentFromImageView:fromView toContainer:self.view animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
