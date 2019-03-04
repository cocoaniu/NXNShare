//
//  NXNShareView.h
//  NIUShareDemo
//
//  Created by cocoa_niu on 2018/11/26.
//  Copyright © 2018年 cocoa_niu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXNShareItemCell.h"

NS_ASSUME_NONNULL_BEGIN

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define NXNShareItemCellSize CGSizeMake(80, 100)

@class NXNShareModel;
@interface NXNShareView : UIView


@property (nullable, nonatomic, strong) UIView *headerView;//头部分享标题
@property (nullable, nonatomic, strong) UIView *footerView;//尾部其他自定义View
@property (nonatomic, strong) UIButton *cancleButton;//取消
@property (nullable, nonatomic, strong) UIColor *containViewColor;
@property (nullable, nonatomic, strong) UIFont *itemTitleFont; //标题字体大小
@property (nullable, nonatomic, strong) UIColor *itemTitleColor; //标题字体颜色
@property (nullable, nonatomic, strong) UIColor *middleLineColor;//分割线颜色

@property (nonatomic) CGSize itemSize; //item大小
@property (nonatomic) CGSize itemImageSize; //item中image大小
@property (nonatomic) BOOL showBorderLine; //是否显示cell边界线
@property (nonatomic) UIEdgeInsets bodyViewEdgeInsets;//中间bodyView的边距;
@property (nonatomic) CGFloat itemImageTopSpace; //item图片距离顶部大小
@property (nonatomic) CGFloat iconAndTitleSpace; //item图片和文字距离
@property (nonatomic) CGFloat itemSpace;//item横向间距
@property (nonatomic) CGFloat middleTopSpace;//分割线距离上部按钮距离
@property (nonatomic) CGFloat middleBottomSpace;//分割线距离下部按钮距离
@property (nonatomic) CGFloat middleLineEdgeSpace;//分割线边距
@property (nonatomic) BOOL showsHorizontalScrollIndicator;//是否显示横向滚动条
@property (nonatomic) BOOL showCancleButton;//是否显示取消按钮

- (instancetype)initWithItems:(NSArray *)items itemSize:(CGSize)itemSize DisplayLine:(BOOL)inLine;
- (instancetype)initWithShareItems:(NSArray *)shareItems functionItems:(NSArray *)functionItems itemSize:(CGSize)itemSize;
- (instancetype)initWithItems:(NSArray *)items countEveryRow:(NSInteger)count;//默认九宫格样式

- (void)showFromControlle:(UIViewController *)controller;
- (void)dismiss:(BOOL)animated;

- (void)addShareModel:(NXNShareModel *)shareModel;

- (void)didSharePlatform:(NSString *)platformName;

@end

NS_ASSUME_NONNULL_END
