//
//  NXNShareItem.h
//  NIUShareDemo
//
//  Created by cocoa_niu on 2018/11/26.
//  Copyright © 2018年 cocoa_niu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/***  当前屏幕宽度 */
#define UI_SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
/***  当前屏幕高度 */
#define UI_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
/***  RGB颜色 */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
/***  Ipad判断 */
#define isIpad (([[UIDevice currentDevice].model isEqualToString:@"iPad"]) ? YES : NO)

/***  iPhoneX / iPhoneXS */
#define isIphoneX_XS (([UIScreen mainScreen].bounds.size.height == 812.f) ? YES : NO)
/***  iPhoneXR / iPhoneXSMax */
#define isIphoneXR_XSMax (([UIScreen mainScreen].bounds.size.height == 896.f) ? YES : NO)
/***  异形全面屏 */
#define isIphoneFullScreen (isIphoneX_XS || isIphoneXR_XSMax)
/***  Ipad判断 */
#define isIpad (([[UIDevice currentDevice].model isEqualToString:@"iPad"]) ? YES : NO)
/***  tabBar高度 */
#define TAB_BAR_HEIGHT (isIphoneFullScreen ? (49.f + 34.f) : 49.f)


NS_ASSUME_NONNULL_BEGIN

@class NXNShareModel;
@class NXNShareItem;
typedef void (^__nullable shareHandle)(NXNShareItem *item);

//预制的分享平台
extern NSString *const  NXNPlatformNameSina;// 新浪微博
extern NSString *const  NXNPlatformNameQQ;//QQ
extern NSString *const  NXNPlatformNameQQZone;//QQ空间
extern NSString *const  NXNPlatformNameWechatTimeLine;//微信朋友圈
extern NSString *const  NXNPlatformNameWechatSession;//微信好友


//预制的分享事件
extern NSString *const  NXNPlatformHandleSina;// 新浪微博
extern NSString *const  NXNPlatformHandleQQ;//QQ
extern NSString *const  NXNPlatformHandleQQZone;//QQ空间
extern NSString *const  NXNPlatformHandleWechatTimeLine;//微信朋友圈
extern NSString *const  NXNPlatformHandleWechatSession;//微信好友

//预制的功能按钮
extern NSString *const  NXNFunctionNameCopyLink;//复制链接
extern NSString *const  NXNFunctionNameMore;//更多

//预制的功能事件
extern NSString *const  NXNFunctionHandleCopyLink;//复制链接
extern NSString *const  NXNFunctionHandleMore;//更多

@interface NXNShareItem : NSObject
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak) UIViewController *presentVC;
@property (nonatomic, copy) shareHandle action;

@property (nullable, nonatomic, strong) NXNShareModel *shareModel;


- (instancetype)initWithImageName:(NSString *)imageName
                        title:(NSString *)title
                       action:(shareHandle)action;

- (instancetype)initWithImageName:(NSString *)imageName
                        title:(NSString *)title
                   actionName:(NSString *)actionName;

- (instancetype)initWithPlatformName:(NSString *)platformName;


@end

NS_ASSUME_NONNULL_END
