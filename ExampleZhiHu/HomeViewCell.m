//
//  HomeViewCell.m
//  HPYZhiHuDaily
//
//  Created by 洪鹏宇 on 15/11/6.
//  Copyright © 2015年 洪鹏宇. All rights reserved.
//

#import "HomeViewCell.h"


@interface HomeViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imaView;
@property (weak, nonatomic) IBOutlet UIImageView *warnImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imaViewWidthConstraint;

@end


@implementation HomeViewCell

- (void)setStoryModel:(StoryModel *)storyModel {
    self.titleLab.text = storyModel.title;
    if (storyModel.images == nil) {
        _imaViewWidthConstraint.constant = 0;
    }else {
        NSString *imageURL = [storyModel.images firstObject];
        [self.imaView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    }
    if (storyModel.isMultipic) {
        if (self.warnImageView.image == nil) {
            self.warnImageView.image = [UIImage imageNamed:@"Home_Morepic"];
        }
        self.warnImageView.hidden = NO;
    }else{
        self.warnImageView.hidden = YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
