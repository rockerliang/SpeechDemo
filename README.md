# SpeechDemo

##sessions 509 语音识别－Speech Recognition API

=============

###　在 iOS 10 中新增加了语音识别的API——Speech ，其特点如下：
###• 可以实现连续的语音识别

###• 可以对语 音文件或者语音流进行识别

###• 最佳化自由格式的听写(可理解为多语言支持)和搜索式的字符串
-----------
####实现步骤
1.  导入头文件：#import<.Speech/Speech.h>
2.  请求语音识别的权限
3.  配置info.plist文件，添加一个属性：NSSpeechRecognitionUsageDescription
5.  初始化一个识别器
6.  初始化语音的url
7.  初始化一个识别的请求
8.  发起请求
9.  得到语音识别的结构

----------------
####代码示例
首先导入头文件：
		
		#import <Speech/Speech.h>
接下来我们来请求语音识别的权限：
		
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

接下来我们在info.plist文件里面添加一个属性：NSSpeechRecognitionUsageDescription

然后我们初始化一个语音识别器：
		
	//初始化一个识别器
    SFSpeechRecognizer *recognizer = [[SFSpeechRecognizer alloc] initWithLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
    
		
然后初始化mp3的url：
		
	
	//初始化mp3的url
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"你好.mp3" withExtension:nil];
    
初始化一个识别请求：
		
	//初始化一个识别的请求
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    
接下来我们就可以发起请求了：
		
		//发起请求
    [recognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if(error != nil)
        {
            NSLog(@"识别错误:%@",error);
        }
        
        NSLog(@"%@",result.bestTranscription.formattedString);
        
        //code..... 根据识别的文字匹配规则。。。
    }];
   
