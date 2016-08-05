//
//  TopStoryView.m
//  ExampleZhiHu
//
//  Created by Aries on 16/4/13.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "TopStoryView.h"

@implementation TopStoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imaView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
        imaView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imaView];
        _imageView = imaView;
        
        UILabel *lab = [[UILabel alloc] init];
        lab.numberOfLines = 0;
        [self addSubview:lab];
        _label = lab;
    }
    return self;
}

@end
