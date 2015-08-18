//
//  noProductCell.m
//  zhicai
//
//  Created by perfect on 15/4/1.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "NoProductCell.h"

@implementation NoProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self makeUI];
    }
    return self;
}

- (void)makeUI
{
    
    self.lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 130, 30)];
    self.lab1.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
   // self.lab1.text =@"智选天下1期";
    self.lab1.textColor = [MyControl getColor:@"#31424A"];
    //lab1.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.lab1];
    lab2 = [MyControl createLabelFrame:CGRectMake(10, 30, 130, 20) font:12 Text:@"预期年化收益"];
    lab2.textColor = [MyControl getColor:@"#8E8E8E"];
    [self.contentView addSubview:lab2];
    self.lab3 = [MyControl createLabelFrame:CGRectMake(21, 50, 130, 45) font:30 Text:nil];//@"10.00"
    //lab3.backgroundColor = [UIColor greenColor];
    self.lab3.textColor = [MyControl getColor:@"#3E535E"];
    [self.contentView addSubview:self.lab3];
    lab6 = [MyControl createLabelFrame:CGRectMake(95, 67, 30, 20) font:12 Text:@"%"];
    lab6.textColor = [UIColor colorWithRGBHex:0x666666];
    lab6.backgroundColor = [UIColor colorWithRGBHex:0xffffff];
    [self.contentView addSubview:lab6];
    
    
     self.lab4 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-10-66, 10, 66, 16) font:11 Text:nil];//@"期限350天"
    self.lab4.layer.cornerRadius =4;
    self.lab4.textColor = [UIColor colorWithRGBHex:0x509ef0];
    self.lab4.clipsToBounds = YES;
    self.lab4.textAlignment = NSTextAlignmentCenter;
    self.lab4.backgroundColor = [MyControl getColor:@"#ededed"];
    [self.contentView addSubview:self.lab4];
    self.proView = [[ProgressView alloc]initWithFrame:CGRectMake(MRScreenWidth-65, 36, 49, 49)];
    self.proView.arcFinishColor = [UIColor colorWithRGBHex:0xededed];
    self.proView.arcBackColor = [MyControl getColor:@"#ededed"];
   // self.proView.percent = 1;
//    if (self.proView.percent>0.3) {
//        
//        self.proView.arcUnfinishColor = [UIColor redColor];
//    }else{
//        
//        self.proView.arcUnfinishColor = [UIColor greenColor];
//    }
    [self.contentView addSubview:self.proView];
    
    lab5 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-90, 70, 35, 20) font:12 Text:@"仅剩"];
   // lab5.backgroundColor = [UIColor redColor];
    lab5.textColor = [MyControl getColor:@"#8E8E8E"];

    [self.contentView addSubview:lab5];
    
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 96, MRScreenWidth-15*2, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [self.contentView addSubview:lineView];

}

- (void)configModel:(productModel *)model
{
   
    self.lab1.text = model.proName;
    self.lab3.text = model.finRate;
    self.lab4.text = [NSString stringWithFormat:@"期限%d天",model.lastDateLong.intValue/ (1000 * 60 * 60 * 24)];
    self.proView.percent = [model.lateMountPresent floatValue]/100;

//    if (self.proView.percent<0.35&&self.proView.percent==0.35) {
//        
//        self.proView.arcUnfinishColor = [UIColor colorWithRGBHex:0xec9095];
//    }else if(self.proView.percent>0.35&&self.proView.percent<0.65&&self.proView.percent==0.65){
//        
//        self.proView.arcUnfinishColor = [UIColor colorWithRGBHex:0xec9095];
//    }else
//        
//    {
        self.proView.arcUnfinishColor = [UIColor colorWithRGBHex:0xec9095];
//    
//    }

}

- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
