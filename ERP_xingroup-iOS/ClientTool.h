//
//  ClientTool.h
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/24.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

@interface ClientTool : NSObject

/*!@brief sdwebimage 获取UIIimageview图片
 */
+ (void)setSDImage:(UIImageView *)imageview WithUrlString:(NSString*)urlString  placeholderImage:(NSString *)placeImage;

//缓存并压缩图片
+ (void) setAndCompressionSDImage:(UIImageView *)imageview WithUrlString:(NSString *)urlString placeholderImage:(NSString *)placeImage;

/*!@brief sdwebimage 获取UIButton图片
 */
+ (void)setSDButtonImage:(UIButton *)button WithUrlString:(NSString*)urlString placeholderImage:(NSString *)placeImage;

/**!@brief Get方法请求数据
 @param urlPath 路径
 @param parameters 请求需要的参数,只传原始参数，不需要考虑openid，systemid，verify
 @param body 上传的body
 @param success 成功block
 @param failure 失败block
 @return
 */
+ (void) getUrlPath:(NSString *)urlPath withParamers:(NSDictionary *)parameters  andBody:(NSDictionary *)body success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure;

/**
 Post方法请求数据
 @param urlPath 路径
 @param parameters 请求需要的参数,只传原始参数，不需要考虑openid，systemid，verify
 @param body 上传的body
 @param success 成功block
 @param failure 失败block
 @return
 */
+ (void) postUrlPath:(NSString *)urlPath withParamers:(NSDictionary *)parameters andBody:(NSDictionary *)body success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure;


/*
 Update图片
 @param imagePath 图片地址数组
 @param parameters 请求需要的参数,只传原始参数，folder = @"",module = @"test/sippingTea"
 @param success 成功block
 @param failure 失败block
 */
+ (void) postUIImagePaths:(NSArray *)imagePaths withPatamaters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure;

/*
 Update图片
 @param images  图片数组 @[UIImage,UIImage,...,nil];
 @param parameters 请求需要的参数,只传原始参数，folder = @"",module = @"test/sippingTea"
 @param serverFolder 服务器上的文件夹，必需要设置
 @param success 成功block
 @param failure 失败block
 */
+ (void) postUIImages:(NSArray *)images withPatamaters:(NSDictionary *)parameters serverFolder:(NSString *)folder success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure;

@end
