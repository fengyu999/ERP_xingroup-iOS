//
//  ClientTool.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/24.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "ClientTool.h"
#import <AFNetworking/AFNetworking.h>
#import "UIView+Extent.h"
#import "UIImage+Compression.h"

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation ClientTool

+ (void)postUrlPath:(NSString *)urlPath withParamers:(NSDictionary *)parameters andBody:(NSDictionary *)body success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure{
    
    NSString *resultStr;
//    if ([urlPath isEqualToString:user_edit]||[urlPath isEqualToString:KactivitypayByXinbi]||[urlPath isEqualToString:KpayForxinbiIOSLog]||[urlPath isEqualToString:kSendVerifyCode]||[urlPath isEqualToString:KJoinActivityCancel]||[urlPath isEqualToString:kactivityDeleteComment]) {
//        
//        resultStr = [NSString_Parameters getVerifyURLWithPath:urlPath baseURL:kBaseURL paramers:parameters andBody:body];
//        
//    }else{
        resultStr = [NSString_Parameters getResultURLWithPath:urlPath baseURL:kBaseURL paramers:parameters andBody:body];
//    }

    //    NSLog(@"resultStr is %@",resultStr);

    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session.requestSerializer setTimeoutInterval:10.0f];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [session.requestSerializer setValue:@"iOS/8.0" forKey:@"User-Agent"];
    
    [session POST:resultStr parameters:body progress:^(NSProgress *uploadProgress) {
        
    }success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"responseObject---%@",responseObject);
        if (responseObject != nil) {
            NSError *error;
            NSObject *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"error---%@",[error userInfo]);
            
            if (!error) {
                success(json);
            }else {
                failure(error);
            }
        }else{
            NSError *error;
            NSLog(@" json结果为空");
            failure(error);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"失败%@",error);
        failure(error);
    }];
    return;
}

+ (void) getUrlPath:(NSString *)urlPath withParamers:(NSDictionary *)parameters  andBody:(NSDictionary *)body success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure{
    NSLog(@"%@",parameters);
    
    NSString *resultStr;
//    if ([urlPath isEqualToString:krenewVip]||[urlPath isEqualToString:kOpenVip]) {
//        
//        resultStr = [NSString_Parameters getVerifyURLWithPath:urlPath baseURL:kBaseURL paramers:parameters andBody:body];
//        
//    }else{
        resultStr = [NSString_Parameters getResultURLWithPath:urlPath baseURL:kBaseURL paramers:parameters andBody:body];
//    }
    
    
    //NSString *resultStr = [NSString_Parameters getResultURLWithPath:urlPath baseURL:kBaseURL paramers:parameters andBody:body];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:10.0];
    
    
    [manager GET:resultStr parameters:body progress:^(NSProgress *downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"responseObject---%@",responseObject);
        if (responseObject != nil) {
            NSError *error;
            NSObject *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSLog(@"error---%@",[error userInfo]);
            if (!error) {
                success(json);
            }else {
                failure(error);
            }
        }else{
            NSError *error;
            NSLog(@" json结果为空");
            failure(error);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
    return;
}

+ (void) setAndCompressionSDImage:(UIImageView *)imageview WithUrlString:(NSString *)urlString placeholderImage:(NSString *)placeImage{
    UIImage *defaultImage = [UIImage imageNamed:placeImage];
    if(!urlString)
    {
        imageview.image = defaultImage;
        return;
    }
    
    NSURL *url ;
    
    if (![urlString hasPrefix:@"http"]) {
        
        url = [NSURL URLWithString:[kBase_Image_URL stringByAppendingString:urlString]];
        
    }
    else
    {
        url = [NSURL URLWithString:urlString];
        
    }
    
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    
    UIImage *image_big = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    UIImage *image ;//图片压缩成合适大小
    
    if (!iPhone6plus) {
        image = [UIImage imageWithImageSimple:image_big scaledToSize:CGSizeMake(imageview.frame.size.width*2, imageview.frame.size.height*2)];
    }else{
        image = [UIImage imageWithImageSimple:image_big scaledToSize:CGSizeMake(imageview.frame.size.width*2.5, imageview.frame.size.height*2.5)];
    }
    
    if (image) {
        imageview.image = image;
        
    } else {
        //  __block UIImageView *imgview = imageview;
        [imageview sd_setImageWithURL:url placeholderImage:defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
    
    defaultImage = nil;
    
    image = nil;
}

+ (void)setSDImage:(UIImageView *)imageview WithUrlString:(NSString*)urlString placeholderImage:(NSString *)placeImage{
    
    UIImage *defaultImage = [UIImage imageNamed:placeImage];
    if(!urlString)
    {
        imageview.image = defaultImage;
        return;
    }
    
    NSURL *url ;
    
    if (![urlString hasPrefix:@"http"]) {
        
        url = [NSURL URLWithString:[kBase_Image_URL stringByAppendingString:urlString]];
        
    }
    else
    {
        url = [NSURL URLWithString:urlString];
        
    }
    
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    
    if (image) {
        imageview.image = image;
        
    } else {
        
        
        [imageview sd_setImageWithURL:url placeholderImage:defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            
        }];
        
    }
    
    defaultImage = nil;
    
    image = nil;
    
    key = nil;
    
    url = nil;
    
    
}

+ (void)setSDButtonImage:(UIButton *)button WithUrlString:(NSString*)urlString placeholderImage:(NSString *)placeImage{
    UIImage *defaultImage = [UIImage imageNamed:placeImage];
    if(!urlString)
    {
        [button setBackgroundImage:defaultImage forState:UIControlStateNormal];
        return;
    }
    
    NSURL *url ;
    
    if (![urlString hasPrefix:@"http"]) {
        
        url = [NSURL URLWithString:[kBase_Image_URL stringByAppendingString:urlString]];
        
    }
    else
    {
        url = [NSURL URLWithString:urlString];
        
    }
    
    
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    
    if (image) {
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
    } else {
        
        __block UIButton *buttonBlock = button;
        
        [buttonBlock sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if(!error)
            {
                
                [buttonBlock setBackgroundImage:image forState:UIControlStateNormal];
                
                
            }
            
        }];
    }
    
}

+ (void)setSDImage:(UIImageView *)imageview WithUrlString:(NSString*)urlString
{
    UIImage *defaultImage = [UIImage imageNamed:@"titleDefault"];
    if(!urlString)
    {
        imageview.image = defaultImage;
        return;
    }
    
    NSURL *url ;
    
    if (![urlString hasPrefix:@"http://"]) {
        
        url = [NSURL URLWithString:[kBase_Image_URL stringByAppendingString:urlString]];
        
    }
    else
    {
        url = [NSURL URLWithString:urlString];
        
    }
    
    
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    if (image) {
        imageview.image = image;
    } else {
        
        
        [imageview sd_setImageWithURL:url placeholderImage:defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            
        }];
        
    }
}

+ (void)setSDButtonImage:(UIButton *)button WithUrlString:(NSString*)urlString
{
    UIImage *defaultImage = [UIImage imageNamed:@"titleDefault"];
    if(!urlString)
    {
        [button setBackgroundImage:defaultImage forState:UIControlStateNormal];
        return;
    }
    
    NSURL *url ;
    
    if (![urlString hasPrefix:@"http://"]) {
        
        url = [NSURL URLWithString:[kBase_Image_URL stringByAppendingString:urlString]];
        
    }
    else
    {
        url = [NSURL URLWithString:urlString];
        
    }
    
    
    
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
    
    UIImage *image = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:key];
    
    
    if (image) {
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
    } else {
        
        __block UIButton *buttonBlock = button;
        
        [buttonBlock sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if(!error)
            {
                [buttonBlock setBackgroundImage:image forState:UIControlStateNormal];
                // [[SDImageCache sharedImageCache] storeImage:image forKey:key];
            }
            
        }];
    }
}

