//
//  NXNShareItem.m
//  NIUShareDemo
//
//  Created by cocoa_niu on 2018/11/26.
//  Copyright © 2018年 cocoa_niu. All rights reserved.
//

#import "NXNShareItem.h"
#import <Social/Social.h>
#import "NXNShareModel.h"
#import "MBProgressHUD.h"

//分享平台
NSString *const  NXNPlatformNameSina = @"NXNPlatformNameSina";
NSString *const  NXNPlatformNameQQ = @"NXNPlatformNameQQ";
NSString *const  NXNPlatformNameQQZone = @"NXNPlatformNameQQZone";
NSString *const  NXNPlatformNameWechatTimeLine = @"NXNPlatformNameWechatTimeLine";
NSString *const  NXNPlatformNameWechatSession = @"NXNPlatformNameWechatSession";


NSString *const  NXNPlatformHandleSina = @"NXNPlatformHandleSina";
NSString *const  NXNPlatformHandleQQ = @"NXNPlatformHandleQQ";
NSString *const  NXNPlatformHandleQQZone = @"NXNPlatformHandleQQZone";
NSString *const  NXNPlatformHandleWechatTimeLine = @"NXNPlatformHandleWechatTimeLine";
NSString *const  NXNPlatformHandleWechatSession = @"NXNPlatformHandleWechatSession";

//功能按钮
NSString *const  NXNFunctionNameCopyLink = @"NXNFunctionNameCopyLink";
NSString *const  NXNFunctionNameMore = @"NXNFunctionNameMore";

NSString *const  NXNFunctionHandleCopyLink = @"NXNFunctionHandleCopyLink";
NSString *const  NXNFunctionHandleMore = @"NXNFunctionHandleMore";

@implementation NXNShareItem


#pragma mark - 初始化方法

- (instancetype)initWithImageName:(NSString *)imageName
                        title:(NSString *)title
                       action:(shareHandle)action
{
    NSParameterAssert(title.length || imageName.length);
    
    self = [super init];
    if (self) {
        _title = title;
        _imageName = imageName;
        _action = action;
    }
    return self;
}


- (instancetype)initWithImageName:(NSString *)imageName
                        title:(NSString *)title
                   actionName:(NSString *)actionName
{
    self = [super init];
    if (self) {
        _title = title;
        _imageName = imageName;
        _action = [self actionFromString:actionName];
    }
    return self;
}

- (instancetype)initWithPlatformName:(NSString *)platformName{
    
    /******************************各种平台***********************************************/
    NSDictionary *messageDict;
    if ([platformName isEqualToString:NXNPlatformNameSina]) {
        messageDict = @{@"image":@"share_sina",@"title":@"新浪微博",@"action":NXNPlatformHandleSina};
    }
    if ([platformName isEqualToString:NXNPlatformNameQQ]) {
        messageDict = @{@"image":@"share_qq",@"title":@"QQ",@"action":NXNPlatformHandleQQ};
    }
    if ([platformName isEqualToString:NXNPlatformNameQQZone]) {
        messageDict = @{@"image":@"share_qqZone",@"title":@"QQ空间",@"action":NXNPlatformHandleQQZone};
    }
    if ([platformName isEqualToString:NXNPlatformNameWechatTimeLine]) {
        messageDict = @{@"image":@"share_wechatTimeLine",@"title":@"朋友圈",@"action":NXNPlatformHandleWechatTimeLine};
    }
    if ([platformName isEqualToString:NXNPlatformNameWechatSession]) {
        messageDict = @{@"image":@"share_wechatSession",@"title":@"微信好友",@"action":NXNPlatformHandleWechatSession};
    }
    
    /*********************************end************************************************/
    
    /******************************各种事件***********************************************/
    if ([platformName isEqualToString:NXNFunctionNameCopyLink]) {
        messageDict = @{@"image":@"share_link",@"title":@"复制链接",@"action":NXNFunctionHandleCopyLink};
    }
    if ([platformName isEqualToString:NXNFunctionNameMore]) {
        messageDict = @{@"image":@"share_more",@"title":@"更多",@"action":NXNFunctionHandleMore};
    }
    /*********************************end************************************************/
    
    self = [super init];
    if (self) {
        _title = (messageDict[@"title"] ? messageDict[@"title"] : @"");
        _imageName = messageDict[@"image"];
        _action = [self actionFromString:messageDict[@"action"]];
    }
    return self;
}

#pragma mark - 私有方法

//字符串转 Block
- (shareHandle)actionFromString:(NSString *)handleName{
    __weak typeof(self) weakSelf = self;
    shareHandle handle = ^(NXNShareItem *item){
        
        /******************************各种事件***********************************************/
        if ([handleName hasPrefix:@"NXNFunction"]) {
            if ([handleName isEqualToString:NXNFunctionHandleCopyLink]) {
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = [NSString stringWithFormat:@"%@",weakSelf.shareModel.shareURL];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.presentVC.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"链接已复制";
                [hud hideAnimated:YES afterDelay:1.f];
            }
            if ([handleName isEqualToString:NXNFunctionHandleMore]) {
                NSString *shareText = weakSelf.shareModel.shareTitle;
                UIImage *shareImage;
                if ([weakSelf.shareModel.shareImage isKindOfClass:[NSString class]]) {
                    shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:weakSelf.shareModel.shareImage]]];
                } else {
                    shareImage = weakSelf.shareModel.shareImage;
                }
                NSURL *shareUrl = [NSURL URLWithString:weakSelf.shareModel.shareURL];
                NSArray *activityItemsArray = @[shareText,shareImage,shareUrl];
                UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItemsArray applicationActivities:nil];
                activityVC.excludedActivityTypes = @[UIActivityTypeAirDrop];
                UIPopoverPresentationController *popoverVC = activityVC.popoverPresentationController;
                if (popoverVC) {
                    popoverVC.sourceView = weakSelf.presentVC.view;
                    popoverVC.sourceRect = CGRectMake(0, UI_SCREEN_HEIGHT, 0, 0);
                    popoverVC.permittedArrowDirections = UIPopoverArrowDirectionUp;
                }
                [weakSelf.presentVC presentViewController:activityVC animated:YES completion:nil];
            }
        }
        /*********************************end************************************************/
        
        /******************************各种平台***********************************************/
        if ([handleName hasPrefix:@"NXNPlatform"]) {
            
            // !!!:配置消息体进行分享
            
            if ([handleName isEqualToString:NXNPlatformHandleSina]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.presentVC.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"分享至新浪";
                [hud hideAnimated:YES afterDelay:1.f];
            }
            if ([handleName isEqualToString:NXNPlatformHandleQQ]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.presentVC.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"分享至QQ";
                [hud hideAnimated:YES afterDelay:1.f];
            }
            if ([handleName isEqualToString:NXNPlatformHandleQQZone]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.presentVC.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"分享至QQ空间";
                [hud hideAnimated:YES afterDelay:1.f];
            }
            if ([handleName isEqualToString:NXNPlatformHandleWechatTimeLine]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.presentVC.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"分享至微信朋友圈";
                [hud hideAnimated:YES afterDelay:1.f];
            }
            if ([handleName isEqualToString:NXNPlatformHandleWechatSession]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.presentVC.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.label.text = @"分享至微信好友";
                [hud hideAnimated:YES afterDelay:1.f];
            }
        }
        /********************************end*************************************************/

    };
    return handle;
}


@end
