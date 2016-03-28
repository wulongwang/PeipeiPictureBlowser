//
//  PeipeiPicture.h
//  
//
//  Created by 58 on 16/3/28.
//  Copyright © 2016年 58. All rights reserved.
//

#import <Foundation/Foundation.h>

/// picture tag
typedef NS_ENUM(NSUInteger, PeipeiPictureBadgeType) {
    PeipeiPictureBadgeTypeNone = 0, ///< normal picture
    PeipeiPictureBadgeTypeLong,     ///< long picture
    PeipeiPictureBadgeTypeGIF,      ///< GIF
};

@interface PeipeiPictureMetadata : NSObject
@property (nonatomic, strong) NSURL *url; ///< Full image url
@property (nonatomic, assign) NSUInteger                  width; ///< pixel width
@property (nonatomic, assign) NSUInteger                  height; ///< pixel height
@property (nonatomic, strong) NSString                    *type; ///< "WEBP" "JPEG" "GIF"
@property (nonatomic, assign) PeipeiPictureBadgeType      badgeType;
@property (nonatomic, copy)   NSString                    *title;
@end


/***  picture  basic info*/
@interface PeipeiPicture : NSObject
@property (nonatomic, strong) PeipeiPictureMetadata    *thumbnail;
@property (nonatomic, strong) PeipeiPictureMetadata    *origin;
@property (nonatomic, strong) NSString *picID;
@property (nonatomic, strong) NSString *objectID;

@end

