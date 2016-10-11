//
//  MXSeeTalkingButton.m
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXSeeTalkingButton.h"

@interface MXSeeTalkingButton()

@property (nonatomic, strong) UIImageView *rightIconView;
@property (nonatomic, copy) void (^ActionBlock)(NSInteger);

@end

@implementation MXSeeTalkingButton

- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag andAction:(void (^)(NSInteger))block
{
    if (self = [super initWithFrame:frame]) {
        self.tag = tag;
        self.ActionBlock = block;
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor mx_randomColor];
    self.image = [UIImage imageNamed:@"seeTalking_bg"];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonDidClick)];
    [self addGestureRecognizer:tapGesture];
    
    UIImageView *rightIconView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 44 - 10, self.height - 44 - 10, 44,44)];
    rightIconView.image = [UIImage imageNamed:@"seeTalking_video"];
    [self addSubview:rightIconView];
}

- (void)buttonDidClick
{
    self.ActionBlock(self.tag);
}

@end
