//
//  ClassDump.h
//  ClassDump
//
//  Created by Leptos on 3/24/19.
//  Copyright © 2019 Leptos. All rights reserved.
//

// to support building as both an Xcode framework and a Swift Package,
// all headers that are marked as "public" for the Xcode framework
// should have a symlink in `Sources/ClassDumpRuntime/include/ClassDump`;
// all those files should then be imported below.
//
// you can generate these imports using a shell script such as
//   `ls ClassDump/*.h | while read HEADER; do printf "#import <${HEADER}>\n"; done`
// (run from `Sources/ClassDumpRuntime/include`)

#import <CDArrayType.h>
#import <CDBitFieldType.h>
#import <CDBlockType.h>
#import <CDClassModel.h>
#import <CDGenerationOptions.h>
#import <CDIvarModel.h>
#import <CDMethodModel.h>
#import <CDObjectType.h>
#import <CDParseType.h>
#import <CDPointerType.h>
#import <CDPrimitiveType.h>
#import <CDPropertyAttribute.h>
#import <CDPropertyModel.h>
#import <CDProtocolModel+Conformance.h>
#import <CDProtocolModel.h>
#import <CDRecordType.h>
#import <CDSemanticString.h>
#import <CDTypeParser.h>
#import <CDUtilities.h>
#import <CDVariableModel.h>
