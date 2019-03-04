//
//  NXNAdjustFontView.m
//  NIUShareDemo
//
//  Created by cocoa_niu on 2018/11/28.
//  Copyright © 2018年 cocoa_niu. All rights reserved.
//

#import "NXNAdjustFontView.h"

@interface NXNAdjustFontView()

@property (nonatomic, weak) UIViewController *presentVC;

@property (nonatomic, strong) UIView *containView;//背景View(包裹各种元素的view)
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UIButton *cancleButton;//取消

@property (nonatomic, copy) FontBlock block;

@end

@implementation NXNAdjustFontView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        UIControl *maskView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        maskView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
        maskView.tag = 1001;
        [maskView addTarget:self action:@selector(maskViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:maskView];
        
        _containView = [[UIView alloc] initWithFrame:CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, 115 + TAB_BAR_HEIGHT)];
        _containView.backgroundColor = [UIColor whiteColor];
        _containView.userInteractionEnabled = YES;
        [self addSubview:_containView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 25, 80, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"字体调整";
        [_containView addSubview:_titleLabel];
        
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, 64, 70)];
        leftLabel.font = [UIFont systemFontOfSize:14.0f];
        leftLabel.textColor = [UIColor blackColor];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.text = @"A";
        [_containView addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI_SCREEN_WIDTH - 64, 45, 64, 70)];
        rightLabel.font = [UIFont systemFontOfSize:28.0f];
        rightLabel.textColor = [UIColor blackColor];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.text = @"A";
        [_containView addSubview:rightLabel];
        
        
        UIView *sliderView = [[UIView alloc] initWithFrame:CGRectMake(64, 79, UI_SCREEN_WIDTH - 128, 1)];
        sliderView.backgroundColor = [UIColor lightGrayColor];
        [_containView addSubview:sliderView];
        
        for (int i = 0; i < 3; i++) {
            UIView *sliderValueView = [[UIView alloc] initWithFrame:CGRectMake(64 + ((UI_SCREEN_WIDTH - 128) / 2) * i, 75, 1, 8)];
            sliderValueView.backgroundColor = [UIColor lightGrayColor];
            [_containView addSubview:sliderValueView];
        }
        
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(64, 45, UI_SCREEN_WIDTH - 128, 70)];
        _slider.continuous = NO;
        _slider.minimumValue = 0;
        _slider.maximumValue = 2;
        
        
        _slider.value = 0;
        
        _slider.minimumTrackTintColor = [UIColor clearColor];
        _slider.maximumTrackTintColor = [UIColor clearColor];
        [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapAction:)];
        [_slider addGestureRecognizer:tap];
        [_containView addSubview:_slider];
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_slider.frame), UI_SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [_containView addSubview:lineView];

        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.backgroundColor = [UIColor whiteColor];
        _cancleButton.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame), UI_SCREEN_WIDTH, TAB_BAR_HEIGHT - 0.5);
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancleButton setTitle:@"完成" forState:UIControlStateNormal];
         [_cancleButton setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_containView addSubview:_cancleButton];
    }
    return self;
}



- (void)sliderAction:(id) sender
{
    if ([sender isKindOfClass:[UISlider class]]) {
        UISlider *slider = sender;
        if (slider.value < 1) {
            if (slider.value < 0.5) {
                slider.value = 0;
            } else {
                slider.value = 1;
            }
        } else {
            if (slider.value > 1.5) {
                slider.value = 2;
            } else {
                slider.value = 1;
            }
        }

    }
}


- (void)sliderTapAction:(UITapGestureRecognizer *)sender
{
    CGPoint touchPoint = [sender locationInView:_slider];
    CGFloat value = (_slider.maximumValue - _slider.minimumValue) * (touchPoint.x / _slider.frame.size.width );
    if (value < 1) {
        if (value < 0.5) {
            _slider.value = 0;
        } else {
            _slider.value = 1;
        }
    } else {
        if (value > 1.5) {
            _slider.value = 2;
        } else {
            _slider.value = 1;
        }
    }
}

- (void)setFontSize:(NSInteger)size {
    _slider.value = size;
}

- (void)showFromControlle:(UIViewController *)controller{
    _presentVC = controller;
    [self showInView:controller.view.window];
}

- (void)showFromControlle:(UIViewController *)controller finish:(FontBlock)block {
    _presentVC = controller;
    _block = block;
    [self showInView:controller.view.window];
}

- (void)showInView:(UIView *)view{
    [view addSubview:self];
    CGFloat height = 115 + TAB_BAR_HEIGHT;
    self.containView.frame = CGRectMake(0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH, height);
    UIView *zhezhaoView = (UIView *)[self viewWithTag:1001];
    zhezhaoView.alpha = 0;
    //执行动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        if (weakSelf.containView) {
            weakSelf.containView.frame = CGRectMake(0, UI_SCREEN_HEIGHT - self.containView.frame.size.height, UI_SCREEN_WIDTH, self.containView.frame.size.height);
        }
        zhezhaoView.alpha = 0.6;
    } completion:nil];
}

- (void)cancleButtonAction:(UIButton *)sender {
    [self tappedCancel];
}

- (void)maskViewClick:(UIControl *)sender {
    [self tappedCancel];
}

- (void)tappedCancel {
    if (_slider.value == 0) {
        NSLog(@"小");
    } else if (_slider.value == 1) {
        NSLog(@"中");
    } else if (_slider.value == 2) {
        NSLog(@"大");
    }
    if (self.block) {
        self.block();
    }
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        UIView *zhezhaoView = (UIView *)[self viewWithTag:1001];
        zhezhaoView.alpha = 0;
        if (weakSelf.containView) {
            weakSelf.containView.frame = CGRectMake(0, UI_SCREEN_HEIGHT,UI_SCREEN_WIDTH, weakSelf.containView.frame.size.height);
        }
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf removeFromSuperview];
        }
    }];
}

@end
