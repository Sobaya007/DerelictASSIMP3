/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.assimp3.assimp;

public {
    import derelict.assimp3.types;
}

private {
    import derelict.util.loader;
    import derelict.util.system;

    static if(Derelict_OS_Windows) {
        static if(size_t.sizeof == 4)
            enum libNames = "assimp.dll, Assimp32.dll";
        else static if(size_t.sizeof == 8)
            enum libNames = "assimp.dll, Assimp64.dll";
        else
            static assert(0);
    }
    else static if(Derelict_OS_Mac)
        enum libNames = "libassimp.3.dylib";
    else static if(Derelict_OS_Posix)
        enum libNames = "libassimp.so.3, libassimp.so.3.0.0";
    else
        static assert(0, "Need to implement ASSIMP3 libNames for this operating system.");
}

aiReturn aiGetMaterialFloat(const(aiMaterial)* mat, const(char)* key, uint type, uint index, float* _out) {
    return aiGetMaterialFloatArray(mat, key, type, index, _out, null);
}

aiReturn aiGetMaterialInteger(const(aiMaterial)* mat, const(char)* key, uint type, uint index, int* _out) {
    return aiGetMaterialIntegerArray(mat, key, type, index, _out, null);
}

extern(C) nothrow {
    // cexport.h
    alias da_aiGetExportFormatCount = size_t function();
    alias da_aiGetExportFormatDescription = aiExportFormatDesc* function(size_t);
    alias da_aiCopyScene = void function(const(aiScene)*,aiScene**);
    alias da_aiFreeScene = void function(const(aiScene)*);
    alias da_aiExportScene = aiReturn function(const(aiScene)*,const(char)*,const(char)*,uint );
    alias da_aiExportSceneEx = aiReturn function(const(aiScene)*,const(char)*,const(char)*,aiFileIO*,uint);
    alias da_aiExportSceneToBlob = const(aiExportDataBlob)* function(const(aiScene)*,const(char)*,uint);
    alias da_aiReleaseExportBlob = void function(const(aiExportDataBlob)*);

    // cimport.h
    alias da_aiImportFile = const(aiScene*) function(const(char)*,uint);
    alias da_aiImportFileEx = const(aiScene*) function(const(char)*,uint,aiFileIO*);
    alias da_aiImportFileExWithProperties = const(aiScene*) function(const(char)*,uint,aiFileIO*,const(aiPropertyStore)*);
    alias da_aiImportFileFromMemory = const(aiScene*) function(const(void)*,uint,uint,const(char)*);
    alias da_aiImportFileFromMemoryWithProperties = const(aiScene*) function(const(void)*,uint,uint,const(char)*,const(aiPropertyStore)*);
    alias da_aiApplyPostProcessing = const(aiScene*) function(const(aiScene*),uint);
    alias da_aiGetPredefinedLogStream = aiLogStream function(aiDefaultLogStream,const(char)*);
    alias da_aiAttachLogStream = void function(const(aiLogStream)*);
    alias da_aiEnableVerboseLogging = void function(aiBool);
    alias da_aiDetachLogStream = aiReturn function(const(aiLogStream)*);
    alias da_aiDetachAllLogStreams = void function();
    alias da_aiReleaseImport = void function(const(aiScene)*);
    alias da_aiGetErrorString = const(char)* function();
    alias da_aiIsExtensionSupported = aiBool function(const(char)*);
    alias da_aiGetExtensionList = void function(aiString*);
    alias da_aiGetMemoryRequirements = void function(const(aiScene)*,aiMemoryInfo*);
    alias da_aiCreatePropertyStore = aiPropertyStore* function();
    alias da_aiReleasePropertyStore = void function(aiPropertyStore*);
    alias da_aiSetImportPropertyInteger = void function(aiPropertyStore*,const(char)*,int);
    alias da_aiSetImportPropertyFloat = void function(aiPropertyStore*,const(char)*,float);
    alias da_aiSetImportPropertyString = void function(aiPropertyStore*,const(char)*,const(aiString)*);
    alias da_aiSetImportPropertyMatrix = void function(aiPropertyStore*,const(char)*,aiMatrix4x4*);
    alias da_aiCreateQuaternionFromMatrix = void function(aiQuaternion*,const(aiMatrix3x3)*);
    alias da_aiDecomposeMatrix = void function(const(aiMatrix4x4)*,aiVector3D*,aiQuaternion*,aiVector3D*);
    alias da_aiTransposeMatrix4 = void function(aiMatrix4x4*);
    alias da_aiTransposeMatrix3 = void function(aiMatrix3x3*);
    alias da_aiTransformVecByMatrix3 = void function(aiVector3D*,const(aiMatrix3x3)*);
    alias da_aiTransformVecByMatrix4 = void function(aiVector3D*,const(aiMatrix4x4)*);
    alias da_aiMultiplyMatrix4 = void function(aiMatrix4x4*,const(aiMatrix4x4)*);
    alias da_aiMultiplyMatrix3 = void function(aiMatrix3x3*,const(aiMatrix3x3)*);
    alias da_aiIdentityMatrix3 = void function(aiMatrix3x3*);
    alias da_aiIdentityMatrix4 = void function(aiMatrix4x4*);

    // material.h
    alias da_aiGetMaterialProperty = aiReturn function(const(aiMaterial)*,const(char)*,uint,uint,aiMaterialProperty**);
    alias da_aiGetMaterialFloatArray = aiReturn function(const(aiMaterial)*,const(char)*,uint,uint,float*,uint*);
    alias da_aiGetMaterialIntegerArray = aiReturn function(const(aiMaterial)*,const(char)*,uint,uint,int*,uint*);
    alias da_aiGetMaterialColor = aiReturn function(const(aiMaterial)*,const(char)*,uint,uint,aiColor4D*);
    alias da_aiGetMaterialUVTransform = aiReturn function(const(aiMaterial)*,const(char)*,uint,uint,aiUVTransform*);
    alias da_aiGetMaterialString = aiReturn function(const(aiMaterial)*,const(char)*,uint,uint,aiString*);
    alias da_aiGetMaterialTextureCount = uint function(const(aiMaterial)*,aiTextureType);
    alias da_aiGetMaterialTexture = aiReturn function(const(aiMaterial)*,aiTextureType,uint,aiString*,aiTextureMapping* m=null,uint* uvindex = null,float* blend = null,aiTextureOp* op = null,aiTextureMapMode* mm = null,uint* flags = null);

    // version.h
    alias da_aiGetLegalString = const(char)* function();
    alias da_aiGetVersionMinor = uint function();
    alias da_aiGetVersionMajor = uint function();
    alias da_aiGetVersionRevision = uint function();
    alias da_aiGetCompileFlags = uint function();
}

