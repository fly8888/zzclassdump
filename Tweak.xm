
#include <mach-o/dyld_images.h>
#include <dlfcn.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import "./ClassDump/ClassDump.h"

#define PATH [NSHomeDirectory() stringByAppendingPathComponent:@"/tmp/classdump"]

@interface UIApplication ()
+(NSString *)classdump;
+(void)newQueueClassdump;
@end
%hook  UIApplication

%new
+(NSString *)classdump
{
    @autoreleasepool {
        NSFileManager * fileMgr = [NSFileManager defaultManager];
        BOOL isDir = NO;
        BOOL exist = [fileMgr fileExistsAtPath:PATH isDirectory:&isDir];
        if(exist)[fileMgr removeItemAtPath:PATH error:nil];

        [fileMgr createDirectoryAtPath:PATH withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSString * bundlePath = [NSBundle mainBundle].bundlePath;
        unsigned int imageCount = 0;
        const char ** imageNames = objc_copyImageNames(&imageCount);
        
        for(int i =0 ;i<imageCount;i++)
        {
            NSString * name = [NSString stringWithUTF8String:imageNames[i]];
            BOOL inBundle = [name hasPrefix:bundlePath];
            if(inBundle)
            {
                NSString * dirPath = [PATH stringByAppendingFormat:@"/%@",name.lastPathComponent];
                BOOL dirExist = [fileMgr fileExistsAtPath:dirPath isDirectory:nil];
                if(!dirExist)
                {
                    [fileMgr createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
                }
                
                unsigned int classCount = 0;
                const char ** classNames = objc_copyClassNamesForImage(imageNames[i],&classCount);
                for(int j=0;j<classCount;j++)
                {
                    NSString * className = [NSString stringWithUTF8String:classNames[j]];
                    Class cla =  NSClassFromString(className);
                    CDClassModel *ortho = [CDClassModel modelWithClass:cla];
                    NSString * content = [ortho linesWithComments:NO synthesizeStrip:YES];
                    NSString * outPath = [dirPath stringByAppendingFormat:@"/%@.h",className];
                    [content writeToFile:outPath atomically:YES encoding:4 error:nil];
                }
            }
        }
        [@"finish" writeToFile:[NSString stringWithFormat:@"%@/finish.txt",PATH] atomically:YES encoding:4 error:nil];
    }
    NSLog(@"PATH:%@",PATH);
    return PATH;
}

%new
+(void)newQueueClassdump
{
    dispatch_queue_t queue = dispatch_queue_create("classdump.queue", NULL);
    dispatch_async(queue, ^{
        [self classdump];
    });
}
%end