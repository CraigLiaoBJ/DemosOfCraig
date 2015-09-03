//
//  CustomTabBar.m
//  CustomizedTabBar
//
//  Created by Craig Liao on 15/9/3.
//  Copyright (c) 2015年 Craig Liao. All rights reserved.
//

#import "CustomTabBar.h"
#import "AppDelegate.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CustomTabBar (){
    UIColor *_normalColor;
    UIColor *_selectColor;
}

@end

@implementation CustomTabBar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            
        }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id)initWithCreatingTabBarWithBackgroundImageName:(NSString *)backgroundImage andViewControllers:(NSArray *)VCArray andButtonSize:(CGSize)buttonSize andButtonsImageName:(NSArray *)buttonsImageName andButtonSelectImageName:(NSArray *)buttonsSelectImageName andLabelSize:(CGSize)labelSize andLabelArray:(NSMutableArray *)LabelArray andLabelNormalColor:(UIColor *)normalColor andLabelSelectColor:(UIColor *)selectColor andDefaultIndex:(int)index{
    self = [super init];
    if (self) {
        //自定义颜色
        _normalColor = normalColor;
        _selectColor = selectColor;
        
        //自定义视图控制器数组
        self.viewControllers = VCArray;
        
        //隐藏掉系统本身的tabBar，这样就可以自定义自己需要的了。
        self.tabBar.hidden = YES;
        
        //自定义图片
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundImage]];
        imageView.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
        imageView.userInteractionEnabled = YES;
        
        //调用appDelegate的代理
//        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        app.myTabBar = imageView;
        
        [self.view addSubview:imageView];
        
        //循环创建 按钮和文字----另外可以直接把图片设置在按钮上呢。那样更好看我觉得
        for (int i = 0; i < buttonsImageName.count; i ++) {
            //TabBar上的按钮
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((SCREEN_WIDTH / buttonsSelectImageName.count) * i + (SCREEN_WIDTH / buttonsSelectImageName.count - buttonSize.width) / 2, (49 - buttonSize.height - labelSize.height) / 2, buttonSize.width, buttonSize.height);
            
            [button setImage:[UIImage imageNamed:buttonsImageName[i]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:buttonsSelectImageName[i]] forState:UIControlStateSelected];
            
            [button addTarget:self action:@selector(tabBarClick:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag = i;
            [imageView addSubview:button];
            
            CGRect rect = button.frame;
            rect.origin.y = rect.origin.y + buttonSize.height;
            rect.size = labelSize;
            
            //文字设置
            UILabel *label = [[UILabel alloc] initWithFrame:rect];
            label.textColor = normalColor;
            label.text = LabelArray[i];
            label.tag = 10 + i;
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            [imageView addSubview:label];
            
            if (i == index) {
                button.selected = YES;
                label.textColor = selectColor;
            }
        }
        self.selectedIndex = index;
    }
    return self;
}

//点击事件
- (void)tabBarClick:(UIButton *)button{
    UIImageView *imageView = (UIImageView *)button.superview;
    for (UIView *view in imageView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.selected = NO;
        }
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            label.textColor = _normalColor;
        }
    }
    button.selected = !button.selected;
    UILabel *label = (UILabel *)[imageView viewWithTag:button.tag + 10];
    label.textColor = _selectColor;
    self.selectedIndex = button.tag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