+ (void) postUIImagePaths:(NSArray *)imagePaths withPatamaters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-type"];
    [manager.requestSerializer setTimeoutInterval:10.0];
    [manager.requestSerializer setValue:@"iOS/8.0" forHTTPHeaderField:@"User-Agent"];
    
    [manager POST:kPostImageBaseURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 直接以 key value 的形式向 formData 中追加二进制数据
        [formData appendPartWithFormData:[@"test/PinChao" dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"module"];
        [formData appendPartWithFormData:[@"ios" dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"folder"];
        
        if (imagePaths != nil && imagePaths.count > 0) {
            [imagePaths enumerateObjectsUsingBlock:^(NSURL *filePath, NSUInteger idx, BOOL *stop) {
                //                NSLog(@" \n :%@",filePath);
                NSString *imageName =[NSString stringWithFormat:@"%f.jpg",[[NSDate date] timeIntervalSince1970]] ;//源日期
                [formData appendPartWithFileURL:filePath name:@"files" fileName:imageName mimeType:@"jpg/file" error:nil];
            }];
        }

    } progress:^(NSProgress *uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject != nil) {

        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error.description);
    }];
}

+ (void) postUIImages:(NSArray *)images withPatamaters:(NSDictionary *)parameters serverFolder:(NSString *)folder success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:10.0];
    [manager POST:kPostImageBaseURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (folder.length > 0){
            // 直接以 key value 的形式向 formData 中追加二进制数据
            [formData appendPartWithFormData:[@"XinCapNew" dataUsingEncoding:NSUTF8StringEncoding] name:@"module"];
            [formData appendPartWithFormData:[folder dataUsingEncoding:NSUTF8StringEncoding] name:@"folder"];
        }else{
            // 直接以 key value 的形式向 formData 中追加二进制数据
            [formData appendPartWithFormData:[@"XinCapNew" dataUsingEncoding:NSUTF8StringEncoding] name:@"module"];
            [formData appendPartWithFormData:[@"default" dataUsingEncoding:NSUTF8StringEncoding] name:@"folder"];
        }
        
        if (images != nil && images.count > 0) {
            [images enumerateObjectsUsingBlock:^(UIImage *img, NSUInteger idx, BOOL *stop) {
                
                NSData *data = UIImageJPEGRepresentation(img,1.0);
                NSString *imageName =[NSString stringWithFormat:@"%f.jpg",[[NSDate date] timeIntervalSince1970]] ;//源日期
                [formData appendPartWithFileData:data name:@"files" fileName:imageName mimeType:@"jpg/file"];
            }];
        }
        
    } progress:^(NSProgress *uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (responseObject != nil) {
            NSError *error;
            NSObject *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            //            NSLog(@" Success json: %@",json);
            if (!error) {
                success(json);
            }else {
                failure(error);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error.description);
        failure(error);
    }];
}

@end
