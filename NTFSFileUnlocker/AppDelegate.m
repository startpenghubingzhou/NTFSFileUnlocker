//
//  AppDelegate.m
//  NTFSFileUnlocker
//
//  Created by phbz on 2025/9/17.
//  Copyright © 2025 phbz. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NFUDragView* dragView;

@property (weak) IBOutlet NSWindow* window;

@end

@implementation AppDelegate

@synthesize window, dragView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Set title icon.
    [window setRepresentedURL:[NSURL URLWithString:[window title]]];
    NSButton* titleBtn = [window standardWindowButton:NSWindowDocumentIconButton];
    [titleBtn setImage:[[NSBundle mainBundle]imageForResource:@"AppIcon"]];
    [titleBtn setEnabled:NO];
    
    [dragView registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
    [dragView setOpenerDelegate:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

- (int) xattrCommandWithPath:(NSString*)path FileType:(BOOL)isFile {
    int ret;
    NSString* xattrCommand;
    NSString* openCommand;
    NSString* commandStr;
    NSString* attrName = kAttrName;
    
    // For command prefix
    if (isFile) {
        commandStr = @"xattr -d";
    } else {
        commandStr = @"xattr -d -r";
    }
    
    // For command processing and opening
    do {
        xattrCommand = [NSString stringWithFormat:@"%@ %@ \"%@\"", commandStr, attrName, path];
        ret = system([xattrCommand cStringUsingEncoding:NSUTF8StringEncoding]);
        if (ret) {
            NSLog(@"xattr command processing failed!");
            break;
        }
        
        openCommand = [NSString stringWithFormat:@"open \"%@\"", path];
        ret = system([openCommand cStringUsingEncoding:NSUTF8StringEncoding]);
        if (ret) {
            NSLog(@"Can't open file or dictionary!");
            break;
        }
    } while (0);
    
    return ret;
}

@end