__gshared {
    da_aiGetExportFormatCount aiGetExportFormatCount;
    da_aiGetExportFormatDescription aiGetExportFormatDescription;
    da_aiCopyScene aiCopyScene;
    da_aiFreeScene aiFreeScene;
    da_aiExportScene aiExportScene;
    da_aiExportSceneEx aiExportSceneEx;
    da_aiExportSceneToBlob aiExportSceneToBlob;
    da_aiReleaseExportBlob aiReleaseExportBlob;
    da_aiImportFile aiImportFile;
    da_aiImportFileEx aiImportFileEx;
    da_aiImportFileExWithProperties aiImportFileExWithProperties;
    da_aiImportFileFromMemory aiImportFileFromMemory;
    da_aiImportFileFromMemoryWithProperties aiImportFileFromMemoryWithProperties;
    da_aiApplyPostProcessing aiApplyPostProcessing;
    da_aiGetPredefinedLogStream aiGetPredefinedLogStream;
    da_aiAttachLogStream aiAttachLogStream;
    da_aiEnableVerboseLogging aiEnableVerboseLogging;
    da_aiDetachLogStream aiDetachLogStream;
    da_aiDetachAllLogStreams aiDetachAllLogStreams;
    da_aiReleaseImport aiReleaseImport;
    da_aiGetErrorString aiGetErrorString;
    da_aiIsExtensionSupported aiIsExtensionSupported;
    da_aiGetExtensionList aiGetExtensionList;
    da_aiGetMemoryRequirements aiGetMemoryRequirements;
    da_aiCreatePropertyStore aiCreatePropertyStore;
    da_aiReleasePropertyStore aiReleasePropertyStore;
    da_aiSetImportPropertyInteger aiSetImportPropertyInteger;
    da_aiSetImportPropertyFloat aiSetImportPropertyFloat;
    da_aiSetImportPropertyString aiSetImportPropertyString;
    da_aiSetImportPropertyMatrix aiSetImportPropertyMatrix;
    da_aiCreateQuaternionFromMatrix aiCreateQuaternionFromMatrix;
    da_aiDecomposeMatrix aiDecomposeMatrix;
    da_aiTransposeMatrix4 aiTransposeMatrix4;
    da_aiTransposeMatrix3 aiTransposeMatrix3;
    da_aiTransformVecByMatrix3 aiTransformVecByMatrix3;
    da_aiTransformVecByMatrix4 aiTransformVecByMatrix4;
    da_aiMultiplyMatrix4 aiMultiplyMatrix4;
    da_aiMultiplyMatrix3 aiMultiplyMatrix3;
    da_aiIdentityMatrix3 aiIdentityMatrix3;
    da_aiIdentityMatrix4 aiIdentityMatrix4;
    da_aiGetMaterialProperty aiGetMaterialProperty;
    da_aiGetMaterialFloatArray aiGetMaterialFloatArray;
    da_aiGetMaterialIntegerArray aiGetMaterialIntegerArray;
    da_aiGetMaterialColor aiGetMaterialColor;
    da_aiGetMaterialString aiGetMaterialString;
    da_aiGetMaterialTextureCount aiGetMaterialTextureCount;
    da_aiGetMaterialTexture aiGetMaterialTexture;
    da_aiGetLegalString aiGetLegalString;
    da_aiGetVersionMinor aiGetVersionMinor;
    da_aiGetVersionMajor aiGetVersionMajor;
    da_aiGetVersionRevision aiGetVersionRevision;
    da_aiGetCompileFlags aiGetCompileFlags;
}

