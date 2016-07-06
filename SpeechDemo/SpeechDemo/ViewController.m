//
//  ViewController.m
//  SpeechDemo
//
//  Created by Rocker on 16/7/3.
//  Copyright © 2016年 Rocker. All rights reserved.
//

#import "ViewController.h"
#import <Speech/Speech.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *speechBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [speechBtn setTitle:@"语音识别" forState:UIControlStateNormal];
    [speechBtn addTarget:self action:@selector(speechAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:speechBtn];
    
    
    //请求语音识别的权限
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        NSLog(@"%ld",(long)status);
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                NSLog(@"设备不支持");// Device isn't permitted
                break;
            case SFSpeechRecognizerAuthorizationStatusDenied:
                NSLog(@"用户拒绝授权");// User said no
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
                NSLog(@"暂时不清楚"); // Don't know yet
                break;
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
                NSLog(@"授权成功");// Good to go
                break;
                
            default:
                break;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)speechAction
{
    //初始化一个识别器
    SFSpeechRecognizer *recognizer = [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
    //初始化mp3的url
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"你好.mp3" withExtension:nil];
    
    //初始化一个识别的请求
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    
    //发起请求
    [recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if(error != nil)
        {
            NSLog(@"识别错误:%@",error);
        }
        
        NSLog(@"%@",result.bestTranscription.formattedString);
        
        //code..... 根据识别的文字匹配规则。。。
    }];
    
}

@end
