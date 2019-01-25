//
//  SGBaseTableViewCell.m
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/26.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "SGBaseTableViewCell.h"

@implementation SGMySelfIndexCellBackGroundView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame])
    {
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
    
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef cont = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont, COLOR_WITH_HEX(0xCCCCCC).CGColor);
    CGContextSetLineWidth(cont, .5);
    CGFloat lengths[] = {2,2};
    CGContextSetLineDash(cont, 0, lengths, 2);  //画虚线
    CGContextBeginPath(cont);
    CGContextMoveToPoint(cont, 17.f, rect.size.height - .5);    //开始画线
    CGContextAddLineToPoint(cont, rect.size.width - 17.f, rect.size.height - .5);
    CGContextStrokePath(cont);
    
}

@end


@interface SGBaseTableViewCell ()

@property (nonatomic, assign) BOOL didSetupConstraintFinished;

@end

@implementation SGBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundView:self.cusBackgroundView];
        
        [self.contentView addSubview:self.lblLeftTitle];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setBackgroundView:self.cusBackgroundView];
    
    [self.contentView addSubview:self.lblLeftTitle];
    
    [self setNeedsUpdateConstraints];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateConstraints {
    if (!self.didSetupConstraintFinished) {
        [self.lblLeftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(17.f);
            make.centerY.equalTo(self.contentView);
            
        }];
    
        self.didSetupConstraintFinished = YES;
    }
    
    [super updateConstraints];
}

- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
    
    [super setAccessoryType:accessoryType];
    [self setNeedsUpdateConstraints];
    
}

#pragma mark - setter

- (void)setHideSeparatorLine:(BOOL)hideSeparatorLine {
    
    _hideSeparatorLine = hideSeparatorLine;
    if (hideSeparatorLine) {
        self.backgroundView = nil;
    } else {
        self.backgroundView = self.cusBackgroundView;
    }
}

- (void)setLeftTitle:(NSString *)leftTitle {
    
    _leftTitle = [leftTitle copy];
    self.lblLeftTitle.text = leftTitle;
    
}

#pragma mark - getter

- (SGMySelfIndexCellBackGroundView *)cusBackgroundView {
    
    if (!_cusBackgroundView) {
        _cusBackgroundView = [[SGMySelfIndexCellBackGroundView alloc] initWithFrame:CGRectZero];
    }
    return _cusBackgroundView;
}

- (UILabel *)lblLeftTitle {
    
    if (!_lblLeftTitle) {
        _lblLeftTitle = [[UILabel alloc]init];
        _lblLeftTitle.font = [UIFont systemFontOfSize:14];
        _lblLeftTitle.textColor = COLOR_WITH_HEX(0x333333);
    }
    return _lblLeftTitle;
}

@end
