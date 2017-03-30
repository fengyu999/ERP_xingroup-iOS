//
//  UIImage+Compression.h
//  PinChao
//
//  Created by Shi.Zhoxing on 15/7/25.
//  Copyright (c) 2015年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage(Compression)

/* ALAsset */
+ (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)size;
/*
 //获取资源图片的详细资源信息
 ALAssetRepresentation* representation = [asset defaultRepresentation];
 //获取资源图片的长宽
 CGSize dimension = [representation dimensions];
*/


/* UIImage */
//压缩图片质量
+(UIImage *)reduceImage:(UIImage *)image percent:(float)percent;
//压缩图片尺寸
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
