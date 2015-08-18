//
//  bankCell.m
//  zhicai
//
//  Created by perfect on 15/4/8.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "BankCardModel.h"
#import "BankCell.h"

@implementation BankCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self makeUI];
    }
    return self;
}

-(void)makeUI

{
    self.backgroundColor = [UIColor whiteColor];
    
    bankImg = [MyControl createImageViewFrame:CGRectMake(21, (59-30)/2, 30, 30) imageName:nil];
    bankImg.backgroundColor = [UIColor grayColor];
    bankImg.layer.cornerRadius = bankImg.frame.size.width/2;
    bankImg.layer.masksToBounds = YES;
    [self.contentView addSubview:bankImg];
    
    
    bankLab = [MyControl createLabelFrame:CGRectMake(61, 0, 100, 59) font:15 Text:@"工商银行"];
    bankLab.textColor = [MyControl getColor:@"#31424A"];
   // bankLab.backgroundColor= [UIColor greenColor];
    [self.contentView addSubview:bankLab];
    
    haoLab = [MyControl createLabelFrame:CGRectMake(140, 0, 100, 59) font:12 Text:@"尾号：1638"];
    haoLab.textColor = [MyControl getColor:@"#8E8E8E"];
    //haoLab.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:haoLab];
    

}
-(void)setBank:(BankCardModel*) model{
    if (model.cardNum.length!=0) {
        bankLab.text = [NSString stringWithFormat:@"%@",model.bankName];
        haoLab.text = [NSString stringWithFormat:@"尾号：%@",[model.cardNum substringFromIndex:model.cardNum.length-4]];
        NSData* data  = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.logoPath]];
        bankImg.image = [UIImage imageWithData:data];

    }else{
        bankLab.text = @"";
        
        haoLab.text = @"";
       // NSData* data  = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.logoPath]];
       // bankImg.image = [UIImage imageWithData:data];

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
