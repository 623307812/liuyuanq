//
//  GetImage.h
//  GifCreat
//
//  Created by admin on 16/11/3.
//  Copyright © 2016年 LiuYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
@interface GetImage : NSObject
+(UIImage *)getImage:(NSString *)videoURL;
+(UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

@end
