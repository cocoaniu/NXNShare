//
//  NXNAdjustFontView.h
//  NIUShareDemo
//
//  Created by cocoa_niu on 2018/11/28.
//  Copyright © 2018年 cocoa_niu. All rights reserved.
//

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

typedef void(^FontBlock)();

@interface NXNAdjustFontView : UIView

- (void)setFontSize:(NSInteger)size;
- (void)showFromControlle:(UIViewController *)controller;
- (void)showFromControlle:(UIViewController *)controller finish:(FontBlock)block;

@end
