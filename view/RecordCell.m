//
//  recordCell.m
//  zhicai
//
//  Created by perfect on 15/4/9.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell
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
    
    recordImg = [MyControl createImageViewFrame:CGRectMake(16, (77-23)/2, 23, 23) imageName:@"xiaowancheng@1x.png"];
    [self.contentView addSubview:recordImg];
    
    UILabel * sucessLab = [MyControl createLabelFrame:CGRectMake(16+23+14, 10, 80,30) font:15 Text:@"交易成功"];
    sucessLab.textColor = [MyControl getColor:@"#31424A"];
    [self.contentView addSubview:sucessLab];
    
    self.infoLab = [MyControl createLabelFrame:CGRectMake(16+23+14, 38, 100, 30) font:12 Text:@"智选理财第一期"];
    self.infoLab.textColor =[MyControl getColor:@"#8E8E8E"];
    [self.contentView addSubview:self.infoLab];
    
    self.priceLab = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-20-80, 5, 80, 40) font:20 Text:@"100.00"];
    self.priceLab.textColor = [MyControl getColor:@"#31424A"];
    self.priceLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.priceLab];
    
    
    self.timeLab = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-20-120, 40, 120, 30) font:12 Text:@"2015-10-01"];
    self.timeLab.textColor = [MyControl getColor:@"#8cc3ea"];
    self.timeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLab];
    
    UIImageView * img = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, 33, 7, 11) imageName:@"dxiayib@1x.png"];
    //img.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:img];
    
    UIView * celline = [[UIView alloc]initWithFrame:CGRectMake(16, 76, MRScreenWidth-16*2, 1)];
    celline.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [self.contentView addSubview:celline];
    
}

-(void)setmodel:(recordModel*)recordmodel{
   // _model = recordmodel;
    self.infoLab.text = [NSString stringWithFormat:@"%@",recordmodel.finname];
    self.priceLab.text = [NSString stringWithFormat:@"%@",recordmodel.bitAmount];
    NSString* str = [NSString stringWithFormat:@"%@",recordmodel.startDate];
    NSDateFormatter* format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyymmdd"];
    NSDate* thedate = [format dateFromString:str];
    [format setDateFormat:@"yyyy-mm-dd"];
    NSString* newstr = [format stringFromDate:thedate];
    //NSString* str = [outputFormatter stringFromDate:[commfunc stringToDate:[NSString stringWithFormat:@"%@",recordmodel.creDate]]];
    self.timeLab.text = newstr;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
