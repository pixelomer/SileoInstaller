#import <Foundation/Foundation.h>
#if DEBUG
#define NSLog(args...) NSLog(@"[SileoPatch] "args)
#else
#define NSLog(...); /* */
#endif

%hook NSFileManager

- (id)contentsOfDirectoryAtPath:(NSString*)path error:(NSError**)error {
	NSLog(@"[NSFileManager contentsOfDirectoryAtPath:@\"%@\" error:<Pointer to NSError*>", path);
	return %orig([path stringByReplacingOccurrencesOfString:@"/etc/apt/sources.list.d" withString:@"/opt/u0sileo/sources.list.d"], error);
}

%end

%hook RepoManager

- (void)parseSourcesFile:(NSString*)file {
	NSLog(@"parseSourcesFile:@\"%@\"", file);
	%orig([file stringByReplacingOccurrencesOfString:@"/etc/apt/sources.list.d" withString:@"/opt/u0sileo/sources.list.d"]);
}

- (void)parseListFile:(NSString*)file {
	NSLog(@"parseListFile:@\"%@\"", file);
	%orig([file stringByReplacingOccurrencesOfString:@"/etc/apt/sources.list.d" withString:@"/opt/u0sileo/sources.list.d"]);
}

%end

%hook rootMeWrapper

// Sileo uses this function to update the sileo.sources file.
+ (int)outputForCommandAsRoot:(NSString*)cmd output:(id*)out {
	@autoreleasepool {
		NSString *finalCmd = [cmd stringByReplacingOccurrencesOfString:@"/etc/apt/sources.list.d" withString:@"/opt/u0sileo/sources.list.d"];
		int exitCode = %orig(finalCmd, out);
		NSLog(@"[rootMeWrapper outputForCommandAsRoot:@\"%@\" output:<id pointer>]", cmd);
		NSLog(@"New command: %@", finalCmd);
		NSLog(@"output = %@", out ? *out : nil);
		return exitCode;
	}
}

%end