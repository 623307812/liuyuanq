//
//  GetImage.m
//  GifCreat
//
//  Created by admin on 16/11/3.
//  Copyright © 2016年 LiuYQ. All rights reserved.
//

#import "GetImage.h"

@implementation GetImage
+(UIImage *)getImage:(NSString *)videoURL

{
    
    //视频地址
    
//    NSURL *url = [[NSURL alloc] initWithString:videoURL];//initFileURLWithPath:videoURL] autorelease];
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath:videoURL];
    
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];//
    
    //获取视频时长，单位：秒
    
    NSLog(@"%llu",urlAsset.duration.value/urlAsset.duration.timescale);
    
    
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    
    
    
    generator.appliesPreferredTrackTransform = YES;
    
    generator.maximumSize = CGSizeMake(1136, 640);
    
    
    
    NSError *error = nil;
    
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(2, 60) actualTime:NULL error:&error];
    
    UIImage *image = [UIImage imageWithCGImage:img];
    
    return image;  
    
}  
+(UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:nil];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = [[UIImage alloc] initWithCGImage:thumbnailImageRef];
    
    return thumbnailImage;
}
@end
