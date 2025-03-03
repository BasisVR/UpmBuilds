default:
	just --list

all: base128 bouncycastle generatorequals newtonsoftjson simplebase

base128:
	just msbuild/Base128/

bouncycastle:
	just msbuild/BouncyCastle/

generatorequals:
	just msbuild/Generator.Equals/

newtonsoftjson:
	just msbuild/Newtonsoft.Json/

simplebase:
	just msbuild/SimpleBase/