class DerelictASSIMP3Loader : SharedLibLoader {
    public this() {
        super(libNames);
    }

    protected override void loadSymbols() {
        bindFunc(cast(void**)&aiGetExportFormatCount, "aiGetExportFormatCount");
        bindFunc(cast(void**)&aiGetExportFormatDescription, "aiGetExportFormatDescription");
        bindFunc(cast(void**)&aiCopyScene, "aiCopyScene");
        bindFunc(cast(void**)&aiFreeScene, "aiFreeScene");
        bindFunc(cast(void**)&aiExportScene, "aiExportScene");
        bindFunc(cast(void**)&aiExportSceneEx, "aiExportSceneEx");
        bindFunc(cast(void**)&aiExportSceneToBlob, "aiExportSceneToBlob");
        bindFunc(cast(void**)&aiReleaseExportBlob, "aiReleaseExportBlob");
        bindFunc(cast(void**)&aiImportFile, "aiImportFile");
        bindFunc(cast(void**)&aiImportFileEx, "aiImportFileEx");
        bindFunc(cast(void**)&aiImportFileExWithProperties, "aiImportFileExWithProperties");
        bindFunc(cast(void**)&aiImportFileFromMemory, "aiImportFileFromMemory");
        bindFunc(cast(void**)&aiImportFileFromMemoryWithProperties, "aiImportFileFromMemoryWithProperties");
        bindFunc(cast(void**)&aiApplyPostProcessing, "aiApplyPostProcessing");
        bindFunc(cast(void**)&aiGetPredefinedLogStream, "aiGetPredefinedLogStream");
        bindFunc(cast(void**)&aiAttachLogStream, "aiAttachLogStream");
        bindFunc(cast(void**)&aiEnableVerboseLogging, "aiEnableVerboseLogging");
        bindFunc(cast(void**)&aiDetachLogStream, "aiDetachLogStream");
        bindFunc(cast(void**)&aiDetachAllLogStreams, "aiDetachAllLogStreams");
        bindFunc(cast(void**)&aiReleaseImport, "aiReleaseImport");
        bindFunc(cast(void**)&aiGetErrorString, "aiGetErrorString");
        bindFunc(cast(void**)&aiIsExtensionSupported, "aiIsExtensionSupported");
        bindFunc(cast(void**)&aiGetExtensionList, "aiGetExtensionList");
        bindFunc(cast(void**)&aiGetMemoryRequirements, "aiGetMemoryRequirements");
        bindFunc(cast(void**)&aiCreatePropertyStore, "aiCreatePropertyStore");
        bindFunc(cast(void**)&aiReleasePropertyStore, "aiReleasePropertyStore");
        bindFunc(cast(void**)&aiSetImportPropertyInteger, "aiSetImportPropertyInteger");
        bindFunc(cast(void**)&aiSetImportPropertyFloat, "aiSetImportPropertyFloat");
        bindFunc(cast(void**)&aiSetImportPropertyString, "aiSetImportPropertyString");
        bindFunc(cast(void**)&aiSetImportPropertyMatrix, "aiSetImportPropertyMatrix");
        bindFunc(cast(void**)&aiCreateQuaternionFromMatrix, "aiCreateQuaternionFromMatrix");
        bindFunc(cast(void**)&aiDecomposeMatrix, "aiDecomposeMatrix");
        bindFunc(cast(void**)&aiTransposeMatrix4, "aiTransposeMatrix4");
        bindFunc(cast(void**)&aiTransposeMatrix3, "aiTransposeMatrix3");
        bindFunc(cast(void**)&aiTransformVecByMatrix3, "aiTransformVecByMatrix3");
        bindFunc(cast(void**)&aiTransformVecByMatrix4, "aiTransformVecByMatrix4");
        bindFunc(cast(void**)&aiMultiplyMatrix4, "aiMultiplyMatrix4");
        bindFunc(cast(void**)&aiMultiplyMatrix3, "aiMultiplyMatrix3");
        bindFunc(cast(void**)&aiIdentityMatrix3, "aiIdentityMatrix3");
        bindFunc(cast(void**)&aiIdentityMatrix4, "aiIdentityMatrix4");
        bindFunc(cast(void**)&aiGetMaterialProperty, "aiGetMaterialProperty");
        bindFunc(cast(void**)&aiGetMaterialFloatArray, "aiGetMaterialFloatArray");
        bindFunc(cast(void**)&aiGetMaterialIntegerArray, "aiGetMaterialIntegerArray");
        bindFunc(cast(void**)&aiGetMaterialColor, "aiGetMaterialColor");
        bindFunc(cast(void**)&aiGetMaterialString, "aiGetMaterialString");
        bindFunc(cast(void**)&aiGetMaterialTextureCount, "aiGetMaterialTextureCount");
        bindFunc(cast(void**)&aiGetMaterialTexture, "aiGetMaterialTexture");
        bindFunc(cast(void**)&aiGetLegalString, "aiGetLegalString");
        bindFunc(cast(void**)&aiGetVersionMinor, "aiGetVersionMinor");
        bindFunc(cast(void**)&aiGetVersionMajor, "aiGetVersionMajor");
        bindFunc(cast(void**)&aiGetVersionRevision, "aiGetVersionRevision");
        bindFunc(cast(void**)&aiGetCompileFlags, "aiGetCompileFlags");
    }
}

__gshared DerelictASSIMP3Loader DerelictASSIMP3;

shared static this() {
    DerelictASSIMP3 = new DerelictASSIMP3Loader;
}