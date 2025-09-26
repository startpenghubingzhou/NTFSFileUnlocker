//
//  AppDelegate.h
//  NTFSFileUnlocker
//
//  Created by phbz on 2025/9/17.
//  Copyright © 2025 phbz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NFUDragView.h"

/*!
     @define        kAttrName
     @abstract      The param for the xattr command.
     @discussion    This param is only for xattr use.
 */
#define kAttrName @"com.apple.FinderInfo";

@interface AppDelegate : NSObject <NSApplicationDelegate>

#pragma mark NSApplicationDelegate Methods

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender;
- (void)applicationWillTerminate:(NSNotification *)aNotification;

#pragma mark User Defined Methods

/*!
     @method        xattrCommandWithPath
     @abstract      Run xattr command to unlock the files on NTFS
                    partitions.
     @discussion    This methods will run "xattr -d"(for files)
                    or "xattr -d -r"(for dictionaries) to unlock
                    file in the NTFS partition.
     @param         path         A NSString containing the path of
                                 a file or a dictionary.
     @param         isDictionary A boolean value used to determine
                                 whether it is a directory
     @result        0 for success, or other value for failure.
 */

- (int) xattrCommandWithPath:(NSString*)path FileType:(BOOL)isDictionary;

@end

