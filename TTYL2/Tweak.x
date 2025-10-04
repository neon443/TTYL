/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreFoundation/CoreFoundation.h>
#import <objc/runtime.h>

static NSString * const TARGET_FOLDER = @"/System/Library/Carrier Bundles/iPhone";
static NSString * const TARGET_KEY = @"ShowTTY";
static NSString * const TARGET_FILE_NAME = @"carrier.plist";

static id setTTYTrue(id obj) {
	if ([obj isKindOfClass:[NSDictionary class]]) {
		NSMutableDictionary *m = [((NSDictionary *)obj) mutableCopy];
		for (id key in [m allKeys]) {
			id val = m[key];
			if ([key isKindOfClass:[NSString class]] && [key isEqualToString:TARGET_KEY]) {
				m[key] = @YES;
			} else {
				id newVal = setTTYTrue(val);
				if (newVal && newVal != val) m[key] = newVal;
			}
		}
		return m;
	}
	else if ([obj isKindOfClass:[NSArray class]]) {
		NSMutableArray *ma = [((NSArray *)obj) mutableCopy];
		for (NSUInteger i = 0; i < ma.count; i++) {
			id el = ma[i];
			id newEl = setTTYTrue(el);
			if (newEl && newEl != el) ma[i] = newEl;
		}
		return ma;
	}
	return obj;
}

static void processPlistAtPath(NSString *path) {
	@try {
		NSFileManager *fm = [NSFileManager defaultManager];
		
		// backup
		NSString *backupPath = [path stringByAppendingString:@".bak"];
		if (![fm fileExistsAtPath:backupPath]) {
			[fm copyItemAtPath:path toPath:backupPath error:NULL];
		}
		
		NSData *data = [NSData dataWithContentsOfFile:path];
		if (!data) return;
		
		NSPropertyListFormat fmt;
		id root = [NSPropertyListSerialization propertyListWithData:data
															options:NSPropertyListMutableContainersAndLeaves
															 format:&fmt
															  error:NULL];
		if (!root) return;
		
		id newRoot = setTTYTrue(root);
		
		NSData *outData = [NSPropertyListSerialization dataWithPropertyList:newRoot
																	 format:fmt == NSPropertyListBinaryFormat_v1_0 ? NSPropertyListBinaryFormat_v1_0 : NSPropertyListXMLFormat_v1_0
																	options:0
																	  error:NULL];
		if (outData) {
			[outData writeToFile:path atomically:YES];
		}
	} @catch (NSException *ex) {
		// optionally log: NSLog(@"plist tweak error: %@", ex);
	}
}

static void processFolderRecursively(NSString *folder) {
	NSFileManager *fm = [NSFileManager defaultManager];
	NSDirectoryEnumerator *enumerator = [fm enumeratorAtPath:folder];
	NSString *relative;
	while ((relative = [enumerator nextObject])) {
		if ([[relative lastPathComponent] isEqualToString:TARGET_FILE_NAME]) {
			NSString *abs = [folder stringByAppendingPathComponent:relative];
			processPlistAtPath(abs);
		}
	}
}

%ctor {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
		@autoreleasepool {
			if ([[NSFileManager defaultManager] fileExistsAtPath:TARGET_FOLDER]) {
				processFolderRecursively(TARGET_FOLDER);
			} else {
				// folder not found — optionally log
			}
		}
	});
}
