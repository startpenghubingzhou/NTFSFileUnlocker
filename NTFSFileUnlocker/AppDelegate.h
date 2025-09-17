//
//  AppDelegate.h
//  NTFSFileUnlocker
//
//  Created by phbz on 2025/9/17.
//  Copyright © 2025 phbz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NFUDragView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

- (int) xattrCommandWithPath:(NSString*)path FileType:(BOOL)isFile;

@end

