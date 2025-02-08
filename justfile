default:
	just --list

all: base128 simplebase bouncycastle

base128:
	just msbuild/Base128/

bouncycastle:
	just msbuild/BouncyCastle/

simplebase:
	just msbuild/SimpleBase/

msidenttokens:
	just msbuild/Microsoft.IdentityModel.Tokens/
