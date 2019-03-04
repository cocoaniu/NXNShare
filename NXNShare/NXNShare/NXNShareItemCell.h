//
//  NXNShareItemCell.h
//  NIUShareDemo
//
//  Created by cocoa_niu on 2018/11/26.
//  Copyright © 2018年 cocoa_niu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXNShareItem.h"

extern NSString *const  kCellIdentifier_NXNShareItemCell;// 循环利用的id

@interface NXNShareItemCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) NXNShareItem *shareItem;

@property (nonatomic) CGSize itemImageSize; //item中image大小
@property (nonatomic) CGFloat itemImageTopSpace; //item图片距离顶部大小
@property (nonatomic) CGFloat iconAndTitleSpace; //item图片和文字距离
@property (nonatomic, assign) BOOL showBorderLine; //是否显示边界线

@property (nonatomic, assign) BOOL isDisplay;

@end
