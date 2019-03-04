//
//  ViewController.m
//  NXNShare
//
//  Created by cocoa_niu on 2019/3/1.
//  Copyright © 2019 cocoa_niu. All rights reserved.
//

#import "ViewController.h"
#import "NXNShareView.h"
#import "NXNShareModel.h"
#import "NXNAdjustFontView.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *shareArray;
@property (nonatomic, strong) NSMutableArray *functionArray;
@property (nonatomic, strong) NXNShareModel *shareModel;

@end

@implementation ViewController

- (NXNShareModel *)shareModel {
    if (!_shareModel) {
        _shareModel = [[NXNShareModel alloc] init];
        _shareModel.shareTitle = @"分享标题";
        _shareModel.shareURL = @"https://www.baidu.com/";
        _shareModel.shareContent = @"分享描述";
        _shareModel.shareImage = @"https://www.baidu.com/img/baidu_resultlogo@2.png";
    }
    return _shareModel;
}

- (NSMutableArray *)shareArray {
    if (!_shareArray) {
        _shareArray = [NSMutableArray array];
        [_shareArray addObject:NXNPlatformNameWechatTimeLine];
        [_shareArray addObject:NXNPlatformNameWechatSession];
        [_shareArray addObject:NXNPlatformNameSina];
        [_shareArray addObject:NXNPlatformNameQQ];
        [_shareArray addObject:NXNPlatformNameQQZone];
    }
    return _shareArray;
}

- (NSMutableArray *)functionArray{
    if (!_functionArray) {
        _functionArray = [NSMutableArray array];
        __weak typeof (self) weakSelf = self;
        //截图分享
        [_functionArray addObject:[[NXNShareItem alloc] initWithImageName:@"share_picture" title:@"截图分享" action:^(NXNShareItem *item) {
            
        }]];
        //复制链接
        [_functionArray addObject:NXNFunctionNameCopyLink];
        //字体调整
        [_functionArray addObject:[[NXNShareItem alloc] initWithImageName:@"share_font" title:@"字体调整" action:^(NXNShareItem *item) {
            NXNAdjustFontView *fontView = [[NXNAdjustFontView alloc] init];
            [fontView showFromControlle:weakSelf finish:^{
                
            }];
        }]];

        //刷新按钮
        [_functionArray addObject:[[NXNShareItem alloc] initWithImageName:@"share_reload" title:@"刷新" action:^(NXNShareItem *item) {
            
        }]];
        //更多
        [_functionArray addObject:NXNFunctionNameMore];
    }
    return _functionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showOneLineStyle:(id)sender {
    NXNShareView *shareView = [[NXNShareView alloc] initWithItems:self.shareArray itemSize:CGSizeMake(80,100) DisplayLine:YES];
    [shareView addShareModel:self.shareModel];
    shareView.itemSpace = 10;
    [shareView showFromControlle:self];
}

- (IBAction)showDoubleLineStyle:(id)sender {
    NXNShareView *shareView = [[NXNShareView alloc] initWithShareItems:self.shareArray functionItems:self.functionArray itemSize:CGSizeMake(80,100)];
    [shareView addShareModel:self.shareModel];
    [shareView showFromControlle:self];
}

- (IBAction)showMultiLineStyle:(id)sender {
    NSMutableArray *totalArry = [NSMutableArray array];
    [totalArry addObjectsFromArray:self.shareArray];
    [totalArry addObjectsFromArray:self.functionArray];
    NXNShareView *shareView = [[NXNShareView alloc] initWithItems:totalArry itemSize:CGSizeMake(80,100) DisplayLine:NO];
    [shareView addShareModel:self.shareModel];
    shareView.itemSpace = 100;
    [shareView showFromControlle:self];
}

- (IBAction)showSquaredStyle:(id)sender {
    NXNShareView *shareView = [[NXNShareView alloc] initWithItems:self.shareArray countEveryRow:3];
    shareView.itemImageSize = CGSizeMake(45, 45);
    [shareView addShareModel:self.shareModel];
    [shareView showFromControlle:self];
}

- (IBAction)showHeadFootStyle:(id)sender {
    NXNShareView *shareView = [[NXNShareView alloc] initWithShareItems:self.shareArray functionItems:self.functionArray itemSize:CGSizeMake(80,100)];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    headerView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:51/255.0 green:68/255.0 blue:79/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"我是头部可以自定义的View";
    [headerView addSubview:label];
    
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    footerView.backgroundColor = [UIColor clearColor];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, headerView.frame.size.width, 15)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:5/255.0 green:27/255.0 blue:40/255.0 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"我是底部可以自定义的View";
    [footerView addSubview:label];
    
    shareView.headerView = headerView;
    shareView.footerView = footerView;
    [shareView addShareModel:self.shareModel];
    [shareView showFromControlle:self];
}

- (IBAction)showUserDefineStyle:(id)sender {
    NXNShareView *shareView = [[NXNShareView alloc] initWithShareItems:self.shareArray functionItems:self.functionArray itemSize:CGSizeMake(80,100)];
    [shareView.cancleButton setTitle:@"我是可以自定义的按钮" forState:UIControlStateNormal];
    shareView.middleLineColor = [UIColor redColor];
    shareView.middleLineEdgeSpace = 20;
    shareView.middleTopSpace = 10;
    shareView.middleBottomSpace = 30;
    [shareView addShareModel:self.shareModel];
    [shareView showFromControlle:self];
}

@end
