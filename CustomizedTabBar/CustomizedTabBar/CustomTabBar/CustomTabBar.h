//
//  CustomTabBar.h
//  CustomizedTabBar
//
//  Created by Craig Liao on 15/9/3.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBar : UITabBarController

- (id)initWithCreatingTabBarWithBackgroundImageName:(NSString *)backgroundImage
                                 andViewControllers:(NSArray *)VCArray
                                      andButtonSize:(CGSize)buttonSize
                                andButtonsImageName:(NSArray *)buttonsImageName
                           andButtonSelectImageName:(NSArray *)buttonsSelectImageName
                                       andLabelSize:(CGSize)labelSize
                                      andLabelArray:(NSMutableArray *)LabelArray
                                andLabelNormalColor:(UIColor *)normalColor
                                andLabelSelectColor:(UIColor *)selectColor
                                    andDefaultIndex:(int)index;
@end
