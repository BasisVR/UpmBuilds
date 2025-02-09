default:
	just --list

all: base128 bouncycastle newtonsoftjson simplebase

base128:
	just msbuild/Base128/

bouncycastle:
	just msbuild/BouncyCastle/

newtonsoftjson:
	just msbuild/Newtonsoft.Json/

simplebase:
	just msbuild/SimpleBase/
