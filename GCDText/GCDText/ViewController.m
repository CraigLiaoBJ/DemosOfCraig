//
//  ViewController.m
//  GCDText
//
//  Created by Craig Liao on 15/7/20.
//  Copyright (c) 2015年 DobeFM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  串行队列
     *
     *  @param "myQueue" 名字（任意填写，注意不要带“@”符号）
     *  @param NULL      如果是串行列队，可以填NULL
     *  使用串行队列只开辟一条线程
     */
//    dispatch_queue_t muQueue = dispatch_queue_create("myQueue", NULL);
    /**
     *  并发队列
     *
     *  @param "myQueue"                 队列的名字
     *  @param DISPATCH_QUEUE_CONCURRENT 固定的填写系统提供的宏
     *  并行的队列 每个任务 对应一个线程 同时执行
     */
//    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //使用系统提供的串行队列
    //系统给的实际上是在主线程进行执行的。
//    dispatch_queue_t myQueue = dispatch_get_main_queue();
    
    /**
     *  使用系统提供的并行队列
     *
     *  @param DISPATCH_QUEUE_PRIORITY_DEFAULT 设置优先级，必填，然并卵。（优先级默认）
     *  @param 0    填0即可，然并卵。
     *
     */
//    dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);


//    dispatch_async(myQueue, ^{
//        NSLog(@"任务1=＝＝＝＝＝＝ %@", [NSThread currentThread]);
//    });
//    dispatch_async(myQueue, ^{
//        NSLog(@"任务2=＝＝＝＝＝＝ %@", [NSThread currentThread]);
//    });
//    dispatch_async(myQueue, ^{
//        NSLog(@"任务3=＝＝＝＝＝＝ %@", [NSThread currentThread]);
//    });
//    dispatch_async(myQueue, ^{
//        NSLog(@"任务4=＝＝＝＝＝＝ %@", [NSThread currentThread]);
//    });
//    dispatch_async(myQueue, ^{
//        NSLog(@"任务5=＝＝＝＝＝＝ %@", [NSThread mainThread]);
//    });
//    
//    //即可执行
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//    });
//    //延迟几秒
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//    });
    
    

    dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//组队列
    //创建组队列
    dispatch_group_t group = dispatch_group_create();
    //在组队列中添加进去一个新的任务（异步的）
    //如果是异步的并发组队列，则开辟的线程是总任务数减一的数量
    //最后一个执行的任务，是在之前最后一个结束的任务的线程内执行的
    dispatch_group_async(group, myQueue, ^{
        NSLog(@"任务1=＝＝＝＝＝＝ %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, myQueue, ^{
        NSLog(@"任务2=＝＝＝＝＝＝ %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, myQueue, ^{
        NSLog(@"任务3=＝＝＝＝＝＝ %@", [NSThread currentThread]);
    });
    dispatch_group_notify(group, myQueue, ^{
     NSLog(@"任务5=＝＝＝＝＝＝ %@", [NSThread currentThread]);
    });
    dispatch_group_async(group, myQueue, ^{
        NSLog(@"任务4=＝＝＝＝＝＝ %@", [NSThread mainThread]);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
